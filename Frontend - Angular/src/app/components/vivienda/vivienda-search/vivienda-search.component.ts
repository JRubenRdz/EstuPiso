import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { UbicacionService } from '../../../service/ubicacion.service';
import { ViviendaService } from '../../../service/vivienda.service';

export interface SearchFilters {
  comunidad?: string;
  provincia?: string;
  municipio?: string;
  nombre?: string;
  tipoVivienda?: string;
  precioMin?: number;
  precioMax?: number;
  habitaciones?: number;
  soloDisponibles?: boolean;
  direccion?: string;
}

@Component({
  selector: 'app-vivienda-search',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './vivienda-search.component.html',
  styleUrl: './vivienda-search.component.css'
})
export class ViviendaSearchComponent implements OnInit {
  
  // Filtros
  filters: SearchFilters = {
    soloDisponibles: true
  };

  // Datos para los selectores - ELIMINAR municipios
  comunidades: any[] = [];
  provincias: any[] = [];
  // ELIMINAR: municipios: any[] = [];

  // Estados de carga - ELIMINAR loadingMunicipios
  loadingProvincias = false;
  // ELIMINAR: loadingMunicipios = false;
  isLoading = false;

  // Resultados de búsqueda
  searchResults: any[] = [];
  totalPages = 0;
  currentPage = 0;
  pageSize = 6;
  totalElements = 0;

  // Estado de búsqueda
  hasSearched = false;
  noResults = false;

  // Tipos de vivienda disponibles
  tiposVivienda = [
    { value: 'PISO', label: 'Piso' },
    { value: 'CASA', label: 'Casa' },
    { value: 'HABITACION', label: 'Habitación' },
    { value: 'ESTUDIO', label: 'Estudio' },
    { value: 'OTRO', label: 'Otro' }
  ];

  // AÑADIR estas propiedades para evitar parpadeos:
  private searchTimeout: any;
  isSearching = false;

  constructor(
    private ubicacionService: UbicacionService,
    private viviendaService: ViviendaService
  ) {}

  ngOnInit(): void {
    this.loadComunidades();
  }

  loadComunidades(): void {
    this.ubicacionService.getAllComunidades().subscribe({
      next: (data) => {
        this.comunidades = data;
      },
      error: (error) => {
        console.error('Error cargando comunidades:', error);
      }
    });
  }

  onComunidadChange(): void {
    // SIMPLIFICAR: Solo resetear provincia y municipio
    this.filters.provincia = undefined;
    this.filters.municipio = ''; // CAMBIAR: resetear como string vacío
    this.provincias = [];

    if (this.filters.comunidad) {
      this.loadingProvincias = true;
      // Buscar el ID de la comunidad seleccionada
      const comunidadSeleccionada = this.comunidades.find(c => c.nombre === this.filters.comunidad);
      if (comunidadSeleccionada) {
        this.ubicacionService.getProvinciasByComunidad(comunidadSeleccionada.id).subscribe({
          next: (data) => {
            this.provincias = data;
            this.loadingProvincias = false;
          },
          error: (error) => {
            console.error('Error cargando provincias:', error);
            this.loadingProvincias = false;
          }
        });
      }
    }

    this.onFilterChange();
  }
  // SIMPLIFICAR onProvinciaChange - ELIMINAR lógica de municipios
  onProvinciaChange(): void {
    // CAMBIAR: Solo resetear municipio como string
    this.filters.municipio = '';

    // ELIMINAR toda la lógica de carga de municipios:
    /*
    if (this.filters.provincia) {
      this.loadingMunicipios = true;
      const provinciaSeleccionada = this.provincias.find(p => p.nombre === this.filters.provincia);
      if (provinciaSeleccionada) {
        this.ubicacionService.getMunicipiosByProvincia(provinciaSeleccionada.id).subscribe({
          // ... código eliminado
        });
      }
    }
    */

    this.onFilterChange();
  }

  // SIMPLIFICAR onMunicipioChange
  onMunicipioChange(): void {
    this.onFilterChange();
  }

  onFilterChange(): void {
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
    
    // Esperar 300ms antes de buscar (debounce)
    this.searchTimeout = setTimeout(() => {
      this.onSearch();
    }, 300);
  }

  onSearch(): void {
    this.currentPage = 0; // Resetear a primera página
    this.buscarViviendas();
  }

  clearFilters(): void {
    // Cancelar búsqueda pendiente
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
    
    this.filters = { soloDisponibles: true };
    this.provincias = [];
    // ELIMINAR: this.municipios = [];
    this.searchResults = [];
    this.hasSearched = false;
    this.noResults = false;
    this.isLoading = false;
    this.isSearching = false;
    this.currentPage = 0;
  }

  private convertirTipoVivienda(tipo: string | undefined): string | undefined {
    if (!tipo) return undefined;
    
    // Mapear valores del frontend a valores del enum del backend
    const mapeoTipos: { [key: string]: string } = {
      'PISO': 'PISO',
      'CASA': 'CASA', 
      'HABITACION': 'HABITACION',
      'ESTUDIO': 'ESTUDIO',
      'OTRO': 'OTRO'
    };
    
    return mapeoTipos[tipo.toUpperCase()] || tipo.toUpperCase();
  }

  buscarViviendas(): void {
    this.isLoading = true;
    this.hasSearched = true;
    this.isSearching = true;

    // Convertir tipo de vivienda antes de enviar
    const tipoViviendaConvertido = this.convertirTipoVivienda(this.filters.tipoVivienda);

    // CAMBIAR: municipio ahora se pasa directamente como string
    const municipioFiltro = this.filters.municipio?.trim() || undefined;

    this.viviendaService.buscarViviendas(
      this.filters.comunidad,
      this.filters.provincia,
      municipioFiltro, // USAR municipio como string
      this.filters.nombre,
      tipoViviendaConvertido,
      this.filters.precioMin,
      this.filters.precioMax,
      this.filters.habitaciones,
      this.filters.soloDisponibles || false,
      this.filters.direccion,
      this.currentPage,
      this.pageSize
    ).subscribe({
      next: (response) => {
        this.searchResults = response.content || [];
        this.totalPages = response.totalPages || 0;
        this.totalElements = response.totalElements || 0;
        this.noResults = this.searchResults.length === 0;
        this.isLoading = false;
        this.isSearching = false;
      },
      error: (error) => {
        console.error('Error en búsqueda:', error);
        this.isLoading = false;
        this.isSearching = false;
        this.noResults = true;
      }
    });
  }

  private hasActiveFilters(): boolean {
    return !!(
      this.filters.comunidad ||
      this.filters.provincia ||
      this.filters.municipio ||
      this.filters.nombre ||
      this.filters.tipoVivienda ||
      this.filters.precioMin ||
      this.filters.precioMax ||
      this.filters.habitaciones ||
      this.filters.direccion
    );
  }

  // Métodos de paginación - SIN CAMBIOS
  nextPage(): void {
    if (this.currentPage < this.totalPages - 1) {
      this.currentPage++;
      this.buscarViviendas();
    }
  }

  previousPage(): void {
    if (this.currentPage > 0) {
      this.currentPage--;
      this.buscarViviendas();
    }
  }

  goToPage(page: number): void {
    if (page >= 0 && page < this.totalPages) {
      this.currentPage = page;
      this.buscarViviendas();
    }
  }

  getPageNumbers(): number[] {
    const pages: number[] = [];
    const start = Math.max(0, this.currentPage - 2);
    const end = Math.min(this.totalPages, start + 5);
    
    for (let i = start; i < end; i++) {
      pages.push(i);
    }
    return pages;
  }

  formatPrice(price: number): string {
    return new Intl.NumberFormat('es-ES', {
      style: 'currency',
      currency: 'EUR'
    }).format(price);
  }

  getImagenPrincipal(vivienda: any): string {
    // Verificar estructura de fotos
    if (vivienda.fotos && Array.isArray(vivienda.fotos) && vivienda.fotos.length > 0) {
      const foto = vivienda.fotos[0];
      
      if (typeof foto === 'string') {
        return foto;
      }
      if (foto.imagen) {
        return foto.imagen;
      }
      if (foto.url) {
        return foto.url;
      }
      if (foto.ruta) {
        return foto.ruta;
      }
    }
    
    // Otros campos posibles
    if (vivienda.imagen && typeof vivienda.imagen === 'string') {
      return vivienda.imagen;
    }
    
    if (vivienda.foto && typeof vivienda.foto === 'string') {
      return vivienda.foto;
    }
    
    // Imagen por defecto
    return 'https://via.placeholder.com/400x200/e9ecef/6c757d?text=Sin+Imagen';
  }

  onImageError(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target && target.src !== 'https://via.placeholder.com/400x200/e9ecef/6c757d?text=Sin+Imagen') {
      target.src = 'https://via.placeholder.com/400x200/e9ecef/6c757d?text=Sin+Imagen';
    }
  }

  tieneImagen(vivienda: any): boolean {
    const imagen = this.getImagenPrincipal(vivienda);
    return imagen !== 'https://via.placeholder.com/400x200/e9ecef/6c757d?text=Sin+Imagen';
  }

  contactar(vivienda: any): void {
    window.open(`/anuncio/${vivienda.id}`, '_blank');
  }

  ngOnDestroy(): void {
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
  }

  // ACTUALIZAR método de ubicación para manejar municipio como string
  getUbicacionCompleta(vivienda: any): string {
    const partes: string[] = [];
    
    // Añadir calle y número si existen
    if (vivienda.calle) {
      let direccion = vivienda.calle;
      if (vivienda.numero) {
        direccion += `, ${vivienda.numero}`;
      }
      partes.push(direccion);
    } else if (vivienda.direccion) {
      partes.push(vivienda.direccion);
    }
    
    // CAMBIAR: Municipio ahora es string simple
    if (vivienda.municipio) {
      if (typeof vivienda.municipio === 'string') {
        partes.push(vivienda.municipio);
      } else if (vivienda.municipio.nombre) {
        // Retrocompatibilidad por si aún llegan objetos
        partes.push(vivienda.municipio.nombre);
      }
    }
    
    // Añadir provincia
    if (vivienda.provincia && typeof vivienda.provincia === 'string') {
      partes.push(vivienda.provincia);
    } else if (vivienda.provincia?.nombre) {
      partes.push(vivienda.provincia.nombre);
    }
    
    return partes.length > 0 ? partes.join(', ') : 'Ubicación no disponible';
  }

  // Métodos de estado - SIN CAMBIOS
  esDisponible(vivienda: any): boolean {
    if (vivienda.hasOwnProperty('disponible')) {
      return vivienda.disponible;
    }
    
    const residentes = vivienda.residentes || [];
    const habitaciones = vivienda.numeroHabitaciones || vivienda.habitaciones || 0;
    
    return residentes.length < habitaciones;
  }

  esParcialmenteOcupada(vivienda: any): boolean {
    const residentes = vivienda.residentes || [];
    const habitaciones = vivienda.numeroHabitaciones || vivienda.habitaciones || 0;
    
    return residentes.length > 0 && residentes.length < habitaciones;
  }

  getEstadoTexto(vivienda: any): string {
    const residentes = vivienda.residentes || [];
    const habitaciones = vivienda.numeroHabitaciones || vivienda.habitaciones || 0;
    
    if (residentes.length === 0) {
      return 'Disponible';
    } else if (residentes.length < habitaciones) {
      return 'Parcialmente ocupada';
    } else {
      return 'Completa';
    }
  }

  getEstadoIcon(vivienda: any): string {
    const residentes = vivienda.residentes || [];
    const habitaciones = vivienda.numeroHabitaciones || vivienda.habitaciones || 0;
    
    if (residentes.length === 0) {
      return 'bi bi-check-circle';
    } else if (residentes.length < habitaciones) {
      return 'bi bi-exclamation-circle';
    } else {
      return 'bi bi-x-circle';
    }
  }
}
