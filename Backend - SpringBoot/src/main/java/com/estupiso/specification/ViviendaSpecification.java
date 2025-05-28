package com.estupiso.specification;

import com.estupiso.model.Vivienda;
import org.springframework.data.jpa.domain.Specification;

public class ViviendaSpecification {

    public static Specification<Vivienda> conComunidad(String comunidad) {
        return (root, query, cb) ->
                comunidad == null ? null : cb.equal(root.get("comunidad"), comunidad);
    }

    public static Specification<Vivienda> conProvincia(String provincia) {
        return (root, query, cb) ->
                provincia == null ? null : cb.equal(root.get("provincia"), provincia);
    }

    public static Specification<Vivienda> conNombre(String nombre) {
        return (root, query, cb) ->
                nombre == null ? null : cb.equal(root.get("nombre"), nombre);
    }

    public static Specification<Vivienda> conMunicipio(String municipio) {
        return (root, query, cb) ->
                municipio == null ? null : cb.equal(root.get("municipio"), municipio);
    }    public static Specification<Vivienda> disponible() {
        return (root, query, cb) -> {
            try {
                // Convertir numeroHabitaciones de String a Integer para la comparación
                return cb.greaterThan(
                    cb.function("CAST", Integer.class, root.get("numeroHabitaciones"), cb.literal("INTEGER")),
                    cb.size(root.get("residentes"))
                );
            } catch (Exception e) {
                // Fallback: asumir que si hay residentes es menor que habitaciones
                return cb.isNotEmpty(root.get("residentes"));
            }
        };
    }public static Specification<Vivienda> conDireccion(String direccion) {
        return (root, query, cb) ->
                direccion == null ? null : cb.like(cb.lower(root.get("calle")), "%" + direccion.toLowerCase() + "%");
    }

    public static Specification<Vivienda> conTipoVivienda(String tipoVivienda) {
        return (root, query, cb) ->
                tipoVivienda == null ? null : cb.equal(root.get("tipoVivienda"), tipoVivienda);
    }

    public static Specification<Vivienda> conPrecioMinimo(Double precioMin) {
        return (root, query, cb) ->
                precioMin == null ? null : cb.greaterThanOrEqualTo(root.get("precioMensual"), precioMin);
    }

    public static Specification<Vivienda> conPrecioMaximo(Double precioMax) {
        return (root, query, cb) ->
                precioMax == null ? null : cb.lessThanOrEqualTo(root.get("precioMensual"), precioMax);
    }    public static Specification<Vivienda> conHabitacionesMinimas(Integer habitaciones) {
        return (root, query, cb) -> {
            if (habitaciones == null) return null;
            try {
                // Convertir String a Integer para la comparación
                return cb.greaterThanOrEqualTo(
                    cb.function("CAST", Integer.class, root.get("numeroHabitaciones"), cb.literal("INTEGER")), 
                    habitaciones
                );
            } catch (Exception e) {
                // Si hay error en la conversión, usar comparación de string
                return cb.greaterThanOrEqualTo(root.get("numeroHabitaciones"), habitaciones.toString());
            }
        };
    }

}
