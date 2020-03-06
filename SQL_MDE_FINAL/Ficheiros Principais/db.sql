DROP TABLE consumos_output CASCADE CONSTRAINTS;

DROP TABLE divisao CASCADE CONSTRAINTS;

DROP TABLE edificio CASCADE CONSTRAINTS;

DROP TABLE equipamentos CASCADE CONSTRAINTS;

DROP TABLE equipamentos_consumos CASCADE CONSTRAINTS;

DROP TABLE erros CASCADE CONSTRAINTS;

DROP TABLE tarifas_edificios CASCADE CONSTRAINTS;

CREATE TABLE consumos_output (
    id                            INTEGER NOT NULL,
    hora_inicio                   TIMESTAMP,
    hora_fim                      TIMESTAMP,
    kw                            NUMBER,
    total                         NUMBER,
    erro                          VARCHAR2(64 CHAR),
    kwh                           NUMBER,
    equipamentos_equipamento_id   INTEGER NOT NULL,
    edificio_edificio_id          INTEGER NOT NULL
);

ALTER TABLE consumos_output ADD CONSTRAINT consumos_output_pk PRIMARY KEY ( id );

CREATE TABLE divisao (
    divisao_id       INTEGER NOT NULL,
    piso             INTEGER,
    area             NUMBER,
    altura           NUMBER,
    n_janelas        INTEGER,
    n_equipamentos   INTEGER,
    edificio_id_fk   INTEGER
);

ALTER TABLE divisao ADD CONSTRAINT divisao_pk PRIMARY KEY ( divisao_id );

CREATE TABLE edificio (
    edificio_id     INTEGER NOT NULL,
    localidade      VARCHAR2(32 CHAR),
    coordenadas     VARCHAR2(64 CHAR),
    area            INTEGER,
    n_divisoes      INTEGER,
    tipo_tarifa     VARCHAR2(32 CHAR),
    endereco        VARCHAR2(64 CHAR),
    tipo_edificio   VARCHAR2(32 CHAR)
);

ALTER TABLE edificio ADD CONSTRAINT edificio_pk PRIMARY KEY ( edificio_id );

CREATE TABLE equipamentos (
    equipamento_id         INTEGER NOT NULL,
    fabricante             VARCHAR2(32 CHAR),
    modelo                 VARCHAR2(32 CHAR),
    referencia             VARCHAR2(64 CHAR),
    tensao                 NUMBER,
    potencia               NUMBER,
    corrente               NUMBER,
    nome                   VARCHAR2(32 CHAR),
    divisao_divisao_id     INTEGER NOT NULL,
    edificio_edificio_id   INTEGER NOT NULL,
    hora_inicio            TIMESTAMP,
    hora_fim               TIMESTAMP
);

ALTER TABLE equipamentos ADD CONSTRAINT equipamentos_pk PRIMARY KEY ( equipamento_id );

ALTER TABLE equipamentos
    ADD CONSTRAINT equipamentos__un UNIQUE ( modelo,
                                             referencia,
                                             nome );

CREATE TABLE equipamentos_consumos (
    id                            INTEGER NOT NULL,
    hora_inicio                   TIMESTAMP,
    hora_fim                      TIMESTAMP,
    kw                            NUMBER,
    equipamentos_equipamento_id   INTEGER NOT NULL,
    edificio_edificio_id          INTEGER NOT NULL,
    kwh                           NUMBER
);

ALTER TABLE equipamentos_consumos ADD CONSTRAINT log_pk PRIMARY KEY ( id );

CREATE TABLE erros (
    id            INTEGER NOT NULL,
    equipamento   VARCHAR2(64 CHAR),
    tipo          VARCHAR2(64 CHAR)
);

ALTER TABLE erros ADD CONSTRAINT erros_pk PRIMARY KEY ( id );

CREATE TABLE tarifas_edificios (
    hora_inicio      TIMESTAMP,
    hora_fim         TIMESTAMP WITH LOCAL TIME ZONE,
    custo_tarifa     FLOAT,
    edificio_id_fk   INTEGER NOT NULL
);

ALTER TABLE equipamentos_consumos
    ADD CONSTRAINT consumos_edificio_fk FOREIGN KEY ( edificio_edificio_id )
        REFERENCES edificio ( edificio_id );

ALTER TABLE equipamentos_consumos
    ADD CONSTRAINT consumos_equipamentos_fk FOREIGN KEY ( equipamentos_equipamento_id )
        REFERENCES equipamentos ( equipamento_id );

ALTER TABLE divisao
    ADD CONSTRAINT divisao_edificio_id_fk FOREIGN KEY ( edificio_id_fk )
        REFERENCES edificio ( edificio_id );

ALTER TABLE equipamentos
    ADD CONSTRAINT equipamentos_divisao_id_fk FOREIGN KEY ( divisao_divisao_id )
        REFERENCES divisao ( divisao_id );

ALTER TABLE equipamentos
    ADD CONSTRAINT equipamentos_edificio_fk FOREIGN KEY ( edificio_edificio_id )
        REFERENCES edificio ( edificio_id );

ALTER TABLE consumos_output
    ADD CONSTRAINT output_edificio_fk FOREIGN KEY ( edificio_edificio_id )
        REFERENCES edificio ( edificio_id );

ALTER TABLE consumos_output
    ADD CONSTRAINT output_equipamentos_fk FOREIGN KEY ( equipamentos_equipamento_id )
        REFERENCES equipamentos ( equipamento_id );

ALTER TABLE tarifas_edificios
    ADD CONSTRAINT tarifas_edificios_edificios_fk FOREIGN KEY ( edificio_id_fk )
        REFERENCES edificio ( edificio_id );
