package com.estupiso.service;

import com.estupiso.model.Admin;
import com.estupiso.model.Roles;
import com.estupiso.repository.AdminRepository;
import com.estupiso.security.JWTUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    private PasswordEncoder passwordEncoder;

    @Autowired
    private JWTUtils jwtUtils;

    @Transactional
    public Admin updateAdmin(Admin adminU) {
        Admin admin = jwtUtils.userLogin();
        if (admin != null) {
            admin.setNombre(adminU.getNombre());
            admin.setEmail(adminU.getEmail());
            admin.setContraseña(adminU.getContraseña());
            admin.setUsuario(adminU.getUsuario());
            admin.setFotoPerfil(adminU.getFotoPerfil());
            admin.setContraseña(passwordEncoder.encode(adminU.getContraseña()));
            return adminRepository.save(admin);
        }
        return null;
    }

    public List<Admin> findAllAdmins() {
        return adminRepository.findAll();
    }

    public Optional<Admin> findById(int id) {
        return adminRepository.findById(id);
    }

    public Optional<Admin> findByUsuario(String username) {
        return adminRepository.findByUsuario(username);
    }

    @Transactional
    public boolean deleteAdmin() {
        Admin admin = jwtUtils.userLogin();
        if (admin != null) {
            adminRepository.deleteById(admin.getId());
            return true;
        }
        return false;
    }

    public void adminPorDefecto() {
        if (this.findAllAdmins().size() <= 0) {
            Admin defaultAdmin = new Admin();
            defaultAdmin.setNombre("Admin por defecto");
            defaultAdmin.setContraseña(passwordEncoder.encode("admin"));
            defaultAdmin.setRol(Roles.ADMIN);
            defaultAdmin.setUsuario("admin");
            defaultAdmin.setEmail("admin@default.es");
            defaultAdmin.setFotoPerfil(null);

            System.out.println("Usuario Admin creado por defecto");
            adminRepository.save(defaultAdmin);
        }
    }

}
