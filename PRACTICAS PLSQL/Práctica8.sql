SET SERVEROUT ON

DECLARE
    nom_empleado employees.first_name%TYPE;
BEGIN
    SELECT
        first_name
    INTO 
        nom_empleado
    FROM
        employees
    WHERE
        employee_id = 10000;
    
    dbms_output.put_line(nom_empleado);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       dbms_output.put_line('Empleado Inexistente, no se ha encontrado ningún empleado con ese identificador');     
END;

---------------------------------
/
---------------------------------

DECLARE
    nom_empleado employees.first_name%TYPE;
BEGIN
    SELECT
        first_name
    INTO 
        nom_empleado
    FROM
        employees
    WHERE
        employee_id > 100;
    
    dbms_output.put_line(nom_empleado);
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
       dbms_output.put_line('Demasiados empleados en la consulta, no caben en una variable, solo cabe una única fila');     
END;

---------------------------------
/
---------------------------------

DECLARE
    salario employees.salary%TYPE;
    resultado employees.salary%TYPE;
BEGIN
    SELECT
        salary
    INTO 
        salario
    FROM
        employees
    WHERE
        employee_id = 100;
    
    resultado := salario/0;
    
EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLCODE);     
       dbms_output.put_line(SQLERRM);     
END;

---------------------------------
/
---------------------------------

DECLARE
    EXC_DUPLICADO EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXC_DUPLICADO,-00001);
BEGIN
    INSERT INTO regions(region_id,region_name) VALUES (1,'TEYVAT');
EXCEPTION
    WHEN EXC_DUPLICADO THEN
        dbms_output.put_line('Clave duplicada, intente otra');
END;

---------------------------------
/
---------------------------------

DECLARE
    control_regiones EXCEPTION;
    clave_region regions.region_id%TYPE;
BEGIN
    clave_region := &clave_region;
    IF clave_region > 200 THEN
        RAISE control_regiones;
    ELSE
        INSERT INTO regions(region_id,region_name) VALUES (clave_region,'TEYVAT');
        COMMIT;
    END IF;
EXCEPTION
    WHEN control_regiones THEN
        dbms_output.put_line('------------------------------------------------');
        dbms_output.put_line('El ID de la region no puede ser superior a 200');
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE);
        dbms_output.put_line(SQLERRM);
END;

---------------------------------
/
---------------------------------

-- Ejemplo anterior utilizando RAISE_APLICATION_ERROR
DECLARE
    clave_region regions.region_id%TYPE;
BEGIN
    clave_region := 250;
    IF clave_region > 200 THEN
        RAISE_APPLICATION_ERROR(-20001,'La ID no puede ser mayor que 200'); -- el Codigo de error debe estar entre -20000 y -20999
    ELSE
        INSERT INTO regions(region_id,region_name) VALUES (clave_region,'TEYVAT');
        COMMIT;
    END IF;
END;

---------------------------------
/
---------------------------------