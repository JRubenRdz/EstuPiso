import { Component, Input, OnInit, OnDestroy, AfterViewInit, HostListener } from '@angular/core';
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
  `,  styles: [`    .map-container {
      position: relative;
      height: 400px;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      /* Forzar hardware acceleration para mejor rendimiento */
      transform: translateZ(0);
      -webkit-transform: translateZ(0);
    }
    
    .map {
      height: 100%;
      width: 100%;
      /* Asegurar que el mapa se renderice correctamente */
      z-index: 1;
      /* Forzar repaint para corregir problemas de renderizado */
      transform: translateZ(0);
      -webkit-transform: translateZ(0);
    }
    
    .map-loading, .map-error {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      margin: 0;
      border-radius: 12px;
      z-index: 10;
    }
    
    .map-loading {
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(5px);
    }
    
    .map-error {
      background: rgba(255, 193, 7, 0.1);
      border: 1px solid rgba(255, 193, 7, 0.3);
    }    /* Estilos globales para el popup de Leaflet - MEJORADOS */
    :host ::ng-deep .custom-popup .leaflet-popup-content-wrapper {
      border-radius: 8px;
      padding: 0;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      border: 1px solid rgba(0, 0, 0, 0.1);
      max-width: none !important;
      min-width: 200px !important;
    }

    :host ::ng-deep .custom-popup .leaflet-popup-content {
      margin: 0;
      padding: 0;
      overflow: hidden;
      word-wrap: break-word;
      overflow-wrap: break-word;
      hyphens: auto;
      max-width: 280px;
      min-width: 200px;
    }

    :host ::ng-deep .custom-popup .leaflet-popup-tip {
      background: white;
      border: 1px solid rgba(0, 0, 0, 0.1);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    :host ::ng-deep .custom-popup .leaflet-popup-close-button {
      padding: 4px 8px !important;
      font-size: 16px !important;
      color: #666 !important;
      font-weight: bold !important;
    }    /* Asegurar que el mapa se renderice correctamente en diferentes resoluciones */
    :host ::ng-deep .leaflet-container {
      background: #f8f9fa;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }

    :host ::ng-deep .leaflet-control-zoom {
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    :host ::ng-deep .leaflet-control-zoom a {
      border-radius: 0 !important;
      border-bottom: 1px solid #ccc !important;
    }

    :host ::ng-deep .leaflet-control-zoom a:last-child {
      border-bottom: none !important;
    }

    /* Corregir problemas de renderizado en diferentes navegadores */
    :host ::ng-deep .leaflet-map-pane {
      /* Forzar re-renderizado */
      transform: translateZ(0);
      -webkit-transform: translateZ(0);
    }

    :host ::ng-deep .leaflet-tile-pane {
      /* Mejorar renderizado de tiles */
      image-rendering: -webkit-optimize-contrast;
      image-rendering: crisp-edges;
    }

    /* Responsive design para popups */
    @media (max-width: 768px) {
      :host ::ng-deep .custom-popup .leaflet-popup-content-wrapper {
        max-width: 250px !important;
        min-width: 180px !important;
      }
      
      :host ::ng-deep .custom-popup .leaflet-popup-content {
        max-width: 250px;
        min-width: 180px;
      }
    }

    @media (max-width: 480px) {
      .map-container {
        height: 300px;
      }
      
      :host ::ng-deep .custom-popup .leaflet-popup-content-wrapper {
        max-width: 200px !important;
        min-width: 160px !important;
      }
      
      :host ::ng-deep .custom-popup .leaflet-popup-content {
        max-width: 200px;
        min-width: 160px;
      }
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

  // Escuchar cambios de tamaño de ventana para redimensionar el mapa
  @HostListener('window:resize', ['$event'])
  onWindowResize(event: any) {
    if (this.map) {
      // Retrasar el invalidateSize para asegurar que el redimensionamiento haya terminado
      setTimeout(() => {
        this.map.invalidateSize();
      }, 100);
    }
  }

  ngOnInit(): void {
    // Configurar iconos de Leaflet
    this.setupLeafletIcons();
  }  ngAfterViewInit(): void {
    // Retrasar la inicialización del mapa para asegurar que el DOM esté completamente renderizado
    setTimeout(() => {
      this.initializeMap();
      // Configurar observador de visibilidad después de inicializar el mapa
      setTimeout(() => {
        this.observeVisibilityChanges();
      }, 500);
    }, 100);
  }
  // Método público para forzar redimensionamiento del mapa (útil cuando se cambia la visibilidad del contenedor)
  public resizeMap(): void {
    if (this.map) {
      setTimeout(() => {
        this.map.invalidateSize(true);
      }, 50);
    }
  }

  // Método para observar cambios de visibilidad del contenedor
  private observeVisibilityChanges(): void {
    const mapElement = document.getElementById('map');
    if (mapElement && 'IntersectionObserver' in window) {
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting && this.map) {
            // El mapa es visible, redimensionar
            setTimeout(() => {
              this.map.invalidateSize(true);
            }, 100);
          }
        });
      });
      
      observer.observe(mapElement);
    }
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
  }  private initializeMap(): void {
    // Verificar que el elemento DOM existe antes de crear el mapa
    const mapElement = document.getElementById('map');
    if (!mapElement) {
      console.error('Elemento del mapa no encontrado');
      this.showError('Error al inicializar el mapa');
      return;
    }

    // Crear mapa centrado en España
    this.map = L.map('map', {
      center: [40.4168, -3.7038], // Madrid como centro inicial
      zoom: 6,
      zoomControl: true,
      scrollWheelZoom: true,
      // Opciones adicionales para mejor renderizado
      preferCanvas: false,
      attributionControl: true,
      fadeAnimation: true,
      zoomAnimation: true
    });

    // Añadir capa de OpenStreetMap
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      maxZoom: 19
    }).addTo(this.map);

    // IMPORTANTE: Múltiples invalidaciones del tamaño para asegurar renderizado correcto
    // Primera invalidación inmediata
    this.map.invalidateSize(true);
    
    // Segunda invalidación con retraso
    setTimeout(() => {
      this.map.invalidateSize(true);
    }, 200);

    // Tercera invalidación para casos extremos
    setTimeout(() => {
      this.map.invalidateSize(true);
    }, 500);

    // Event listener para cuando el mapa termina de cargar completamente
    this.map.whenReady(() => {
      setTimeout(() => {
        this.map.invalidateSize(true);
      }, 100);
    });

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
  }  private addMarkerAndCenter(coords: {lat: number, lng: number}, isExactLocation: boolean): void {
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

    // Popup con información - MEJORADO para mejor responsividad
    const popupContent = `
      <div style="
        text-align: center; 
        min-width: 180px; 
        max-width: 250px; 
        padding: 12px;
        box-sizing: border-box;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      ">
        <h6 style="
          margin: 0 0 8px 0; 
          color: #667eea;
          font-size: 14px;
          font-weight: 600;
          line-height: 1.2;
          word-wrap: break-word;
          overflow-wrap: break-word;
        ">${this.nombreVivienda}</h6>
        <p style="
          margin: 0; 
          font-size: 12px;
          line-height: 1.3;
          word-wrap: break-word;
          overflow-wrap: break-word;
          color: #495057;
        ">
          <i class="bi bi-geo-alt text-primary"></i>
          ${this.direccion} ${this.numero}<br>
          ${this.municipio}, ${this.provincia}
        </p>
        ${!isExactLocation ? 
          '<small style="color: #6c757d; font-size: 10px; margin-top: 4px; display: block;"><i class="bi bi-info-circle"></i> Ubicación aproximada</small>' : 
          ''
        }
      </div>
    `;

    // Configurar popup con opciones mejoradas
    marker.bindPopup(popupContent, {
      maxWidth: 280,
      minWidth: 200,
      autoClose: false,
      closeOnClick: false,
      className: 'custom-popup',
      autoPan: true,
      autoPanPadding: [5, 5]
    });

    // Abrir popup con múltiples invalidaciones para asegurar dimensiones correctas
    setTimeout(() => {
      marker.openPopup();
      
      // Primera invalidación inmediata después de abrir popup
      setTimeout(() => {
        this.map.invalidateSize(true);
      }, 50);
      
      // Segunda invalidación con más retraso
      setTimeout(() => {
        this.map.invalidateSize(true);
      }, 200);
      
      // Invalidación final para casos extremos
      setTimeout(() => {
        this.map.invalidateSize(true);
      }, 500);
    }, 300);

    this.isLoading = false;
  }

  private showError(message: string): void {
    this.error = message;
    this.isLoading = false;
  }
}
