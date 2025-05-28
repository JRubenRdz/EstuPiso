import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/active.environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UbicacionService {

constructor(private http: HttpClient) { }

private urlApi = environment.apiUrl;

getAllComunidades(): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/comunidades`);
}

getAllProvincias(): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/provincias`);
}

getProvinciasByComunidad(comunidadId: number): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/provincias/comunidad/${comunidadId}`);
}

getAllMunicipios(): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/municipios`);
}

getMunicipiosByProvincia(provinciaId: number): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/municipios/provincia/${provinciaId}`);
}

}
