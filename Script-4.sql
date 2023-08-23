--  SCRIPT DDL

create table usuario(
	usuario_id serial PRIMARY KEY,
	nome_completo varchar(20) NOT NULL,
	renda_mensal varchar(20),
	cpf varchar(11) NOT NULL UNIQUE,
	telefone varchar(20) UNIQUE,
	endereco varchar(20) NOT NULL
);

CREATE TABLE produto(
	produto_id serial PRIMARY KEY,
	nome varchar(20) NOT NULL,
	anuidade REAL NOT NULL,
	operadora varchar NOT NULL,
	limite_max_credito REAL NOT NULL
);

CREATE TABLE analista(
	analista_id serial PRIMARY KEY,
	nome varchar(20 )NOT NULL UNIQUE
);


CREATE TABLE solicitacao(
	solicitacao_id serial PRIMARY KEY,
	data_criacao date NOT NULL,
	status varchar(20) NOT NULL,
	atualizacao_data date,
	data_finalizacao date,
	usuario_id int NOT NULL,
	analista_id int NOT NULL,
	produto_id int NOT NULL,
	CONSTRAINT fk_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (usuario_id),
	CONSTRAINT fk_analista_id FOREIGN KEY (analista_id) REFERENCES analista(analista_id),
	CONSTRAINT fk_produto_id FOREIGN KEY (produto_id) REFERENCES produto(produto_id)
	
);

CREATE TABLE cartao(
	cartao_id serial  PRIMARY KEY,
	fechamento_ciclo varchar(20) NOT NULL,
	numero_cartao varchar(20) NOT NULL,
	cvv varchar(3) NOT NULL,
	validade date NOT NULL,
	limite_credito REAL NOT NULL,
	usuario_id int NOT NULL,
	produto_id int NOT NULL,
	CONSTRAINT fk_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id),
	CONSTRAINT fk_produto_id FOREIGN KEY (produto_id) REFERENCES produto(produto_id)

);



--  SCRIPT DML


INSERT INTO usuario(NOME_COMPLETO, RENDA_MENSAL, CPF, TELEFONE, ENDERECO)
VALUES ('Marcelina Silva', 3.000,'12345687945', '24988756548',' Rua Valenca n-68'),
('Carolina Silva Sauro',6.000,'25647896324',' 985746856','Rua Paqueta n-55'),
('Ruberval Silva', 5.000, '25489657412',' 968547256',' Rua Feliz n-115'),
('Joselino Torres', 10.000,'24589654785',' 00256987456', 'Rua Pacha n-45'),
('Sonia Freitas', 4.000,'52465891456','25897456321',' Rua Paraiso');



INSERT INTO PRODUTO (NOME, ANUIDADE, OPERADORA, LIMITE_MAX_CREDITO)
VALUES('Convencional', 100.00, 'Visa', 1000),
('Internacional', 200.00, 'Mastercard', 5000),
('Platinum', 250.00, 'Visa', 10000),
('Infinity Black', 800.00, 'Mastercard', 30000),
('Gold', 400.00, 'Visa', 15000);
	
INSERT INTO analista (nome)
VALUES ('Paulo'), 
('Laura'), 
('Karina'), 
('Renata'), 
('Lucio');

-- Script fluxo

SELECT * FROM USUARIO U  

INSERT INTO SOLICITACAO (DATA_CRIACAO, STATUS, USUARIO_ID, ANALISTA_ID, PRODUTO_ID)
VALUES (now(),'Em processamento', 4, 18, 3);

-- CONSULTA ANALISE DE SOLICITACAO EM PROCESSAMENTO

SELECT S.SOLICITACAO_ID, S.DATA_CRIACAO, S.STATUS, S.ATUALIZACAO_DATA, S.DATA_FINALIZACAO,
		U.NOME_COMPLETO, U.RENDA_MENSAL, U.CPF, U.TELEFONE, U.ENDERECO,
		P.NOME, P.ANUIDADE, P.OPERADORA, P.LIMITE_MAX_CREDITO,
		A.NOME 		
FROM SOLICITACAO S 
INNER JOIN USUARIO U 
ON U.USUARIO_ID =  S.USUARIO_ID
INNER JOIN PRODUTO P 
ON P.PRODUTO_ID = S.PRODUTO_ID
INNER JOIN ANALISTA A 
ON A.ANALISTA_ID = S.ANALISTA_ID 
WHERE S.STATUS = 'Em processamento'
ORDER BY S.DATA_CRIACAO;

--status da solicitacao
SELECT * FROM SOLICITACAO S 

--status de finalizacao

UPDATE SOLICITACAO
SET ATUALIZACAO_DATA = NOW(),
STATUS = 'Finalizado',
DATA_FINALIZACAO = NOW()
WHERE SOLICITACAO_ID = 5;

SELECT * FROM SOLICITACAO S 

--  CONSULTA PARA BUSCA DE ANALISE, caso seja reprovado, colocar Nao autorizado, 

SELECT S.SOLICITACAO_ID, S.DATA_CRIACAO, S.STATUS, S.ATUALIZACAO_DATA, S.DATA_FINALIZACAO,
		U.NOME_COMPLETO, U.RENDA_MENSAL, U.CPF, U.TELEFONE, U.ENDERECO,
		P.NOME, P.ANUIDADE, P.OPERADORA, P.LIMITE_MAX_CREDITO,
		A.NOME 		
FROM SOLICITACAO S 
INNER JOIN USUARIO U 
ON U.USUARIO_ID =  S.USUARIO_ID
INNER JOIN PRODUTO P 
ON P.PRODUTO_ID = S.PRODUTO_ID
INNER JOIN ANALISTA A 
ON A.ANALISTA_ID = S.ANALISTA_ID 
WHERE S.STATUS = 'APROVADO'
ORDER BY S.DATA_CRIACAO;

--inserindo dados do cartao caso seja aprovado

INSERT INTO CARTAO (FECHAMENTO_CICLO, NUMERO_CARTAO, CVV, VALIDADE, LIMITE_CREDITO, USUARIO_ID, PRODUTO_ID, SOLICITACAO_ID)
VALUES(' ', ' ', ' ', '  ',  ,   ,   ,    ,);





	
	
	
	
	
	
	
	
	