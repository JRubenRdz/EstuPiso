import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { jwtDecode } from 'jwt-decode';
import { UsuarioService } from '../../../service/usuario.service';
import { EstudianteService } from '../../../service/estudiante.service';
import { ModalService } from '../../../service/modal.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent implements OnInit {
  // Propiedades existentes
  id: number | null = null;
  username: string | null = null;
  email: string | null = null;
  rol: string | null = null;
  isLoggedIn = false;

  // NUEVAS propiedades para el modal de eliminar cuenta
  mostrandoModalEliminar = false;
  eliminandoCuenta = false;  constructor(
    private router: Router,
    private usuarioService: UsuarioService,
    private estudianteService: EstudianteService,
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
        
        // Validar expiración del token (más de 1 día)
        const currentTime = Date.now() / 1000; // Tiempo actual en segundos
        const tokenIssuedAt = decodedToken.iat || 0;
        const tokenExpiration = decodedToken.exp || 0;
        
        // Si han pasado más de 24 horas desde la emisión del token, hacer logout automático
        const dayInSeconds = 24 * 60 * 60; // 86400 segundos = 1 día
        if (currentTime - tokenIssuedAt > dayInSeconds) {
          this.logout();
          return;
        }
        
        // También verificar si el token ha expirado oficialmente
        if (currentTime > tokenExpiration) {
          this.logout();
          return;
        }
        
        this.id = decodedToken.id;
        this.username = decodedToken.sub;
        this.email = decodedToken.email;
        this.rol = decodedToken.rol;
        
        this.isLoggedIn = true;
      } catch (error) {
        console.error('Error al decodificar token:', error);
        this.logout();
      }
    } else {
      // Limpiar datos cuando no hay token
      this.id = null;
      this.username = null;
      this.email = null;
      this.rol = null;
      this.isLoggedIn = false;
    }
  }

  logout(): void {
    localStorage.removeItem('token');
    this.id = null;
    this.username = null;
    this.email = null;
    this.rol = null;
    this.isLoggedIn = false;
    this.router.navigate(['/']);
    window.location.reload();
  }

  reloadAuth(): void {
    this.checkUserAuthentication();
  }

  // NUEVOS métodos para el modal de eliminar cuenta
  mostrarModalEliminarCuenta(): void {
    this.mostrandoModalEliminar = true;
  }

  cerrarModalEliminar(): void {
    this.mostrandoModalEliminar = false;
    this.eliminandoCuenta = false;
  }
  // CORREGIDO: Eliminar cuenta según el rol
  eliminarCuenta(): void {
    if (!this.rol) {
      this.modalService.showError('No se pudo determinar el tipo de usuario', 'Error de Identificación');
      this.eliminandoCuenta = false;
      return;
    }

    this.eliminandoCuenta = true;

    try {
      this.usuarioService.eliminarCuentaSegunRol(this.rol).subscribe({
        next: () => {
          this.modalService.showSuccess('Cuenta eliminada correctamente', 'Cuenta Eliminada');
          this.logout();
          this.cerrarModalEliminar();
        },
        error: (error) => {
          console.error('Error al eliminar cuenta:', error);
          this.eliminandoCuenta = false;
          this.logout();
          window.location.reload();
        }
      });
    } catch (error) {
      console.error('Error:', error);
      this.eliminandoCuenta = false;
      alert('Error: ' + (error as Error).message);
    }
  }
  // OPCIONAL: Método para confirmar antes de eliminar
  confirmarEliminacion(): void {
    const tipoUsuario = this.rol?.toLowerCase() || 'usuario';
    const confirmacion = confirm(
      `¿Estás seguro de que quieres eliminar tu cuenta de ${tipoUsuario}?\n\n` +
      'Esta acción no se puede deshacer y se eliminarán todos tus datos.'
    );
    
    if (confirmacion) {
      this.eliminarCuenta();
    } else {
      this.cerrarModalEliminar();
    }
  }
  // NUEVO: Método para navegar a "Mi vivienda" para estudiantes
  irAMiVivienda(): void {
    if (!this.isLoggedIn || this.rol !== 'ESTUDIANTE' || !this.id) {
      console.error('Error: Usuario no autenticado o no es estudiante');
      return;
    }

    this.estudianteService.getEstudianteById(this.id).subscribe({
      next: (estudiante: any) => {
        if (estudiante && estudiante.viviendaId) {
          // Navegar a la página de detalles de la vivienda del estudiante
          this.router.navigate(['/anuncio', estudiante.viviendaId]);
        }
      },
      error: (error: any) => {
        console.error('Error al obtener datos del estudiante:', error);
        alert('Actualmente no eres miembro de ninguna vivienda');
      }
    });
  }
}
