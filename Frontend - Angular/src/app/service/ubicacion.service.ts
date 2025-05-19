import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment.development';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UbicacionService {

constructor(private http: HttpClient) { }

private urlApi = environment.apiUrl;

getAllComunidades(): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/comunidad`);
}

getAllProvincias(): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/provincia`);
}

getAllMunicipios(): Observable<any[]> {
  return this.http.get<any[]>(`${this.urlApi}/municipio`);
}

}
