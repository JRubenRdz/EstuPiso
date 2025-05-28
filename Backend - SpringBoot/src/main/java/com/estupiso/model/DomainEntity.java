package com.estupiso.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class DomainEntity {    
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Version
    @Column(columnDefinition = "integer default 0")
    private int version;

    public DomainEntity() {
        super();
    }


}
