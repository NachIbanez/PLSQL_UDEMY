SET SERVEROUT ON

BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line('La tabla del '
                             || i
                             || ' es:       ');
        FOR j IN 1..10 LOOP
            dbms_output.put((i * j)
                            || '     ');
        END LOOP;

        dbms_output.new_line;
    END LOOP;
END;

---------------------------------
/
---------------------------------

DECLARE
    texto             VARCHAR2(100);
    texto_invertido   VARCHAR2(100);
    contador_palabras NUMBER;
    letra_invertida   VARCHAR2(1);
BEGIN
    texto := '&texto';
    contador_palabras := length(texto);
    WHILE ( contador_palabras > 0 ) LOOP
        letra_invertida := substr(texto, contador_palabras, 1);
        texto_invertido := concat(texto_invertido, letra_invertida);
        contador_palabras := contador_palabras - 1;
        EXIT WHEN ( letra_invertida = 'x' OR letra_invertida = 'X' );
    END LOOP;

    dbms_output.put_line('------------------------------------------');
    dbms_output.put_line(texto
                         || '  ---->  '
                         || texto_invertido);
END;


---------------------------------
/
---------------------------------

DECLARE
    nombre            VARCHAR2(20) := &nombre;
    nombre_asteriscos VARCHAR2(20);
BEGIN
    nombre := '&nombre';
    FOR i IN 1..length(nombre) LOOP
        nombre_asteriscos := nombre_asteriscos || '*';
    END LOOP;

    dbms_output.put_line('------------------------------------------');
    dbms_output.put_line(nombre
                         || '  ---->  '
                         || nombre_asteriscos);
END;

---------------------------------
/
---------------------------------

DECLARE
    inicio NUMBER;
    fin    NUMBER;
BEGIN
    inicio := &inicio;
    fin := &fin;
    FOR i IN inicio..fin LOOP
        IF MOD(i, 4) = 0 THEN
            dbms_output.put_line(i || ' es múltiplo de 4');
        END IF;
    END LOOP;

END;