import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViviendaFormComponent } from './vivienda-form.component';

describe('ViviendaFormComponent', () => {
  let component: ViviendaFormComponent;
  let fixture: ComponentFixture<ViviendaFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ViviendaFormComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ViviendaFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
