-- ROLES: table
CREATE TABLE "KITT"."ROLES"
(
    "ROL"         VARCHAR2(15) NOT NULL ENABLE,
    "DESCRIPCION" VARCHAR2(100),
    PRIMARY KEY ("ROL")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- PERSONAS: table
CREATE TABLE "KITT"."PERSONAS"
(
    "ID"        VARCHAR2(13) NOT NULL ENABLE,
    "NOMBRE1"   VARCHAR2(10) NOT NULL ENABLE,
    "APELLIDO1" VARCHAR2(10) NOT NULL ENABLE,
    "NOMBRE2"   VARCHAR2(10),
    "APELLIDO2" VARCHAR2(10),
    "EMAIL"     VARCHAR2(30) DEFAULT NULL,
    "TELEFONO"  VARCHAR2(8)  DEFAULT NULL,
    "V1"        CHAR(1)      DEFAULT 0, -- presidente
    "V2"        CHAR(1)      DEFAULT 0, -- alcalde
    "V3"        CHAR(1)      DEFAULT 0, -- diputado
    PRIMARY KEY ("ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    CONSTRAINT "TEL_UQ" UNIQUE ("TELEFONO")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- MESAS: table
CREATE TABLE "KITT"."MESAS"
(
    "ID"        NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE NOT NULL ENABLE,
    "ESTADO"    CHAR(1) NOT NULL ENABLE,
    "UBICACION" NUMBER  NOT NULL ENABLE,
    PRIMARY KEY ("ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    FOREIGN KEY ("UBICACION")
        REFERENCES "KITT"."UBICACION" ("ID") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- CANDIDATO: table
CREATE TABLE "KITT"."CANDIDATO"
(
    "ID_PERSONA" VARCHAR2(13) NOT NULL ENABLE,
    "ID_CARGO"   VARCHAR2(20) NOT NULL ENABLE,
    "FOTO"       VARCHAR2(255) DEFAULT NULL,
    "ID_PARTIDO" NUMBER(*, 0),
    FOREIGN KEY ("ID_PERSONA")
        REFERENCES "KITT"."PERSONAS" ("ID") ENABLE,
    FOREIGN KEY ("ID_CARGO")
        REFERENCES "KITT"."CARGO" ("NOMBRE") ENABLE,
    CONSTRAINT "SYS_C007812" FOREIGN KEY ("ID_PARTIDO")
        REFERENCES "KITT"."PARTIDO" ("ID") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
ALTER TABLE "KITT"."CANDIDATO"
    ADD PRIMARY KEY ("ID_PERSONA")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE
/

-- CARGO: table
CREATE TABLE "KITT"."CARGO"
(
    "NOMBRE"      VARCHAR2(20) NOT NULL ENABLE,
    "DESCRIPCION" VARCHAR2(100),
    PRIMARY KEY ("NOMBRE")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- PARTIDO: table
CREATE TABLE "KITT"."PARTIDO"
(
    "NOMBRE"      VARCHAR2(20) NOT NULL ENABLE,
    "DESCRIPCION" VARCHAR2(100),
    "BANDERA"     VARCHAR2(255) DEFAULT NULL,
    "ID"          NUMBER(*, 0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE NOT NULL ENABLE,
    CONSTRAINT "SYS_C007775" PRIMARY KEY ("ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- PARTIDO_NOMBRE_UINDEX: index
CREATE UNIQUE INDEX "KITT"."PARTIDO_NOMBRE_UINDEX" ON "KITT"."PARTIDO" ("NOMBRE")
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
    STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
    TABLESPACE "USERS"
/

-- TIPOPAPELETA: table
CREATE TABLE "KITT"."TIPOPAPELETA"
(
    "ID"   NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE NOT NULL ENABLE,
    "TIPO" VARCHAR2(20) NOT NULL ENABLE,
    PRIMARY KEY ("ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    UNIQUE ("TIPO")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- PAPELETAELECTORAL: table
CREATE TABLE "KITT"."PAPELETAELECTORAL"
(
    "ID_PAPELETA"  NUMBER NOT NULL ENABLE,
    "ID_CANDIDATO" VARCHAR2(13),
    PRIMARY KEY ("ID_CANDIDATO", "ID_PAPELETA")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    FOREIGN KEY ("ID_PAPELETA")
        REFERENCES "KITT"."PAPELETA" ("ID") ENABLE,
    CONSTRAINT "FK_CANDIDATOP" FOREIGN KEY ("ID_CANDIDATO")
        REFERENCES "KITT"."CANDIDATO" ("ID_PERSONA") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- MESAPERSONA: table
CREATE TABLE "KITT"."MESAPERSONA"
(
    "ID_MESA"    NUMBER       NOT NULL ENABLE,
    "ID_PERSONA" VARCHAR2(13) NOT NULL ENABLE,
    PRIMARY KEY ("ID_MESA", "ID_PERSONA")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    FOREIGN KEY ("ID_PERSONA")
        REFERENCES "KITT"."PERSONAS" ("ID") ENABLE,
    FOREIGN KEY ("ID_MESA")
        REFERENCES "KITT"."MESAS" ("ID") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- MESAPERSONA_ID_PERSONA_UINDEX: index
CREATE UNIQUE INDEX "KITT"."MESAPERSONA_ID_PERSONA_UINDEX" ON "KITT"."MESAPERSONA" ("ID_PERSONA")
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
    STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
    TABLESPACE "USERS"
/

-- UBICACION: table
CREATE TABLE "KITT"."UBICACION"
(
    "ID"           NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE NOT NULL ENABLE,
    "DEPARTAMENTO" VARCHAR2(50) NOT NULL ENABLE,
    "MUNICIPIO"    VARCHAR2(50) NOT NULL ENABLE,
    "LATITUD"      NUMBER(8, 6) NOT NULL ENABLE,
    "LONGITUD"     NUMBER(9, 6) NOT NULL ENABLE,
    "DESCRIPCION"  VARCHAR2(255),
    PRIMARY KEY ("ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- MESAPAPELETA: table
CREATE TABLE "KITT"."MESAPAPELETA"
(
    "ID_PAPELETA" NUMBER NOT NULL ENABLE,
    "ID_MESA"     NUMBER NOT NULL ENABLE,
    PRIMARY KEY ("ID_PAPELETA", "ID_MESA")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    FOREIGN KEY ("ID_PAPELETA")
        REFERENCES "KITT"."PAPELETA" ("ID") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- PAPELETA: table
CREATE TABLE "KITT"."PAPELETA"
(
    "ID"   NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE NOT NULL ENABLE,
    "TIPO" NUMBER(*, 0) NOT NULL ENABLE,
    PRIMARY KEY ("ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    FOREIGN KEY ("TIPO")
        REFERENCES "KITT"."TIPOPAPELETA" ("ID") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- VOTO: table
CREATE TABLE "KITT"."VOTO"
(
    "ESTADO"       CHAR(1)      NOT NULL ENABLE,
    "ID"           NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE NOKEEP NOSCALE NOT NULL ENABLE,
    "ID_VOTANTE"   VARCHAR2(13) NOT NULL ENABLE,
    "ID_CANDIDATO" VARCHAR2(13),
    PRIMARY KEY ("ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    FOREIGN KEY ("ID_VOTANTE")
        REFERENCES "KITT"."PERSONAS" ("ID") ENABLE,
    CONSTRAINT "FK_CANDIDATO" FOREIGN KEY ("ID_CANDIDATO")
        REFERENCES "KITT"."CANDIDATO" ("ID_PERSONA") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/

-- USUARIO: table
CREATE TABLE "KITT"."USUARIO"
(
    "ID_PERSONA" VARCHAR2(13) NOT NULL ENABLE,
    "PASSWORD"   VARCHAR2(255),
    "ESTADO_U"   CHAR(1)      NOT NULL ENABLE,
    "ROL"        VARCHAR2(15),
    "ESTADO_P"   CHAR(1)      NOT NULL ENABLE,
    PRIMARY KEY ("ID_PERSONA")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
            STORAGE (INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
            PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
            BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
            TABLESPACE "USERS" ENABLE,
    FOREIGN KEY ("ID_PERSONA")
        REFERENCES "KITT"."PERSONAS" ("ID") ENABLE,
    CONSTRAINT "FK_ROL" FOREIGN KEY ("ROL")
        REFERENCES "KITT"."ROLES" ("ROL") ENABLE
) SEGMENT CREATION IMMEDIATE
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
    NOCOMPRESS LOGGING
    STORAGE
(
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
    BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
)
    TABLESPACE "USERS"
/


