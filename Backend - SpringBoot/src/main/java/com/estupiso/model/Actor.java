package com.estupiso.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.URL;

@Getter
@Setter
@Entity
public class Actor extends DomainEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @NotBlank
    private String nombre;

    @NotBlank
    private String usuario;

    @NotBlank
    private String contraseña;

    @Email
    @NotBlank
    private String email;

    @URL
    @NotBlank
    private String fotoPerfil;

    @NotBlank
    private Roles rol;

    public Actor() {
    }
}
