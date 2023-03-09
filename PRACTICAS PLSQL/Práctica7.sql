SET SERVEROUT ON

DECLARE
    nuevo_id departments.department_id%TYPE;
    nuevo_departamento_nombre departments.department_name%TYPE;
BEGIN
    SELECT
        MAX(department_id)
    INTO nuevo_id
    FROM
        departments;

    nuevo_id := nuevo_id + 1;
    
    INSERT INTO DEPARTMENTS (department_id,department_name,manager_id,location_id) VALUES (nuevo_id,'INFORMATICA',100,1000);
    COMMIT;
    
    SELECT department_name INTO nuevo_departamento_nombre FROM departments WHERE department_id = nuevo_id;
    dbms_output.put_line('Se ha añadido el departamento de ' || nuevo_departamento_nombre || ' con el identificador ' || nuevo_id);
    
END;

/

-- DELETE FROM departments WHERE department_id IN (272,273,274); 


---------------------------------
/
---------------------------------
 
BEGIN
    UPDATE departments SET location_id=1700 WHERE (department_id = 271 AND department_name = 'INFORMATICA');
    COMMIT;
END;

---------------------------------
/
---------------------------------

BEGIN
    DELETE FROM departments WHERE (department_id = 271 AND department_name = 'INFORMATICA');
END;

/
COMMIT;
/
ROLLBACK;
