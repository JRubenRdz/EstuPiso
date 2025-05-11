package com.estupiso.repository;

import com.estupiso.model.Comunidad;
import com.estupiso.model.Provincia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProvinciaRepository extends JpaRepository<Provincia, Integer> {
    public Optional<Provincia> findByNombre(String nombre);
    public List<Provincia> findByComunidad(Comunidad comunidad);
}
