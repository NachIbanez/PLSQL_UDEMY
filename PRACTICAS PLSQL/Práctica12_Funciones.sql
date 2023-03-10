SET SERVEROUT ON

------------------------------------
/ -- 1
------------------------------------

CREATE OR REPLACE FUNCTION TOTAL_SALARIOS
    (NUM_DEPT DEPARTMENTS.DEPARTMENT_ID%TYPE)
RETURN NUMBER
IS
    SALARY NUMBER;
    NUM_EMPLEADOS NUMBER;
    DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT DEPARTMENT_ID INTO DEPT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = NUM_DEPT;
    SELECT SUM(SALARY) INTO SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = NUM_DEPT;
    SELECT COUNT(*) INTO NUM_EMPLEADOS FROM EMPLOYEES WHERE DEPARTMENT_ID = NUM_DEPT;
    IF NUM_EMPLEADOS = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'El departamento existe, pero no hay empleados asignados a ese departamento');
    END IF;
    RETURN SALARY;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20011, 'Ese departamento no existe');
END;

/

DECLARE
    TOT_SAL EMPLOYEES.SALARY%TYPE;
    DEPT_NUM EMPLOYEES.DEPARTMENT_ID%TYPE;
BEGIN
    DEPT_NUM := 100;
    TOT_SAL := TOTAL_SALARIOS(DEPT_NUM);
    dbms_output.put_line('El salario total de los empleados del departamento ' || DEPT_NUM || ' es ' || TOT_SAL);
END;

------------------------------------
/ -- 2
------------------------------------

CREATE OR REPLACE FUNCTION TOTAL_SALARIOS_OUT
    (NUM_DEPT IN DEPARTMENTS.DEPARTMENT_ID%TYPE,
     NUM_EMPL OUT NUMBER)
RETURN NUMBER
IS
    SALARY NUMBER;
    DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT DEPARTMENT_ID INTO DEPT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = NUM_DEPT;
    SELECT SUM(SALARY) INTO SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = NUM_DEPT;
    SELECT COUNT(*) INTO NUM_EMPL FROM EMPLOYEES WHERE DEPARTMENT_ID = NUM_DEPT;
    IF NUM_EMPL = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'El departamento existe, pero no hay empleados asignados a ese departamento');
    END IF; 
    RETURN SALARY;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20011, 'Ese departamento no existe');
END;

/
DECLARE
    TOT_SAL EMPLOYEES.SALARY%TYPE;
    DEPT_NUM EMPLOYEES.DEPARTMENT_ID%TYPE;
    NUM_EMPLEADOS NUMBER;
BEGIN
    DEPT_NUM := 100;
    TOT_SAL := TOTAL_SALARIOS_OUT(DEPT_NUM, NUM_EMPLEADOS);
    dbms_output.put_line('El salario total de los empleados del departamento ' || DEPT_NUM || ' es ' || TOT_SAL);
    dbms_output.put_line('El numero de empleados afectados en la query es de: ' || NUM_EMPLEADOS);
END;

------------------------------------
/ -- 3
------------------------------------

CREATE OR REPLACE FUNCTION CREAR_REGION
    (NOMBRE_REGION IN REGIONS.REGION_NAME%TYPE)
    RETURN NUMBER
IS
    MAX_ID PLS_INTEGER;
BEGIN
    SELECT MAX(REGION_ID) INTO MAX_ID FROM REGIONS;
    MAX_ID := MAX_ID + 1;
    INSERT INTO REGIONS VALUES (MAX_ID, NOMBRE_REGION);
    RETURN MAX_ID;
END;

/
DECLARE
    MI_NUEVO_ID REGIONS.REGION_ID%TYPE;
BEGIN
    MI_NUEVO_ID := CREAR_REGION('TEYVAT');
END;