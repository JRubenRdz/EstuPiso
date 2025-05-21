import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';
import { Estudiante } from '../model/Estudiante';

@Injectable({
  providedIn: 'root'
})
export class EstudianteService {

constructor(private http: HttpClient) { }
  private urlAPI = environment.apiUrl + '/estudiante';
  
  guardarEstudiante(estudiante: any): Observable<void> {
    return this.http.post<any>(`${this.urlAPI}`, estudiante);
  }
  
  actualizarEstudiante(estudiante: any): Observable<void> {
    return this.http.put<void>(`${this.urlAPI}`, estudiante);
  }

  getAllEstudiantes(): Observable<any[]> {
    return this.http.get<any[]>(`${this.urlAPI}/all`);
  }

  getEstudianteByUsuario(usuario: string): Observable<any> {
    return this.http.get<any>(`${this.urlAPI}/user/${usuario}`);
  }

  getEstudianteById(id: number): Observable<any> {
    return this.http.get<any>(`${this.urlAPI}/${id}`);
  }

  eliminarEstudianteLogeado(): Observable<void> {
    return this.http.delete<void>(`${this.urlAPI}`);
  }

}
