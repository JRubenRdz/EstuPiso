import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AnuncianteService {

constructor(private http: HttpClient) { }

  private urlAPI = environment.apiUrl + '/anunciante';

  guardarAnunciante(anunciante: any): Observable<void> {
    return this.http.post<void>(`${this.urlAPI}`, anunciante);
  }

  actualizarAnunciante(anunciante: any): Observable<void> {
    return this.http.put<void>(`${this.urlAPI}`, anunciante);
  }

  getAllAnunciantes(): Observable<any[]> {
    return this.http.get<any[]>(`${this.urlAPI}/all`);
  }

  getAnuncianteByUsuario(usuario: string): Observable<any> {
    return this.http.get<any>(`${this.urlAPI}/user/${usuario}`);
  }

  getAnuncianteById(id: number): Observable<any> {
    return this.http.get<any>(`${this.urlAPI}/${id}`);
  }

  eliminarAnuncianteLogeado(): Observable<void> {
    return this.http.delete<void>(`${this.urlAPI}`);
  }

}
