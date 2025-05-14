package com.estupiso.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Vivienda extends DomainEntity {

    @NotBlank
    private String nombre;

    @NotBlank
    private String comunidad;

    @NotBlank
    private String provincia;

    @NotBlank
    private String municipio;

    @NotBlank
    private String calle;

    @NotBlank
    private String numero;

    @NotBlank
    private String descripcion;

    @NotBlank
    private int precioMensual;

    @NotBlank
    private TiposVivienda tipoVivienda;

    @NotBlank
    private String numeroHabitaciones;

    @NotBlank
    private LocalDateTime fechaPublicacion;

    @NotBlank
    private LocalDateTime ultimaEdicion;

    @ManyToOne
    @JoinColumn(name = "anunciante_id")
    private Anunciante anunciante;

    @OneToMany(mappedBy = "vivienda", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Estudiante> residentes = new ArrayList<>();

    @OneToMany(mappedBy = "vivienda", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<FotoVivienda> fotos = new ArrayList<>();

    public void añadirResidente(Estudiante estudiante) {
        if (!residentes.contains(estudiante)) {
            residentes.add(estudiante);
        }
        estudiante.setVivienda(this);
    }
}
