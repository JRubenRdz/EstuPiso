package com.estupiso.model;

import jakarta.persistence.*;

@Entity
public class FotoVivienda extends DomainEntity {

    @Lob
    @Column(columnDefinition = "bytea")
    private byte[] imagen;

    @ManyToOne
    @JoinColumn(name = "vivienda_id", nullable = false)
    private Vivienda vivienda;

}
