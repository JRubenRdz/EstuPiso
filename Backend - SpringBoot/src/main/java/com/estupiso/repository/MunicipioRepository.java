package com.estupiso.repository;

import java.util.List;
import java.util.Optional;

import com.estupiso.model.Municipio;
import com.estupiso.model.Provincia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MunicipioRepository extends JpaRepository<Municipio, Integer> {
   public Optional<Municipio> findByNombre(String nombre);

   @Query("SELECT m FROM Municipio m WHERE m.provincia.id = :provinciaId")
   public List<Municipio> findByProvinciaId(@Param("provinciaId") Integer provinciaId);
}