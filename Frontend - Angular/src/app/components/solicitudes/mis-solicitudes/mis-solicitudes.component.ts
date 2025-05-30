import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { jwtDecode } from 'jwt-decode';
import { SolicitudViviendaService, SolicitudViviendaDto } from '../../../service/solicitudvivienda.service';
import { ModalService } from '../../../service/modal.service';

@Component({
  selector: 'app-mis-solicitudes',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './mis-solicitudes.component.html',
  styleUrl: './mis-solicitudes.component.css'
})
export class MisSolicitudesComponent implements OnInit {
  solicitudes: SolicitudViviendaDto[] = []; // USAR el tipo correcto
  usuarioActual: any = null;
  isLoading = true;
  error: string | null = null;
  constructor(
    private solicitudService: SolicitudViviendaService,
    private modalService: ModalService
  ) {}

  ngOnInit(): void {
    this.checkUserAuthentication();
  }

  checkUserAuthentication(): void {
    const token = localStorage.getItem('token');
    if (token) {
      try {
        const decodedToken: any = jwtDecode(token);
        
        this.usuarioActual = {
          id: decodedToken.id,
          nombre: decodedToken.sub,
          email: decodedToken.email,
          tipoUsuario: decodedToken.rol // USAR 'rol'
        };

        if (this.usuarioActual.tipoUsuario !== 'ESTUDIANTE') {
          console.error('No es estudiante:', this.usuarioActual.tipoUsuario);
          this.error = 'Solo los estudiantes pueden acceder a esta sección';
          this.isLoading = false;
          return;
        }

        this.cargarSolicitudes();
        
      } catch (error) {
        console.error('Error al decodificar token:', error);
        this.error = 'Sesión inválida. Por favor, inicia sesión nuevamente.';
        this.isLoading = false;
      }
    } else {
      this.error = 'Debes iniciar sesión para ver tus solicitudes';
      this.isLoading = false;
    }
  }

  cargarSolicitudes(): void {
    if (!this.usuarioActual?.id) {
      this.error = 'No se pudo identificar al usuario';
      this.isLoading = false;
      return;
    }


    this.solicitudService.obtenerSolicitudesEstudiante(this.usuarioActual.id).subscribe({
      next: (solicitudes) => {
        this.solicitudes = solicitudes || [];
        this.isLoading = false;
      },
      error: (error) => {
        this.error = 'Error al cargar las solicitudes: ' + (error.error?.message || 'Error desconocido');
        this.isLoading = false;
      }
    });
  }
  // AÑADIR método para cancelar solicitud
  cancelarSolicitud(solicitud: SolicitudViviendaDto): void {
    if (solicitud.estado !== 'PENDIENTE') {
      this.modalService.showWarning('Solo se pueden cancelar solicitudes pendientes', 'Acción No Permitida');
      return;
    }

    if (confirm('¿Estás seguro de que quieres cancelar esta solicitud?')) {
      this.solicitudService.cancelarSolicitud(solicitud.id, this.usuarioActual.id).subscribe({
        next: () => {
          this.modalService.showSuccess('Solicitud cancelada correctamente', 'Solicitud Cancelada');
          this.cargarSolicitudes(); // Recargar la lista
        },
        error: (error) => {
          console.error('Error al cancelar solicitud:', error);          this.modalService.showError('Error al cancelar la solicitud: ' + (error.error?.message || 'Error desconocido'), 'Error al Cancelar');
        }
      });
    }
  }

  // AÑADIR método para obtener clase CSS del estado
  getEstadoClass(estado: string): string {
    switch (estado) {
      case 'PENDIENTE': return 'badge bg-warning';
      case 'ACEPTADA': return 'badge bg-success';
      case 'RECHAZADA': return 'badge bg-danger';
      case 'CANCELADA': return 'badge bg-secondary';
      default: return 'badge bg-light';
    }
  }

  // AÑADIR método para formatear fecha
  formatearFecha(fecha: string): string {
    return new Date(fecha).toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }

  // AÑADIR método getEstadoIcon que falta:
  getEstadoIcon(estado: string): string {
    switch (estado) {
      case 'PENDIENTE': return 'bi bi-clock';
      case 'ACEPTADA': return 'bi bi-check-circle';
      case 'RECHAZADA': return 'bi bi-x-circle';
      case 'CANCELADA': return 'bi bi-slash-circle';
      default: return 'bi bi-question-circle';
    }
  }

  volver(): void {
    window.history.back();
  }
}
