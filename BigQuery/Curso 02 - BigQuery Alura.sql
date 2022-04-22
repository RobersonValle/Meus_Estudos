------------------------------------------------------------------------------------------------------------------------------------
-- ROUND
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS (
    SELECT 'SAT' AS DAY, 1451 AS NUMRIDES, 1018 AS ONEWAYS
    UNION ALL SELECT 'SUN', 2376, 936
)
SELECT 
        *
        , (ONEWAYS/NUMRIDES) AS FARC_ONEWAY
        , ROUND(ONEWAYS/NUMRIDES, 2) AS FARC_ONEWAY_ROUND 
    FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- IEEE_DIVIDE
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS (
    SELECT 'SAT' AS DAY, 1451 AS NUMRIDES, 1018 AS ONEWAYS
    UNION ALL SELECT 'SUN', 2376, 936
    UNION ALL SELECT 'WEB', 0, 0
)
SELECT 
        *
        , IEEE_DIVIDE(ONEWAYS,NUMRIDES) AS FARC_ONEWAY
        , ROUND(IEEE_DIVIDE(ONEWAYS,NUMRIDES), 2) AS FARC_ONEWAY_ROUND 
    FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- SAFE
------------------------------------------------------------------------------------------------------------------------------------

SELECT SAFE.LOG(10, -3), SAFE.LOG(10,3)

------------------------------------------------------------------------------------------------------------------------------------
-- IEEE_DIVIDE
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS (
    SELECT 'SAT' AS DAY, 1451 AS NUMRIDES, 1018 AS ONEWAYS
    UNION ALL SELECT 'SUN', 2376, 936
    UNION ALL SELECT 'MON', NULL, NULL
    UNION ALL SELECT 'TUE', IEEE_DIVIDE(0, 0), 0
    UNION ALL SELECT 'WED', IEEE_DIVIDE(3, 0), 0
)
SELECT 
        *
    FROM example
    --WHERE NUMRIDES<2000;

------------------------------------------------------------------------------------------------------------------------------------
-- NUMERIC
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS (
    SELECT 1.23 AS PAYMENT
    UNION ALL SELECT  7.89
    UNION ALL SELECT  12.43
)
SELECT
    SUM(PAYMENT) AS TOTAL_PAYMENT
    ,AVG(PAYMENT) AS AVG_PAYMENT
    FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- NUMERIC
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS (
    SELECT NUMERIC '1.23' AS PAYMENT
    UNION ALL SELECT NUMERIC '7.89'
    UNION ALL SELECT NUMERIC '12.43'
)
SELECT
    SUM(PAYMENT) AS TOTAL_PAYMENT
    ,AVG(PAYMENT) AS AVG_PAYMENT
    FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- SIGN - RETORNA 1 SE FOR POSITIVO E 0 SE FOR NEGATIVO
------------------------------------------------------------------------------------------------------------------------------------

SELECT SIGN (3.45)
SELECT SIGN (-3.45)

------------------------------------------------------------------------------------------------------------------------------------
-- IS_INF - CHECA SE O NUMERO É INFINITO
------------------------------------------------------------------------------------------------------------------------------------

SELECT IS_INF(IEEE_DIVIDE(3, 0)), IS_INF(IEEE_DIVIDE(0, 0));

------------------------------------------------------------------------------------------------------------------------------------
-- IS_NAN - CHECA SE O NUMERO É NaN
------------------------------------------------------------------------------------------------------------------------------------

SELECT IS_NAN(IEEE_DIVIDE(3, 0)), IS_NAN(IEEE_DIVIDE(0, 0));

------------------------------------------------------------------------------------------------------------------------------------
-- RAND - GERA UM NUMERO RANDOMICO
------------------------------------------------------------------------------------------------------------------------------------

SELECT RAND();

------------------------------------------------------------------------------------------------------------------------------------
-- SQRT - RAIZ QUADRADA
------------------------------------------------------------------------------------------------------------------------------------

SELECT SQRT(25)

------------------------------------------------------------------------------------------------------------------------------------
-- POW - ELEVADO A POTENCIA
------------------------------------------------------------------------------------------------------------------------------------

SELECT POW(2,4);

------------------------------------------------------------------------------------------------------------------------------------
-- LN, LOG, LOG10 - LOGARITIMO
------------------------------------------------------------------------------------------------------------------------------------

SELECT LOG10(5);

------------------------------------------------------------------------------------------------------------------------------------
-- GREATEST - RETORNA O MAIOR NUMERO EM UM ARRAY
------------------------------------------------------------------------------------------------------------------------------------

SELECT GREATEST(1,23,4,5,8,6,42,0,6)

------------------------------------------------------------------------------------------------------------------------------------
-- LEAST - RETORNA O MENOR NUMERO EM UM ARRAY
------------------------------------------------------------------------------------------------------------------------------------

SELECT LEAST(1,23,4,5,8,6,42,0,6)

------------------------------------------------------------------------------------------------------------------------------------
-- SAFE_MULTIPLU, SAFE_DIVIDE, SAFE_SUBSTRACT, SAFE_NEGATIVE, SAFE_ADD - LIDA COM NUMEROS MUITO GRANDES
------------------------------------------------------------------------------------------------------------------------------------

SELECT SAFE_MULTIPLY(4000000000,60000000000000)

------------------------------------------------------------------------------------------------------------------------------------
-- MOD - RESTO
------------------------------------------------------------------------------------------------------------------------------------

SELECT MOD (10,3);

------------------------------------------------------------------------------------------------------------------------------------
-- ROUND, TRUNC - ROUND ARREDONDA, TRUNC TIRA AS CASAS DECIMAIS
------------------------------------------------------------------------------------------------------------------------------------

SELECT ROUND(3.47, 1), TRUNC(3.47, 1);

------------------------------------------------------------------------------------------------------------------------------------
-- CEIL, FLOOR -  CEIL MAIOR INTEIRO DEPOIS DO NUMERO - FLOOR MENOR INTEIRO ANTES DO NUMERO
------------------------------------------------------------------------------------------------------------------------------------

SELECT CEIL(3.78), FLOOR(3.78)
SELECT CEIL(3.01), FLOOR(3.01)

------------------------------------------------------------------------------------------------------------------------------------
-- RANGE_BUCKET
------------------------------------------------------------------------------------------------------------------------------------

SELECT ALUNO, RANGE_BUCKET(39.[5, 10, 15, 20, 30, 40, 50])

WITH STUDENTS AS (
    SELECT 'A1' AS ALUNO, 11 AS AGE
    UNION ALL SELECT 'A2', 12
    UNION ALL SELECT 'A3', 11
    UNION ALL SELECT 'A4', 14
    UNION ALL SELECT 'A5', 17
    UNION ALL SELECT 'A6', 17
    UNION ALL SELECT 'A7', 18
    UNION ALL SELECT 'A8', 16
    UNION ALL SELECT 'A9', 11
    UNION ALL SELECT 'A10', 12
    UNION ALL SELECT 'A11', 13
    UNION ALL SELECT 'A12', 13
    UNION ALL SELECT 'A13', 16
)
SELECT RANGE_BUCKET(AGE, [9,13,15,19]), COUNT(*) FROM STUDENTS GROUP BY 1;

------------------------------------------------------------------------------------------------------------------------------------
-- IF
------------------------------------------------------------------------------------------------------------------------------------

WITH catalog AS (
  SELECT 30.0 AS costPrice, 0.15 as margin, 0.1 as taxRate
  UNION ALL SELECT NULL, 0.21, 0.15
  UNION ALL SELECT 30.0, NULL, 0.09
  UNION ALL SELECT 30.0, 0.30, NULL
  UNION ALL SELECT 30.0, NULL, NULL
)
SELECT ROUND (
  IF (costPrice IS NULL, 30.0, costPrice) * 
  IF (margin IS NULL, 0.10, margin) * 
  IF (taxrate IS NULL, 0.15, taxrate) , 2
) as FORMULA FROM catalog;

------------------------------------------------------------------------------------------------------------------------------------
-- COALESCE
------------------------------------------------------------------------------------------------------------------------------------

SELECT COALESCE ('A', 'B', 'C');
SELECT COALESCE (NULL, 'B', 'C');

WITH catalog AS (
  SELECT 30.0 AS costPrice, 0.15 as margin, 0.1 as taxRate
  UNION ALL SELECT NULL, 0.21, 0.15
  UNION ALL SELECT 30.0, NULL, 0.09
  UNION ALL SELECT 30.0, 0.30, NULL
  UNION ALL SELECT 30.0, NULL, 0.10
)
SELECT 
  IF (costPrice IS NULL, 30.0, costPrice) * 
  IF (margin IS NULL, 0.10, margin) * 
  IF (taxrate IS NULL, 0.15, taxrate) 
  as FORMULA1 ,
  COALESCE (
    costPrice * margin * taxrate, 
    30.0 * margin * taxrate, 
    costprice * 0.10 * taxrate, 
    costPrice * margin * 0.15
  ) as FORMULA2 FROM catalog;


------------------------------------------------------------------------------------------------------------------------------------
-- SAFE_CAST
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS (
    SELECT 'Jonh' AS employee, 'Doente' as Hours_work
    UNION ALL SELECT 'Jean', '100'
    UNION ALL SELECT 'Peter', 'De férias'
    UNION ALL SELECT 'Mary', '80'
)
SELECT SUM (SAFE_CAST(Hours_work AS INT64)) AS TOTAL FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- CASE WHEN
------------------------------------------------------------------------------------------------------------------------------------

WITH Numbers AS (
    SELECT 90 as A, 2 as B
    UNION ALL SELECT 50, 8
    UNION ALL SELECT 60, 6
    UNION ALL SELECT 50, 10
)
SELECT A, B, 
    CASE 
        WHEN (A = 90 AND B > 10) THEN 'red'
        WHEN A = 50 THEN 'blue'
        ELSE 'green' END AS Color
    FROM Numbers;


WITH Students AS
(SELECT 'A1' AS ALUNO, 11 AS AGE
UNION ALL SELECT 'A2' , 12
UNION ALL SELECT 'A3' , 11
UNION ALL SELECT 'A4' , 14
UNION ALL SELECT 'A5' , 17
UNION ALL SELECT 'A6' , 17
UNION ALL SELECT 'A7' , 18
UNION ALL SELECT 'A8' , 16
UNION ALL SELECT 'A9' , 11
UNION ALL SELECT 'A10' , 12
UNION ALL SELECT 'A11' , 13
UNION ALL SELECT 'A12' , 13
UNION ALL SELECT 'A13' , 16)
SELECT ALUNO, RANGE_BUCKET( AGE, [9, 13, 15, 18]),
CASE 
  WHEN AGE >= 9 AND AGE < 13 THEN '1'
  WHEN AGE >= 13 AND AGE < 15 THEN '2'
  WHEN AGE >= 15 AND AGE < 18 THEN '3'
  ELSE '4' END 
FROM Students;

------------------------------------------------------------------------------------------------------------------------------------
-- LOWER 
------------------------------------------------------------------------------------------------------------------------------------

WITH items AS
 (SELECT 'FOO' AS ITEM
 UNION ALL SELECT 'BAR'
 UNION ALL SELECT 'BAZ')
 SELECT LOWER(ITEM) FROM items;

------------------------------------------------------------------------------------------------------------------------------------
-- UPPER 
------------------------------------------------------------------------------------------------------------------------------------

WITH items AS
 (SELECT 'foo' AS ITEM
 UNION ALL SELECT 'bar'
 UNION ALL SELECT 'baz')
 SELECT UPPER(ITEM) FROM items;

------------------------------------------------------------------------------------------------------------------------------------
-- LOWER e UPPER
------------------------------------------------------------------------------------------------------------------------------------

WITH items AS
 (SELECT 'rUA Antonio Carlos' AS ITEM
 UNION ALL SELECT 'AVENIDA sÃO pAULO'
 UNION ALL SELECT 'tv atroS DO aLTO')
 SELECT ITEM, UPPER(ITEM), LOWER(ITEM) FROM items;

------------------------------------------------------------------------------------------------------------------------------------
-- INITCAP
------------------------------------------------------------------------------------------------------------------------------------

WITH examples AS
 (SELECT "Alo Mundo-todo mundo!" AS FRASES
 UNION ALL SELECT "o cachorro TORNADO é alegre+manso"
 UNION ALL SELECT "maça&laranja&pera"
 UNION ALL SELECT "tata ta tavendo a tatia")
 SELECT FRASES, INITCAP(FRASES) FROM examples;


WITH examples AS
 (SELECT "Alo Mundo-todo mundo!" AS FRASES, " " AS DELIMITER
 UNION ALL SELECT "o cachorro TORNADO é alegre+manso", "+"
 UNION ALL SELECT "maça&laranja&pera", "&"
 UNION ALL SELECT "tata ta tavendo a tatia", "t")
 SELECT FRASES, INITCAP(FRASES), INITCAP(FRASES, DELIMITER) FROM examples;

------------------------------------------------------------------------------------------------------------------------------------
-- CONCAT, CHAR_LENGTH, STARTS_WITH e ENDS_WITH
------------------------------------------------------------------------------------------------------------------------------------

WITH examples AS
(SELECT "DR" AS Titulo, "Carlos" as NOME, "Junior" as SOBRENOME
UNION ALL SELECT "SR", "Marcos", "Almeida"
UNION ALL SELECT "DR" , "Mario", "Costa"
UNION ALL SELECT "MS" , "Maria", "Rosa")
SELECT CONCAT (Titulo, " ", Nome, " ", Sobrenome), 
CHAR_LENGTH(CONCAT (Titulo, " ", Nome, " ", Sobrenome)),
STARTS_WITH(CONCAT (Titulo, " ", Nome, " ", Sobrenome), "DR"), 
ENDS_WITH(CONCAT (Titulo, " ", Nome, " ", Sobrenome), "a") FROM examples;

------------------------------------------------------------------------------------------------------------------------------------
-- INSTR 
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS
(SELECT 'banana' AS source_value, 'an' AS search_value, 1 as position, 1 as occcurrence
UNION ALL SELECT 'banana' AS source_value, 'an' AS search_value, 3 as position, 1 as occcurrence
UNION ALL SELECT 'banana' AS source_value, 'xx' AS search_value, 1 as position, 2 as occcurrence)
SELECT *, INSTR(source_value, search_value, position, occcurrence) FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- SUBSTR 
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS
(SELECT 'banana' AS source_value,
UNION ALL SELECT 'melancia'
UNION ALL SELECT 'tangerina')
SELECT source_value, SUBSTR(source_value,3,3) FROM example;

WITH example AS
(SELECT 'banana' AS source_value,
UNION ALL SELECT 'melancia'
UNION ALL SELECT 'tangerina')
SELECT source_value, SUBSTR(source_value,3) FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- STRPOS 
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, SUBSTR(source_value,1, STRPOS(source_value, "@") - 1) FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- REVERSE
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, REVERSE(source_value) FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- REPLACE 
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, REPLACE(source_value, "@","XXXXXX") FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- SPLIT 
------------------------------------------------------------------------------------------------------------------------------------

WITH example AS
(SELECT 'foo@example.com' AS source_value,
UNION ALL SELECT 'victor@gmail.com'
UNION ALL SELECT 'quexample@brazil.com')
SELECT source_value, SPLIT(source_value, "@") FROM example;

------------------------------------------------------------------------------------------------------------------------------------
-- REGEXP_CONTAINS, REGEXP_EXTRACT, REGEXP_EXTRACT_ALL e REGEXP_REPLACE
------------------------------------------------------------------------------------------------------------------------------------

SELECT FIELD,
REGEXP_CONTAINS(FIELD, r'[0-9]{5}-[0-9]{3}') AS TEM_CEP,
REGEXP_EXTRACT(FIELD, r'[0-9]{5}-[0-9]{3}', 1, 1) AS CEP,
REGEXP_EXTRACT(FIELD, r'[0-9]{5}-[0-9]{3}', 1, 2) AS CEP2,
REGEXP_EXTRACT_ALL(FIELD, r'[0-9]{5}-[0-9]{3}') AS CEP3,
REGEXP_REPLACE(FIELD, r'[0-9]{5}-[0-9]{3}', 'XXXXX-XXX') AS CEP2,
FROM
(SELECT * from UNNEST
(["22222-22","     22222-222  ","Meu CEP é 222222-22", "Do CEP 22222-222 ATÉ O 22333-222"]) AS FIELD);


------------------------------------------------------------------------------------------------------------------------------------
-- DATETIME, TIMESTAMP, DATE e TIME
------------------------------------------------------------------------------------------------------------------------------------

SELECT CURRENT_DATETIME,
CURRENT_DATETIME('America/Sao_Paulo'),
CURRENT_DATETIME('Europe/London'),
CURRENT_TIMESTAMP,
CURRENT_DATE,
CURRENT_TIME;

SELECT TIMESTAMP('2020-07-01 10:00:00'),
DATETIME (2020, 7, 1, 10, 0 , 0),
DATE(2020, 7, 1),
TIME(10,0,0);

SELECT DATE(TIMESTAMP('2020-07-01 10:00:00')),
DATETIME(TIMESTAMP('2020-07-01 10:00:00')),
TIME(TIMESTAMP('2020-07-01 10:00:00'));

------------------------------------------------------------------------------------------------------------------------------------
-- ADD (DATETIME_ADD, TIMESTAMP_ADD, DATE_ADD e TIME_ADD)
------------------------------------------------------------------------------------------------------------------------------------

SELECT 
  DATE_ADD (DATE(2008, 12, 25), INTERVAL 5 DAY) AS CINCO_DIAS_DEPOIS,
  DATE_ADD (DATE(2008, 12, 25), INTERVAL 4 YEAR) AS QUATRO_ANOS_DEPOIS,
  TIMESTAMP_ADD (CURRENT_TIMESTAMP, INTERVAL 45 MINUTE) AS QUARENTA_CINCO_MINUTOS_DEPOIS;


------------------------------------------------------------------------------------------------------------------------------------
-- SUB (DATETIME_SUB, TIMESTAMP_SUB, DATE_SUB e TIME_SUB)
------------------------------------------------------------------------------------------------------------------------------------

SELECT 
  DATE_SUB (DATE(2008, 12, 25), INTERVAL 5 DAY) AS CINCO_DIAS_ANTES,
  DATE_SUB (DATE(2008, 12, 25), INTERVAL 4 YEAR) AS QUATRO_ANOS_ANTES,
  TIMESTAMP_SUB (CURRENT_TIMESTAMP, INTERVAL 45 MINUTE) AS QUARENTA_CINCO_MINUTOS_ANTES;

------------------------------------------------------------------------------------------------------------------------------------
-- DIFF (DATETIME_DIFF, TIMESTAMP_DIFF, DATE_DIFF e TIME_DIFF)
------------------------------------------------------------------------------------------------------------------------------------

SELECT 
  DATE_DIFF (DATE(2010,12,25), DATE(2008, 9, 15), DAY),
  DATETIME_DIFF (CURRENT_DATETIME, DATETIME(TIMESTAMP('2020-07-01 10:00:00')), MINUTE);

------------------------------------------------------------------------------------------------------------------------------------
-- EXTRACT - Extrair elementos de uma data
------------------------------------------------------------------------------------------------------------------------------------

SELECT DATA,
  EXTRACT(MONTH FROM DATA) AS MES,
  EXTRACT(DAY FROM DATA) AS DIA,
  EXTRACT(YEAR FROM DATA) AS ANO,
  EXTRACT(DAYOFWEEK FROM DATA) AS SEMANA
FROM UNNEST (GENERATE_DATE_ARRAY('2015-12-23', '2016-01-09')) AS DATA
ORDER BY DATA;

------------------------------------------------------------------------------------------------------------------------------------
-- TRUNC (DATETIME_TRUNC, TIMESTAMP_TRUNC, DATE_TRUNC e TIME_TRUNC) - Diminui o valor na menor representação especificada.
------------------------------------------------------------------------------------------------------------------------------------

SELECT 
  DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), DAY), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), MINUTE), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), MONTH), 
  DATETIME_TRUNC(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), YEAR);

------------------------------------------------------------------------------------------------------------------------------------
-- LAST_DAY (DATE, DATETIME)
------------------------------------------------------------------------------------------------------------------------------------

SELECT 
  DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), 
  LAST_DAY(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), MONTH),
  LAST_DAY(DATETIME_ADD(CURRENT_DATETIME, INTERVAL 90 DAY), YEAR);

------------------------------------------------------------------------------------------------------------------------------------
-- FORMAT (FORMAT_TIME, FORMAT_DATIME, FORMAT_DATE e FORMAT_TIMESTAMP)
------------------------------------------------------------------------------------------------------------------------------------

	
-- %A	O nome completo do dia da semana
-- %a	O nome abreviado do dia da semana
-- %B	O nome completo do mês
-- %b ou %h	O nome abreviado do mês
-- %C	O século (um ano dividido por 100 e truncado como um inteiro) como um número decimal (00-99)
-- %D	A data no formato %m/%d/%y
-- %d	O dia do mês como número decimal (01-31)
-- %e	O dia do mês como número decimal (1-31). Dígitos únicos são precedidos por um espaço
-- %F	A data no formato %Y-%m-%d
-- %G	O ano ISO 8601 com o século como número decimal. Cada ano ISO começa na segunda-feira antes da primeira quinta-feira do ano calendário gregoriano. Observe que %G e %Y podem produzir -- resultados diferentes próximos aos limites do ano gregoriano, em que o ano gregoriano e o ano ISO podem divergir
-- %g	O ano ISO 8601 sem o século como número decimal (00-99). Cada ano ISO começa na segunda-feira antes da primeira quinta-feira do ano calendário gregoriano. Observe que %g e %y podem --- produzir resultados diferentes próximos aos limites do ano gregoriano, em que o ano gregoriano e o ano ISO podem divergir
-- %j	O dia do ano como número decimal (001-366)
-- %m	O mês como número decimal (01-12)
-- %n	Um caractere de nova linha
-- %Q	O trimestre como um número decimal (de 1–4)
-- %t	Um caractere de tabulação
-- %U	O número da semana do ano (domingo como o primeiro dia da semana) como número decimal (00-53)
-- %u	O dia da semana (segunda-feira como o primeiro dia da semana) como número decimal (1-7)
-- %V	O número da semana ISO 8601 do ano (segunda-feira como o primeiro dia da semana) como um número decimal (01–53). Se a semana que tem 1 de janeiro tiver quatro ou mais dias no ano ----- novo, então será a semana 1. Caso contrário, será a semana 53 do ano anterior e a semana seguinte será a semana 1
-- %W	O número da semana do ano (segunda-feira como o primeiro dia da semana) como número decimal (00-53)
-- %w	O dia da semana (domingo como o primeiro dia da semana) como número decimal (0-6)
-- %x	A representação de data no formato MM/DD/YY
-- %Y	O ano com o século como número decimal
-- %y	O ano sem o século como número decimal (00-99), com um zero opcional à esquerda. Pode ser misturado com %C. Se %C não for especificado, os anos 00-68 são os 2000, enquanto os anos 6--- 69-99 são os 1900
-- %E4Y	Anos com quatro caracteres (0001 ... 9999). %Y produz quantos caracteres forem necessários para processar totalmente o ano
-- %H	A hora em um relógio de 24 horas como número decimal (00-23)
-- %I	A hora em um relógio de 12 horas como número decimal (01-12)
-- %j	O dia do ano como número decimal (001-366)
-- %k	A hora em um relógio de 24 horas como número decimal (0-23). Dígitos únicos são precedidos por um espaço
-- %l	A hora em um relógio de 12 horas como número decimal (1-12). Dígitos únicos são precedidos por um espaço
-- %M	O minuto como número decimal (00-59)
-- %n	Um caractere de nova linha
-- %P	am ou pm
-- %p	AM ou PM
-- %R	A hora no formato %H:%M
-- %r	A hora em um relógio de 12 horas usando a notação AM/PM
-- %S	O segundo como número decimal (00-60)
-- %T	A hora no formato %H:%M:%S
-- %t	Um caractere de tabulação
-- %X	A representação da hora no formato HH:MM:SS
-- %%	Um único caractere %
-- %E#S	Segundos com # dígitos de precisão fracionária
-- %E*S	Segundos com precisão fracionária total (um literal '*')

SELECT CURRENT_DATETIME, FORMAT_DATETIME('%A, Dia %d de %B de %Y', CURRENT_DATETIME);

------------------------------------------------------------------------------------------------------------------------------------
-- UNIX
------------------------------------------------------------------------------------------------------------------------------------

SELECT
  visitStartTime, TIMESTAMP_SECONDS(visitStartTime) FROM
 `bigquery-public-data.google_analytics_sample.ga_sessions_20170731`
LIMIT 10;

SELECT CURRENT_TIMESTAMP, UNIX_SECONDS(CURRENT_TIMESTAMP);
