import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViviendaDetailsComponent } from './vivienda-details.component';

describe('ViviendaDetailsComponent', () => {
  let component: ViviendaDetailsComponent;
  let fixture: ComponentFixture<ViviendaDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ViviendaDetailsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ViviendaDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
