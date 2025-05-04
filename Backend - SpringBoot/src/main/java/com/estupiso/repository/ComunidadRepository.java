package com.estupiso.repository;

import com.estupiso.model.Comunidad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ComunidadRepository extends JpaRepository<Comunidad, Integer> {
    public Optional<Comunidad> findByNombre(String nombre);
}
