import { Component, Input, OnInit, ViewChild, ElementRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { EstudianteService } from '../../../service/estudiante.service';
import { AnuncianteService } from '../../../service/anunciante.service';
import { AdminService } from '../../../service/admin.service'; // <-- Añade esto
import { Actor } from '../../../model/Actor';
import { CommonModule, NgClass } from '@angular/common';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-actor-form',
  templateUrl: './actor-form.component.html',
  styleUrl: './actor-form.component.css',
  standalone: true,
  imports: [NgClass, ReactiveFormsModule, CommonModule]
})
export class ActorFormComponent implements OnInit {
  @Input() actor?: Actor;
  form!: FormGroup;
  modoEdicion = false;
  titulo = 'Registro de usuario';
  roles = [
    { value: 'ESTUDIANTE', label: 'Estudiante' },
    { value: 'ANUNCIANTE', label: 'Anunciante' }
  ];
  puedeCrearAdmin = false;
  usuarioLogeado = false;
  mostrarFormulario = false;

  usuarioRepetido = false;
  mensajeExito = '';
  mensajeError = '';
  @ViewChild('modalExito') modalExito!: ElementRef;
  @ViewChild('modalError') modalError!: ElementRef;

  imgError = false;

  constructor(
    private fb: FormBuilder,
    private estudianteService: EstudianteService,
    private anuncianteService: AnuncianteService,
    private adminService: AdminService, // <-- Añade esto
    private router: Router,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.initForm();
    const token = localStorage.getItem('token');
    const currentRoute = this.route.snapshot.routeConfig?.path;
    // Redirección si usuario logeado entra a /register
    if (currentRoute === 'register' && token) {
      this.router.navigate(['/']);
      return;
    }
    if (currentRoute === 'register') {
      // Registro: solo si NO hay token
      this.usuarioLogeado = false;
      this.mostrarFormulario = !token;
      this.titulo = 'Registro de usuario';
      this.modoEdicion = false;
      this.puedeCrearAdmin = false;
      // Permitir editar usuario en registro
      this.form.get('usuario')?.enable();
    } else if (currentRoute === 'create-user') {
      // Solo permitir acceso si es admin
      if (token) {
        const decoded: any = jwtDecode(token);
        const rol = decoded.rol;
        this.usuarioLogeado = true;
        if (rol === 'ADMIN') {
          this.puedeCrearAdmin = true;
          this.titulo = 'Crear usuario';
          this.modoEdicion = false;
          this.roles = [
            { value: 'ESTUDIANTE', label: 'Estudiante' },
            { value: 'ANUNCIANTE', label: 'Anunciante' },
            { value: 'ADMIN', label: 'Administrador' }
          ];
          this.mostrarFormulario = true;
          this.form.get('usuario')?.enable();
        } else {
          this.puedeCrearAdmin = false;
          this.mostrarFormulario = false;
        }
      } else {
        this.usuarioLogeado = false;
        this.puedeCrearAdmin = false;
        this.mostrarFormulario = false;
      }
    } else if (currentRoute === 'mis-datos') {
      // Permitir acceso a cualquier usuario autenticado
      if (token) {
        const decoded: any = jwtDecode(token);
        const id = decoded.id;
        const rol = decoded.rol;
        this.usuarioLogeado = true;
        this.titulo = 'Mis datos';
        this.modoEdicion = true;
        this.puedeCrearAdmin = rol === 'ADMIN';
        this.mostrarFormulario = true;
        // Bloquear edición de usuario
        this.form.get('usuario')?.disable();
        if (rol === 'ESTUDIANTE') {
          this.estudianteService.getEstudianteById(id).subscribe(actor => {
            this.form.patchValue({
              nombre: actor.nombre,
              usuario: actor.usuario,
              email: actor.email,
              fotoPerfil: actor.fotoPerfil,
              rol: actor.rol,
              telefono: ''
            });
            // ...usuario ya deshabilitado arriba
          });
        } else if (rol === 'ANUNCIANTE') {
          this.anuncianteService.getAnuncianteById(id).subscribe(actor => {
            this.form.patchValue({
              nombre: actor.nombre,
              usuario: actor.usuario,
              email: actor.email,
              fotoPerfil: actor.fotoPerfil,
              rol: actor.rol,
              telefono: actor.telefono
            });
            // ...usuario ya deshabilitado arriba
          });
        } else if (rol === 'ADMIN') {
          this.adminService.getAdminByUsuario(decoded.sub).subscribe(actor => {
            this.form.patchValue({
              nombre: actor.nombre,
              usuario: actor.usuario,
              email: actor.email,
              fotoPerfil: actor.fotoPerfil,
              rol: actor.rol,
              telefono: ''
            });
            // ...usuario ya deshabilitado arriba
          });
        }
      } else {
        // Si no hay token, redirigir a login
        this.router.navigate(['/login']);
        return;
      }
    } else {
      // Cualquier otra ruta: no mostrar formulario
      this.usuarioLogeado = false;
      this.puedeCrearAdmin = false;
      this.mostrarFormulario = false;
    }
    this.form.get('usuario')?.valueChanges.subscribe(() => {
      this.usuarioRepetido = false;
    });
  }

  initForm() {
    this.form = this.fb.group({
      nombre: ['', [Validators.required]],
      usuario: ['', [Validators.required, Validators.minLength(3)]],
      contraseña: ['', [Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
      fotoPerfil: ['', []], // Ya no es obligatorio
      rol: [{ value: '', disabled: this.modoEdicion }, [Validators.required]],
      telefono: ['', [Validators.pattern(/^([6789]\d{8})?$/)]]
    });

    // Si no es edición, la contraseña es obligatoria
    if (!this.modoEdicion) {
      this.form.get('contraseña')?.addValidators(Validators.required);
    }

    this.form.get('rol')?.valueChanges.subscribe(rol => {
      const telCtrl = this.form.get('telefono');
      if (rol === 'ANUNCIANTE') {
        telCtrl?.setValidators([Validators.required, Validators.pattern(/^([6789]\d{8})?$/)]);
      } else {
        telCtrl?.clearValidators();
        telCtrl?.setValue('');
      }
      telCtrl?.updateValueAndValidity();
    });
  }

  isAnunciante(): boolean {
    return (this.form.get('rol')?.value || this.actor?.rol) === 'ANUNCIANTE';
  }

  isAdmin(): boolean {
    // Devuelve true si el campo rol del formulario es 'ADMIN' o si el actor lo es
    return (this.form.get('rol')?.value === 'ADMIN') || this.actor?.rol === 'ADMIN';
  }

  onSubmit() {
    if (this.form.invalid) return;
    const datos = { ...this.form.getRawValue() };
    if (this.modoEdicion) {
      // Eliminar usuario del payload para evitar que se envíe aunque esté en el input (por seguridad)
      delete datos.usuario;
      if (!datos.contraseña) delete datos.contraseña;
    }

    if (datos.rol === 'ADMIN') {
      this.adminService.guardarAdmin(datos).subscribe({
        next: () => {
          this.mensajeExito = 'Administrador creado correctamente.';
          this.abrirModal('modalExito');
          setTimeout(() => this.router.navigate(['/']), 1500);
        },
        error: (err) => {
          if (err.status === 500) {
            this.usuarioRepetido = true;
            this.mensajeError = 'El nombre de usuario ya está en uso. Por favor, elige otro.';
          } else {
            this.mensajeError = 'Error al registrar el administrador.';
          }
          this.abrirModal('modalError');
        }
      });
      return;
    }

    if (this.isAnunciante()) {
      if (this.modoEdicion) {
        this.anuncianteService.actualizarAnunciante(datos).subscribe({
          next: () => {
            this.mensajeExito = 'Datos actualizados correctamente.';
            this.abrirModal('modalExito');
            setTimeout(() => this.router.navigate(['/']), 1500);
          },
          error: (err) => {
            if (err.status === 500) {
              this.usuarioRepetido = true;
              this.mensajeError = 'El nombre de usuario ya está en uso. Por favor, elige otro.';
            } else {
              this.mensajeError = 'Error al actualizar los datos.';
            }
            this.abrirModal('modalError');
          }
        });
      } else {
        this.anuncianteService.guardarAnunciante(datos).subscribe({
          next: () => {
            this.mensajeExito = 'Registro completado correctamente.';
            this.abrirModal('modalExito');
            setTimeout(() => this.router.navigate(['/login']), 1500);
          },
          error: (err) => {
            if (err.status === 500) {
              this.usuarioRepetido = true;
              this.mensajeError = 'El nombre de usuario ya está en uso. Por favor, elige otro.';
            } else {
              this.mensajeError = 'Error al registrar el anunciante.';
            }
            this.abrirModal('modalError');
          }
        });
      }
    } else {
      if (this.modoEdicion) {
        this.estudianteService.actualizarEstudiante(datos).subscribe({
          next: () => {
            this.mensajeExito = 'Datos actualizados correctamente.';
            this.abrirModal('modalExito');
            setTimeout(() => this.router.navigate(['/']), 1500);
          },
          error: (err) => {
            if (err.status === 500) {
              this.usuarioRepetido = true;
              this.mensajeError = 'El nombre de usuario ya está en uso. Por favor, elige otro.';
            } else {
              this.mensajeError = 'Error al actualizar los datos.';
            }
            this.abrirModal('modalError');
          }
        });
      } else {
        this.estudianteService.guardarEstudiante(datos).subscribe({
          next: () => {
            this.mensajeExito = 'Registro completado correctamente.';
            this.abrirModal('modalExito');
            setTimeout(() => this.router.navigate(['/login']), 1500);
          },
          error: (err) => {
            if (err.status === 500) {
              this.usuarioRepetido = true;
              this.mensajeError = 'El nombre de usuario ya está en uso. Por favor, elige otro.';
            } else {
              this.mensajeError = 'Error al registrar el estudiante.';
            }
            this.abrirModal('modalError');
          }
        });
      }
    }
  }

  abrirModal(id: string) {
    const modal = document.getElementById(id);
    if (modal) {
      // @ts-ignore
      const bsModal = new window.bootstrap.Modal(modal);
      bsModal.show();
    }
  }

  cancelar() {
    this.router.navigate(['/']);
  }
}