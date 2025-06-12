CREATE DATABASE mi_cine_es_tu_cine;
GO

USE mi_cine_es_tu_cine;
GO

-- Tabla #1: Película
CREATE TABLE pelicula (
    pelicula_id INT PRIMARY KEY IDENTITY(1,1),
    titulo VARCHAR(50) NOT NULL,
    sinopsis VARCHAR(250) NOT NULL,
    duracion INT NOT NULL,
    pais_origen VARCHAR(50) NOT NULL,
    imagen_url VARCHAR(250) NOT NULL
);
GO

-- Tabla #2: Película Idioma
CREATE TABLE pelicula_idioma (
    pelicula_id INT NOT NULL,
    idioma VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pelicula_pi FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id)
);
GO

-- Tabla #3: Película Subtítulo
CREATE TABLE pelicula_subtitulo (
    pelicula_id INT NOT NULL,
    subtitulo VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pelicula_ps FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id)
);
GO

-- Tabla #4: Actor
CREATE TABLE actor (
    actor_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_actor VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL
);
GO

-- Tabla #5: Categoría
CREATE TABLE categoria (
    categoria_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_categoria VARCHAR(50) NOT NULL
);
GO

-- Tabla #6: Película-Actor (Relación N:M)
CREATE TABLE pelicula_actor (
    pelicula_id INT NOT NULL,
    actor_id INT NOT NULL,
    CONSTRAINT fk_pelicula_p FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id),
    CONSTRAINT fk_actor_a FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    CONSTRAINT pk_pelicula_actor PRIMARY KEY (pelicula_id, actor_id)
);
GO

-- Tabla #7: Película-Categoría (Relación N:M)
CREATE TABLE pelicula_categoria (
    categoria_id INT NOT NULL,
    pelicula_id INT NOT NULL,
    CONSTRAINT fk_categoria_a FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id),
    CONSTRAINT fk_pelicula_pe FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id),
    CONSTRAINT pk_pelicula_categoria PRIMARY KEY (pelicula_id, categoria_id)
);
GO

-- Tabla #8: Cartelera
CREATE TABLE cartelera (
    cartelera_id INT PRIMARY KEY IDENTITY(1,1),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);
GO

-- Tabla #9: Sala
CREATE TABLE sala (
    sala_id INT PRIMARY KEY IDENTITY(1,1),
    ubicacion VARCHAR(100) NOT NULL,
    nombre_sala VARCHAR(50) NOT NULL
);
GO

-- Tabla #10: Función
CREATE TABLE funcion (
    funcion_id INT PRIMARY KEY IDENTITY(1,1),
    cartelera_id INT NOT NULL,
    sala_id INT NOT NULL,
    hora VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT fk_cartelera_f FOREIGN KEY (cartelera_id) REFERENCES cartelera(cartelera_id),
    CONSTRAINT fk_sala_f FOREIGN KEY (sala_id) REFERENCES sala(sala_id)
);
GO

-- Tabla #11: Película-Función (Relación N:M)
CREATE TABLE pelicula_funcion (
    pelicula_id INT NOT NULL,
    funcion_id INT NOT NULL,
    CONSTRAINT fk_pelicula_f FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id),
    CONSTRAINT fk_funcion_f FOREIGN KEY (funcion_id) REFERENCES funcion(funcion_id),
    CONSTRAINT pk_pelicula_funcion PRIMARY KEY (pelicula_id, funcion_id)
);
GO

-- Tabla #12: Asiento
CREATE TABLE asiento (
    asiento_id INT PRIMARY KEY IDENTITY(1,1),
    sala_id INT NOT NULL,
    fila VARCHAR(25) NOT NULL,
    secuencia VARCHAR(50) NOT NULL,
    CONSTRAINT fk_sala_a FOREIGN KEY (sala_id) REFERENCES sala(sala_id)
);
GO

-- Tabla #13: Asiento-Función
CREATE TABLE asiento_funcion (
    asiento_funcion_id INT PRIMARY KEY IDENTITY(1,1),
    funcion_id INT NOT NULL,
    asiento_id INT NOT NULL,
    estado VARCHAR(30) NOT NULL, -- Libre o Reservado
    CONSTRAINT fk_funcion_af FOREIGN KEY (funcion_id) REFERENCES funcion(funcion_id),
    CONSTRAINT fk_asiento_af FOREIGN KEY (asiento_id) REFERENCES asiento(asiento_id),
    CONSTRAINT chk_estado_asiento CHECK (estado IN ('Libre', 'Reservado'))
);
GO

-- Tabla #14: Dependiente
CREATE TABLE dependiente (
    dependiente_id INT PRIMARY KEY IDENTITY(1,1),
    nombre_dependiente VARCHAR(100) NOT NULL
);
GO

-- Tabla #15: Cliente
CREATE TABLE cliente (
    cliente_id INT PRIMARY KEY IDENTITY(1,1),
    fecha_nacimiento DATE NULL,
    pais_origen VARCHAR(50) NULL,
    nombre_cliente VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NULL,
    segundo_apellido VARCHAR(50) NULL
);
GO

DROP TABLE compra
-- Tabla #16: Compra
CREATE TABLE compra (
    compra_id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    dependiente_id INT NOT NULL,
    metodo_pago_id INT NOT NULL,
    canal VARCHAR(50) NOT NULL,
    CONSTRAINT fk_cliente_c FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    CONSTRAINT fk_dependiente_c FOREIGN KEY (dependiente_id) REFERENCES dependiente(dependiente_id),
    CONSTRAINT fk_metodo_pago FOREIGN KEY (metodo_pago_id) REFERENCES metodo_de_pago(metodo_pago_id),
    CONSTRAINT chk_canal_compra CHECK (canal IN ('boleteria', 'web'))
);
GO


-- Tabla #17: Tiquete
CREATE TABLE tiquete (
    tiquete_id INT PRIMARY KEY IDENTITY(1,1),
    funcion_id INT NOT NULL,
    asiento_funcion_id INT NOT NULL,
    compra_id INT NOT NULL,
    precio INT NOT NULL,
    tipo_pago_o_puntos VARCHAR(75) NOT NULL,
    CONSTRAINT fk_funcion_t FOREIGN KEY (funcion_id) REFERENCES funcion(funcion_id),
    CONSTRAINT fk_asiento_funcion_t FOREIGN KEY (asiento_funcion_id) REFERENCES asiento_funcion(asiento_funcion_id),
    CONSTRAINT fk_compra_t FOREIGN KEY (compra_id) REFERENCES compra(compra_id)
);
GO

-- Tabla #18: Puntos
CREATE TABLE puntos (
    puntos_id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    acumulado INT NOT NULL,
    canjeado INT NULL,
    saldo INT NULL,
    CONSTRAINT fk_cliente_p FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);
GO

-- Tabla #19: Método de Pago
CREATE TABLE metodo_de_pago (
    metodo_pago_id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    detalles VARCHAR(75) NOT NULL,
    CONSTRAINT fk_cliente_mp FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);
GO

-- Tabla #20: Auditoría
CREATE TABLE auditoria (
    auditoria_id INT PRIMARY KEY IDENTITY(1,1),
    usuario VARCHAR(50) NOT NULL,
    accion VARCHAR(20) NOT NULL,
    tabla VARCHAR(50) NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT GETDATE(),
    descripcion VARCHAR(100) NULL
);
GO


--Se tuvo que realizar cambios ya que si el usuario no compra en línea no debe de registrar los datos del cliente
--Se borra la referencia
ALTER TABLE compra
DROP CONSTRAINT fk_cliente_c;

--Se editó y se pasó a que fuera NULL
ALTER TABLE compra
ALTER COLUMN cliente_id INT NULL
GO

--Se vuelve a referenciar pero en este caso ya siendo NULL
ALTER TABLE compra
ADD CONSTRAINT fk_cliente_c FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id);
GO