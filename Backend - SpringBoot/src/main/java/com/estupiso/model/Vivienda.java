package com.estupiso.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Data
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
    @Column(name = "municipio")
    private String municipio;

    @NotBlank
    private String calle;

    @NotBlank
    private String numero;

    @NotBlank
    private String descripcion;

    @NotNull
    private int precioMensual;

    @NotNull
    private TiposVivienda tipoVivienda;

    @Column
    private int numeroHabitaciones;

    @NotNull
    private LocalDateTime fechaPublicacion;

    @NotNull
    private LocalDateTime ultimaEdicion;

    @ManyToOne
    @JoinColumn(name = "anunciante_id")
    @JsonBackReference
    private Anunciante anunciante;

    @OneToMany(mappedBy = "vivienda", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Estudiante> residentes = new ArrayList<>();

    @OneToMany(mappedBy = "vivienda", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<FotoVivienda> fotos = new ArrayList<>();

    // Usar JsonIgnore para evitar conflictos
    @OneToMany(mappedBy = "vivienda", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<SolicitudVivienda> solicitudes = new ArrayList<>();

    public void añadirResidente(Estudiante estudiante) {
        if (!residentes.contains(estudiante)) {
            residentes.add(estudiante);
        }
        estudiante.setVivienda(this);
    }

    public void addFoto(FotoVivienda foto) {
        if (fotos == null) {
            fotos = new ArrayList<>();
        }
        fotos.add(foto);
        foto.setVivienda(this);
    }

    public void removeFoto(FotoVivienda foto) {
        if (fotos != null) {
            fotos.remove(foto);
            foto.setVivienda(null);
        }
    }

    public void clearFotos() {
        if (fotos != null) {
            Iterator<FotoVivienda> iterator = fotos.iterator();
            while (iterator.hasNext()) {
                FotoVivienda foto = iterator.next();
                foto.setVivienda(null);
                iterator.remove();
            }
        }
    }
}