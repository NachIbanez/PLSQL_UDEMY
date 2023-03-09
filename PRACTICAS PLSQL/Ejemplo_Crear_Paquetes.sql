-- EJEMPLO PAQUETE (EN OTROS LENGUAJES ES UN COCNEPTO SIMILAR A LIBRER�A)
-- LA CABECERA Y EL BODY SE CREAN POR SEPARADO, SOLO SE PODR� LLAMAR DESDE OTROS SITIOS LAS VARIABLES O PROCEDIMIENTOS DE LA CABECERA, EL BODY ES PRIVADO
CREATE OR REPLACE PACKAGE PACK1
IS
    v1 NUMBER;
    v2 VARCHAR2(100);
    PROCEDURE CONVERT (NAME VARCHAR2, CONVERSION_TYPE CHAR);
END;
/
CREATE OR REPLACE PACKAGE BODY PACK1
IS 
    FUNCTION UP(NAME VARCHAR2)
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN UPPER(NAME);
    END UP;
    
    FUNCTION DO (NAME VARCHAR2)
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN LOWER(NAME);
    END DO;
    
    PROCEDURE CONVERT (NAME VARCHAR2, CONVERSION_TYPE CHAR)
    IS
    BEGIN
        IF CONVERSION_TYPE='U' THEN
            dbms_output.put_line(UP(NAME));
        ELSIF CONVERSION_TYPE='L' THEN
            dbms_output.put_line(DO(NAME));
        ELSE
            dbms_output.put_line('El par�metro debe ser U o L');
        END IF;
    END CONVERT;
END PACK1;


-- EL MISMO PAQUETE QUE ANTES PERO USANDO UNA FUNCION

CREATE OR REPLACE PACKAGE PACK2
IS
    v1 NUMBER;
    v2 VARCHAR2(100);
    FUNCTION CONVERT (NAME VARCHAR2, CONVERSION_TYPE CHAR) 
        RETURN VARCHAR2;
END;
/
CREATE OR REPLACE PACKAGE BODY PACK2
IS 
    FUNCTION UP(NAME VARCHAR2)
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN UPPER(NAME);
    END UP;
    
    FUNCTION DO (NAME VARCHAR2)
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN LOWER(NAME);
    END DO;
    
    FUNCTION CONVERT (NAME VARCHAR2, CONVERSION_TYPE CHAR) 
        RETURN VARCHAR2
    IS
    BEGIN
        IF CONVERSION_TYPE='U' THEN
            RETURN(UP(NAME));
        ELSIF CONVERSION_TYPE='L' THEN
            RETURN(DO(NAME));
        ELSE
            RETURN('El par�metro debe ser U o L');
        END IF;
    END CONVERT;
END PACK2;

/

CREATE OR REPLACE 
PACKAGE PACK3 AS 
  FUNCTION COUNT_EMPLOYEES(ID NUMBER) RETURN NUMBER;
  FUNCTION COUNT_EMPLOYEES(ID VARCHAR2) RETURN NUMBER;
END PACK3;

CREATE OR REPLACE
PACKAGE BODY PACK3 AS

  FUNCTION COUNT_EMPLOYEES(ID NUMBER) RETURN NUMBER AS
    X NUMBER;  
  BEGIN
    SELECT COUNT(*) INTO X FROM EMPLOYEES WHERE DEPARTMENT_ID=ID;
    RETURN X;
  END COUNT_EMPLOYEES;

  FUNCTION COUNT_EMPLOYEES(ID VARCHAR2) RETURN NUMBER AS
    X NUMBER;
  BEGIN
    SELECT COUNT(*) INTO X FROM EMPLOYEES A, DEPARTMENTS B
        WHERE DEPARTMENT_NAME=ID
        AND A.DEPARTMENT_ID=B.DEPARTMENT_ID;
    RETURN X;
  END COUNT_EMPLOYEES;

END PACK3;