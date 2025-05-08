package com.estupiso.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

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

    @Lob
    @Column(columnDefinition = "bytea")
    private byte[] fotoPerfil;

    @NotBlank
    private Roles rol;

    public Actor() {
    }
}
