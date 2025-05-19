import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-navbar',
  imports: [CommonModule, RouterLink],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {
  token: string | null = localStorage.getItem('token');
  rol!: string
  nombreUsuario !: string

  constructor(private router: Router) {
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
}
