package com.estupiso.repository;

import com.estupiso.model.Estudiante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EstudianteRepository extends JpaRepository<Estudiante, Integer> {
    public Optional<Estudiante> findByUsuario(String usuario);
}
