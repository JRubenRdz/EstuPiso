package com.estupiso.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "municipio")
public class Municipio extends DomainEntity {

    @NotNull
    @Column(name = "cod_municipio", columnDefinition = "INTEGER")
    private Integer codMunicipio;

    @NotNull
    @Column(columnDefinition = "INTEGER")
    private Integer dc;

    @NotBlank
    @Column(columnDefinition = "VARCHAR(255)")
    private String nombre;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "provincia_id", nullable = false, columnDefinition = "INTEGER")
    @JsonBackReference
    private Provincia provincia;
}