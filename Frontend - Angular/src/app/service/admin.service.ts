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
  return this.http.post<any>(`${this.urlAPI}`, admin);
}

actualizarAdmin(admin: Admin): Observable<void> {
  return this.http.put<any>(`${this.urlAPI}`, admin);
}

getAdminByUsuario(usuario: string): Observable<Admin> {
  return this.http.get<Admin>(`${this.urlAPI}/user/${usuario}`);
}
}
