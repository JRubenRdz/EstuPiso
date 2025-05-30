import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from './components/layout/navbar/navbar.component';
import { ModalComponent } from './components/shared/modal/modal.component';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, NavbarComponent, ModalComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'EstuPiso-Front';
}
