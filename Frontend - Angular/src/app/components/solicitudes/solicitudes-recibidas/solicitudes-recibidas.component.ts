import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { SolicitudViviendaService, SolicitudViviendaDto } from '../../../service/solicitudvivienda.service';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-solicitudes-recibidas',
  standalone: true,
  imports: [CommonModule, RouterModule, FormsModule],
  templateUrl: './solicitudes-recibidas.component.html',
  styleUrl: './solicitudes-recibidas.component.css'
})
export class SolicitudesRecibidasComponent implements OnInit {
  solicitudes: SolicitudViviendaDto[] = [];
  isLoading = true;
  error = '';
  usuarioActual: any = null;
  
  // Modal de respuesta
  mostrandoModalRespuesta = false;
  solicitudSeleccionada: SolicitudViviendaDto | null = null;
  tipoRespuesta: 'aceptar' | 'rechazar' = 'aceptar';
  mensajeRespuesta = '';
  enviandoRespuesta = false;

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
          user: decodedToken.sub,
          email: decodedToken.email,
          rol: decodedToken.rol
        };

        if (this.usuarioActual.rol === 'ANUNCIANTE') {
          this.loadSolicitudes();
        } else {
          this.error = 'Solo los anunciantes pueden ver solicitudes recibidas';
          this.isLoading = false;
        }
      } catch (error) {
        console.error('Error al decodificar token:', error);
        this.error = 'Error al verificar la autenticación';
        this.isLoading = false;
        localStorage.removeItem('token');
      }
    } else {
      this.error = 'Debes iniciar sesión para ver las solicitudes';
      this.isLoading = false;
    }
  }

  loadSolicitudes(): void {
    this.solicitudService.obtenerSolicitudesAnunciante(this.usuarioActual.id).subscribe({
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

  // Abrir modal para responder
  abrirModalRespuesta(solicitud: SolicitudViviendaDto, tipo: 'aceptar' | 'rechazar'): void {
    if (solicitud.estado !== 'PENDIENTE') {
      alert('Esta solicitud ya ha sido respondida');
      return;
    }

    this.solicitudSeleccionada = solicitud;
    this.tipoRespuesta = tipo;
    this.mensajeRespuesta = '';
    this.mostrandoModalRespuesta = true;
  }

  // Cerrar modal
  cerrarModalRespuesta(): void {
    this.mostrandoModalRespuesta = false;
    this.solicitudSeleccionada = null;
    this.mensajeRespuesta = '';
    this.enviandoRespuesta = false;
  }

  // Enviar respuesta
  enviarRespuesta(): void {
    if (!this.solicitudSeleccionada) return;

    this.enviandoRespuesta = true;
    const respuesta = this.mensajeRespuesta.trim() || undefined;

    const observable = this.tipoRespuesta === 'aceptar' 
      ? this.solicitudService.aceptarSolicitud(this.solicitudSeleccionada.id, this.usuarioActual.id, respuesta)
      : this.solicitudService.rechazarSolicitud(this.solicitudSeleccionada.id, this.usuarioActual.id, respuesta);

    observable.subscribe({
      next: () => {
        this.loadSolicitudes(); // Recargar lista
        this.cerrarModalRespuesta();
        alert(`Solicitud ${this.tipoRespuesta === 'aceptar' ? 'aceptada' : 'rechazada'} correctamente`);
      },
      error: (error) => {
        console.error('Error al responder solicitud:', error);
        this.enviandoRespuesta = false;
        alert('Error al responder la solicitud');
      }
    });
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

  // Filtrar solicitudes
  get solicitudesPendientes(): SolicitudViviendaDto[] {
    return this.solicitudes.filter(s => s.estado === 'PENDIENTE');
  }

  get solicitudesRespondidas(): SolicitudViviendaDto[] {
    return this.solicitudes.filter(s => s.estado !== 'PENDIENTE');
  }
}
