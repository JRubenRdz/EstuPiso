export enum Roles {
    ADMIN = 'ADMIN',
    ANUNCIANTE = 'ANUNCIANTE',
    ESTUDIANTE = 'ESTUDIANTE'
}


export abstract class Actor {
    id!: number;
    nombre: string;
    usuario: string;
    contraseña: string;
    email: string;
    fotoPerfil: string;
    rol: Roles;

    constructor(nombre: string, usuario: string, contraseña: string, email: string, fotoPerfil: string, rol: Roles) {
        this.nombre = nombre;
        this.usuario = usuario;
        this.contraseña = contraseña;
        this.email = email;
        this.fotoPerfil = fotoPerfil;
        this.rol = rol;
    }
}
