import { Anunciante } from "./Anunciante";
import { Estudiante } from "./Estudiante";
import { FotoVivienda } from "./FotoVivienda";

export enum TiposVivienda {
    PISO = "PISO",
    CASA = "CASA",
    APARTAMENTO = "APARTAMENTO",
    ESTUDIO = "ESTUDIO",
    ÁTICO = "ÁTICO",
    OTRO = "OTRO"
}


export class Vivienda {
    id!: number;
    nombre: string;
    comunidad: string;
    provincia: string;
    municipio: string;
    calle: string;
    numero: string;
    descripcion: string;
    precioMensual: number;
    tipoVivienda: TiposVivienda;
    numeroHabitaciones: number;
    fechaPublicacion: Date;
    ultimaEdicion: Date;
    anunciante: Anunciante;
    residentes: Estudiante[];
    fotos: FotoVivienda[];
    
    constructor(nombre: string, comunidad: string, provincia: string, municipio: string, calle: string, numero: string, descripcion: string, precioMensual: number, tipoVivienda: TiposVivienda, numeroHabitaciones: number, fechaPublicacion: Date, ultimaEdicion: Date, anunciante: Anunciante, residentes: Estudiante[], fotos: FotoVivienda[]) {
        this.nombre = nombre;
        this.comunidad = comunidad;
        this.provincia = provincia;
        this.municipio = municipio;
        this.calle = calle;
        this.numero = numero;
        this.descripcion = descripcion;
        this.precioMensual = precioMensual;
        this.tipoVivienda = tipoVivienda;
        this.numeroHabitaciones = numeroHabitaciones;
        this.fechaPublicacion = fechaPublicacion;
        this.ultimaEdicion = ultimaEdicion;
        this.anunciante = anunciante;
        this.residentes = residentes;
        this.fotos = fotos;
    }
}