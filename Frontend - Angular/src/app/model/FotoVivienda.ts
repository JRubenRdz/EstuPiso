import { Vivienda } from "./Vivienda";

export class FotoVivienda {
    id!: number;
    url: string;
    vivienda: Vivienda;

    constructor(url: string, vivienda: Vivienda) {
        this.url = url;
        this.vivienda = vivienda;
    }
}