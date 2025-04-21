package com.estupiso.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
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
public class Vivienda {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @NotBlank
    private String direccion;

    @NotBlank
    private String descripcion;

    @ManyToOne
    @JoinColumn(name = "anunciante_id")
    private Anunciante anunciante;

    @NotBlank
    private String tipoVivienda;

    @NotBlank
    private String numeroHabitaciones;

    @OneToMany(mappedBy = "vivienda", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Estudiante> residentes = new ArrayList<>();


}
