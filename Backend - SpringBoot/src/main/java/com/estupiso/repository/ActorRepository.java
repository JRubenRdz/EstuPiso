package com.estupiso.repository;

import java.util.Optional;

import com.estupiso.model.Actor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ActorRepository extends JpaRepository<Actor, Integer> {
    public Optional<Actor> findByUsuario(String usuario);
}
