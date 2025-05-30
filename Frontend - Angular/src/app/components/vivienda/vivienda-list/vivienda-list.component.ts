import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms'; // AÑADIR FormsModule
import { Router } from '@angular/router';
import { ViviendaService } from '../../../service/vivienda.service';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-vivienda-list',
  imports: [CommonModule, FormsModule], // AÑADIR FormsModule
  templateUrl: './vivienda-list.component.html',
  styleUrl: './vivienda-list.component.css'
})
export class ViviendaListComponent implements OnInit {
  viviendas: any[] = [];
  todasLasViviendas: any[] = []; // AÑADIR para mantener copia original
  viviendasFiltradas: any[] = []; // AÑADIR para filtros
  isLoading = true;
  error = '';
  anuncianteName = '';

  filtros = {
    tipoVivienda: '',
    precioMinimo: null as number | null,
    precioMaximo: null as number | null,
    numeroHabitaciones: null as number | null,
    comunidad: '',
    provincia: '',
    municipio: '' // MANTENER como string simple
  };

  constructor(
    private viviendaService: ViviendaService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.checkAuthentication();
    this.loadViviendas();
  }

  checkAuthentication(): void {
    const token = localStorage.getItem('token');
    if (!token) {
      this.router.navigate(['/login']);
      return;
    }

    try {
      const decoded: any = jwtDecode(token);
      const rol = decoded.rol;
      
      if (rol !== 'ANUNCIANTE') {
        this.router.navigate(['/']);
        return;
      }

      this.anuncianteName = decoded.sub || 'Anunciante';
    } catch (error) {
      console.error('Error al decodificar token:', error);
      this.router.navigate(['/login']);
    }
  }

  loadViviendas(): void {
    this.isLoading = true;
    this.error = '';
    
    this.viviendaService.getViviendasByAnunciante().subscribe({
      next: (viviendas) => {
        this.todasLasViviendas = viviendas;
        this.viviendas = [...viviendas]; // Copia para mostrar
        this.viviendasFiltradas = [...viviendas];
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error al cargar viviendas:', error);
        this.error = 'Error al cargar las viviendas';
        this.isLoading = false;
      }
    });
  }

  // AÑADIR método aplicarFiltros completo:
  aplicarFiltros(): void {
    let viviendasFiltradas = [...this.todasLasViviendas];

    // Filtro por tipo de vivienda
    if (this.filtros.tipoVivienda) {
      viviendasFiltradas = viviendasFiltradas.filter(v => 
        v.tipoVivienda === this.filtros.tipoVivienda
      );
    }

    // Filtro por precio mínimo
    if (this.filtros.precioMinimo !== null && this.filtros.precioMinimo !== undefined) {
      viviendasFiltradas = viviendasFiltradas.filter(v => 
        v.precioMensual >= this.filtros.precioMinimo!
      );
    }

    // Filtro por precio máximo
    if (this.filtros.precioMaximo !== null && this.filtros.precioMaximo !== undefined) {
      viviendasFiltradas = viviendasFiltradas.filter(v => 
        v.precioMensual <= this.filtros.precioMaximo!
      );
    }

    // Filtro por número de habitaciones
    if (this.filtros.numeroHabitaciones !== null && this.filtros.numeroHabitaciones !== undefined) {
      viviendasFiltradas = viviendasFiltradas.filter(v => 
        v.numeroHabitaciones >= this.filtros.numeroHabitaciones!
      );
    }

    // Filtro por comunidad
    if (this.filtros.comunidad) {
      viviendasFiltradas = viviendasFiltradas.filter(v => 
        v.comunidad === this.filtros.comunidad
      );
    }

    // Filtro por provincia
    if (this.filtros.provincia) {
      viviendasFiltradas = viviendasFiltradas.filter(v => 
        v.provincia === this.filtros.provincia
      );
    }

    // CORREGIR: Filtro por municipio (búsqueda por texto)
    if (this.filtros.municipio && this.filtros.municipio.trim()) {
      const municipioBusqueda = this.filtros.municipio.trim().toLowerCase();
      viviendasFiltradas = viviendasFiltradas.filter(v => 
        v.municipio && v.municipio.toLowerCase().includes(municipioBusqueda)
      );
    }

    // Actualizar viviendas mostradas
    this.viviendas = viviendasFiltradas;
    this.viviendasFiltradas = viviendasFiltradas;
  }

  crearNuevaVivienda(): void {
    this.router.navigate(['/nuevo-anuncio']);
  }

  editarVivienda(id: number): void {
    this.router.navigate(['/editar-vivienda', id]);
  }

  verDetalles(id: number): void {
    this.router.navigate(['/anuncio', id]);
  }

  eliminarVivienda(vivienda: any): void {
    if (confirm(`¿Estás seguro de que quieres eliminar "${vivienda.nombre}"?`)) {
      this.viviendaService.deleteVivienda(vivienda.id).subscribe({
        next: () => {
          // Actualizar todas las listas
          this.todasLasViviendas = this.todasLasViviendas.filter(v => v.id !== vivienda.id);
          this.viviendas = this.viviendas.filter(v => v.id !== vivienda.id);
          this.viviendasFiltradas = this.viviendasFiltradas.filter(v => v.id !== vivienda.id);
        },
        error: (error) => {
          console.error('Error al eliminar vivienda:', error);
          this.error = 'Error al eliminar la vivienda';
        }
      });
    }
  }

  formatearFecha(fecha: string): string {
    if (!fecha) return 'N/A';
    return new Date(fecha).toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }

  getEstadoVivienda(vivienda: any): string {
    if (!vivienda.residentes || vivienda.residentes.length === 0) {
      return 'Disponible';
    }
    if (vivienda.residentes.length < vivienda.numeroHabitaciones) {
      return 'Parcialmente ocupada';
    }
    return 'Completa';
  }

  getEstadoClass(vivienda: any): string {
    const estado = this.getEstadoVivienda(vivienda);
    switch (estado) {
      case 'Disponible': return 'text-success';
      case 'Parcialmente ocupada': return 'text-warning';
      case 'Completa': return 'text-danger';
      default: return 'text-secondary';
    }
  }

  // AÑADIR método para obtener imagen principal:
  getImagenPrincipal(vivienda: any): string {
    // Verificar si tiene fotos
    if (vivienda.fotos && Array.isArray(vivienda.fotos) && vivienda.fotos.length > 0) {
      const primeraFoto = vivienda.fotos[0];
    
      if (primeraFoto.imagen) {
        return primeraFoto.imagen;
      }
    }
    
    // Si no hay fotos, usar placeholder
    return this.getPlaceholderImage();
  }

  // AÑADIR método para obtener placeholder:
  getPlaceholderImage(): string {
    return 'https://via.placeholder.com/400x300/e9ecef/6c757d?text=Sin+Imagen';
  }

  // CORREGIR método onImageError:
  onImageError(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target) {
      // Si la imagen actual no es el placeholder, cambiar al placeholder
      if (target.src !== this.getPlaceholderImage()) {
        target.src = this.getPlaceholderImage();
      }
    }
  }

  // AÑADIR método para verificar si tiene imagen válida:
  tieneImagenValida(vivienda: any): boolean {
    const imagen = this.getImagenPrincipal(vivienda);
    return imagen !== this.getPlaceholderImage();
  }

  // Métodos para calcular estadísticas (basados en viviendas filtradas)
  get viviendasDisponibles(): number {
    return this.viviendas.filter(v => this.getEstadoVivienda(v) === 'Disponible').length;
  }

  get viviendasParciales(): number {
    return this.viviendas.filter(v => this.getEstadoVivienda(v) === 'Parcialmente ocupada').length;
  }

  get viviendasCompletas(): number {
    return this.viviendas.filter(v => this.getEstadoVivienda(v) === 'Completa').length;
  }
}
