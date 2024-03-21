CREATE TABLE "Usuario" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "nombre" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "tipo" nvarchar2(255) NOT NULL CHECK ("tipo" IN ('empleado', 'usuario', 'jefe')) NOT NULL DEFAULT 'usuario'
);

CREATE TABLE "PurificacionAgua" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "sistema_id" INT NOT NULL,
  "capacidad" FLOAT,
  "eficiencia" FLOAT
);

CREATE TABLE "Panel" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "sistema_id" INT NOT NULL,
  "eficiencia_mejorada" FLOAT,
  "id_proveedor" INT NOT NULL
);

CREATE TABLE "SistemaMecanico" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "usuario_id" INT NOT NULL,
  "estado" VARCHAR(50)
);

CREATE TABLE "SistemaSoftware" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "usuario_id" INT NOT NULL,
  "estado" VARCHAR(50)
);

CREATE TABLE "DatoEficiencia" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "sistema_id" INT NOT NULL,
  "tipo_datos" nvarchar2(255) NOT NULL CHECK ("tipo_datos" IN ('voltaje', 'porcentaje')) NOT NULL,
  "valor" FLOAT
);

CREATE TABLE "Proveedor" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "marca_panel" VARCHAR(50),
  "garantia" INT NOT NULL,
  "precio" FLOAT,
  "id_factura" INT NOT NULL
);

CREATE TABLE "Factura" (
  "id" INT GENERATED AS IDENTITY PRIMARY KEY,
  "numero_serie" VARCHAR(30),
  "nit" VARCHAR(20)
);

ALTER TABLE "PurificacionAgua" ADD FOREIGN KEY ("sistema_id") REFERENCES "SistemaSoftware" ("id");

ALTER TABLE "Panel" ADD FOREIGN KEY ("sistema_id") REFERENCES "SistemaMecanico" ("id");

ALTER TABLE "SistemaMecanico" ADD FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id");

ALTER TABLE "SistemaSoftware" ADD FOREIGN KEY ("usuario_id") REFERENCES "Usuario" ("id");

ALTER TABLE "DatoEficiencia" ADD FOREIGN KEY ("sistema_id") REFERENCES "SistemaMecanico" ("id");

ALTER TABLE "Panel" ADD FOREIGN KEY ("id_proveedor") REFERENCES "Proveedor" ("id");

ALTER TABLE "Proveedor" ADD FOREIGN KEY ("id_factura") REFERENCES "Factura" ("id");
