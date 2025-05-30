package com.estupiso.specification;

import com.estupiso.model.TiposVivienda;
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

    public static Specification<Vivienda> conMunicipio(String municipio) {
        return (root, query, cb) ->
                municipio == null ? null : cb.like(cb.lower(root.get("municipio")), 
                        "%" + municipio.toLowerCase() + "%");
    }

    public static Specification<Vivienda> conNombre(String nombre) {
        return (root, query, cb) ->
                nombre == null ? null : cb.like(cb.lower(root.get("nombre")), 
                        "%" + nombre.toLowerCase() + "%");
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
    }

    public static Specification<Vivienda> conHabitacionesMinimas(Integer habitaciones) {
        return (root, query, cb) ->
                habitaciones == null ? null : cb.greaterThanOrEqualTo(root.get("numeroHabitaciones"), habitaciones);
    }

    public static Specification<Vivienda> conDireccion(String direccion) {
        return (root, query, cb) -> {
            if (direccion == null) return null;
            String pattern = "%" + direccion.toLowerCase() + "%";
            return cb.or(
                cb.like(cb.lower(root.get("calle")), pattern),
                cb.like(cb.lower(root.get("municipio")), pattern),
                cb.like(cb.lower(root.get("provincia")), pattern),
                cb.like(cb.lower(root.get("comunidad")), pattern)
            );
        };
    }

    public static Specification<Vivienda> disponible() {
        return (root, query, cb) ->
                cb.lessThan(cb.size(root.get("residentes")), root.get("numeroHabitaciones"));
    }
}