package com.estupiso.repository;

import com.estupiso.model.Anunciante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AnuncianteRepository extends JpaRepository<Anunciante, Integer> {
    public Optional<Anunciante> findByUsuario(String usuario);
}
