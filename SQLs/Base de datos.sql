CREATE TABLE "Anunciante" (
  "id" integer PRIMARY KEY,
  "nombre" varchar NOT NULL,
  "usuario" varchar NOT NULL,
  "contraseña" varchar NOT NULL,
  "email" varchar NOT NULL,
  "foto_perfil" varchar,
  "rol" varchar NOT NULL
);

CREATE TABLE "Vivienda" (
  "id" integer PRIMARY KEY,
  "direccion" varchar NOT NULL,
  "Descripción" text,
  "id_anunciante" integer NOT NULL,
  "tipo_vivienda" varchar NOT NULL,
  "num_habitaciones" integer NOT NULL,
  "total_residentes" integer NOT NULL
);

CREATE TABLE "Estudiante" (
  "id" integer PRIMARY KEY,
  "nombre" varchar NOT NULL,
  "usuario" varchar NOT NULL,
  "contraseña" varchar NOT NULL,
  "email" varchar NOT NULL,
  "foto_perfil" varchar,
  "id_vivienda" integer,
  "rol" varchar NOT NULL
);

CREATE TABLE "Administradores" (
  "id" integer PRIMARY KEY,
  "usuario" varchar NOT NULL,
  "contraseña" varchar NOT NULL,
  "email" varchar NOT NULL,
  "rol" varchar NOT NULL
);

CREATE TABLE "Comunidades" (
  "id" integer PRIMARY KEY,
  "nombre" varchar NOT NULL
);

CREATE TABLE "Provincias" (
  "id" integer PRIMARY KEY,
  "id_comunidad" integer NOT NULL,
  "nombre" varchar NOT NULL
);

CREATE TABLE "Municipios" (
  "id" integer PRIMARY KEY,
  "id_provincia" integer NOT NULL,
  "cod_municipio" integer NOT NULL,
  "dc" integer NOT NULL,
  "nombre" varchar NOT NULL
);

COMMENT ON COLUMN "Vivienda"."Descripción" IS 'Descripción de la vivienda';

ALTER TABLE "Vivienda" ADD CONSTRAINT "vivienda_anunciante" FOREIGN KEY ("id_anunciante") REFERENCES "Anunciante" ("id");

ALTER TABLE "Estudiante" ADD CONSTRAINT "estudiante_vivienda" FOREIGN KEY ("id_vivienda") REFERENCES "Vivienda" ("id");

ALTER TABLE "Provincias" ADD CONSTRAINT "provincia_comunidad" FOREIGN KEY ("id_comunidad") REFERENCES "Comunidades" ("id");

ALTER TABLE "Municipios" ADD CONSTRAINT "municipio_provincia" FOREIGN KEY ("id_provincia") REFERENCES "Provincias" ("id");
