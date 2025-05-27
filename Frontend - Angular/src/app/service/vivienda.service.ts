import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ViviendaService {

  constructor(private http: HttpClient) { }

  private urlApi = environment.apiUrl + '/vivienda';

  crearVivienda(vivienda: any): Observable<void> {
    return this.http.post<void>(`${this.urlApi}`, vivienda);
  }

  actualizarVivienda(vivienda: any): Observable<void> {
    return this.http.put<void>(`${this.urlApi}`, vivienda);
  }

  getAllViviendas(): Observable<any[]> {
    return this.http.get<any[]>(`${this.urlApi}/all`);
  }

  getViviendasByAnunciante(): Observable<any[]> {
    return this.http.get<any[]>(`${this.urlApi}/all`);
  }

  getViviendaById(id: number): Observable<any> {
    return this.http.get<any>(`${this.urlApi}/${id}`);
  }


  buscarViviendas(
    comunidad?: string,
    provincia?: string,
    municipio?: string,
    nombre?: string,
    soloDisponibles: boolean = false,
    direccion?: string,
    pagina: number = 0,
    tamañoPagina: number = 10
  ): Observable<any> {
    const params: any = {
      soloDisponibles,
      pagina,
      tamañoPagina
    };
    if (comunidad) params.comunidad = comunidad;
    if (provincia) params.provincia = provincia;
    if (municipio) params.municipio = municipio;
    if (nombre) params.nombre = nombre;
    if (direccion) params.direccion = direccion;

    return this.http.get<any>(`${this.urlApi}/buscar`, { params });
  }

  añadirResidente(idVivienda: number, idEstudiante: number): Observable<void> {
    return this.http.get<void>(`${this.urlApi}/${idVivienda}/residente/${idEstudiante}`);
  }

  deleteVivienda(id: number): Observable<void> {
    return this.http.delete<void>(`${this.urlApi}/${id}`);
  }

}
