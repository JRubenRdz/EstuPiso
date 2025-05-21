import { Routes } from '@angular/router';
import { LoginComponent } from './components/actor/login/login.component';
import { ActorFormComponent } from './components/actor/actor-form/actor-form.component';

export const routes: Routes = [
    
    { path: 'login', component: LoginComponent },
    { path: 'register', component: ActorFormComponent },
    { path: 'mis-datos', component: ActorFormComponent },
    { path: 'create-user', component: ActorFormComponent },
];
