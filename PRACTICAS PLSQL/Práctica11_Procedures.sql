SET SERVEROUT ON

------------------------------------
/ -- 1
------------------------------------

CREATE OR REPLACE PROCEDURE VISUALIZAR
IS
    CURSOR c_empl IS SELECT * FROM EMPLOYEES;
    v_empl EMPLOYEES%ROWTYPE;
BEGIN
    FOR EMPLEADO IN c_empl LOOP
        dbms_output.put_line(EMPLEADO.FIRST_NAME || ' ' || EMPLEADO.LAST_NAME || ', salario: ' || EMPLEADO.SALARY);
    END LOOP;
END;

/

BEGIN
    VISUALIZAR;
END;

------------------------------------
/ -- 2
------------------------------------

CREATE OR REPLACE PROCEDURE VISUALIZAR_DEPT
    (NUM_DEPT IN DEPARTMENTS.DEPARTMENT_ID%TYPE)
IS
    CURSOR c_empl IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = NUM_DEPT;
    v_empl EMPLOYEES%ROWTYPE;
BEGIN
    FOR EMPLEADO IN c_empl LOOP
        dbms_output.put_line(EMPLEADO.FIRST_NAME || ' ' || EMPLEADO.LAST_NAME || ', salario: ' || EMPLEADO.SALARY);
    END LOOP;
END;

/

BEGIN
    VISUALIZAR_DEPT(100);
END;


------------------------------------
/ -- 3
------------------------------------

CREATE OR REPLACE PROCEDURE FORMAT_NUMERO_CUENTA
    (NUM_CUENTA IN OUT VARCHAR2)
IS
BEGIN
    dbms_output.put_line('Sin formatear: ' || num_cuenta);
    NUM_CUENTA := (SUBSTR(NUM_CUENTA,1,4) || '-' || SUBSTR(NUM_CUENTA,5,4) || '-' || SUBSTR(NUM_CUENTA,9,2) || '-' || SUBSTR(NUM_CUENTA,11));
    dbms_output.put_line('Formateado: ' || num_cuenta);
END;

/

DECLARE
    num_cuenta VARCHAR2(30);
BEGIN
    num_cuenta := '11111111111111111111';
    FORMAT_NUMERO_CUENTA(num_cuenta);
END;