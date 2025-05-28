package com.estupiso.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Municipio extends DomainEntity{

    @NotBlank
    @Column(name = "cod_municipio")
    private int codMunicipio;

    @NotBlank
    private int dc;

    @NotBlank
    private String nombre;

    @ManyToOne
    @JoinColumn(name = "provincia_id", nullable = false)
    @JsonBackReference
    private Provincia provincia;

}
