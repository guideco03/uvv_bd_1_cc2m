/* O primeiro passo foi criar meu usuário no Banco de Dados, com o comando CREATE USER, e a senha '1234' com o comando IDENTIFIED BY. */
CREATE USER 'guilherme_gobbi'@'localhost' IDENTIFIED BY '1234';

/* A seguir, foram dados todos os privilégios do banco de dados para o meu usuário. */
GRANT ALL PRIVILEGES ON * . * TO 'guilherme_gobbi'@'localhost';

/* Para que as mudanças tenham efeito, executei o seguinte comando: */
FLUSH PRIVILEGES;

/* Pronto. Hora de criar a Database UVV. Utilizei o comando CREATE DATABASE e, em seguida, o comando USE (nome da Database) para ter certeza que
estou utilizando aquela Database. */
CREATE DATABASE UVV;
USE UVV;

/* Hora da criação das Tabelas. Para isso, utilizei o comando padrão CREATE TABLE e fui inserindo os dados do projeto Elmarsi. */
CREATE TABLE Funcionario (
                CPF CHAR(11) NOT NULL,
                Primeiro_Nome VARCHAR(15) NOT NULL,
                Nome_Meio CHAR(1),
                Ultimo_Nome VARCHAR(15) NOT NULL,
                Data_Nascimento DATE,
                Endereco VARCHAR(30),
                Sexo CHAR(1),
                Salario DECIMAL(10,2),
                CPF_Supervisor CHAR(11) NOT NULL,
                Numero_Departamento INTEGER NOT NULL,
                CONSTRAINT Funcionario_pk PRIMARY KEY (CPF)
);


CREATE TABLE Departamento (
                Numero_departamento INTEGER NOT NULL,
                Nome_departamento VARCHAR(15) NOT NULL,
                CPF_Gerente CHAR(11) NOT NULL,
                Data_Inicio_Gerente DATE,
                CONSTRAINT Departamento_pk PRIMARY KEY (Numero_departamento)
);

/* Aqui foi utilizado o comando CREATE UNIQUE INDEX para garantir que a chave de índice não contenha nenhum valor duplicado e, 
portanto, cada linha na tabela é exclusiva */
CREATE UNIQUE INDEX Departamento_idx
 ON Departamento
 ( Nome_departamento );

CREATE TABLE Localizacoes_Departamento (
                Numero_Departamento INTEGER NOT NULL,
                Local VARCHAR(15) NOT NULL,
                CONSTRAINT Localizacoes_Departamento_pk PRIMARY KEY (Numero_Departamento, Local)
);


CREATE TABLE Projeto (
                Numero_Projeto INTEGER NOT NULL,
                Nome_Projeto VARCHAR(15) NOT NULL,
                Local_Projeto VARCHAR(15),
                Numero_Departamento INTEGER NOT NULL,
                CONSTRAINT Projeto_pk PRIMARY KEY (Numero_Projeto)
);


CREATE UNIQUE INDEX Projeto_idx1
 ON Projeto
 ( Nome_Projeto );

CREATE TABLE Trabalha_Em (
                Numero_Projeto INTEGER NOT NULL,
                CPF_Funcionario CHAR(11) NOT NULL,
                Horas DECIMAL(3,1) NOT NULL,
                CONSTRAINT Trabalha_Em_pk PRIMARY KEY (Numero_Projeto, CPF_Funcionario)
);


CREATE TABLE Dependente (
                CPF_Funcionario CHAR(11) NOT NULL,
                Nome_Dependente VARCHAR(15) NOT NULL,
                Sexo CHAR(1),
                Parentesco VARCHAR(15),
                Data_Nascimento DATE,
                CONSTRAINT Dependente_pk PRIMARY KEY (CPF_Funcionario, Nome_Dependente)
);


ALTER TABLE Dependente ADD CONSTRAINT Funcionario_Dependente_fk
FOREIGN KEY (CPF_Funcionario)
REFERENCES Funcionario (CPF)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Funcionario ADD CONSTRAINT Funcionario_Funcionario_fk
FOREIGN KEY (CPF_Supervisor)
REFERENCES Funcionario (CPF)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Departamento ADD CONSTRAINT Funcionario_Departamento_fk
FOREIGN KEY (CPF_Gerente)
REFERENCES Funcionario (CPF)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Trabalha_Em ADD CONSTRAINT Funcionario_Trabalha_Em_fk
FOREIGN KEY (CPF_Funcionario)
REFERENCES Funcionario (CPF)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Projeto ADD CONSTRAINT Departamento_Projeto_fk
FOREIGN KEY (Numero_Departamento)
REFERENCES Departamento (Numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Localizacoes_Departamento ADD CONSTRAINT Departamento_Localizacoes_Departamento_fk
FOREIGN KEY (Numero_Departamento)
REFERENCES Departamento (Numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Trabalha_Em ADD CONSTRAINT Projeto_Trabalha_Em_fk
FOREIGN KEY (Numero_Projeto)
REFERENCES Projeto (Numero_Projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
