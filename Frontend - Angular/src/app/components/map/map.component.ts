import { Component, Input, OnInit, OnDestroy, AfterViewInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import * as L from 'leaflet';
import { GeocodingService } from '../../service/geocoding.service';

@Component({
  selector: 'app-map',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="map-container">
      <div 
        *ngIf="isLoading" 
        class="map-loading d-flex align-items-center justify-content-center">
        <div class="spinner-border text-primary me-2" role="status"></div>
        <span>Cargando mapa...</span>
      </div>
      
      <div 
        *ngIf="error" 
        class="map-error alert alert-warning d-flex align-items-center">
        <i class="bi bi-exclamation-triangle me-2"></i>
        <span>{{ error }}</span>
      </div>
      
      <div 
        id="map"
        class="map"
        [style.display]="isLoading || error ? 'none' : 'block'">
      </div>
    </div>
  `,
  styles: [`
    .map-container {
      position: relative;
      height: 400px;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }
    
    .map {
      height: 100%;
      width: 100%;
    }
    
    .map-loading, .map-error {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      margin: 0;
      border-radius: 12px;
    }
    
    .map-loading {
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(5px);
    }
    
    .map-error {
      background: rgba(255, 193, 7, 0.1);
      border: 1px solid rgba(255, 193, 7, 0.3);
    }
  `]
})
export class MapComponent implements OnInit, OnDestroy, AfterViewInit {
  @Input() direccion!: string;
  @Input() numero!: string;
  @Input() municipio!: string;
  @Input() provincia!: string;
  @Input() nombreVivienda!: string;

  private map!: L.Map;
  isLoading = true;
  error = '';

  constructor(private geocodingService: GeocodingService) {}

  ngOnInit(): void {
    // Configurar iconos de Leaflet
    this.setupLeafletIcons();
  }

  ngAfterViewInit(): void {
    this.initializeMap();
  }

  ngOnDestroy(): void {
    if (this.map) {
      this.map.remove();
    }
  }

  private setupLeafletIcons(): void {
    // Fix para los iconos de Leaflet en Angular
    delete (L.Icon.Default.prototype as any)._getIconUrl;
    L.Icon.Default.mergeOptions({
      iconRetinaUrl: 'assets/marker-icon-2x.png',
      iconUrl: 'assets/marker-icon.png',
      shadowUrl: 'assets/marker-shadow.png',
    });
  }

  private initializeMap(): void {
    // Crear mapa centrado en España
    this.map = L.map('map', {
      center: [40.4168, -3.7038], // Madrid como centro inicial
      zoom: 6,
      zoomControl: true,
      scrollWheelZoom: true
    });

    // Añadir capa de OpenStreetMap
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      maxZoom: 19
    }).addTo(this.map);

    // Buscar coordenadas
    this.searchLocation();
  }

  private searchLocation(): void {
    const direccionCompleta = `${this.direccion} ${this.numero}`.trim();
    
    // Intentar geocodificación con dirección completa primero
    this.geocodingService.geocodeAddress(direccionCompleta, this.municipio, this.provincia)
      .subscribe({
        next: (coords) => {
          if (coords) {
            this.addMarkerAndCenter(coords, true);
          } else {
            // Fallback: buscar solo por municipio y provincia
            this.searchCityLocation();
          }
        },
        error: (error) => {
          console.error('Error en geocodificación:', error);
          this.searchCityLocation();
        }
      });
  }

  private searchCityLocation(): void {
    this.geocodingService.geocodeCityProvince(this.municipio, this.provincia)
      .subscribe({
        next: (coords) => {
          if (coords) {
            this.addMarkerAndCenter(coords, false);
          } else {
            this.showError('No se pudo localizar la dirección en el mapa');
          }
        },
        error: (error) => {
          console.error('Error en geocodificación de ciudad:', error);
          this.showError('Error al cargar la ubicación en el mapa');
        }
      });
  }

  private addMarkerAndCenter(coords: {lat: number, lng: number}, isExactLocation: boolean): void {
    // Centrar mapa en las coordenadas
    const zoomLevel = isExactLocation ? 16 : 13;
    this.map.setView([coords.lat, coords.lng], zoomLevel);

    // Crear marcador personalizado
    const customIcon = L.divIcon({
      className: 'custom-div-icon',
      html: `
        <div style="
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          width: 30px;
          height: 30px;
          border-radius: 50%;
          border: 3px solid white;
          box-shadow: 0 2px 8px rgba(0,0,0,0.3);
          display: flex;
          align-items: center;
          justify-content: center;
        ">
          <i class="bi bi-house-door-fill" style="color: white; font-size: 14px;"></i>
        </div>
      `,
      iconSize: [30, 30],
      iconAnchor: [15, 15]
    });

    // Añadir marcador
    const marker = L.marker([coords.lat, coords.lng], { icon: customIcon }).addTo(this.map);

    // Popup con información
    const popupContent = `
      <div style="text-align: center; min-width: 200px;">
        <h6 style="margin: 0 0 8px 0; color: #667eea;">${this.nombreVivienda}</h6>
        <p style="margin: 0; font-size: 0.9rem;">
          <i class="bi bi-geo-alt text-primary"></i>
          ${this.direccion} ${this.numero}<br>
          ${this.municipio}, ${this.provincia}
        </p>
        ${!isExactLocation ? 
          '<small style="color: #6c757d;"><i class="bi bi-info-circle"></i> Ubicación aproximada</small>' : 
          ''
        }
      </div>
    `;

    marker.bindPopup(popupContent).openPopup();

    this.isLoading = false;
  }

  private showError(message: string): void {
    this.error = message;
    this.isLoading = false;
  }
}
