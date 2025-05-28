import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { EstudianteService } from './estudiante.service';
import { AnuncianteService } from './anunciante.service';
import { AdminService } from './admin.service';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {

  constructor(
    private estudianteService: EstudianteService,
    private anuncianteService: AnuncianteService,
    private adminService: AdminService
  ) { }

  eliminarCuentaSegunRol(rol: string): Observable<void> {
    switch (rol) {
      case 'ESTUDIANTE':
        return this.estudianteService.eliminarEstudianteLogeado();
      case 'ANUNCIANTE':
        return this.anuncianteService.eliminarAnuncianteLogeado();
      case 'ADMIN':
        return this.adminService.eliminarAdminLogeado();
      default:
        throw new Error('Rol no válido para eliminación');
    }
  }
}