SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE read_file IS

    str_prueba VARCHAR2(32767);
    Vfile UTL_FILE.FILE_TYPE;

BEGIN
    --OPEN FILE
    Vfile := UTL_FILE.FOPEN('EXEE','F1.txt','R');
    LOOP
        BEGIN
            --READ LINE
            UTL_FILE.GET_LINE(Vfile,str_prueba);
            dbms_output.put_line(str_prueba);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
        END;
    END LOOP;
    
    --CLOSE FILE
    UTL_FILE.FCLOSE(Vfile);
    
END;