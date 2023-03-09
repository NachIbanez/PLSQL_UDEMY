SET SERVEROUTPUT ON
DECLARE
    prueba VARCHAR2(100);
    prueba2 VARCHAR2(100);
BEGIN
    PACK1.v1:=100;
    PACK1.v2:='Soy una variable del paquete';
    dbms_output.put_line(PACK1.v1);
    dbms_output.put_line(PACK1.v2);
    
    prueba := 'hOOOOOOOlAaAaAaA';
    PACK1.convert(prueba, 'U');
    
    prueba2 := PACK2.CONVERT(prueba, 'L');
    dbms_output.put_line(prueba2);
END;

/
-- PUEDO TAMBIEN UTILIZAR LA FUNCION (YA QUE DEVUELVE UN VALOR, CON EL PROCEDURE DARIA ERROR EN ESTE CASO) EN SQL
SELECT
    first_name, PACK2.CONVERT(first_name,'U'), PACK2.CONVERT(first_name,'L')
FROM
    employees
GROUP BY
    first_name;
    
    /

-- USAMOS EL PACK3 QUE TIENE FUNCIONES SOBRECARGADAS   
BEGIN
    dbms_output.put_line(PACK3.COUNT_EMPLOYEES(100));
    dbms_output.put_line(PACK3.COUNT_EMPLOYEES('Shipping'));
END;

/

-- MOSTRAR DESCRIPCION DE UN PROCEDIMIENTO, PAQUETE, FUNCION, ETC
desc utl_file

/

-- PROBAR PROCEDURE READ_FILE

BEGIN
    read_file;
END;