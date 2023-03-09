SET SERVEROUT ON

------------------------------------
/ -- 1
------------------------------------

DECLARE 
    CURSOR c1 IS SELECT * FROM EMPLOYEES;
    empl EMPLOYEES%ROWTYPE;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO empl; 
        EXIT WHEN c1%NOTFOUND;
        IF empl.EMPLOYEE_ID = 100 THEN
            RAISE_APPLICATION_ERROR(-20500,'El sueldo del jefe no puede visualizarse'); -- el Codigo de error debe estar entre -20000 y -20999
        END IF;
        dbms_output.put_line(empl.FIRST_NAME || ' ' || empl.LAST_NAME || ' - ' || empl.SALARY);    
    END LOOP;
    CLOSE c1;
END;

------------------------------------
/ -- 2
------------------------------------

DECLARE
    CURSOR c_empl IS SELECT * FROM EMPLOYEES;
    CURSOR c_dept(m_id DEPARTMENTS.MANAGER_ID%TYPE) IS SELECT * FROM DEPARTMENTS WHERE MANAGER_ID = m_id;
    v_empl EMPLOYEES%ROWTYPE;
    v_dept DEPARTMENTS%ROWTYPE;
BEGIN
    FOR i IN c_empl LOOP
        OPEN c_dept(i.EMPLOYEE_ID);        
        FETCH c_dept INTO v_dept;
        IF c_dept%NOTFOUND THEN
            dbms_output.put_line(i.FIRST_NAME || ' ' || i.LAST_NAME || ' no es jefe de nada'); 
        ELSE
            dbms_output.put_line(i.FIRST_NAME || ' ' || i.LAST_NAME || ' es jefe del departamento ' || v_dept.DEPARTMENT_NAME);             
        END IF;
        CLOSE c_dept;
    END LOOP;
END;

------------------------------------
/ -- 3
------------------------------------

DECLARE
    CURSOR c_empl(dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) IS SELECT COUNT(*) FROM EMPLOYEES WHERE DEPARTMENT_ID=dept_id;
    v_empl NUMBER;
    v_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    v_id := 100;
    OPEN c_empl(v_id);
    FETCH c_empl INTO v_empl;
    dbms_output.put_line('En el departamento con ID ' || v_id || ' el número de empleados es de ' || v_empl);
END;

------------------------------------
/ -- 4
------------------------------------

BEGIN
    FOR EMPLEADO IN (SELECT * FROM EMPLOYEES WHERE JOB_ID='ST_CLERK') LOOP
        dbms_output.put_line(EMPLEADO.FIRST_NAME || ' ' || EMPLEADO.LAST_NAME);
    END LOOP;
END;

------------------------------------
/ -- 5
------------------------------------

DECLARE
    CURSOR c_empl IS SELECT * FROM EMPLOYEES FOR UPDATE;
    v_empl EMPLOYEES%ROWTYPE;
BEGIN
    FOR EMPLEADO IN c_empl LOOP
        IF EMPLEADO.SALARY > 8000 THEN
            UPDATE EMPLOYEES SET SALARY = SALARY*1.02 WHERE CURRENT OF c_empl;
        ELSIF EMPLEADO.SALARY < 800 THEN
            UPDATE EMPLOYEES SET SALARY = SALARY*1.03 WHERE CURRENT OF c_empl;
        END IF;
    END LOOP;
    COMMIT;
END;