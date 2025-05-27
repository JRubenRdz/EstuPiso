import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class GeocodingService {
  
  constructor(private http: HttpClient) { }

  // Usando Nominatim (OpenStreetMap) - Gratuito
  geocodeAddress(direccion: string, municipio: string, provincia: string): Observable<{lat: number, lng: number} | null> {
    const query = `${direccion}, ${municipio}, ${provincia}, España`;
    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}&limit=1&countrycodes=es`;
    
    return this.http.get<any[]>(url).pipe(
      map(results => {
        if (results && results.length > 0) {
          return {
            lat: parseFloat(results[0].lat),
            lng: parseFloat(results[0].lon)
          };
        }
        return null;
      })
    );
  }

  // Fallback con solo municipio y provincia
  geocodeCityProvince(municipio: string, provincia: string): Observable<{lat: number, lng: number} | null> {
    const query = `${municipio}, ${provincia}, España`;
    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}&limit=1&countrycodes=es`;
    
    return this.http.get<any[]>(url).pipe(
      map(results => {
        if (results && results.length > 0) {
          return {
            lat: parseFloat(results[0].lat),
            lng: parseFloat(results[0].lon)
          };
        }
        return null;
      })
    );
  }
}
