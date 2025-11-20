/*
DROP TABLE IF EXISTS  telefone_proprietario;
DROP TABLE IF EXISTS email_proprietario;
DROP TABLE IF EXISTS animaL;
DROP TABLE IF EXISTS propietario_animais;
DROP TABLE IF EXISTS telefone_veterinario;
DROP TABLE IF EXISTS veterinario;

CREATE TABLE propietario_animais(
	id_proprietario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome_proprietario VARCHAR(200),
	cpf_proprietario VARCHAR(200),
	uf VARCHAR(2),
	logradouro VARCHAR(200),
	numero VARCHAR(200),
	bairro VARCHAR(200),
	cep VARCHAR(200),
	cidade VARCHAR(200)
);

CREATE TABLE telefone_proprietario(
	id_telefone_proprietario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk_id_proprietario BIGINT,
	numero_telefone VARCHAR(200),
	FOREIGN KEY (fk_id_proprietario) REFERENCES propietario_animais(id_proprietario)
);

CREATE TABLE email_proprietario(
	id_email_proprietario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk2_id_proprietario BIGINT,
	email VARCHAR(200),
	FOREIGN KEY (fk2_id_proprietario ) REFERENCES propietario_animais(id_proprietario)
);

CREATE TABLE animal(
	id_animal BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome_animal VARCHAR(200),
	especie_animal VARCHAR(200),
	raca_animal VARCHAR(200),
	data_de_nascimento_animal VARCHAR(200),
	peso_animal VARCHAR(200),
	proprietario BIGINT,
	FOREIGN KEY (proprietario) REFERENCES propietario_animais(id_proprietario)
);


CREATE TABLE veterinario(
	id_veterinario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome_veterinario VARCHAR(200),
	crmv_veterinario VARCHAR(200),
	especialidade_veterinario VARCHAR(200)
);

CREATE TABLE telefone_veterinario(
	id_telefone_veterinario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk_id_veterinario BIGINT,
	numero_telefone_veterinario VARCHAR(200),
	FOREIGN KEY (fk_id_veterinario) REFERENCES veterinario(id_veterinario)
);
*/
DROP TABLE IF EXISTS consultas;
DROP TABLE IF EXISTS  telefone_proprietario;
DROP TABLE IF EXISTS email_proprietario;
DROP TABLE IF EXISTS animal;
DROP TABLE IF EXISTS propietario_animais;
DROP TABLE IF EXISTS telefone_veterinario;
DROP TABLE IF EXISTS veterinario;

CREATE TABLE propietario_animais(
	id_proprietario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome_proprietario VARCHAR(200),
	cpf_proprietario VARCHAR(14) UNIQUE,
	uf VARCHAR(2),
	logradouro VARCHAR(200),
	numero VARCHAR(10),
	bairro VARCHAR(200),
	cep VARCHAR(9),
	cidade VARCHAR(200)
);

CREATE TABLE telefone_proprietario(
	id_telefone_proprietario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk_id_proprietario BIGINT,
	numero_telefone VARCHAR(20),
	FOREIGN KEY (fk_id_proprietario) REFERENCES propietario_animais(id_proprietario)
);

CREATE TABLE email_proprietario(
	id_email_proprietario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk2_id_proprietario BIGINT,
	email VARCHAR(200),
	FOREIGN KEY (fk2_id_proprietario ) REFERENCES 	     propietario_animais(id_proprietario)
);

CREATE TABLE animal(
	id_animal BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome_animal VARCHAR(200),
	especie_animal VARCHAR(200),
	raca_animal VARCHAR(200),
	data_de_nascimento_animal DATE,
	peso_animal numeric(10,2),
	proprietario BIGINT,
	FOREIGN KEY (proprietario) REFERENCES propietario_animais(id_proprietario)
);


CREATE TABLE veterinario(
	id_veterinario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	nome_veterinario VARCHAR(200),
	crmv_veterinario VARCHAR(200) UNIQUE,
	especialidade_veterinario VARCHAR(200)
);

CREATE TABLE telefone_veterinario(
	id_telefone_veterinario BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fk_id_veterinario BIGINT,
	numero_telefone_veterinario VARCHAR(20),
	FOREIGN KEY (fk_id_veterinario) REFERENCES veterinario(id_veterinario)
);

CREATE TABLE consultas(
  id_consulta BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  data_hora_consulta TIMESTAMP,
  diagnostico TEXT,
  valor numeric(20,2),
  fk2_id_veterinario BIGINT,
  fk_id_animal BIGINT,
  FOREIGN KEY (fk2_id_veterinario) REFERENCES veterinario (id_veterinario),
  FOREIGN KEY (fk_id_animal) REFERENCES animal (id_animal)
 );


--DML
INSERT INTO propietario_animais (nome_proprietario, cpf_proprietario, uf, logradouro, numero, bairro, cep, cidade) VALUES
('Ana Silva Pereira', 12345678901, 'SP', 'Rua das Flores', '100', 'Jardim Paulista', '01426-000', 'São Paulo'),
('Carlos Eduardo Santos', 98765432109, 'RJ', 'Av. Atlântica', '1500', 'Copacabana', '22070-000', 'Rio de Janeiro'),
('Beatriz Costa', 45678901234, 'MG', 'Rua Minas Gerais', '25', 'Centro', '30160-000', 'Belo Horizonte');

INSERT INTO telefone_proprietario (fk_id_proprietario, numero_telefone) VALUES
-- Telefones para Ana Silva Pereira (ID 1)
(1, '(11) 98765-4321'),
(1, '(11) 3333-2222'),

-- Telefones para Carlos Eduardo Santos (ID 2)
(2, '(21) 99999-0000'),

-- Telefones para Beatriz Costa (ID 3)
(3, '(31) 98888-7777'),
(3, '(31) 3222-1111');

INSERT INTO email_proprietario (fk2_id_proprietario,email) VALUES 
(1,'ana@gmail.com'), (2,'carlos@gmail.com') , (2,'carlos10@gmail.com'), (3,'beatriz@gmail.com');

INSERT INTO animal(nome_animal,especie_animal,raca_animal,data_de_nascimento_animal,peso_animal,proprietario) VALUES
('bob','cachorro','pug','26/05/2020','12kg',1),
('mack', 'cachorro','buldog','10/04/2021','10kg',2),
('blue', 'ave','arara azul','03/08/2019','1kg',3);

INSERT INTO veterinario (nome_veterinario, crmv_veterinario, especialidade_veterinario) VALUES
('Dr. Marcelo Antunes', 'CRMV-SP 12345', 'Clínica Geral'),
('Dra. Laura Mendes', 'CRMV-RJ 67890', 'Cardiologia'),
('Dr. Ricardo Alencar', 'CRMV-MG 10112', 'Ortopedia');

INSERT INTO telefone_veterinario (fk_id_veterinario, numero_telefone_veterinario) VALUES
-- Telefones para Dr. Marcelo (ID 1)
(1, '(11) 98888-7777'),

-- Telefones para Dra. Laura (ID 2)
(2, '(21) 99999-5555'),
(2, '(21) 3444-1111'),

-- Telefones para Dr. Ricardo (ID 3)
(3, '(31) 98765-1234');


--DQL
--SELECT id_proprietario,nome_proprietario, cpf_proprietario,numero_telefone,email, uf, logradouro, numero, bairro, cep, cidade FROM propietario_animais 
--INNER JOIN telefone_proprietario ON fk_id_proprietario = id_proprietario
--INNER JOIN email_proprietario ON fk2_id_proprietario = id_proprietario


--SELECT id_animal , nome_animal,especie_animal,raca_animal,data_de_nascimento_animal,peso_animal,nome_proprietario FROM animal INNER JOIN propietario_animais ON proprietario = id_proprietario

SELECT nome_veterinario, crmv_veterinario, especialidade_veterinario , numero_telefone_veterinario FROM veterinario INNER JOIN telefone_veterinario ON  fk_id_veterinario = id_veterinario
