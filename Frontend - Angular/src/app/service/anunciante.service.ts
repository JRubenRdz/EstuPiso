import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/active.environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AnuncianteService {

constructor(private http: HttpClient) { }

  private urlAPI = environment.apiUrl + '/anunciante';

  guardarAnunciante(anunciante: any): Observable<any> {
    return this.http.post<any>(`${this.urlAPI}`, anunciante);
  }

  actualizarAnunciante(anunciante: any): Observable<any> {
    return this.http.put<any>(`${this.urlAPI}`, anunciante);
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
