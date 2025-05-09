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
    }

    public static Specification<Vivienda> disponible() {
        return (root, query, cb) ->
                cb.greaterThan(root.get("numeroHabitaciones"), cb.size(root.get("residentes")));
    }

    public static Specification<Vivienda> conDireccion(String direccion) {
        return (root, query, cb) ->
                direccion == null ? null : cb.equal(root.get("direccion"), direccion);
    }

}
