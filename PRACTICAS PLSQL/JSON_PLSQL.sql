CREATE TABLE PRODUCTOS1 (
    codigo INT,
    nombre VARCHAR2(200),
    datos JSON
);

INSERT INTO PRODUCTOS1 VALUES 
(
1,
'Ejemplo 1',
'{
    "Pa�s": "Argentina", 
    "Ciudad":"Buenos Aires",
    "Poblaci�n": 1000000
}'
);

INSERT INTO PRODUCTOS1 VALUES 
(
2,
'Ejemplo 2',
'{
    "Pa�s": "Argentina", 
    "Ciudad":"Buenos Aires",
    "Poblaci�n": 1000000,
    "Direcci�n": {
                "calle": "San Marcelo",
                "piso": 6,
                "puerta": "D"
                 }
}'
);

INSERT INTO PRODUCTOS1 VALUES 
(
2,
'Ejemplo 2',
'{
    "Pa�s": "Argentina", 
    "Ciudad":"Buenos Aires",
    "Poblaci�n": 1000000,
    "Direcci�n": {
                "calle": "San Marcelo",
                "piso": 6,
                "puerta": "D"
                 },
    "Tel�fonos": [
                "111-111111",
                "222-222222"
                ]
}'
);

/

SELECT * FROM PRODUCTOS1;

SELECT P1.DATOS.Pa�s FROM PRODUCTOS1 P1;

SELECT P1.DATOS.Direcci�n.puerta FROM PRODUCTOS1 P1;

SELECT P1.DATOS.Tel�fonos[1] FROM PRODUCTOS1 P1;

SELECT * FROM PRODUCTOS1 WHERE datos IS JSON;

SELECT PROD1.DATOS FROM PRODUCTOS1 PROD1 WHERE JSON_EXISTS(PROD1.DATOS, '$.Direcci�n'); -- filtrar si el atributo direccion existe en el Atributo Datos de tipo JSON

SELECT JSON_VALUE(PROD1.DATOS, '$.Pa�s') FROM PRODUCTOS1 PROD1; -- Nos devuelve el valor del campo JSON, no valdr�a poner otro JSON o Array sin indicar �ndice concreto

SELECT JSON_QUERY(PROD1.DATOS, '$.Direcci�n.piso') FROM PRODUCTOS1 PROD1; -- Nos devuelve el conjunto complejo del campo JSON

-- USAR JSON_TABLE PARA MOSTRAR VALORES ESCALARES DEL JSON COMO COLUMNAS DE UNA TABLA
SELECT J_PAIS FROM PRODUCTOS1 PROD1,JSON_TABLE(PROD1.DATOS, '$' COLUMNS(J_PAIS PATH '$.Pa�s'));
SELECT J_PAIS, J_CIUDAD FROM PRODUCTOS1 PROD1,JSON_TABLE(PROD1.DATOS, '$' COLUMNS(J_PAIS PATH '$.Pa�s', J_CIUDAD PATH '$.Ciudad'));

