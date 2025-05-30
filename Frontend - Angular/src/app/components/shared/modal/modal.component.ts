import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Subscription } from 'rxjs';
import { ModalService, ModalConfig } from '../../../service/modal.service';

@Component({
  selector: 'app-modal',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './modal.component.html',
  styleUrl: './modal.component.css'
})
export class ModalComponent implements OnInit, OnDestroy {
  modalConfig: ModalConfig = {
    show: false,
    type: 'info',
    title: '',
    message: ''
  };
  private subscription: Subscription = new Subscription();
  private autoCloseTimer?: number;

  constructor(private modalService: ModalService) {}

  ngOnInit(): void {
    this.subscription = this.modalService.modal$.subscribe(config => {
      this.modalConfig = config;
      
      if (config.show && config.autoClose) {
        this.startAutoCloseTimer();
      } else {
        this.clearAutoCloseTimer();
      }
    });
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
    this.clearAutoCloseTimer();
  }

  closeModal(): void {
    this.clearAutoCloseTimer();
    this.modalService.closeModal();
    
    if (this.modalConfig.onClose) {
      this.modalConfig.onClose();
    }
  }
  private startAutoCloseTimer(): void {
    this.clearAutoCloseTimer();
    const closeTime = this.modalConfig.autoCloseTime || 3000;
    
    this.autoCloseTimer = window.setTimeout(() => {
      this.closeModal();
    }, closeTime);
  }
  private clearAutoCloseTimer(): void {
    if (this.autoCloseTimer) {
      window.clearTimeout(this.autoCloseTimer);
      this.autoCloseTimer = undefined;
    }
  }
  getModalClass(): string {
    switch (this.modalConfig.type) {
      case 'success': return 'modal-success';
      case 'error': return 'modal-error';
      case 'warning': return 'modal-warning';
      case 'info': return 'modal-info';
      case 'confirm': return 'modal-confirm';
      default: return 'modal-info';
    }
  }

  getHeaderClass(): string {
    switch (this.modalConfig.type) {
      case 'success': return 'bg-success text-white';
      case 'error': return 'bg-danger text-white';
      case 'warning': return 'bg-warning text-dark';
      case 'info': return 'bg-info text-white';
      case 'confirm': return 'bg-warning text-dark';
      default: return 'bg-info text-white';
    }
  }

  getIconClass(): string {
    switch (this.modalConfig.type) {
      case 'success': return 'bi bi-check-circle-fill';
      case 'error': return 'bi bi-exclamation-triangle-fill';
      case 'warning': return 'bi bi-exclamation-triangle-fill';
      case 'info': return 'bi bi-info-circle-fill';
      case 'confirm': return 'bi bi-question-circle-fill';
      default: return 'bi bi-info-circle-fill';
    }
  }  confirmAction(): void {
    this.clearAutoCloseTimer();
    
    // CORREGIR: Ejecutar el callback ANTES de cerrar el modal
    if (this.modalConfig.onConfirm) {
      this.modalConfig.onConfirm();
    } 
    
    // Cerrar el modal DESPUÉS de ejecutar la acción
    this.modalService.closeModal();
  }  cancelAction(): void {
    this.clearAutoCloseTimer();
    
    // CORREGIR: Ejecutar el callback ANTES de cerrar el modal
    if (this.modalConfig.onCancel) {
      this.modalConfig.onCancel();
    }
    
    // Cerrar el modal DESPUÉS de ejecutar la acción
    this.modalService.closeModal();
  }

  isConfirmModal(): boolean {
    return this.modalConfig.type === 'confirm';
  }

  getFormattedMessage(): string {
    if (!this.modalConfig.message) return '';
    
    // Convertir saltos de línea \n a <br> tags para HTML
    return this.modalConfig.message.replace(/\n/g, '<br>');
  }
}
