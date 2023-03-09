SET SERVEROUT ON

DECLARE 
    CURSOR c1 IS SELECT * FROM REGIONS; --Declaramos un cursor y hacia donde va a apuntar
    v1 REGIONS%ROWTYPE; --Declaramos una variable de tipo columna de la tabla que vamos a recorrer con el cursor
BEGIN
    OPEN c1; --Abrimos memoria para poder trabajar con nuestro cursor declarado anteriormente
    FETCH c1 INTO v1; --Con FETCH leemos el contenido al que apuntar el cursor (empezando por la fila 1)y lo guardamos donde indiquemos con INTO, es decir en la variable v1
    dbms_output.put_line(v1.REGION_ID || ' - ' || v1.REGION_NAME);
    FETCH c1 INTO v1; -- Si volvemos a utilizar FETCH apuntará a la siguiente fila, lo normal es recorrer filas desde la primera hasta la última por medio de un bucle
    dbms_output.put_line(v1.REGION_ID || ' - ' || v1.REGION_NAME);
    CLOSE c1; --Cerrar el cursor cuando hayamos terminado de utilizarlo
    
END;


----------------------------------
/ -- RECORRER CURSOR CON LOOP
----------------------------------

DECLARE 
    CURSOR c1 IS SELECT * FROM REGIONS;
    v1 REGIONS%ROWTYPE;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v1; 
        EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line(v1.REGION_ID || ' - ' || v1.REGION_NAME);    
    END LOOP;
    CLOSE c1;
END;


----------------------------------
/ -- RECORRER CURSOR CON FOR
----------------------------------

DECLARE
    CURSOR c1 IS SELECT * FROM REGIONS;
    v1 REGIONS%ROWTYPE;
BEGIN
    FOR i IN c1 LOOP
        dbms_output.put_line(i.REGION_ID || ' - ' || i.REGION_NAME);
    END LOOP;
END;


----------------------------------
/ -- RECORRER CURSOR CON FOR EMPLEANDO SUBQUERIES
----------------------------------

BEGIN
    FOR i IN (SELECT * FROM REGIONS) LOOP
        dbms_output.put_line(i.REGION_NAME);
    END LOOP;
END;


----------------------------------
/ -- RECORRER CURSOR CON PARAMETROS
----------------------------------


DECLARE 
    CURSOR c1(sal NUMBER) IS SELECT * FROM EMPLOYEES WHERE SALARY>sal;
    empl EMPLOYEES%ROWTYPE;
BEGIN
    OPEN c1(8000);
    LOOP
        FETCH c1 INTO empl; 
        EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line(empl.FIRST_NAME || ' ' || empl.LAST_NAME || ' - ' || empl.SALARY);    
    END LOOP;
    dbms_output.put_line('He encontrado ' || c1%rowcount || ' empleados');
    CLOSE c1;
END;


---------------------------------------------------------
/ -- RECORRER CURSOR WHERE CURRENT OF (UPDATES Y DELETES)
---------------------------------------------------------

DECLARE
    CURSOR c1 IS SELECT * FROM EMPLOYEES FOR UPDATE;
    empl EMPLOYEES%ROWTYPE;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO empl;
        EXIT WHEN c1%notfound;
        IF empl.commission_pct IS NOT NULL THEN
            UPDATE employees SET SALARY=SALARY*1.10 WHERE CURRENT OF c1;
        ELSE
            UPDATE employees SET SALARY=SALARY*1.15 WHERE CURRENT OF c1;
        END IF;
    END LOOP;
    CLOSE c1;
END;