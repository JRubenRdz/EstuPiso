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

  // Datos para los selectores
  comunidades: any[] = [];
  provincias: any[] = [];
  municipios: any[] = [];

  // Estados de carga
  loadingProvincias = false;
  loadingMunicipios = false;
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
  tiposVivienda = ['PISO', 'CASA', 'HABITACION', 'ESTUDIO'];

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
    this.filters.provincia = undefined;
    this.filters.municipio = undefined;
    this.provincias = [];
    this.municipios = [];

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

  onProvinciaChange(): void {
    this.filters.municipio = undefined;
    this.municipios = [];

    if (this.filters.provincia) {
      this.loadingMunicipios = true;
      // Buscar el ID de la provincia seleccionada
      const provinciaSeleccionada = this.provincias.find(p => p.nombre === this.filters.provincia);
      if (provinciaSeleccionada) {
        this.ubicacionService.getMunicipiosByProvincia(provinciaSeleccionada.id).subscribe({
          next: (data) => {
            this.municipios = data;
            this.loadingMunicipios = false;
          },
          error: (error) => {
            console.error('Error cargando municipios:', error);
            this.loadingMunicipios = false;
          }
        });
      }
    }

    this.onFilterChange();
  }

  onMunicipioChange(): void {
    this.onFilterChange();
  }

  onFilterChange(): void {
    if (this.hasActiveFilters()) {
      this.currentPage = 0;
      this.buscarViviendas();
    }
  }

  onSearch(): void {
    this.currentPage = 0;
    this.buscarViviendas();
  }

  clearFilters(): void {
    this.filters = { soloDisponibles: true };
    this.provincias = [];
    this.municipios = [];
    this.searchResults = [];
    this.hasSearched = false;
    this.noResults = false;
  }

  buscarViviendas(): void {
    this.isLoading = true;
    this.hasSearched = true;

    this.viviendaService.buscarViviendas(
      this.filters.comunidad,
      this.filters.provincia,
      this.filters.municipio,
      this.filters.nombre,
      this.filters.tipoVivienda,
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
      },
      error: (error) => {
        console.error('Error en búsqueda:', error);
        this.searchResults = [];
        this.noResults = true;
        this.isLoading = false;
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
  // Métodos de paginación
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

  // Métodos auxiliares para el template
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

  contactar(vivienda: any): void {
    // TODO: Implementar lógica de contacto (modal, redirección, etc.)
    console.log('Contactar con anunciante de vivienda:', vivienda.id);
    alert(`Función de contacto en desarrollo para la vivienda: ${vivienda.nombre}`);
  }
}
