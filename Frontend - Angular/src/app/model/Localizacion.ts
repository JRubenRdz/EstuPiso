export class Comunidad {
    id: number;
    nombre: string;
    provincias: Provincia[];

    constructor(id: number, nombre: string, provincias: Provincia[]) {
        this.id = id;
        this.nombre = nombre;
        this.provincias = provincias;
    }
}

export class Provincia {
    id: number;
    nombre: string;
    comunidad: Comunidad;
    municipios: Municipio[];

    constructor(id: number, nombre: string, comunidad: Comunidad, municipios: Municipio[]) {
        this.id = id;
        this.nombre = nombre;
        this.comunidad = comunidad;
        this.municipios = municipios;
    }
}

export class Municipio {
    id: number;
    codMunicipio: number;
    dc: number;
    nombre: string;
    provincia: Provincia;
    
    constructor(id: number, codMunicipio: number, dc: number, nombre: string, provincia: Provincia) {
        this.id = id;
        this.codMunicipio = codMunicipio;
        this.dc = dc;
        this.nombre = nombre;
        this.provincia = provincia;
    }
}