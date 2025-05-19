import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ActorService } from '../../../service/actor.service';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent implements OnInit {
  formLogin!: FormGroup;
  id!: number;

  constructor(
    private router: Router,
    private fb: FormBuilder,
    private actorService: ActorService
  ) {
    this.formLogin = this.fb.group({
      username: ['', [Validators.required, Validators.minLength(3)]],
      password: ['', [Validators.required, Validators.minLength(3)]]
    });
  }

  ngOnInit(): void {
    if(localStorage.getItem("token") !== null) {
      this.router.navigate(['/']);
    }
  }

  login() {
    const actor = this.formLogin.value;
    this.actorService.login(actor).subscribe(
      tokenLogin => { 
        localStorage.setItem("token", tokenLogin.token);
        this.router.navigate(['/']).then(() => window.location.reload());
      },
      error => { window.alert("Usuario y/o constraseña incorrecto"); }
    );
  }
}