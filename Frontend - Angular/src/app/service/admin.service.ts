import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Admin } from '../model/Admin';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  constructor(private http: HttpClient) { }

  private urlAPI = environment.apiUrl + '/admin';

  guardarAdmin(admin: Admin): Observable<void> {
    return this.http.post<void>(`${this.urlAPI}`, admin);
  }

  actualizarAdmin(admin: Admin): Observable<void> {
    return this.http.put<void>(`${this.urlAPI}`, admin);
  }

  getAdminByUsuario(usuario: string): Observable<Admin> {
    return this.http.get<Admin>(`${this.urlAPI}/user/${usuario}`);
  }

  eliminarAdminLogeado(): Observable<void> {
    return this.http.delete<void>(`${this.urlAPI}`);
  }
}
