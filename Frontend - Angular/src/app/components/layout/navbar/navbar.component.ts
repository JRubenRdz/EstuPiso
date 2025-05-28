import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { jwtDecode } from 'jwt-decode';
import { UsuarioService } from '../../../service/usuario.service';

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
  eliminandoCuenta = false;

  constructor(
    private router: Router,
    private usuarioService: UsuarioService // AÑADIR
  ) {}

  ngOnInit(): void {
    this.checkUserAuthentication();
  }

  checkUserAuthentication(): void {
    const token = localStorage.getItem('token');
    if (token) {
      try {
        const decodedToken: any = jwtDecode(token);
        
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
      alert('No se pudo determinar el tipo de usuario');
      this.eliminandoCuenta = false;
      return;
    }

    this.eliminandoCuenta = true;

    try {
      this.usuarioService.eliminarCuentaSegunRol(this.rol).subscribe({
        next: () => {
          alert('Cuenta eliminada correctamente');
          this.logout();
          this.cerrarModalEliminar();
        },
        error: (error) => {
          console.error('Error al eliminar cuenta:', error);
          this.eliminandoCuenta = false;
          alert('Error al eliminar la cuenta: ' + (error.error?.message || 'Error desconocido'));
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
}
