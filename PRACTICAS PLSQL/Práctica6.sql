SET SERVEROUT ON

DECLARE
    salario_maximo employees.salary%TYPE;
BEGIN
    SELECT
        MAX(salary)
    INTO salario_maximo
    FROM
        employees
    WHERE
        department_id = 100;

    dbms_output.put_line('El salario máximo del departamento 100 es: ' || salario_maximo);
END;

---------------------------------
/
---------------------------------

DECLARE
    tipo_trabajo jobs.job_title%TYPE;
BEGIN
    SELECT
        job_title
    INTO tipo_trabajo
    FROM
             jobs j
        INNER JOIN employees e ON j.job_id = e.job_id
    WHERE
        e.employee_id = 100;

    dbms_output.put_line('El tipo de trabajo del empleado 100 es: ' || tipo_trabajo);
END;

---------------------------------
/
---------------------------------

DECLARE
    id_departamento               departments.department_id%TYPE;
    nombre_departamento           departments.department_name%TYPE;
    numero_empleados_departamento NUMBER;
BEGIN
    id_departamento := 90;
    SELECT
        COUNT(*)
    INTO numero_empleados_departamento
    FROM
        employees
    WHERE
        department_id = id_departamento
    GROUP BY
        department_id;

    SELECT
        department_name
    INTO nombre_departamento
    FROM
        departments
    WHERE
        department_id = id_departamento;

    dbms_output.put_line('En el departamento con ID '
                         || id_departamento
                         || ' el número de empleados es '
                         || numero_empleados_departamento
                         || ', y el nombre del departamento es '
                         || nombre_departamento);

END;


---------------------------------
/
---------------------------------

DECLARE
    salario_max NUMBER;
    salario_min NUMBER;
    diferencia  NUMBER;
BEGIN
    SELECT
        MAX(salary),
        MIN(salary)
    INTO
        salario_max,
        salario_min
    FROM
        employees;

    diferencia := ( salario_max - salario_min );
    dbms_output.put_line('El salario más alto de la empresa es '
                         || salario_max
                         || ' y el más bajo '
                         || salario_min);
    dbms_output.put_line('La diferencia entre ambos es de: ' || diferencia);
END;