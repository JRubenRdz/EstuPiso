package com.estupiso.repository;

import com.estupiso.model.Anunciante;
import com.estupiso.model.Vivienda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface ViviendaRepository extends JpaRepository<Vivienda, Integer>, JpaSpecificationExecutor<Vivienda> {
    public Optional<Vivienda> findByNombre(String nombre);

    public Optional<List<Vivienda>> findAllByAnuncianteId(int idAnunciante);
    
    // Nueva consulta que carga residentes explícitamente
    @Query("SELECT v FROM Vivienda v LEFT JOIN FETCH v.residentes LEFT JOIN FETCH v.anunciante WHERE v.id = :id")
    Optional<Vivienda> findByIdWithResidentes(@Param("id") Integer id);
}