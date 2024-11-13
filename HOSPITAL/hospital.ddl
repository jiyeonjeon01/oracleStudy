-- 생성자 Oracle SQL Developer Data Modeler 24.3.0.275.2224
--   위치:        2024-11-08 18:00:35 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE
CREATE TABLE class (
    classid   CHAR(6 CHAR) NOT NULL,
    c_name    VARCHAR2(10 CHAR) NOT NULL,
    c_phone   CHAR(11 CHAR) NOT NULL,
    c_address VARCHAR2(40 CHAR) NOT NULL
)
PCTFREE 10
PCTUSED 40
TABLESPACE users
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

CREATE UNIQUE INDEX hospital.class_pk ON
    hospital.class (
        classid
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE (
                PCTINCREASE
            0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hospital.class
    ADD CONSTRAINT class_pk PRIMARY KEY ( classid )
        USING INDEX hospital.class_pk;

CREATE TABLE hospital.doctor (
    docid   CHAR(6 CHAR) NOT NULL,
    docname VARCHAR2(10 CHAR) NOT NULL,
    classid CHAR(6 CHAR) NOT NULL
)
PCTFREE 10
PCTUSED 40
TABLESPACE users
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

CREATE UNIQUE INDEX hospital.doctor_pk ON
    hospital.doctor (
        docid
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE (
                PCTINCREASE
            0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hospital.doctor
    ADD CONSTRAINT doctor_pk PRIMARY KEY ( docid )
        USING INDEX hospital.doctor_pk;

CREATE TABLE hospital.patient (
    patiid   CHAR(6 BYTE) NOT NULL,
    patiname VARCHAR2(5 BYTE) NOT NULL,
    resinum  VARCHAR2(14 BYTE) NOT NULL,
    insur    CHAR(2 BYTE) NOT NULL
)
PCTFREE 10
PCTUSED 40
TABLESPACE users
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

ALTER TABLE hospital.patient
    ADD CONSTRAINT patient_insur_ck CHECK ( insur IN ( 'N', 'Y' ) );

CREATE UNIQUE INDEX hospital.patient_patiid_pk ON
    hospital.patient (
        patiid
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE (
                PCTINCREASE
            0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

CREATE UNIQUE INDEX hospital.patient_resinum_uk ON
    hospital.patient (
        resinum
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE (
                PCTINCREASE
            0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hospital.patient
    ADD CONSTRAINT patient_patiid_pk PRIMARY KEY ( patiid )
        USING INDEX hospital.patient_patiid_pk;

ALTER TABLE hospital.patient
    ADD CONSTRAINT patient_resinum_uk UNIQUE ( resinum )
        USING INDEX hospital.patient_resinum_uk;

CREATE TABLE hospital.prescription (
    preid    CHAR(6 CHAR) NOT NULL,
    reservid CHAR(6 CHAR) NOT NULL,
    patiid   CHAR(6 CHAR) NOT NULL,
    detail   VARCHAR2(20 CHAR) NOT NULL
)
PCTFREE 10
PCTUSED 40
TABLESPACE users
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

CREATE UNIQUE INDEX hospital.prescription_pk ON
    hospital.prescription (
        preid
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE (
                PCTINCREASE
            0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hospital.prescription
    ADD CONSTRAINT prescription_pk PRIMARY KEY ( preid )
        USING INDEX hospital.prescription_pk;

CREATE TABLE hospital.reservation (
    reservid   CHAR(6 CHAR) NOT NULL,
    patiid     CHAR(6 CHAR) NOT NULL,
    docid      CHAR(6 CHAR) NOT NULL,
    reservdate DATE NOT NULL,
    status     VARCHAR2(3 CHAR) NOT NULL
)
PCTFREE 10
PCTUSED 40
TABLESPACE users
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
NO INMEMORY;

CREATE UNIQUE INDEX hospital.reservation_reservid_pk ON
    hospital.reservation (
        reservid
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE (
                PCTINCREASE
            0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE hospital.reservation
    ADD CONSTRAINT reservation_reservid_pk PRIMARY KEY ( reservid )
        USING INDEX hospital.reservation_reservid_pk;

ALTER TABLE hospital.doctor
    ADD CONSTRAINT doctor_classid_fk
        FOREIGN KEY ( classid )
            REFERENCES hospital.class ( classid )
            NOT DEFERRABLE;

ALTER TABLE hospital.prescription
    ADD CONSTRAINT prescription_patiid_fk
        FOREIGN KEY ( patiid )
            REFERENCES hospital.patient ( patiid )
                ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE hospital.prescription
    ADD CONSTRAINT prescription_reservid_fk
        FOREIGN KEY ( reservid )
            REFERENCES hospital.reservation ( reservid )
                ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE hospital.reservation
    ADD CONSTRAINT reservation_docid_fk
        FOREIGN KEY ( docid )
            REFERENCES hospital.doctor ( docid )
                ON DELETE CASCADE
            NOT DEFERRABLE;

ALTER TABLE hospital.reservation
    ADD CONSTRAINT reservation_patiid_fk
        FOREIGN KEY ( patiid )
            REFERENCES hospital.patient ( patiid )
                ON DELETE CASCADE
            NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             6
-- ALTER TABLE                             12
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
