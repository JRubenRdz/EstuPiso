import { Vivienda } from "./Vivienda";

export class FotoVivienda {
    id!: number;
    imagen: string;
    vivienda: Vivienda;

    constructor(imagen: string, vivienda: Vivienda) {
        this.imagen = imagen;
        this.vivienda = vivienda;
    }
}