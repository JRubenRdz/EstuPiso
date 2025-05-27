import { Routes } from '@angular/router';
import { LoginComponent } from './components/actor/login/login.component';
import { ActorFormComponent } from './components/actor/actor-form/actor-form.component';
import { ViviendaFormComponent } from './components/vivienda/vivienda-form/vivienda-form.component';
import { ViviendaListComponent } from './components/vivienda/vivienda-list/vivienda-list.component';
import { ViviendaDetailsComponent } from './components/vivienda/vivienda-details/vivienda-details.component';
import { HomeComponent } from './components/layout/home/home.component'; // <-- Agregar import

export const routes: Routes = [
  // Home
  { path: '', component: HomeComponent }, // <-- Cambiar la ruta por defecto

  // Actores
  { path: 'login', component: LoginComponent },
  { path: 'register', component: ActorFormComponent },
  { path: 'mis-datos', component: ActorFormComponent },

  // Admin
  { path: 'create-user', component: ActorFormComponent },

  // Anunciante
  { path: 'nuevo-anuncio', component: ViviendaFormComponent },
  { path: 'editar-vivienda/:id', component: ViviendaFormComponent },
  { path: 'mis-anuncios', component: ViviendaListComponent },
  
  // Vivienda detalles
  { path: 'anuncio/:id', component: ViviendaDetailsComponent },

  // Redirección por defecto
  { path: '**', redirectTo: '', pathMatch: 'full' } // <-- Cambiar redirección
];
