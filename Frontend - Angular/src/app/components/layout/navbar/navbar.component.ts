import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { jwtDecode } from 'jwt-decode';
import { EstudianteService } from '../../../service/estudiante.service';
import { AnuncianteService } from '../../../service/anunciante.service';
import { AdminService } from '../../../service/admin.service';

@Component({
  selector: 'app-navbar',
  imports: [CommonModule, RouterLink],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
  providers: [EstudianteService, AnuncianteService, AdminService]
})
export class NavbarComponent {
  token: string | null = localStorage.getItem('token');
  rol!: string
  nombreUsuario !: string

  constructor(
    private router: Router,
    private estudianteService: EstudianteService,
    private anuncianteService: AnuncianteService,
    private adminService: AdminService
  ) {
    if (this.token !== null && this.token) {
      this.nombreUsuario = jwtDecode(this.token).sub ?? '';
      this.rol = jwtDecode<{ rol: string }>(this.token).rol;
    }
  }

  login() {
    this.router.navigateByUrl("/login");
  }

  register() {
    this.router.navigateByUrl("/register");
  }

  misDatos() {
    this.router.navigateByUrl("/mis-datos");
  }

  logout() {
    localStorage.removeItem("token");
    this.router.navigate(['/']).then(() => window.location.reload());
  }

  eliminarUsuario() {
    if (!this.rol) return;
    let eliminar$;
    if (this.rol === 'ESTUDIANTE') {
      eliminar$ = this.estudianteService.eliminarEstudianteLogeado();
    } else if (this.rol === 'ANUNCIANTE') {
      eliminar$ = this.anuncianteService.eliminarAnuncianteLogeado();
    } else if (this.rol === 'ADMIN') {
      eliminar$ = this.adminService.eliminarAdminLogeado();
    } else {
      return;
    }
    eliminar$.subscribe({
      next: () => {
        localStorage.removeItem('token');
        this.router.navigate(['/']).then(() => window.location.reload());
      },
      error: () => {
        alert('Error al eliminar el usuario.');
      }
    });
  }
}
