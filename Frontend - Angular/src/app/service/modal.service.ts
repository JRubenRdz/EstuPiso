import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';

export interface ModalConfig {
  show: boolean;
  type: 'success' | 'error' | 'info' | 'warning' | 'confirm';
  title: string;
  message: string;
  autoClose?: boolean;
  autoCloseTime?: number;
  showCloseButton?: boolean;
  onClose?: () => void;
  onConfirm?: () => void;
  onCancel?: () => void;
  confirmText?: string;
  cancelText?: string;
}

@Injectable({
  providedIn: 'root'
})
export class ModalService {
  private modalSubject = new BehaviorSubject<ModalConfig>({
    show: false,
    type: 'info',
    title: '',
    message: ''
  });

  public modal$: Observable<ModalConfig> = this.modalSubject.asObservable();

  constructor() { }

  // Mostrar modal de éxito
  showSuccess(message: string, title: string = '¡Éxito!', autoClose: boolean = false): void {
    this.showModal({
      show: true,
      type: 'success',
      title,
      message,
      autoClose,
      autoCloseTime: autoClose ? 3000 : undefined,
      showCloseButton: true
    });
  }

  // Mostrar modal de error
  showError(message: string, title: string = 'Error', autoClose: boolean = false): void {
    this.showModal({
      show: true,
      type: 'error',
      title,
      message,
      autoClose,
      autoCloseTime: autoClose ? 5000 : undefined,
      showCloseButton: true
    });
  }

  // Mostrar modal de información
  showInfo(message: string, title: string = 'Información', autoClose: boolean = false): void {
    this.showModal({
      show: true,
      type: 'info',
      title,
      message,
      autoClose,
      autoCloseTime: autoClose ? 4000 : undefined,
      showCloseButton: true
    });
  }

  // Mostrar modal de advertencia
  showWarning(message: string, title: string = 'Advertencia', autoClose: boolean = false): void {
    this.showModal({
      show: true,
      type: 'warning',
      title,
      message,
      autoClose,
      autoCloseTime: autoClose ? 4000 : undefined,
      showCloseButton: true
    });
  }

  // Mostrar modal de confirmación
  showConfirm(
    message: string, 
    title: string = 'Confirmar Acción',
    onConfirm: () => void,
    onCancel?: () => void,
    confirmText: string = 'Confirmar',
    cancelText: string = 'Cancelar'
  ): void {
    this.showModal({
      show: true,
      type: 'confirm',
      title,
      message,
      showCloseButton: false,
      onConfirm,
      onCancel,
      confirmText,
      cancelText
    });
  }

  // Mostrar modal personalizado
  showModal(config: ModalConfig): void {
    this.modalSubject.next(config);

    // Auto cerrar si está habilitado
    if (config.autoClose && config.autoCloseTime) {
      setTimeout(() => {
        this.close();
      }, config.autoCloseTime);
    }
  }

  // Cerrar modal
  close(): void {
    const currentModal = this.modalSubject.value;
    
    // Ejecutar callback si existe
    if (currentModal.onClose) {
      currentModal.onClose();
    }

    // Cerrar el modal
    this.modalSubject.next({
      show: false,
      type: 'info',
      title: '',
      message: ''
    });
  }

  // Alias para close() para compatibilidad
  closeModal(): void {
    this.close();
  }
}
