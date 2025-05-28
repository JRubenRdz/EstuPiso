import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { SolicitudViviendaService, SolicitudViviendaDto } from '../../../service/solicitudvivienda.service';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-mis-solicitudes',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './mis-solicitudes.component.html',
  styleUrl: './mis-solicitudes.component.css'
})
export class MisSolicitudesComponent implements OnInit {
  solicitudes: SolicitudViviendaDto[] = [];
  isLoading = true;
  error = '';
  usuarioActual: any = null;

  constructor(
    private solicitudService: SolicitudViviendaService,
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
          tipoUsuario: decodedToken.rol 
        };

        if (this.usuarioActual.rol === 'ESTUDIANTE') {
          this.loadSolicitudes();
        } else {
          this.error = 'Solo los estudiantes pueden ver sus solicitudes';
          this.isLoading = false;
        }
      } catch (error) {
        this.error = 'Error al verificar la autenticación';
        this.isLoading = false;
        localStorage.removeItem('token');
      }
    } else {
      this.error = 'Debes iniciar sesión para ver tus solicitudes';
      this.isLoading = false;
    }
  }

  loadSolicitudes(): void {
    this.solicitudService.obtenerSolicitudesEstudiante(this.usuarioActual.id).subscribe({
      next: (solicitudes) => {
        this.solicitudes = solicitudes;
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error al cargar solicitudes:', error);
        this.error = 'Error al cargar las solicitudes';
        this.isLoading = false;
      }
    });
  }

  cancelarSolicitud(solicitud: SolicitudViviendaDto): void {
    if (solicitud.estado !== 'PENDIENTE') {
      alert('Solo se pueden cancelar solicitudes pendientes');
      return;
    }

    if (confirm(`¿Estás seguro de que quieres cancelar tu solicitud para "${solicitud.viviendaTitulo}"?`)) {
      this.solicitudService.cancelarSolicitud(solicitud.id, this.usuarioActual.id).subscribe({
        next: () => {
          this.loadSolicitudes(); // Recargar lista
          alert('Solicitud cancelada correctamente');
        },
        error: (error) => {
          console.error('Error al cancelar solicitud:', error);
          alert('Error al cancelar la solicitud');
        }
      });
    }
  }

  getEstadoClass(estado: string): string {
    switch (estado) {
      case 'PENDIENTE': return 'bg-warning text-dark';
      case 'ACEPTADA': return 'bg-success';
      case 'RECHAZADA': return 'bg-danger';
      case 'CANCELADA': return 'bg-secondary';
      default: return 'bg-secondary';
    }
  }

  getEstadoIcon(estado: string): string {
    switch (estado) {
      case 'PENDIENTE': return 'bi-clock';
      case 'ACEPTADA': return 'bi-check-circle';
      case 'RECHAZADA': return 'bi-x-circle';
      case 'CANCELADA': return 'bi-dash-circle';
      default: return 'bi-question-circle';
    }
  }

  formatearFecha(fecha: string): string {
    return new Date(fecha).toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }
}
