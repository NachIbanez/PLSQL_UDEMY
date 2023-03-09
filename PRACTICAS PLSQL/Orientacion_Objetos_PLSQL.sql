CREATE OR REPLACE TYPE PRODUCTO AS OBJECT (

--ATRIBUTOS
codigo NUMBER,
nombre VARCHAR2(100),
precio NUMBER,

MEMBER FUNCTION ver_producto RETURN VARCHAR2,
MEMBER FUNCTION ver_precio RETURN NUMBER,
MEMBER PROCEDURE cambiar_precio (pvp NUMBER),
MEMBER PROCEDURE mayus,
STATIC PROCEDURE auditoria,
CONSTRUCTOR FUNCTION producto (n1 varchar2) RETURN SELF AS RESULT

);

/

CREATE OR REPLACE TYPE BODY PRODUCTO AS

MEMBER FUNCTION ver_producto RETURN VARCHAR2 AS
BEGIN
    return 'Código -->' || codigo || ' nombre-->' || nombre || ' Precio-->' || precio;
END ver_producto;

MEMBER FUNCTION ver_precio RETURN NUMBER AS
BEGIN
    return precio;
END ver_precio;

MEMBER PROCEDURE cambiar_precio(pvp NUMBER) AS
BEGIN
    precio:=pvp;
END cambiar_precio;

MEMBER PROCEDURE MAYUS AS
BEGIN
    nombre:=upper(nombre);
END MAYUS;

STATIC PROCEDURE auditoria AS
BEGIN
    INSERT INTO auditoria VALUES(user,sysdate);
    COMMIT;
END auditoria;

CONSTRUCTOR FUNCTION producto (n1 varchar2) RETURN SELF AS RESULT
IS
BEGIN
    self.nombre:=n1;
    self.precio:=null;
    self.codigo:=SEQ1.nextval;
    return;
END producto;


END;

/
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
    v1 producto;
BEGIN
    v1 := producto('manzanas');
    dbms_output.put_line(v1.ver_precio);
    dbms_output.put_line(v1.ver_producto);
    v1.mayus;
    v1.cambiar_precio(20);
    dbms_output.put_line(v1.ver_producto);
    
    producto.auditoria(); -- metodos estaticos no se podran llamar como instancia de una clase, si no directamente como clase
END;
/

/

CREATE TABLE TIENDA (codigo NUMBER, estanteria NUMBER, producto producto);

INSERT INTO TIENDA VALUES(1,1,producto(1,'limon','90'));

SELECT t.producto.precio FROM TIENDA t;

SELECT t.producto.ver_producto() from tienda t;

DROP TABLE auditoria

CREATE TABLE auditoria (usuario varchar2(100), fecha date);

SELECT * FROM AUDITORIA;

DROP TYPE PRODUCTO

CREATE SEQUENCE SEQ1;
