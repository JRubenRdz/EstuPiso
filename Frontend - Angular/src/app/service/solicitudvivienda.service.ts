import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from '../../environments/environment.development';

export interface CrearSolicitudDto {
  viviendaId: number;
  anuncianteId: number; // AÑADIR este campo
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

  // AÑADIR: Verificar si existe solicitud pendiente
  verificarSolicitudPendiente(estudianteId: number, viviendaId: number): Observable<boolean> {
    return this.http.get<boolean>(`${this.urlApi}/verificar/${estudianteId}/${viviendaId}`);
  }

  // AÑADIR: Verificar si el estudiante ya pertenece a la vivienda
  verificarPertenenciaVivienda(estudianteId: number, viviendaId: number): Observable<boolean> {
    return this.http.get<boolean>(`${this.urlApi}/pertenece/${estudianteId}/${viviendaId}`);
  }

  // Obtener solicitudes del estudiante
  obtenerSolicitudesEstudiante(estudianteId: number): Observable<SolicitudViviendaDto[]> {
    return this.http.get<SolicitudViviendaDto[]>(`${this.urlApi}/estudiante/${estudianteId}`);
  }

  // Obtener solicitudes para el anunciante
  obtenerSolicitudesAnunciante(anuncianteId: number): Observable<SolicitudViviendaDto[]> {
    return this.http.get<SolicitudViviendaDto[]>(`${this.urlApi}/anunciante/${anuncianteId}`)
      .pipe(
        catchError(error => {
          console.error('Error en obtenerSolicitudesAnunciante:', error);
          return of([]); // Devolver array vacío en caso de error
        })
      );
  }
  // Aceptar solicitud y añadir estudiante a la vivienda
  aceptarSolicitudYAñadirEstudiante(solicitudId: number, anuncianteId: number, respuesta?: string): Observable<any> {
    const body = respuesta ? { respuesta } : {};
    return this.http.put<any>(`${this.urlApi}/${solicitudId}/aceptar-y-añadir/${anuncianteId}`, body);
  }

  // Método simplificado para aceptar solicitud (mantener compatibilidad)
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

  // AÑADIR: Obtener ocupación actual de una vivienda
  obtenerOcupacionActual(viviendaId: number): Observable<number> {
    return this.http.get<number>(`${this.urlApi}/ocupacion/${viviendaId}`);
  }

  // AÑADIR método en el servicio del frontend:
  eliminarEstudianteDeVivienda(estudianteId: number, viviendaId: number, anuncianteId: number): Observable<string> {
    return this.http.delete<string>(`${this.urlApi}/eliminar-estudiante/${estudianteId}/${viviendaId}/${anuncianteId}`, {
      responseType: 'text' as 'json'
    });
  }
}