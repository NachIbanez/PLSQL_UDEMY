SET SERVEROUT ON

DECLARE
    TYPE empl_record IS RECORD(
        NAME VARCHAR2(100),
        SAL EMPLOYEES.SALARY%TYPE,
        COD_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE);
    
    TYPE empl_table IS TABLE OF
        empl_record
    INDEX BY PLS_INTEGER;
    
    empl empl_table;
BEGIN
    
    FOR i IN 100..206 LOOP
        SELECT
            FIRST_NAME || ' ' || LAST_NAME,
            SALARY,
            DEPARTMENT_ID
        INTO empl(i)
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID=i;
    END LOOP;
    
    FOR i IN empl.FIRST..empl.LAST LOOP
        dbms_output.put_line('El empleado con ID ' || i || ' es: ');
        dbms_output.put_line(empl(i).NAME);
        dbms_output.put_line('Su salario es ' || empl(i).SAL);
        dbms_output.put_line('El ID de su departamento es ' || empl(i).COD_DEPT);
        dbms_output.new_line;
    END LOOP;
    
    dbms_output.put_line('El primer empleado es: ' || empl(empl.first).NAME);
    dbms_output.put_line('El ultimo empleado es: ' || empl(empl.last).NAME);
    dbms_output.put_line('El número total de empleados es: ' || empl.COUNT);
    
    -- Borramos de la colección los empleados con salario menor a 7000
    FOR i IN empl.FIRST..empl.LAST LOOP
        IF empl(i).SAL <7000 THEN
            empl.DELETE(i);
        END IF;
    END LOOP;
    
    dbms_output.put_line('El número total de empleados con salario mayor a 7000 es: ' || empl.COUNT);
   
    

      
    
END;