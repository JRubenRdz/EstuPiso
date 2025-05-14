import { Actor, Roles } from "./Actor";
import { Vivienda } from "./Vivienda";

export class Estudiante extends Actor {
    vivienda: Vivienda;

    constructor(
        nombre: string,
        usuario: string,
        contraseña: string,
        email: string,
        fotoPerfil: string,
        rol: Roles,
        vivienda: Vivienda
    ) {
        super(nombre, usuario, contraseña, email, fotoPerfil, rol);
        this.vivienda = vivienda;
    }
}