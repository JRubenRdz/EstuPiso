package com.estupiso.model;

import jakarta.persistence.*;
import org.hibernate.validator.constraints.URL;

@Entity
public class FotoVivienda extends DomainEntity {

    @URL
    private String imagen;

    @ManyToOne
    @JoinColumn(name = "vivienda_id", nullable = false)
    private Vivienda vivienda;

}
