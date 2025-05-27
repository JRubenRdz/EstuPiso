import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { ViviendaService } from '../../../service/vivienda.service';
import { jwtDecode } from 'jwt-decode';
import { MapComponent } from '../../map/map.component';

@Component({
  selector: 'app-vivienda-details',
  imports: [CommonModule, MapComponent],
  templateUrl: './vivienda-details.component.html',
  styleUrl: './vivienda-details.component.css'
})
export class ViviendaDetailsComponent implements OnInit {
  vivienda: any = null;
  isLoading = true;
  error = '';
  viviendaId!: number;
  usuarioActual: any = null;
  esAnunciante = false;
  esEstudiante = false;
  puedeEditar = false;
  yaEsResidente = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private viviendaService: ViviendaService
  ) {}

  ngOnInit(): void {
    this.checkUserAuthentication();
    this.getViviendaId();
    this.loadViviendaDetails();
  }

  checkUserAuthentication(): void {
    const token = localStorage.getItem('token');
    if (token) {
      try {
        const decoded: any = jwtDecode(token);
        this.usuarioActual = {
          id: decoded.id,
          usuario: decoded.sub,
          rol: decoded.rol
        };
        this.esAnunciante = decoded.rol === 'ANUNCIANTE';
        this.esEstudiante = decoded.rol === 'ESTUDIANTE';
      } catch (error) {
        console.error('Error al decodificar token:', error);
      }
    }
  }

  getViviendaId(): void {
    this.route.params.subscribe(params => {
      this.viviendaId = +params['id'];
      if (!this.viviendaId) {
        this.router.navigate(['/']);
      }
    });
  }

  loadViviendaDetails(): void {
    this.isLoading = true;
    this.viviendaService.getViviendaById(this.viviendaId).subscribe({
      next: (vivienda) => {
        this.vivienda = vivienda;
        this.checkPermissions();
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error al cargar vivienda:', error);
        this.error = 'No se pudo cargar la información de la vivienda';
        this.isLoading = false;
      }
    });
  }

  checkPermissions(): void {
    if (this.usuarioActual && this.vivienda) {
      // Verificar si puede editar (es el anunciante propietario)
      this.puedeEditar = this.esAnunciante && 
        this.vivienda.anunciante?.id === this.usuarioActual.id;
      
      // Verificar si ya es residente
      this.yaEsResidente = this.esEstudiante && 
        this.vivienda.residentes?.some((r: any) => r.id === this.usuarioActual.id);
    }
  }

  editarVivienda(): void {
    if (this.puedeEditar) {
      this.router.navigate(['/editar-vivienda', this.viviendaId]);
    }
  }

  aplicarVivienda(): void {
    if (this.esEstudiante && !this.yaEsResidente) {
      this.viviendaService.añadirResidente(this.viviendaId, this.usuarioActual.id).subscribe({
        next: () => {
          alert('¡Solicitud enviada correctamente!');
          this.loadViviendaDetails(); // Recargar para actualizar estado
        },
        error: (error) => {
          console.error('Error al aplicar:', error);
          alert('Error al enviar la solicitud');
        }
      });
    }
  }

  volver(): void {
    window.history.back();
  }

  formatearFecha(fecha: string): string {
    if (!fecha) return 'N/A';
    return new Date(fecha).toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  getEstadoVivienda(): string {
    if (!this.vivienda.residentes || this.vivienda.residentes.length === 0) {
      return 'Disponible';
    }
    if (this.vivienda.residentes.length < this.vivienda.numeroHabitaciones) {
      return 'Parcialmente ocupada';
    }
    return 'Completa';
  }

  getEstadoClass(): string {
    const estado = this.getEstadoVivienda();
    switch (estado) {
      case 'Disponible': return 'text-success';
      case 'Parcialmente ocupada': return 'text-warning';
      case 'Completa': return 'text-danger';
      default: return 'text-secondary';
    }
  }

  onImageError(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target) {
      target.src = '/assets/placeholder-house.jpg';
    }
  }
}
