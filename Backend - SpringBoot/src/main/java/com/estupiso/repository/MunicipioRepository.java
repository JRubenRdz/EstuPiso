package com.estupiso.repository;

import java.util.Optional;

import com.estupiso.model.Municipio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MunicipioRepository extends JpaRepository<Municipio, Integer> {
   public Optional<Municipio> findByNombre(String nombre);
}
