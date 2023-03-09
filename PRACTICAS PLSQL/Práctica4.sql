SET SERVEROUT ON

DECLARE
    numero NUMBER;
BEGIN
    numero := 3;
    IF MOD(numero, 2) = 0 THEN
        dbms_output.put_line('Par');
    ELSE
        dbms_output.put_line('Impar');
    END IF;

END;

---------------------------------
/
---------------------------------

DECLARE
    tipo_producto CHAR(1);
BEGIN
    tipo_producto := 'C';
    IF tipo_producto = 'A' THEN
        dbms_output.put_line('Electr�nica');
    ELSIF tipo_producto = 'B' THEN
        dbms_output.put_line('Inform�tica');
    ELSIF tipo_producto = 'C' THEN
        dbms_output.put_line('Ropa');
    ELSIF tipo_producto = 'D' THEN
        dbms_output.put_line('M�sica');
    ELSIF tipo_producto = 'E' THEN
        dbms_output.put_line('Libros');
    ELSE
        dbms_output.put_line('El c�digo es incorrecto');
    END IF;
END;


---------------------------------
/
---------------------------------

DECLARE
    usuario VARCHAR2(40);
BEGIN
    usuario := user;
    CASE usuario
        WHEN 'SYS' THEN 
            dbms_output.put_line('Eres superadministrador!');
        WHEN 'SYSTEM' THEN 
            dbms_output.put_line('Eres un administrador normal');
        WHEN 'HR' THEN 
            dbms_output.put_line('Eres de Recursos Humanos');
        ELSE
            dbms_output.put_line('Usuario no autorizado');
    END CASE;
END;