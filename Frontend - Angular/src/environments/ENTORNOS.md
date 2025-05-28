# Sistema Simple de Entornos

## 🎯 Cómo cambiar entorno

En el archivo `src/environments/active.environment.ts`, simplemente cambia esta línea:

```typescript
const ACTIVE_ENVIRONMENT = 'development'; // Cambiar aquí
```

### Opciones disponibles:
- `'development'` - Desarrollo local (http://localhost:8080)
- `'production'` - Producción (http://api.estupiso.com)  
- `'tests'` - Testing (http://test.estupiso.com:8080)

## ✅ Servicios actualizados:
- ✅ ubicacion.service.ts
- ✅ vivienda.service.ts  
- ✅ actor.service.ts
- ✅ admin.service.ts
- ✅ anunciante.service.ts
- ✅ estudiante.service.ts

Todos estos servicios ahora usan `active.environment.ts` automáticamente.
