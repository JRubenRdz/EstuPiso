import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { EstudianteService } from '../../../service/estudiante.service';
import { AnuncianteService } from '../../../service/anunciante.service';
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

  constructor(
    private fb: FormBuilder,
    private estudianteService: EstudianteService,
    private anuncianteService: AnuncianteService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.initForm();

    const token = localStorage.getItem('token');
    if (token) {
      const decoded: any = jwtDecode(token);
      const usuario = decoded.sub;
      const rol = decoded.rol;
      this.titulo = 'Mis datos';
      this.modoEdicion = true;

      if (rol === 'ESTUDIANTE') {
        this.estudianteService.getEstudianteByUsuario(usuario.toString()).subscribe(actor => {
          this.form.patchValue({
            nombre: actor.nombre,
            usuario: actor.usuario,
            email: actor.email,
            fotoPerfil: actor.fotoPerfil,
            rol: actor.rol,
            telefono: ''
          });
          this.form.get('rol')?.disable();
        });
      } else if (rol === 'ANUNCIANTE') {
        this.anuncianteService.getAnuncianteByUsuario(usuario).subscribe(actor => {
          this.form.patchValue({
            nombre: actor.nombre,
            usuario: actor.usuario,
            email: actor.email,
            fotoPerfil: actor.fotoPerfil,
            rol: actor.rol,
            telefono: actor.telefono
          });
          this.form.get('rol')?.disable();
        });
      }
    }
  }

  initForm() {
    this.form = this.fb.group({
      nombre: ['', [Validators.required]],
      usuario: ['', [Validators.required, Validators.minLength(5)]],
      contraseña: ['', [this.modoEdicion ? Validators.nullValidator : Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
      fotoPerfil: ['', [Validators.required]],
      rol: [{ value: '', disabled: this.modoEdicion }, [Validators.required]],
      telefono: ['', [Validators.pattern(/^([6789]\d{8})?$/)]]
    });

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
    return this.actor?.rol === 'ADMIN';
  }

  onSubmit() {
    if (this.form.invalid) return;
    const datos = { ...this.form.getRawValue() };
    if (this.modoEdicion && !datos.contraseña) delete datos.contraseña;

    if (this.isAnunciante()) {
      if (this.modoEdicion) {
        this.anuncianteService.actualizarAnunciante(datos).subscribe(() => this.router.navigate(['/']));
      } else {
        this.anuncianteService.guardarAnunciante(datos).subscribe(() => this.router.navigate(['/login']));
      }
    } else {
      if (this.modoEdicion) {
        this.estudianteService.actualizarEstudiante(datos).subscribe(() => this.router.navigate(['/']));
      } else {
        this.estudianteService.guardarEstudiante(datos).subscribe(() => this.router.navigate(['/login']));
      }
    }
  }

  cancelar() {
    this.router.navigate(['/']);
  }
}