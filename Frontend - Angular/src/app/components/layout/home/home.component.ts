import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { ViviendaService } from '../../../service/vivienda.service';
import { ModalService } from '../../../service/modal.service';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-home',
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent implements OnInit {
  ultimosAnuncios: any[] = [];
  isLoading = true;
  error = '';
  usuarioActual: any = null;
  esUsuarioLogueado = false;
  constructor(
    private viviendaService: ViviendaService,
    private modalService: ModalService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.checkUserAuthentication();
    this.loadUltimosAnuncios();
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
        this.esUsuarioLogueado = true;
      } catch (error) {
        console.error('Error al decodificar token:', error);
        this.esUsuarioLogueado = false;
      }
    }
  }

  loadUltimosAnuncios(): void {
    this.isLoading = true;
    this.viviendaService.getAllViviendas().subscribe({
      next: (viviendas) => {
        // Ordenar por fecha de publicación (más recientes primero) y tomar los últimos 8
        this.ultimosAnuncios = viviendas
          .sort((a, b) => new Date(b.fechaPublicacion).getTime() - new Date(a.fechaPublicacion).getTime())
          .slice(0, 8);
        this.isLoading = false;
      },      error: (error) => {
        console.error('Error al cargar anuncios:', error);
        this.modalService.showError('Error al cargar los anuncios. Por favor, recarga la página.', 'Error de Carga');
        this.isLoading = false;
      }
    });
  }

  verDetalles(id: number): void {
    this.router.navigate(['/anuncio', id]);
  }

  irALogin(): void {
    this.router.navigate(['/login']);
  }

  irARegistro(): void {
    this.router.navigate(['/register']);
  }

  irAMisAnuncios(): void {
    this.router.navigate(['/mis-anuncios']);
  }

  crearAnuncio(): void {
    this.router.navigate(['/nuevo-anuncio']);
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

  onImageError(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target) {
      target.src = '/assets/placeholder-house.jpg';
    }
  }

  irABusqueda(): void {
    this.router.navigate(['/buscar']);
  }
}
