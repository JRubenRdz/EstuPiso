import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { jwtDecode } from 'jwt-decode';
import { SolicitudViviendaService, CrearSolicitudDto } from '../../../service/solicitudvivienda.service';
import { ViviendaService } from '../../../service/vivienda.service';
import { ModalService } from '../../../service/modal.service';
import { MapComponent } from '../../map/map.component';

@Component({
  selector: 'app-vivienda-details',
  standalone: true,
  imports: [CommonModule, RouterModule, FormsModule, MapComponent],
  templateUrl: './vivienda-details.component.html',
  styleUrl: './vivienda-details.component.css'
})
export class ViviendaDetailsComponent implements OnInit {
  vivienda: any = null;
  viviendaId: number = 0;
  usuarioActual: any = null;
  esEstudiante = false;
  esAnunciante = false;
  isLoading = true;
  error: string | null = null;
  nombreAnunciante: string | null = null;

  // Propiedades para solicitudes
  mostrandoFormularioSolicitud = false;
  mensajeSolicitud = '';
  enviandoSolicitud = false;
  solicitudEnviada = false;
  tieneSolicitudPendiente = false;
  
  // AÑADIR: Nueva propiedad para verificar si pertenece a la vivienda
  perteneceAVivienda = false;

  // AÑADIR: Propiedades para la gestión de estudiantes
  eliminandoEstudiante = false;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private solicitudService: SolicitudViviendaService,
    private viviendaService: ViviendaService,
    private modalService: ModalService
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe(params => {
      this.viviendaId = +params['id'];
      if (this.viviendaId) {
        this.checkUserAuthentication();
        this.cargarVivienda();
      } else {
        this.error = 'ID de vivienda no válido';
        this.isLoading = false;
      }
    });
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

        this.esEstudiante = this.usuarioActual.tipoUsuario === 'ESTUDIANTE';
        this.esAnunciante = this.usuarioActual.tipoUsuario === 'ANUNCIANTE';

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
  cargarVivienda(): void {
    if (!this.viviendaId) {
      this.error = 'ID de vivienda no válido';
      this.isLoading = false;
      return;
    }

    
    this.viviendaService.getViviendaById(this.viviendaId).subscribe({
      next: (vivienda) => {
        
        this.vivienda = vivienda;
        
        // AÑADIR: Obtener ocupación real (incluyendo solicitudes aceptadas)
        this.obtenerOcupacionReal();
        
        this.isLoading = false;
        this.error = null;
      },
      error: (error) => {
        this.isLoading = false;
        
        if (error.status === 404) {
          this.error = 'Vivienda no encontrada';
        } else if (error.status === 403) {
          this.error = 'No tienes permisos para ver esta vivienda';
        } else {
          this.error = 'Error al cargar la vivienda: ' + (error.error?.message || 'Error desconocido');
        }
      }
    });
  }
  // AÑADIR: Método para obtener ocupación real
  obtenerOcupacionReal(): void {
    if (!this.viviendaId) return;

    this.solicitudService.obtenerOcupacionActual(this.viviendaId).subscribe({
      next: (ocupacion) => {
        // El backend ya devuelve solo residentes físicos, sin doble conteo
        this.vivienda.ocupacionPorSolicitudes = 0; // Ya no hay solicitudes aceptadas pendientes
        this.vivienda.ocupacionTotal = ocupacion; // Solo residentes físicos actuales
      },
      error: (error) => {
        this.vivienda.ocupacionPorSolicitudes = 0;
        this.vivienda.ocupacionTotal = this.vivienda.residentes?.length || 0;
      }
    });
  }

  volver(): void {
    window.history.back();
  }
  mostrarFormularioSolicitud(): void {
    if (!this.usuarioActual || !this.esEstudiante) {
      this.modalService.showWarning('Debes estar logueado como estudiante para solicitar una vivienda', 'Acceso Requerido');
      return;
    }
    
    if (this.tieneSolicitudPendiente) {
      this.modalService.showInfo('Ya tienes una solicitud pendiente para esta vivienda', 'Solicitud Existente');
      return;
    }
    
    this.mostrandoFormularioSolicitud = true;
    this.mensajeSolicitud = '';
  }

  cerrarFormularioSolicitud(): void {
    this.mostrandoFormularioSolicitud = false;
    this.mensajeSolicitud = '';
  }  // MEJORAR el método enviarSolicitud con mejor manejo de errores:
  enviarSolicitud(): void {
    if (!this.usuarioActual || !this.esEstudiante) {
      this.modalService.showError('No estás autenticado como estudiante', 'Error de Autenticación');
      return;
    }

    // VERIFICACIÓN MÁS ROBUSTA - declarar como number, no number | null:
    let anuncianteId: number;
    
    // Intentar obtener el ID del anunciante de diferentes fuentes
    if (this.vivienda?.anunciante?.id) {
      anuncianteId = this.vivienda.anunciante.id;
    } else if (this.vivienda?.anuncianteId) {
      anuncianteId = this.vivienda.anuncianteId;
    } else {
      this.modalService.showError('No se pudo identificar al propietario de la vivienda. Contacta al administrador.', 'Error del Sistema');
      return; // SALIR aquí, no continuar con null
    }

    // EN ESTE PUNTO anuncianteId SIEMPRE SERÁ number, nunca null
    this.enviandoSolicitud = true;

    const solicitudData: CrearSolicitudDto = {
      viviendaId: this.viviendaId,
      anuncianteId: anuncianteId, // Ahora es definitivamente number
      mensaje: this.mensajeSolicitud.trim() || undefined
    };


    this.solicitudService.crearSolicitud(this.usuarioActual.id, solicitudData).subscribe({
      next: (response) => {
        this.solicitudEnviada = true;
        this.tieneSolicitudPendiente = true;
        this.enviandoSolicitud = false;
        this.cerrarFormularioSolicitud();
          // Recargar datos para refrescar el estado
        this.verificarSolicitudPendiente();
        this.obtenerOcupacionReal();
        
        this.modalService.showSuccess('Solicitud enviada correctamente. El anunciante será notificado.', '¡Solicitud Enviada!');
      },
      error: (error) => {
        console.error('Error al enviar solicitud:', error);
        this.enviandoSolicitud = false;
        
        let mensaje = 'Error al enviar la solicitud';
        if (error.error?.message) {
          mensaje = error.error.message;
        } else if (error.status === 401) {
          mensaje = 'No estás autorizado. Inicia sesión nuevamente.';
        } else if (error.status === 409) {
          mensaje = 'Ya tienes una solicitud pendiente para esta vivienda';        } else if (error.status === 400) {
          mensaje = error.error?.message || 'Datos inválidos en la solicitud';
        }
        
        this.modalService.showError(mensaje, 'Error al Enviar Solicitud');
      }
    });
  }

  // MEJORAR verificarSolicitudPendiente con reintento:
  verificarSolicitudPendiente(): void {
    if (!this.usuarioActual?.id || !this.viviendaId) return;

    // Verificar solicitud pendiente
    this.solicitudService.verificarSolicitudPendiente(this.usuarioActual.id, this.viviendaId).subscribe({
      next: (tieneSolicitud) => {
        this.tieneSolicitudPendiente = tieneSolicitud;
      },
      error: (error) => {
        this.tieneSolicitudPendiente = false;
      }
    });

    // Verificar si ya pertenece a la vivienda
    this.solicitudService.verificarPertenenciaVivienda(this.usuarioActual.id, this.viviendaId).subscribe({
      next: (pertenece) => {
        this.perteneceAVivienda = pertenece;
      },
      error: (error) => {
        console.error('Error al verificar pertenencia:', error);
        this.perteneceAVivienda = false;
      }
    });
  }
  puedeEditar(): boolean {
    
    if (!this.vivienda || !this.usuarioActual) {
      return false;
    }
    
    return this.vivienda.anuncianteId == this.usuarioActual.id;
  }

  editarVivienda(): void {
    if (this.viviendaId) {
      this.router.navigate(['/editar-vivienda', this.viviendaId]);
    }
  }

  // CORREGIR puedeAplicar para incluir la verificación de pertenencia:
  puedeAplicar(): boolean {
    return this.esEstudiante && 
           !this.tieneSolicitudPendiente && 
           !this.solicitudEnviada &&
           !this.perteneceAVivienda && // AÑADIR esta verificación
           this.usuarioActual &&
           this.vivienda;
  }

  // MEJORAR getEstadoVivienda para mostrar ocupación correcta:
  getEstadoVivienda(): string {
    if (!this.vivienda) return 'Estado desconocido';
    
    const habitaciones = this.vivienda.numeroHabitaciones || this.vivienda.habitaciones || 0;
    const ocupacionTotal = this.vivienda.ocupacionTotal || this.vivienda.residentes?.length || 0;
    
    if (ocupacionTotal === 0) {
      return 'Disponible';
    } else if (ocupacionTotal < habitaciones) {
      return `${ocupacionTotal}/${habitaciones} habitaciones ocupadas`;
    } else {
      return 'Completa';
    }
  }

  // CORREGIR getEstadoClass para reflejar ocupación real:
  getEstadoClass(): string {
    if (!this.vivienda) return 'bg-secondary';
    
    const habitaciones = this.vivienda.numeroHabitaciones || this.vivienda.habitaciones || 0;
    const ocupacionTotal = this.vivienda.ocupacionTotal || this.vivienda.residentes?.length || 0;
    
    if (ocupacionTotal === 0) {
      return 'bg-success text-white';
    } else if (ocupacionTotal < habitaciones) {
      return 'bg-warning text-dark';
    } else {
      return 'bg-danger text-white';
    }
  }

  onImageError(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target) {
      target.src = 'https://via.placeholder.com/800x400/e9ecef/6c757d?text=Imagen+no+disponible';
    }
  }

  formatearFecha(fecha: string | Date): string {
    if (!fecha) return 'Fecha no disponible';
    
    const fechaObj = typeof fecha === 'string' ? new Date(fecha) : fecha;
    
    return fechaObj.toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  puedeGestionarEstudiantes(): boolean {
    
    if (!this.vivienda || !this.usuarioActual) {
      return false;
    }
    
    if (this.usuarioActual.id == this.vivienda.anuncianteId || this.usuarioActual.tipoUsuario === 'ANUNCIANTE') {
      return true;
    }
    return false;
  }
  // CORREGIR el método eliminarEstudiante (ya está en tu código, solo verificar que esté completo):
  eliminarEstudiante(estudiante: any): void {
    
    if (!this.puedeGestionarEstudiantes()) {
      this.modalService.showWarning('No tienes permisos para eliminar estudiantes', 'Acceso Denegado');
      return;
    }

    // Verificar que tenemos el ID del anunciante
    if (!this.usuarioActual?.id) {
      this.modalService.showError('No se pudo identificar al usuario actual', 'Error de Sesión');
      return;
    }

    // Verificar que tenemos todos los datos necesarios
    if (!estudiante?.id) {
      this.modalService.showError('No se pudo identificar al estudiante', 'Error de Datos');
      return;
    }

    if (!this.viviendaId) {
      this.modalService.showError('No se pudo identificar la vivienda', 'Error de Datos');
      return;
    }

    
    this.modalService.showConfirm(
      `¿Estás seguro de que quieres eliminar a ${estudiante.nombre} de esta vivienda?\n\nEsta acción no se puede deshacer.`,
      'Confirmar Eliminación',
      () => {
        // Callback de confirmación
        this.eliminarEstudianteConfirmado(estudiante);
      },
      () => 
      'Cancelar',
      'Eliminar'
    );
  }private eliminarEstudianteConfirmado(estudiante: any): void {
    
    this.eliminandoEstudiante = true;

    // Pasar el ID del anunciante actual
    this.solicitudService.eliminarEstudianteDeVivienda(
      estudiante.id, 
      this.viviendaId, 
      this.usuarioActual.id
    ).subscribe({
      next: (response) => {
        
        this.modalService.showSuccess('Estudiante eliminado correctamente de la vivienda', '¡Estudiante Eliminado!');
        
        // Recargar la vivienda para actualizar la lista de residentes
        this.cargarVivienda();
        this.obtenerOcupacionReal();
        
        this.eliminandoEstudiante = false;
      },
      error: (error) => {
        this.eliminandoEstudiante = false;
        
        let mensaje = 'Error al eliminar el estudiante';
        if (error.error?.message || error.error) {
          mensaje = error.error.message || error.error;
        }
        
        this.modalService.showError(mensaje, 'Error al Eliminar Estudiante');
      }
    });
  }
}
