package com.estupiso.model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Anunciante extends Actor {

    @Pattern(regexp = "^([6789]\\d{8})?$")
    private String telefono;

    @OneToMany(mappedBy = "anunciante", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Vivienda> viviendas = new ArrayList<>();

}
