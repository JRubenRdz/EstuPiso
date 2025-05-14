import { Actor, Roles } from "./Actor";
import { Vivienda } from "./Vivienda";

export class Anunciante extends Actor {

    telefono: string;
    viviendas: Vivienda[];

    constructor(
        nombre: string,
        usuario: string,
        contraseña: string,
        email: string,
        fotoPerfil: string,
        rol: Roles,
        telefono: string,
        viviendas: Vivienda[]
    ) {
        super(nombre, usuario, contraseña, email, fotoPerfil, rol); // <-- Pásalo aquí también
        this.telefono = telefono;
        this.viviendas = viviendas;
    }

}