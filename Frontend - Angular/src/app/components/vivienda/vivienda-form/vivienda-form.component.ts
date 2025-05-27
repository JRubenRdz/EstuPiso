import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule, FormArray } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { CommonModule } from '@angular/common';
import { TiposVivienda, Vivienda } from '../../../model/Vivienda';
import { ViviendaService } from '../../../service/vivienda.service';
import { UbicacionService } from '../../../service/ubicacion.service';
import { ActorService } from '../../../service/actor.service';
import { AnuncianteService } from '../../../service/anunciante.service';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-vivienda-form',
  templateUrl: './vivienda-form.component.html',
  styleUrls: ['./vivienda-form.component.css'],
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule]
})
export class ViviendaFormComponent implements OnInit {
  viviendaForm!: FormGroup;
  isEditMode = false;
  viviendaId: number | null = null;
  isLoading = false;
  isSubmitting = false;
  showSuccessModal = false;
  showErrorModal = false;
  modalMessage = '';

  // Enum para el template
  tiposVivienda = Object.values(TiposVivienda);
  
  // Datos de ubicación
  comunidades: any[] = [];
  provincias: any[] = [];
  municipios: any[] = [];
  provinciasFiltradas: any[] = [];
  municipiosFiltrados: any[] = [];

  // Estado de carga para selectores
  loadingProvincias = false;
  loadingMunicipios = false;
  constructor(
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private viviendaService: ViviendaService,
    private ubicacionService: UbicacionService,
    private actorService: ActorService,
    private anuncianteService: AnuncianteService
  ) {}

  ngOnInit(): void {
    // Verificar que el usuario sea anunciante
    const token = localStorage.getItem('token');
    if (!token) {
      this.router.navigate(['/']);
      return;
    }

    try {
      const decoded: any = jwtDecode(token);
      const rol = decoded.rol;
      
      // Solo los anunciantes pueden crear/editar viviendas
      if (rol !== 'ANUNCIANTE') {
        this.router.navigate(['/']);
        return;
      }
    } catch (error) {
      console.error('Error al decodificar token:', error);
      this.router.navigate(['/']);
      return;
    }

    // Si llegamos aquí, el usuario es anunciante - continuar con la lógica normal
    this.initializeForm();
    this.loadComunidades();
    this.checkEditMode();
    this.setupFormSubscriptions();
  }

  initializeForm(): void {
    this.viviendaForm = this.fb.group({
      nombre: ['', [Validators.required, Validators.minLength(3), Validators.maxLength(100)]],
      comunidad: ['', [Validators.required]],
      provincia: ['', [Validators.required]],
      municipio: ['', [Validators.required]],
      calle: ['', [Validators.required, Validators.minLength(2), Validators.maxLength(100)]],
      numero: ['', [Validators.required, Validators.pattern(/^\d+[A-Za-z]?$/)]],
      descripcion: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(1000)]],
      precioMensual: ['', [Validators.required, Validators.min(1), Validators.max(9999)]],
      tipoVivienda: ['', [Validators.required]],
      numeroHabitaciones: ['', [Validators.required, Validators.min(1), Validators.max(20)]],
      fotos: this.fb.array([this.createFotoControl()]) // <-- Nuevo FormArray
    });
  }

  // Crear un control para una foto individual
  createFotoControl() {
    return this.fb.control('', [Validators.required, Validators.pattern(/^https?:\/\/.+\.(jpg|jpeg|png|gif|webp)$/i)]);
  }

  // Getter para el FormArray de fotos
  get fotosArray(): FormArray {
    return this.viviendaForm.get('fotos') as FormArray;
  }

  // Añadir una nueva foto
  addFoto(): void {
    if (this.fotosArray.length < 10) { // Límite de 10 fotos
      this.fotosArray.push(this.createFotoControl());
    }
  }

  // Remover la última foto
  removeFoto(): void {
    if (this.fotosArray.length > 1) { // Mínimo 1 foto
      this.fotosArray.removeAt(this.fotosArray.length - 1);
    }
  }

  // Remover una foto específica por índice
  removeFotoAt(index: number): void {
    if (this.fotosArray.length > 1) {
      this.fotosArray.removeAt(index);
    }
  }

  // Verificar si una foto específica es inválida
  isFotoInvalid(index: number): boolean {
    const foto = this.fotosArray.at(index);
    return !!(foto && foto.invalid && foto.touched);
  }

  // Obtener error de una foto específica
  getFotoError(index: number): string {
    const foto = this.fotosArray.at(index);
    if (!foto || !foto.errors) return '';

    const errors = foto.errors;
    if (errors['required']) return 'La URL de la foto es obligatoria';
    if (errors['pattern']) return 'URL no válida. Debe ser una imagen (jpg, jpeg, png, gif, webp)';
    return 'URL no válida';
  }

  checkEditMode(): void {
    this.route.params.subscribe(params => {
      if (params['id']) {
        this.isEditMode = true;
        this.viviendaId = +params['id'];
        this.loadViviendaData();
      }
    });
  }

  loadComunidades(): void {
    this.ubicacionService.getAllComunidades().subscribe({
      next: (data) => {
        this.comunidades = data;
      },
      error: (error) => {
        console.error('Error al cargar comunidades:', error);
      }
    });
  }
  onComunidadChange(comunidadNombre: string): void {
    if (!comunidadNombre) {
      this.provinciasFiltradas = [];
      this.municipiosFiltrados = [];
      this.viviendaForm.patchValue({ provincia: '', municipio: '' });
      return;
    }

    this.loadingProvincias = true;
    this.municipiosFiltrados = [];
    this.viviendaForm.patchValue({ provincia: '', municipio: '' });

    // Buscar la comunidad por nombre para obtener su ID
    const comunidadSeleccionada = this.comunidades.find(c => c.nombre === comunidadNombre);
    if (comunidadSeleccionada) {
      this.ubicacionService.getProvinciasByComunidad(comunidadSeleccionada.id).subscribe({
        next: (data) => {
          this.provinciasFiltradas = data;
          this.loadingProvincias = false;
        },
        error: (error) => {
          console.error('Error al cargar provincias:', error);
          this.loadingProvincias = false;
        }
      });
    } else {
      this.loadingProvincias = false;
    }
  }
  onProvinciaChange(provinciaNombre: string): void {
    if (!provinciaNombre) {
      this.municipiosFiltrados = [];
      this.viviendaForm.patchValue({ municipio: '' });
      return;
    }

    this.loadingMunicipios = true;
    this.viviendaForm.patchValue({ municipio: '' });

    // Buscar la provincia por nombre para obtener su ID
    const provinciaSeleccionada = this.provinciasFiltradas.find(p => p.nombre === provinciaNombre);
    if (provinciaSeleccionada) {
      this.ubicacionService.getMunicipiosByProvincia(provinciaSeleccionada.id).subscribe({
        next: (data) => {
          this.municipiosFiltrados = data;
          this.loadingMunicipios = false;
        },
        error: (error) => {
          console.error('Error al cargar municipios:', error);
          this.loadingMunicipios = false;
        }
      });
    } else {
      this.loadingMunicipios = false;
    }
  }

  loadViviendaData(): void {
    if (!this.viviendaId) return;

    this.isLoading = true;
    this.viviendaService.getViviendaById(this.viviendaId).subscribe({
      next: (vivienda) => {
        this.populateForm(vivienda);
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error al cargar vivienda:', error);
        this.modalMessage = 'Error al cargar los datos de la vivienda';
        this.showErrorModal = true;
        this.isLoading = false;
      }
    });
  }

  populateForm(vivienda: any): void {
    // Limpiar el array de fotos primero
    while (this.fotosArray.length) {
      this.fotosArray.removeAt(0);
    }

    // Añadir las fotos existentes o una vacía si no hay fotos
    if (vivienda.fotos && vivienda.fotos.length > 0) {
      vivienda.fotos.forEach((foto: any) => {
        this.fotosArray.push(this.fb.control(foto.imagen, [
          Validators.required, 
          Validators.pattern(/^https?:\/\/.+\.(jpg|jpeg|png|gif|webp)$/i)
        ]));
      });
    } else {
      this.fotosArray.push(this.createFotoControl());
    }

    this.viviendaForm.patchValue({
      nombre: vivienda.nombre,
      comunidad: vivienda.comunidad,
      provincia: vivienda.provincia,
      municipio: vivienda.municipio,
      calle: vivienda.calle,
      numero: vivienda.numero,
      descripcion: vivienda.descripcion,
      precioMensual: vivienda.precioMensual,
      tipoVivienda: vivienda.tipoVivienda,
      numeroHabitaciones: vivienda.numeroHabitaciones
    });
  }

  onSubmit(): void {
    if (this.viviendaForm.invalid) {
      this.markFormGroupTouched();
      return;
    }

    this.isSubmitting = true;
    const formData = this.viviendaForm.value;
    
    // Obtener el anunciante actual desde JWT
    const token = localStorage.getItem('token');
    if (!token) {
      this.modalMessage = 'Error: Usuario no autenticado';
      this.showErrorModal = true;
      this.isSubmitting = false;
      return;
    }

    const decoded: any = jwtDecode(token);
    const currentUserId = decoded.id;
    
    // Preparar las fotos en el formato correcto para el backend
    const fotosFormatted = formData.fotos
      .filter((url: string) => url.trim()) // Filtrar URLs vacías
      .map((url: string) => ({ imagen: url.trim() })); // <-- CAMBIO: 'url' por 'imagen'
    
    // Preparar el payload
    const viviendaPayload = {
      ...formData,
      fotos: fotosFormatted,
      fechaPublicacion: this.isEditMode ? undefined : new Date(),
      ultimaEdicion: new Date(),
      anunciante: {
        id: currentUserId
      }
    };

    if (this.isEditMode && this.viviendaId) {
      viviendaPayload.id = this.viviendaId;
    }

    const request = this.isEditMode 
      ? this.viviendaService.actualizarVivienda(viviendaPayload)
      : this.viviendaService.crearVivienda(viviendaPayload);

    request.subscribe({
      next: (response) => {
        console.log('Respuesta exitosa:', response);
        this.modalMessage = this.isEditMode 
          ? 'Vivienda actualizada correctamente'
          : 'Vivienda creada correctamente';
        this.showSuccessModal = true;
        this.isSubmitting = false;
      },
      error: (error) => {
        console.error('Error completo:', error);
        
        if (error.status === 201) {
          this.modalMessage = this.isEditMode 
            ? 'Vivienda actualizada correctamente'
            : 'Vivienda creada correctamente';
          this.showSuccessModal = true;
          this.isSubmitting = false;
          return;
        }
        
        if (error.status === 400 && error.error) {
          this.modalMessage = error.error.message || 'Error de validación en los datos';
        } else if (error.status === 409) {
          this.modalMessage = 'Ya existe una vivienda en esa dirección';
        } else {
          this.modalMessage = this.isEditMode 
            ? 'Error al actualizar la vivienda'
            : 'Error al crear la vivienda';
        }
        
        this.showErrorModal = true;
        this.isSubmitting = false;
      }
    });
  }

  markFormGroupTouched(): void {
    Object.keys(this.viviendaForm.controls).forEach(key => {
      const control = this.viviendaForm.get(key);
      if (control instanceof FormArray) {
        control.controls.forEach(arrayControl => {
          arrayControl.markAsTouched();
        });
      } else {
        control?.markAsTouched();
      }
    });
  }

  isFieldInvalid(fieldName: string): boolean {
    const field = this.viviendaForm.get(fieldName);
    return !!(field && field.invalid && field.touched);
  }

  getFieldError(fieldName: string): string {
    const field = this.viviendaForm.get(fieldName);
    if (!field || !field.errors) return '';

    const errors = field.errors;
    
    if (errors['required']) return `El campo ${fieldName} es obligatorio`;
    if (errors['minlength']) return `Mínimo ${errors['minlength'].requiredLength} caracteres`;
    if (errors['maxlength']) return `Máximo ${errors['maxlength'].requiredLength} caracteres`;
    if (errors['min']) return `El valor mínimo es ${errors['min'].min}`;
    if (errors['max']) return `El valor máximo es ${errors['max'].max}`;
    if (errors['pattern']) return 'Formato no válido';

    return 'Campo no válido';
  }

  onCancel(): void {
    this.router.navigate(['/']);
  }

  abrirModal(tipo: 'success' | 'error'): void {
    const modalElement = document.getElementById(tipo === 'success' ? 'successModal' : 'errorModal');
    if (modalElement) {
      const modal = new (window as any).bootstrap.Modal(modalElement);
      modal.show();

      if (tipo === 'success') {
        modalElement.addEventListener('hidden.bs.modal', () => {
          this.router.navigate(['/mis-anuncios']);
        }, { once: true });
      }
    }
  }

  cerrarModal(tipo: 'success' | 'error'): void {
    if (tipo === 'success') {
      this.showSuccessModal = false;
      this.router.navigate(['/mis-anuncios']);
    } else {
      this.showErrorModal = false;
    }
  }

  // Método para mostrar automáticamente los modales cuando cambian las propiedades
  ngDoCheck(): void {
    if (this.showSuccessModal) {
      this.abrirModal('success');
      this.showSuccessModal = false;
    }
    if (this.showErrorModal) {
      this.abrirModal('error');
      this.showErrorModal = false;
    }
  }

  setupFormSubscriptions(): void {
    // Suscripción para cambios en la comunidad
    this.viviendaForm.get('comunidad')?.valueChanges.subscribe(comunidadNombre => {
      if (comunidadNombre) {
        this.onComunidadChange(comunidadNombre);
      }
    });

    // Suscripción para cambios en la provincia
    this.viviendaForm.get('provincia')?.valueChanges.subscribe(provinciaNombre => {
      if (provinciaNombre) {
        this.onProvinciaChange(provinciaNombre);
      }
    });

    // Opcional: Suscripción para validar URLs de fotos en tiempo real
    this.fotosArray.valueChanges.subscribe(fotos => {
      // Aquí puedes añadir lógica adicional si necesitas validar
      // las URLs de fotos en tiempo real
    });
  }

  // Método para manejar error de carga de imagen
  onImageError(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target) {
      target.style.display = 'none';
    }
  }

  // Método para manejar carga exitosa de imagen
  onImageLoad(event: Event): void {
    const target = event.target as HTMLImageElement;
    if (target) {
      target.style.display = 'block';
    }
  }
}