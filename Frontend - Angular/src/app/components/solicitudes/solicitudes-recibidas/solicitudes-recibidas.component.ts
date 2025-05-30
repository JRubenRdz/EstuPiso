import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { jwtDecode } from 'jwt-decode';
import { SolicitudViviendaService, SolicitudViviendaDto } from '../../../service/solicitudvivienda.service';
import { ViviendaService } from '../../../service/vivienda.service';

@Component({
  selector: 'app-solicitudes-recibidas',
  standalone: true,
  imports: [CommonModule, RouterModule, FormsModule],
  templateUrl: './solicitudes-recibidas.component.html',
  styleUrl: './solicitudes-recibidas.component.css'
})
export class SolicitudesRecibidasComponent implements OnInit {
  // INICIALIZAR las propiedades como arrays vacíos
  solicitudes: SolicitudViviendaDto[] = [];
  solicitudesPendientes: SolicitudViviendaDto[] = [];
  solicitudesRespondidas: SolicitudViviendaDto[] = [];
  
  usuarioActual: any = null;
  isLoading = true;
  error: string | null = null;

  // Modal de respuesta
  mostrandoModalRespuesta = false;
  solicitudSeleccionada: SolicitudViviendaDto | null = null;
  tipoRespuesta: 'aceptar' | 'rechazar' = 'aceptar';
  mensajeRespuesta = '';
  enviandoRespuesta = false;

  constructor(
    private solicitudService: SolicitudViviendaService,
    private viviendaService: ViviendaService
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

        console.log('Usuario en solicitudes-recibidas:', this.usuarioActual);

        if (this.usuarioActual.tipoUsuario !== 'ANUNCIANTE') {
          this.error = 'Solo los anunciantes pueden acceder a esta sección';
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
      this.error = 'Debes iniciar sesión para ver las solicitudes';
      this.isLoading = false;
    }
  }

  cargarSolicitudes(): void {
    if (!this.usuarioActual?.id) {
      this.error = 'No se pudo identificar al usuario';
      this.isLoading = false;
      return;
    }

    console.log('Cargando solicitudes para anunciante ID:', this.usuarioActual.id);

    this.solicitudService.obtenerSolicitudesAnunciante(this.usuarioActual.id).subscribe({
      next: (solicitudes) => {
        console.log('Solicitudes recibidas:', solicitudes);
        
        // ASEGURAR que solicitudes no sea null
        this.solicitudes = solicitudes || [];
        
        // Separar solicitudes por estado
        this.solicitudesPendientes = this.solicitudes.filter(s => s.estado === 'PENDIENTE');
        this.solicitudesRespondidas = this.solicitudes.filter(s => 
          s.estado === 'ACEPTADA' || s.estado === 'RECHAZADA' || s.estado === 'CANCELADA'
        );
        
        console.log('Solicitudes pendientes:', this.solicitudesPendientes.length);
        console.log('Solicitudes respondidas:', this.solicitudesRespondidas.length);
        
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error al cargar solicitudes:', error);
        this.error = 'Error al cargar las solicitudes: ' + (error.error?.message || 'Error desconocido');
        
        // ASEGURAR que las propiedades estén inicializadas incluso en caso de error
        this.solicitudes = [];
        this.solicitudesPendientes = [];
        this.solicitudesRespondidas = [];
        
        this.isLoading = false;
      }
    });
  }

  getEstadoClass(estado: string): string {
    switch (estado) {
      case 'PENDIENTE': return 'bg-warning text-dark';
      case 'ACEPTADA': return 'bg-success text-white';
      case 'RECHAZADA': return 'bg-danger text-white';
      case 'CANCELADA': return 'bg-secondary text-white';
      default: return 'bg-light text-dark';
    }
  }

  getEstadoIcon(estado: string): string {
    switch (estado) {
      case 'PENDIENTE': return 'bi-clock';
      case 'ACEPTADA': return 'bi-check-circle';
      case 'RECHAZADA': return 'bi-x-circle';
      case 'CANCELADA': return 'bi-slash-circle';
      default: return 'bi-question-circle';
    }
  }

  formatearFecha(fecha: string): string {
    if (!fecha) return 'Fecha no disponible';
    
    const fechaObj = new Date(fecha);
    return fechaObj.toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }

  abrirModalRespuesta(solicitud: SolicitudViviendaDto, tipo: 'aceptar' | 'rechazar'): void {
    this.solicitudSeleccionada = solicitud;
    this.tipoRespuesta = tipo;
    this.mensajeRespuesta = '';
    this.mostrandoModalRespuesta = true;
  }

  cerrarModalRespuesta(): void {
    this.mostrandoModalRespuesta = false;
    this.solicitudSeleccionada = null;
    this.mensajeRespuesta = '';
    this.enviandoRespuesta = false;
  }

  enviarRespuesta(): void {
    if (!this.solicitudSeleccionada || !this.usuarioActual) return;

    this.enviandoRespuesta = true;

    const respuesta = this.mensajeRespuesta.trim() || undefined;

    if (this.tipoRespuesta === 'aceptar') {
      this.solicitudService.aceptarSolicitud(this.solicitudSeleccionada.id, this.usuarioActual.id, respuesta).subscribe({
        next: (solicitudActualizada) => {
          console.log('Solicitud aceptada:', solicitudActualizada);
          this.cerrarModalRespuesta();
          this.cargarSolicitudes(); // Recargar la lista
          this.viviendaService.añadirResidente(this.solicitudSeleccionada?.viviendaId, this.solicitudSeleccionada?.estudianteId).subscribe({
            next: (residente) => {
              alert('Solicitud aceptada correctamente');
            },
            error: (error) => {
              alert('Error al añadir residente: ' + (error.error?.message || 'Error desconocido'));
            }
          });
        },
        error: (error) => {
          console.error('Error al aceptar solicitud:', error);
          this.enviandoRespuesta = false;
          alert('Error al aceptar la solicitud: ' + (error.error?.message || 'Error desconocido'));
        }
      });
    } else {
      this.solicitudService.rechazarSolicitud(this.solicitudSeleccionada.id, this.usuarioActual.id, respuesta).subscribe({
        next: (solicitudActualizada) => {
          console.log('Solicitud rechazada:', solicitudActualizada);
          this.cerrarModalRespuesta();
          this.cargarSolicitudes(); // Recargar la lista
          alert('Solicitud rechazada correctamente');
        },
        error: (error) => {
          console.error('Error al rechazar solicitud:', error);
          this.enviandoRespuesta = false;
          alert('Error al rechazar la solicitud: ' + (error.error?.message || 'Error desconocido'));
        }
      });
    }
  }
}
