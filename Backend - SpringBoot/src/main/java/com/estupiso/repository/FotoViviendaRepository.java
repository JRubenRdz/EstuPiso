package com.estupiso.repository;

import com.estupiso.model.FotoVivienda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FotoViviendaRepository extends JpaRepository<FotoVivienda, Integer> {
}
