SET SERVEROUTPUT ON
CREATE OR REPLACE PACKAGE REGIONES
IS
    PROCEDURE ALTA_REGION (codigo NUMBER, region VARCHAR2);
    PROCEDURE BAJA_REGION (codigo NUMBER, region VARCHAR2);
    PROCEDURE MOD_REGION (codigo NUMBER, region VARCHAR2, region_nueva VARCHAR2);
    FUNCTION CON_REGION (codigo NUMBER) RETURN VARCHAR2;
    
END;

/

CREATE OR REPLACE PACKAGE BODY REGIONES
IS
    --
    FUNCTION EXISTE_REGION (codigo NUMBER, region VARCHAR2) RETURN BOOLEAN IS
        region_existente REGIONS%ROWTYPE;
    BEGIN
        SELECT * INTO region_existente FROM REGIONS WHERE region_id = codigo AND region_name=region;
        RETURN TRUE;    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END;
    
    --
    
    FUNCTION CON_REGION (codigo NUMBER) RETURN VARCHAR2 IS
        nombre_region VARCHAR2(100);
    BEGIN
        SELECT region_name INTO nombre_region FROM regions WHERE region_id = codigo;
        RETURN nombre_region;
    END;
    
    --
    
    PROCEDURE ALTA_REGION(codigo NUMBER, region VARCHAR2) IS
        region_existe BOOLEAN;
    BEGIN
        region_existe := EXISTE_REGION(codigo,region);
        IF NOT region_existe THEN
            INSERT INTO REGIONS VALUES (codigo,region);
            dbms_output.put_line('La región ' || region || ' se ha añadido correctamente, con ID ' || codigo);
        ELSE
            dbms_output.put_line('La región ' || region || ' ya existe');         
        END IF;
    END;
    
    --
    
    PROCEDURE BAJA_REGION(codigo NUMBER, region VARCHAR2) IS
        region_existe BOOLEAN;
    BEGIN
        region_existe := EXISTE_REGION(codigo,region);
        IF region_existe THEN
            DELETE FROM REGIONS WHERE region_id = codigo AND region_name = region;
            dbms_output.put_line('La región ' || region || ' se ha eliminado correctamente');
        ELSE
            dbms_output.put_line('La región ' || region || ' no existe');
        END IF;
    END;
    
    --
    
    PROCEDURE MOD_REGION(codigo NUMBER, region VARCHAR2, region_nueva VARCHAR2) IS
        region_existe BOOLEAN;
    BEGIN
        region_existe := EXISTE_REGION(codigo,region);
        IF region_existe THEN
            UPDATE REGIONS SET region_name = region_nueva WHERE region_id = codigo;
            dbms_output.put_line('La región ' || region || ' se ha actualizado correctamente por ' || region_nueva);
        ELSE
            dbms_output.put_line('La región ' || region || ' no existe');
        END IF;
    END;
END;

/

CREATE OR REPLACE PACKAGE NOMINA IS
    
    FUNCTION CALCULAR_NOMINA(id_empl NUMBER) RETURN NUMBER;
    FUNCTION CALCULAR_NOMINA(id_empl NUMBER, porcentaje NUMBER) RETURN NUMBER;
    FUNCTION CALCULAR_NOMINA(id_empl NUMBER, porcentaje NUMBER, comision CHAR:='V') RETURN NUMBER;
   
END;

/

CREATE OR REPLACE PACKAGE BODY NOMINA IS

    FUNCTION CALCULAR_NOMINA (id_empl NUMBER) RETURN NUMBER IS
        salario NUMBER;
    BEGIN
        SELECT salary INTO salario FROM employees WHERE employee_id = id_empl;
        RETURN salario * 0.85; 
    END;
    
    FUNCTION CALCULAR_NOMINA (id_empl NUMBER, porcentaje NUMBER) RETURN NUMBER IS
        salario NUMBER;
    BEGIN
        SELECT salary INTO salario FROM employees WHERE employee_id = id_empl;
        RETURN salario * 0.85 * porcentaje; 
    END;
    
    FUNCTION CALCULAR_NOMINA (id_empl NUMBER, porcentaje NUMBER, comision CHAR := 'V') RETURN NUMBER IS
        salario NUMBER;
        comision_ctd NUMBER;
    BEGIN
        SELECT salary INTO salario FROM employees WHERE employee_id = id_empl;
        SELECT commission_pct INTO comision_ctd FROM employees WHERE employee_id = id_empl;

        RETURN salario * (1+comision_ctd) * 0.85;

    END;

END;