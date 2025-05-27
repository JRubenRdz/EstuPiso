import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { ViviendaService } from '../../../service/vivienda.service';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-vivienda-list',
  imports: [CommonModule],
  templateUrl: './vivienda-list.component.html',
  styleUrl: './vivienda-list.component.css'
})
export class ViviendaListComponent implements OnInit {
  viviendas: any[] = [];
  isLoading = true;
  error = '';
  anuncianteName = '';

  constructor(
    private viviendaService: ViviendaService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.checkAuthentication();
    this.loadViviendas();
  }

  checkAuthentication(): void {
    const token = localStorage.getItem('token');
    if (!token) {
      this.router.navigate(['/login']);
      return;
    }

    try {
      const decoded: any = jwtDecode(token);
      const rol = decoded.rol;
      
      if (rol !== 'ANUNCIANTE') {
        this.router.navigate(['/']);
        return;
      }

      this.anuncianteName = decoded.sub || 'Anunciante';
    } catch (error) {
      console.error('Error al decodificar token:', error);
      this.router.navigate(['/login']);
    }
  }

  loadViviendas(): void {
    this.isLoading = true;
    this.viviendaService.getViviendasByAnunciante().subscribe({
      next: (viviendas) => {
        this.viviendas = viviendas;
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error al cargar viviendas:', error);
        this.error = 'Error al cargar las viviendas';
        this.isLoading = false;
      }
    });
  }

  crearNuevaVivienda(): void {
    this.router.navigate(['/crear-vivienda']);
  }

  editarVivienda(id: number): void {
    this.router.navigate(['/editar-vivienda', id]);
  }

  verDetalles(id: number): void {
    this.router.navigate(['/vivienda', id]);
  }

  eliminarVivienda(vivienda: any): void {
    if (confirm(`¿Estás seguro de que quieres eliminar "${vivienda.nombre}"?`)) {
      this.viviendaService.deleteVivienda(vivienda.id).subscribe({
        next: () => {
          this.viviendas = this.viviendas.filter(v => v.id !== vivienda.id);
          console.log('Vivienda eliminada correctamente');
        },
        error: (error) => {
          console.error('Error al eliminar vivienda:', error);
          this.error = 'Error al eliminar la vivienda';
        }
      });
    }
  }

  formatearFecha(fecha: string): string {
    if (!fecha) return 'N/A';
    return new Date(fecha).toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }

  getEstadoVivienda(vivienda: any): string {
    if (!vivienda.residentes || vivienda.residentes.length === 0) {
      return 'Disponible';
    }
    if (vivienda.residentes.length < vivienda.numeroHabitaciones) {
      return 'Parcialmente ocupada';
    }
    return 'Completa';
  }

  getEstadoClass(vivienda: any): string {
    const estado = this.getEstadoVivienda(vivienda);
    switch (estado) {
      case 'Disponible': return 'text-success';
      case 'Parcialmente ocupada': return 'text-warning';
      case 'Completa': return 'text-danger';
      default: return 'text-secondary';
    }
  }

  // Método para manejar error de imagen
  onImageError(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target) {
      target.src = '/assets/placeholder-house.jpg';
    }
  }

  // Métodos para calcular estadísticas (necesarios para el template)
  get viviendasDisponibles(): number {
    return this.viviendas.filter(v => this.getEstadoVivienda(v) === 'Disponible').length;
  }

  get viviendasParciales(): number {
    return this.viviendas.filter(v => this.getEstadoVivienda(v) === 'Parcialmente ocupada').length;
  }

  get viviendasCompletas(): number {
    return this.viviendas.filter(v => this.getEstadoVivienda(v) === 'Completa').length;
  }
}
