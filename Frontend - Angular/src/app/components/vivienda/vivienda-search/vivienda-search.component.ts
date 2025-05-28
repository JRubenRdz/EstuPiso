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
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
    
    // Esperar 300ms antes de buscar (debounce)
    this.searchTimeout = setTimeout(() => {
      this.onSearch();
    }, 300);

  }

  // AÑADIR método onSearch que falta:
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
    this.municipios = [];
    this.searchResults = [];
    this.hasSearched = false;
    this.noResults = false;
    this.isLoading = false;
    this.isSearching = false;
    this.currentPage = 0;
  }


  // AÑADIR método para convertir el enum antes de enviar:
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

    this.viviendaService.buscarViviendas(
      this.filters.comunidad,
      this.filters.provincia,
      this.filters.municipio,
      this.filters.nombre,
      tipoViviendaConvertido, // USAR EL VALOR CONVERTIDO
      this.filters.precioMin,
      this.filters.precioMax,
      this.filters.habitaciones,
      this.filters.soloDisponibles || false,
      this.filters.direccion,
      this.currentPage,
      this.pageSize
    ).subscribe({
      next: (response) => {
        console.log('Respuesta completa:', response);
        console.log('Tipo vivienda enviado:', tipoViviendaConvertido);
        
        this.searchResults = response.content || [];
        this.totalPages = response.totalPages || 0;
        this.totalElements = response.totalElements || 0;
        this.noResults = this.searchResults.length === 0;
        this.isLoading = false;
        this.isSearching = false;
      },
      error: (error) => {
        console.error('Error en la búsqueda:', error);
        console.error('Tipo vivienda que causó error:', tipoViviendaConvertido);
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

  // MEJORAR método getImagenPrincipal:
  getImagenPrincipal(vivienda: any): string {
    console.log('Datos de vivienda para imagen:', {
      id: vivienda.id,
      fotos: vivienda.fotos
    });

    // Verificar estructura de fotos
    if (vivienda.fotos && Array.isArray(vivienda.fotos) && vivienda.fotos.length > 0) {
      const foto = vivienda.fotos[0];
      console.log('Primera foto:', foto);
      
      if (typeof foto === 'string') {
        return foto;
      }
      // CORREGIDO: usar 'imagen' en lugar de 'url'
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
      console.log('Error cargando imagen:', target.src);
      target.src = 'https://via.placeholder.com/400x200/e9ecef/6c757d?text=Sin+Imagen';
    }
  }

  // AÑADIR método para verificar si tiene imagen válida:
  tieneImagen(vivienda: any): boolean {
    const imagen = this.getImagenPrincipal(vivienda);
    return imagen !== 'https://via.placeholder.com/400x200/e9ecef/6c757d?text=Sin+Imagen';
  }

  // CORREGIR método contactar:
  contactar(vivienda: any): void {
    // Usar router en lugar de window.location para mejor navegación
    window.open(`/anuncio/${vivienda.id}`, '_blank');
  }

  // AÑADIR método para limpiar timeout al destruir componente:
  ngOnDestroy(): void {
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
  }

  // Añadir estos métodos al final de la clase:

  // Método para obtener ubicación completa
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
    
    // Añadir municipio
    if (vivienda.municipio) {
      if (typeof vivienda.municipio === 'string') {
        partes.push(vivienda.municipio);
      } else if (vivienda.municipio.nombre) {
        partes.push(vivienda.municipio.nombre);
      }
    }
    
    // Añadir provincia si no está incluida en municipio
    if (vivienda.provincia && typeof vivienda.provincia === 'string') {
      partes.push(vivienda.provincia);
    } else if (vivienda.provincia?.nombre) {
      partes.push(vivienda.provincia.nombre);
    }
    
    return partes.length > 0 ? partes.join(', ') : 'Ubicación no disponible';
  }

  // Método para verificar si está disponible
  esDisponible(vivienda: any): boolean {
    // Si tiene una propiedad disponible explícita, usarla
    if (vivienda.hasOwnProperty('disponible')) {
      return vivienda.disponible;
    }
    
    // Si no, calcular basándose en residentes vs habitaciones
    const residentes = vivienda.residentes || [];
    const habitaciones = vivienda.numeroHabitaciones || vivienda.habitaciones || 0;
    
    return residentes.length < habitaciones;
  }

  // Método para verificar si está parcialmente ocupada
  esParcialmenteOcupada(vivienda: any): boolean {
    const residentes = vivienda.residentes || [];
    const habitaciones = vivienda.numeroHabitaciones || vivienda.habitaciones || 0;
    
    return residentes.length > 0 && residentes.length < habitaciones;
  }

  // Método para obtener el texto del estado
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

  // Método para obtener el icono del estado
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
