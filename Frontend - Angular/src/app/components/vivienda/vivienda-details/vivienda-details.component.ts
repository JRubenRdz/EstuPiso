import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { ViviendaService } from '../../../service/vivienda.service';
import { jwtDecode } from 'jwt-decode';
import { MapComponent } from '../../map/map.component';
import { SolicitudViviendaService } from '../../../service/solicitudvivienda.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-vivienda-details',
  imports: [CommonModule, MapComponent, FormsModule], // <-- Añadir FormsModule
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

  // Nuevas propiedades para solicitudes
  tieneSolicitudPendiente = false;
  solicitudActual: any = null;
  mostrandoFormularioSolicitud = false;
  mensajeSolicitud = '';
  enviandoSolicitud = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private viviendaService: ViviendaService,
    private solicitudService: SolicitudViviendaService
  ) {}

  ngOnInit(): void {
    this.viviendaId = Number(this.route.snapshot.paramMap.get('id'));
    this.checkUserAuthentication();
    this.loadViviendaDetails();
  }

  // CORREGIDO: Método sin AuthService
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

        // Establecer roles
        this.esEstudiante = this.usuarioActual.tipoUsuario === 'ESTUDIANTE';
        this.esAnunciante = this.usuarioActual.tipoUsuario === 'ANUNCIANTE';
        
        console.log('Usuario autenticado:', this.usuarioActual);

        // Verificar si tiene solicitud pendiente (solo para estudiantes)
        if (this.esEstudiante && this.viviendaId) {
          this.verificarSolicitudPendiente();
        }
        
      } catch (error) {
        console.error('Error al decodificar token:', error);
        this.usuarioActual = null;
        this.esEstudiante = false;
        this.esAnunciante = false;
        localStorage.removeItem('token');
      }
    } else {
      this.usuarioActual = null;
      this.esEstudiante = false;
      this.esAnunciante = false;
    }
  }

  verificarSolicitudPendiente(): void {
    if (this.usuarioActual && this.esEstudiante) {
      this.solicitudService.obtenerSolicitudesEstudiante(this.usuarioActual.id).subscribe({
        next: (solicitudes) => {
          this.solicitudActual = solicitudes.find(s => 
            s.viviendaId === this.viviendaId && s.estado === 'PENDIENTE'
          );
          this.tieneSolicitudPendiente = !!this.solicitudActual;
        },
        error: (error) => {
          console.error('Error al verificar solicitudes:', error);
        }
      });
    }
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

  // NUEVO: Mostrar formulario de solicitud
  mostrarFormularioSolicitud(): void {
    if (!this.usuarioActual || !this.esEstudiante) {
      alert('Debes estar logueado como estudiante para solicitar una vivienda');
      return;
    }
    
    this.mostrandoFormularioSolicitud = true;
    this.mensajeSolicitud = '';
  }

  // NUEVO: Cancelar formulario
  cancelarSolicitud(): void {
    this.mostrandoFormularioSolicitud = false;
    this.mensajeSolicitud = '';
  }

  // NUEVO: Enviar solicitud
  enviarSolicitud(): void {
    if (!this.usuarioActual || !this.esEstudiante) {
      alert('Debes estar logueado como estudiante para solicitar una vivienda');
      return;
    }

    this.enviandoSolicitud = true;

    const solicitudDto = {
      viviendaId: this.viviendaId,
      mensaje: this.mensajeSolicitud.trim() || undefined
    };

    this.solicitudService.crearSolicitud(this.usuarioActual.id, solicitudDto).subscribe({
      next: (solicitud) => {
        this.solicitudActual = solicitud;
        this.tieneSolicitudPendiente = true;
        this.mostrandoFormularioSolicitud = false;
        this.mensajeSolicitud = '';
        this.enviandoSolicitud = false;
        
        // Mostrar modal de éxito
        alert('¡Solicitud enviada correctamente! El anunciante será notificado.');
      },
      error: (error) => {
        console.error('Error al enviar solicitud:', error);
        this.enviandoSolicitud = false;
        alert('Error al enviar la solicitud: ' + (error.error?.message || 'Error desconocido'));
      }
    });
  }

  // NUEVO: Cancelar solicitud pendiente
  cancelarSolicitudPendiente(): void {
    if (!this.solicitudActual || !this.usuarioActual) return;

    if (confirm('¿Estás seguro de que quieres cancelar tu solicitud?')) {
      this.solicitudService.cancelarSolicitud(this.solicitudActual.id, this.usuarioActual.id).subscribe({
        next: () => {
          this.solicitudActual = null;
          this.tieneSolicitudPendiente = false;
          alert('Solicitud cancelada correctamente');
        },
        error: (error) => {
          console.error('Error al cancelar solicitud:', error);
          alert('Error al cancelar la solicitud');
        }
      });
    }
  }

  // Actualizar método existente
  puedeAplicar(): boolean {
    return this.esEstudiante && 
           !this.yaEsResidente && 
           !this.tieneSolicitudPendiente &&
           this.getEstadoVivienda() !== 'Completa';
  }

  // Método que faltaba
  aplicarVivienda(): void {
    // Redirigir al formulario de solicitud o mostrar el modal
    this.mostrarFormularioSolicitud();
  }
}
