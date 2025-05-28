package com.estupiso.specification;

import com.estupiso.model.TiposVivienda;
import com.estupiso.model.Vivienda;
import org.springframework.data.jpa.domain.Specification;
import jakarta.persistence.criteria.Expression;

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
                nombre == null ? null : cb.like(cb.lower(root.get("nombre")), "%" + nombre.toLowerCase() + "%");
    }

    public static Specification<Vivienda> conMunicipio(String municipio) {
        return (root, query, cb) ->
                municipio == null ? null : cb.equal(root.get("municipio"), municipio);
    }    // CORREGIDO: Método para viviendas disponibles
    public static Specification<Vivienda> disponible() {
        return (root, query, cb) -> {
            // Verificar que numeroHabitaciones > número de residentes
            Expression<Integer> numeroHabitaciones = root.get("numeroHabitaciones");
            Expression<Integer> numeroResidentes = cb.size(root.get("residentes"));
            
            return cb.greaterThan(numeroHabitaciones, numeroResidentes);
        };
    }public static Specification<Vivienda> conDireccion(String direccion) {
        return (root, query, cb) ->
                direccion == null ? null : cb.like(cb.lower(root.get("calle")), "%" + direccion.toLowerCase() + "%");
    }

    public static Specification<Vivienda> conTipoVivienda(TiposVivienda tipoVivienda) {
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
    }    // CORREGIDO: Método para habitaciones mínimas
    public static Specification<Vivienda> conHabitacionesMinimas(Integer habitaciones) {
        return (root, query, cb) -> {
            if (habitaciones == null) return null;
            
            // Comparación directa sin CAST
            Expression<Integer> numeroHabitaciones = root.get("numeroHabitaciones");
            return cb.greaterThanOrEqualTo(numeroHabitaciones, habitaciones);
        };
    }
}
