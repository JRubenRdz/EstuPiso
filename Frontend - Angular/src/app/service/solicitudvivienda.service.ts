import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment.development';

export interface CrearSolicitudDto {
  viviendaId: number;
  mensaje?: string;
}

export interface SolicitudViviendaDto {
  id: number;
  estudianteId: number;
  estudianteNombre: string;
  estudianteEmail: string;
  viviendaId: number;
  viviendaTitulo: string;
  viviendaCalle: string;
  viviendaNumero: string;
  estado: 'PENDIENTE' | 'ACEPTADA' | 'RECHAZADA' | 'CANCELADA';
  fechaSolicitud: string;
  fechaRespuesta?: string;
  mensaje?: string;
  respuestaAnunciante?: string;
}

@Injectable({
  providedIn: 'root'
})
export class SolicitudViviendaService {

  constructor(private http: HttpClient) { }

  private urlApi = environment.apiUrl + '/solicitudes';

  // Crear solicitud (estudiante)
  crearSolicitud(estudianteId: number, dto: CrearSolicitudDto): Observable<SolicitudViviendaDto> {
    return this.http.post<SolicitudViviendaDto>(`${this.urlApi}/crear/${estudianteId}`, dto);
  }

  // Obtener solicitudes del estudiante
  obtenerSolicitudesEstudiante(estudianteId: number): Observable<SolicitudViviendaDto[]> {
    return this.http.get<SolicitudViviendaDto[]>(`${this.urlApi}/estudiante/${estudianteId}`);
  }

  // Obtener solicitudes para el anunciante
  obtenerSolicitudesAnunciante(anuncianteId: number): Observable<SolicitudViviendaDto[]> {
    return this.http.get<SolicitudViviendaDto[]>(`${this.urlApi}/anunciante/${anuncianteId}`);
  }

  // Aceptar solicitud
  aceptarSolicitud(solicitudId: number, anuncianteId: number, respuesta?: string): Observable<SolicitudViviendaDto> {
    const body = respuesta ? { respuesta } : {};
    return this.http.put<SolicitudViviendaDto>(`${this.urlApi}/${solicitudId}/aceptar/${anuncianteId}`, body);
  }

  // Rechazar solicitud
  rechazarSolicitud(solicitudId: number, anuncianteId: number, respuesta?: string): Observable<SolicitudViviendaDto> {
    const body = respuesta ? { respuesta } : {};
    return this.http.put<SolicitudViviendaDto>(`${this.urlApi}/${solicitudId}/rechazar/${anuncianteId}`, body);
  }

  // Cancelar solicitud (estudiante)
  cancelarSolicitud(solicitudId: number, estudianteId: number): Observable<void> {
    return this.http.put<void>(`${this.urlApi}/${solicitudId}/cancelar/${estudianteId}`, {});
  }
}