package com.estupiso.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.URL;

@Getter
@Setter
@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
public abstract class Actor extends DomainEntity {

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
    private String fotoPerfil;

    private Roles rol;

    public Actor() {
    }
}
