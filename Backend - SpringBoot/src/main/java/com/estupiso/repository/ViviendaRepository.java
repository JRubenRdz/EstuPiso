package com.estupiso.repository;

import com.estupiso.model.Vivienda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ViviendaRepository extends JpaRepository<Vivienda, Integer> {
    public Optional<Vivienda> findByNombre(String nombre);
}
