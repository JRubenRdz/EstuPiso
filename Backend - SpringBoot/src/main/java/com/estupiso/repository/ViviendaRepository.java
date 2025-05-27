package com.estupiso.repository;

import com.estupiso.model.Anunciante;
import com.estupiso.model.Vivienda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface ViviendaRepository extends JpaRepository<Vivienda, Integer>, JpaSpecificationExecutor<Vivienda> {
    public Optional<Vivienda> findByNombre(String nombre);

    public Optional<List<Vivienda>> findAllByAnunciante(Anunciante anunciante);
}
