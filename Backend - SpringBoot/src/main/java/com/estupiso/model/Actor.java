package com.estupiso.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.URL;

@Getter
@Setter
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Actor extends DomainEntity {

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
