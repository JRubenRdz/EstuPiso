import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/active.environment';
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

  actualizarVivienda(vivienda: any): Observable<any> { 
    return this.http.put<any>(`${this.urlApi}`, vivienda);
  }

  getAllViviendas(): Observable<any[]> {
    return this.http.get<any[]>(`${this.urlApi}/all`);
  }

  getViviendasByAnunciante(): Observable<any[]> {
    return this.http.get<any[]>(`${this.urlApi}/all/user-login`);
  }

  getViviendaById(id: number): Observable<any> {
    return this.http.get<any>(`${this.urlApi}/${id}`);
  }  buscarViviendas(
    comunidad?: string,
    provincia?: string,
    municipio?: string,
    nombre?: string,
    tipoVivienda?: string,
    precioMin?: number,
    precioMax?: number,
    habitaciones?: number,
    soloDisponibles: boolean = false,
    direccion?: string,
    pagina: number = 0,
    tamanoPagina: number = 10
  ): Observable<any> {
    const params: any = {
      soloDisponibles,
      pagina,
      tamanoPagina
    };
    if (comunidad) params.comunidad = comunidad;
    if (provincia) params.provincia = provincia;
    if (municipio) params.municipio = municipio;
    if (nombre) params.nombre = nombre;
    if (tipoVivienda) params.tipoVivienda = tipoVivienda;
    if (precioMin !== undefined && precioMin !== null) params.precioMin = precioMin;
    if (precioMax !== undefined && precioMax !== null) params.precioMax = precioMax;
    if (habitaciones !== undefined && habitaciones !== null) params.habitaciones = habitaciones;
    if (direccion) params.direccion = direccion;

    return this.http.get<any>(`${this.urlApi}/buscar`, { params });
  }

  añadirResidente(idVivienda: any, idEstudiante: any): Observable<any> {
    return this.http.post<any>(`${this.urlApi}/${idVivienda}/residente/${idEstudiante}`, {});
  }

  deleteVivienda(id: number): Observable<void> {
    return this.http.delete<void>(`${this.urlApi}/${id}`);
  }
}
