package com.estupiso.repository;

import com.estupiso.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Integer> {

    public Optional<Admin> findByUsuario(String username);
}
