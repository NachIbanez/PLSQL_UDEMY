DECLARE
    col1 test.c1%TYPE;
    col2 test.c2%TYPE;
BEGIN
    col1 := 200;
    col2 := 'Desconocido';
    INSERT INTO test (
        c1,
        c2
    ) VALUES (
        col1,
        col2
    );

    COMMIT;
END;

-------------------------------
/
-------------------------------

DECLARE
    t test.c1%TYPE;
BEGIN
    t := 105;
    UPDATE test
    SET
        c1 = t
    WHERE
        c2 = 'Dendróculus';

    COMMIT;
END;

-------------------------------
/
-------------------------------

DECLARE
    t test.c2%TYPE;
BEGIN
    t := 'Desconocido';
    DELETE FROM test
    WHERE
        c2 = t;
    
    COMMIT;
END;

-------------------------------
/
-------------------------------

SELECT * FROM TEST;