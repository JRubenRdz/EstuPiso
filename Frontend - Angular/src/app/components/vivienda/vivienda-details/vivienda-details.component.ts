import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { jwtDecode } from 'jwt-decode';
import { SolicitudViviendaService, CrearSolicitudDto } from '../../../service/solicitudvivienda.service';
import { ViviendaService } from '../../../service/vivienda.service';
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
    private viviendaService: ViviendaService
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

        console.log('Usuario autenticado:', this.usuarioActual);
        console.log('Es estudiante:', this.esEstudiante);

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

  // CORREGIR cargarVivienda para obtener datos completos:
  cargarVivienda(): void {
    if (!this.viviendaId) {
      this.error = 'ID de vivienda no válido';
      this.isLoading = false;
      return;
    }

    console.log('Cargando vivienda con ID:', this.viviendaId);

    

    this.viviendaService.getViviendaById(this.viviendaId).subscribe({
      next: (vivienda) => {
        console.log('=== DEBUG VIVIENDA CARGADA ===');
        console.log('Vivienda completa:', vivienda);
        console.log('Anunciante:', vivienda.anunciante);
        console.log('Anunciante ID:', vivienda.anunciante?.id);
        console.log('¿Tiene anunciante?:', !!vivienda.anunciante);
        
        this.vivienda = vivienda;
        
        // AÑADIR: Obtener ocupación real (incluyendo solicitudes aceptadas)
        this.obtenerOcupacionReal();
        
        this.isLoading = false;
        this.error = null;
      },
      error: (error) => {
        console.error('Error al cargar vivienda:', error);
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
        console.log('Ocupación actual:', ocupacion);
        // Añadir la ocupación por solicitudes aceptadas a la vivienda
        this.vivienda.ocupacionPorSolicitudes = ocupacion;
        this.vivienda.ocupacionTotal = (this.vivienda.residentes?.length || 0) + ocupacion;
      },
      error: (error) => {
        console.error('Error al obtener ocupación:', error);
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
      alert('Debes estar logueado como estudiante para solicitar una vivienda');
      return;
    }
    
    if (this.tieneSolicitudPendiente) {
      alert('Ya tienes una solicitud pendiente para esta vivienda');
      return;
    }
    
    this.mostrandoFormularioSolicitud = true;
    this.mensajeSolicitud = '';
  }

  cerrarFormularioSolicitud(): void {
    this.mostrandoFormularioSolicitud = false;
    this.mensajeSolicitud = '';
  }

  // MEJORAR el método enviarSolicitud con mejor manejo de errores:
  enviarSolicitud(): void {
    if (!this.usuarioActual || !this.esEstudiante) {
      alert('Error: No estás autenticado como estudiante');
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
      console.error('PROBLEMA: No se encontró el ID del anunciante');
      console.log('Estructura de vivienda:', this.vivienda);
      alert('Error: No se pudo identificar al propietario de la vivienda. Contacta al administrador.');
      return; // SALIR aquí, no continuar con null
    }

    // EN ESTE PUNTO anuncianteId SIEMPRE SERÁ number, nunca null
    this.enviandoSolicitud = true;

    const solicitudData: CrearSolicitudDto = {
      viviendaId: this.viviendaId,
      anuncianteId: anuncianteId, // Ahora es definitivamente number
      mensaje: this.mensajeSolicitud.trim() || undefined
    };

    console.log('Enviando solicitud:', solicitudData);

    this.solicitudService.crearSolicitud(this.usuarioActual.id, solicitudData).subscribe({
      next: (response) => {
        console.log('Solicitud enviada correctamente:', response);
        this.solicitudEnviada = true;
        this.tieneSolicitudPendiente = true;
        this.enviandoSolicitud = false;
        this.cerrarFormularioSolicitud();
        
        // Recargar datos para refrescar el estado
        this.verificarSolicitudPendiente();
        this.obtenerOcupacionReal();
        
        alert('Solicitud enviada correctamente. El anunciante será notificado.');
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
          mensaje = 'Ya tienes una solicitud pendiente para esta vivienda';
        } else if (error.status === 400) {
          mensaje = error.error?.message || 'Datos inválidos en la solicitud';
        }
        
        alert(mensaje);
      }
    });
  }

  // MEJORAR verificarSolicitudPendiente con reintento:
  verificarSolicitudPendiente(): void {
    if (!this.usuarioActual?.id || !this.viviendaId) return;

    console.log('Verificando estado del estudiante:', this.usuarioActual.id, 'para vivienda:', this.viviendaId);

    // Verificar solicitud pendiente
    this.solicitudService.verificarSolicitudPendiente(this.usuarioActual.id, this.viviendaId).subscribe({
      next: (tieneSolicitud) => {
        this.tieneSolicitudPendiente = tieneSolicitud;
        console.log('Tiene solicitud pendiente:', tieneSolicitud);
      },
      error: (error) => {
        console.error('Error al verificar solicitud pendiente:', error);
        this.tieneSolicitudPendiente = false;
      }
    });

    // Verificar si ya pertenece a la vivienda
    this.solicitudService.verificarPertenenciaVivienda(this.usuarioActual.id, this.viviendaId).subscribe({
      next: (pertenece) => {
        this.perteneceAVivienda = pertenece;
        console.log('Pertenece a la vivienda:', pertenece);
      },
      error: (error) => {
        console.error('Error al verificar pertenencia:', error);
        this.perteneceAVivienda = false;
      }
    });
  }

  puedeEditar(): boolean {
    return this.esAnunciante && 
           this.vivienda && 
           this.usuarioActual && 
           this.vivienda.anunciante?.id === this.usuarioActual.id;
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

  // AÑADIR: Método para verificar permisos de gestión
  puedeGestionarEstudiantes(): boolean {
    return this.esAnunciante && 
           this.vivienda && 
           this.usuarioActual && 
           this.vivienda.anunciante?.id === this.usuarioActual.id;
  }

  // CORREGIR el método eliminarEstudiante (ya está en tu código, solo verificar que esté completo):
  eliminarEstudiante(estudiante: any): void {
    if (!this.puedeGestionarEstudiantes()) {
      alert('No tienes permisos para eliminar estudiantes');
      return;
    }

    // Verificar que tenemos el ID del anunciante
    if (!this.usuarioActual?.id) {
      alert('Error: No se pudo identificar al usuario actual');
      return;
    }

    const confirmar = confirm(
      `¿Estás seguro de que quieres eliminar a ${estudiante.nombre} de esta vivienda?\n\n` +
      `Esta acción no se puede deshacer y el estudiante perderá acceso a la vivienda.`
    );

    if (!confirmar) return;

    this.eliminandoEstudiante = true;

    // Pasar el ID del anunciante actual
    this.solicitudService.eliminarEstudianteDeVivienda(
      estudiante.id, 
      this.viviendaId, 
      this.usuarioActual.id
    ).subscribe({
      next: (response) => {
        console.log('Estudiante eliminado:', response);
        alert('Estudiante eliminado correctamente de la vivienda');
        
        // Recargar la vivienda para actualizar la lista de residentes
        this.cargarVivienda();
        this.obtenerOcupacionReal();
        
        this.eliminandoEstudiante = false;
      },
      error: (error) => {
        console.error('Error al eliminar estudiante:', error);
        this.eliminandoEstudiante = false;
        
        let mensaje = 'Error al eliminar el estudiante';
        if (error.error?.message || error.error) {
          mensaje = error.error.message || error.error;
        }
        
        alert(mensaje);
      }
    });
  }
}
