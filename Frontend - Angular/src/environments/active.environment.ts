import { environment as devEnvironment } from './environment.development';
import { environment as prodEnvironment } from './environment.production';
import { environment as testEnvironment } from './environment.tests';

// CAMBIAR SOLO ESTA LÍNEA PARA CAMBIAR EL ENTORNO ACTIVO:
const ACTIVE_ENVIRONMENT = 'development'; // 'development' | 'production' | 'tests'

// Mapeo de entornos
const environments = {
  'development': devEnvironment,
  'production': prodEnvironment,
  'tests': testEnvironment
};

// Exportar el entorno activo
export const environment = environments[ACTIVE_ENVIRONMENT as keyof typeof environments];