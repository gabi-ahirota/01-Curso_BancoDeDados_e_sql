INSERT INTO CLIENTE VALUES(NULL, 'JOAO', 'M', 'JOAO@IG.COM', '9485945594');
INSERT INTO CLIENTE VALUES(NULL, 'CARLOS', 'M', 'CARLOS@GMAIL.COM', '8495505604');
INSERT INTO CLIENTE VALUES(NULL, 'ANA', 'F', 'ANAJULIA@UOL.COM', '543904295');
INSERT INTO CLIENTE VALUES(NULL, 'CLARA', 'F', NULL, '059459406');
INSERT INTO CLIENTE VALUES(NULL, 'JORGE', 'M', 'JORGEOI@IG.COM', '7438590566');
INSERT INTO CLIENTE VALUES(NULL, 'CELIA', 'F', 'CELIANOVA@IG.COM', '3955095065');

SELECT * FROM CLIENTE;

+-----------+--------+------+------------------+------------+
| IDCLIENTE | NOME   | SEXO | EMAIL            | CPF        |
+-----------+--------+------+------------------+------------+
|         1 | JOAO   | M    | JOAO@IG.COM      | 9485945594 |
|         3 | CARLOS | M    | CARLOS@GMAIL.COM | 8495505604 |
|         4 | ANA    | F    | ANAJULIA@UOL.COM | 543904295  |
|         5 | CLARA  | F    | NULL             | 059459406  |
|         6 | JORGE  | M    | JORGEOI@IG.COM   | 7438590566 |
|         7 | CELIA  | F    | CELIANOVA@IG.COM | 3955095065 |
+-----------+--------+------+------------------+------------+

DESC ENDERECO;

INSERT INTO ENDERECO VALUES(NULL, 'RUA ANTONIO SA', 'CENTRO', 'B. HORIZONTE', 'MG',4);
INSERT INTO ENDERECO VALUES(NULL, 'RUA CAPITAO HERMES', 'CENTRO', 'RIO DE JANEIRO', 'RJ',1);
INSERT INTO ENDERECO VALUES(NULL, 'RUA PRES VARGAS', 'JARDINS', 'SAO PAULO', 'SP',3);
INSERT INTO ENDERECO VALUES(NULL, 'RUA ALFANDEGA', 'ESTACIO', 'RIO DE JANEIRO', 'RJ',2);
INSERT INTO ENDERECO VALUES(NULL, 'RUA DO OUVIDOR', 'FLAMENGO', 'RIO DE JANEIRO', 'RJ',6);
INSERT INTO ENDERECO VALUES(NULL, 'RUA URUGUAIANA', 'CENTRO', 'VITORIA', 'ES',5);

DESC TELEFONE;

INSERT INTO TELEFONE VALUES(NULL, 'CEL', '90303059', 5);

INSERT INTO TELEFONE VALUES(NULL, 'RES', '95958650', 5);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '98354975', 1);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '85278509', 2);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '95428050', 1);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '89920445', 3);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '23458955', 3);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '43349500', 1);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '23525895', 5);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '87458798', 2);

/* SELEÇÃO, PROJEÇÃO E JUNÇÃO */

/* PROJEÇÃO -> É TUDO QUE VOCÊ QUER MOSTRAR NA TELA. */

SELECT NOW() AS DATA_ATUAL;

SELECT 2 + 2 AS SOMA;

SELECT 2 + 2 AS SOMA, NOME, NOW()
FROM CLIENTE;

/* SELECÃO - É A SELEÇÃO DE UM SUB-CONJUNTO DE UM CONJUNTO TOTAL DE REGISTROS DE
UMA TABELA 
A CLAUSULA DE SELEÇÃO É O WHERE.
*/

SELECT NOME, SEXO, EMAIL /* PROJEÇÃO */
FROM CLIENTE /* ORIGEM */
WHERE SEXO = 'F'; /* SELEÇÃO */


SELECT NUMERO /* PROJEÇÃO */
FROM TELEFONE /* ORIGEM */
WHERE TIPO = 'CEL' /* SELEÇÃO */

/* JUNÇÃO -> JOIN */

SELECT NOME, EMAIL, IDCLIENTE
FROM CLIENTE;

SELECT ID_CLIENTE, BAIRRO, CIDADE
FROM ENDERECO;

+--------+------------------+-----------+
| NOME   | EMAIL            | IDCLIENTE |
+--------+------------------+-----------+
| JOAO   | JOAO@IG.COM      |         1 |
| CARLOS | CARLOS@GMAIL.COM |         2 |
| ANA    | ANAJULIA@UOL.COM |         3 |
| CLARA  | NULL             |         4 |
| JORGE  | JORGEOI@IG.COM   |         5 |
| CELIA  | CELIANOVA@IG.COM |         6 |
+--------+------------------+-----------+

+------------+----------+----------------+
| ID_CLIENTE | BAIRRO   | CIDADE         |
+------------+----------+----------------+
|          4 | CENTRO   | B. HORIZONTE   |
|          1 | CENTRO   | RIO DE JANEIRO |
|          3 | JARDINS  | SAO PAULO      |
|          2 | ESTACIO  | RIO DE JANEIRO |
|          6 | FLAMENGO | RIO DE JANEIRO |
|          5 | CENTRO   | VITORIA        |
+------------+----------+----------------+

/* NOME, SEXO, BAIRRO, CIDADE */

SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJEÇÃO */
FROM CLIENTE /* ORIGEM */
INNER JOIN ENDERECO
WHERE IDCLIENTE = ID_CLIENTE; /* JUNÇÃO */

SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJEÇÃO */
FROM CLIENTE /* ORIGEM */
	INNER JOIN ENDERECO /* JUNÇÃO */
	ON IDCLIENTE = ID_CLIENTE
WHERE SEXO = 'F'; /* SELEÇÃO */

/* NOME , SEXO , EMAIL, TIPO, NUMERO */

SELECT NOME, SEXO, EMAIL, TIPO, NUMERO /*PROJEÇÃO*/
FROM CLIENTE /* ORIGEM */
	 INNER JOIN TELEFONE
	 ON IDCLIENTE = ID_CLIENTE; /* CONDIÇÃO EM QUE JUNTA A TABELA CLIENTE COM A TABELA TELEFONE */

/* JUNÇÃO DE 3 TABELAS - NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO */

SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE, TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE
	INNER JOIN ENDERECO
	ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
	INNER JOIN TELEFONE
	ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

/* PONTEIRAMENTO - É UMA OUTRA MANEIRA DE FAZER A PROJEÇÃO COM DETERMINADOS
DADOS DE 3 TABELAS.
MUITO UTILIZADO, POIS AJUDA NA PERFORMANCE DO BANCO DE DADOS */

	SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
	INNER JOIN ENDERECO E 
	ON C.IDCLIENTE = E.ID_CLIENTE
	INNER JOIN TELEFONE T
	ON C.IDCLIENTE = T.ID_CLIENTE;

+--------+------+---------+----------------+------+----------+
| NOME   | SEXO | BAIRRO  | CIDADE         | TIPO | NUMERO   |
+--------+------+---------+----------------+------+----------+
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | CEL  | 98354975 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | RES  | 95428050 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | COM  | 43349500 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | COM  | 85278509 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | CEL  | 87458798 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 89920445 |
| ANA    | F    | JARDINS | SAO PAULO      | CEL  | 23458955 |
| JORGE  | M    | CENTRO  | VITORIA        | CEL  | 90303059 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 95958650 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 23525895 |
+--------+------+---------+----------------+------+----------+

/*
	DML - DATA MANIPULATION LANGUAGE -> MANIPULAÇÃO DOS DADOS
	DDL - DATA DEFINITION LANGUAGE -> TIPAGEM DOS DADOS
	DCL - DATA CONTROL LANGUAGE -> CONTROLE DE ACESSO DOS DADOS
	TCL - TRANSACTION CONTROL LANGUAGE -> CONTROLE DE TRANSAÇÃO

*/

/* INSERT */

INSERT INTO CLIENTE VALUES(NULL, 'PAULA', 'M', NULL, 77345671);
INSERT INTO ENDERECO VALUES(NULL, 'RUA JOAQUIM SILVA', 'ALVORADA', 'NITEROI', 'RJ', 7);

SELECT * FROM CLIENTE;

/* FILTROS */

SELECT * FROM CLIENTE
WHERE SEXO = 'M';

/* UPDADE */
/* NUNCA ATUALIZAR UM REGISTRO SEM VERIFICAR COM O SELECT PARA SABER SE É OS DADOS CERTOS PARA ALTERAR*/

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 7;

UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 7;

/* DELETE */

INSERT INTO CLIENTE VALUES(NULL, 'XXX', 'M', NULL, 'XXX');

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 8;

DELETE FROM CLIENTE 
WHERE IDCLIENTE = 8;

/* 
	DDL - DATA DEFINITION LANGUAGE 
*/

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10,2) NOT NULL
);

/* ALTER TABLE */

/* ALTERANDO O NOME DE UMA COLUNA - CHANGE */

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int         | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int         | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int         | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int         | YES  |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+


/* MODIFY - OUTRA CLAUSULA QUE ALTERA A TABELA TAMBEM E MELHOR
QUE O ALTER NA HORA DE ALTERAR O TIPO
*/

ALTER TABLE PRODUTO 
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

/* ADICIONANDO COLUNAS */

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

DESC PRODUTO;

/* APAGANDO UMA COLUNA */

ALTER TABLE PRODUTO
DROP COLUMN PESO;

/* ADICIONANDO UMA COLUNA NA ORDEM ESPECÍFICA */

ALTER TABLE PRODUTO 
ADD COLUMN PESO FLOAT(10,2) NOT NULL
AFTER NOME_PRODUTO;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int         | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| PESO           | float(10,2) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int         | YES  |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* ADD UMA COLUNA E COLOCAR ELA EM PRIMEIRO */

ALTER TABLE PRODUTO 
ADD COLUMN PESO FLOAT(10,2) NOT NULL
FIRST;

