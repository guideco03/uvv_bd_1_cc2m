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

/* Nos códigos a seguir foram feitos os relacionamentos entre as tabelas com o comando ALTER TABLE. */
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

/* Com todas as tabelas prontas, ssuas devidas restrições e relaconamentos, agora é hora de inserir os dados na tabela de acordo com o PDF*/
/* Dferente do PostgreSQL, aqui optei por enxutar os códigos ao invés de colocar um monte de INSERT_INTO.*/

INSERT INTO Funcionario (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('João', 'B', 'Silva', 12345678966, '09-01-1965', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, 33344555587, 5), 
('Fernando', 'T', 'Wong', 33344555587, '08-12-1955', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, 88866555576, 5),
('Alice', 'J', 'Zelaya', 99988777767, '19-01-1968', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, 98765432168, 4),
('Jennifer', 'S', 'Souza', 98765432168, '20-06-1941', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000, 88866555576, 4),
('Ronaldo', 'K', 'Lima', 66688444476, '15-09-1962', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, 33344555587, 5),
('Joice', 'A', 'Leite', 45345345376, '31-07-1972', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, 33344555587, 5),
('André', 'V', 'Pereira', 98798798733, '29-03-1969', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, 98765432168, 4),
('Jorge', 'E', 'Brito', 88866555576, '10-11-1937', 'Rua do Horto, 35, São Paulo, SP', 'M', 38000, 5);

/* Bem mais enxuto né. Feito isso, foram inseridos os dados da tabela departamento */

INSERT INTO Departamento (Nome_Departamento, Numero_Departamento, CPF_Gerente, Data_Inicio_Gerente)
VALUES ('Pesquisa', 5, 33344555587, '22-05-1988'), ('Administração', 4, 98765432168, '01-01-1995'), ('Matriz', 1, 88866555576, '19-06-1981');

/* Hora de inserir os dados da tabela Localizacoes_Departamento */

INSERT INTO Localizacoes_Departamento (Numero_Departamento, Local)
VALUES (1, 'São Paulo'), (4, 'Mauá'), (5, 'Santo André'), (5, 'Itu'), (5, 'São Paulo');

/* Continuando inserindo mais dados... agora os da tabela Projeto */

INSERT INTO Projeto (Nome_Projeto, Numero_Projeto, Local_Projeto, Numero_Departamento)
VALUES ('ProdutoX', 1, 'Santo André', 5), ('ProdutoY', 2, 'Itu', 5), ('ProdutoZ', 3, 'São Paulo', 5), ('Informatização', 10, 'Mauá', 4),
('Reorgnização', 20, 'São Paulo', 1), ('NovosBenefícios', 30, 'Mauá', 4);

/* Colocando os dados da tabela Dependente */

INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (33344555587, 'Alicia', 'F', '05-04-1986', 'Filha'), (33344555587, 'Tiago', 'M', '25-10-1983', 'Filho'), (33344555587, 'Janaina', 'F', '03-05-1958', 'Esposa'),
(98765432168, 'Antonio', 'M', '28-02-1942', 'Marido'), (12345678966, 'Michael', 'M', '04-01-1988', 'Filho'), (12345678966, 'Alicia', 'F', '30-12-1988', 'Filha'),
(12345678966, 'Elizabeth', 'F', '05-05-1967', 'Esposa');

/* E por fim, os dados da tabela Trabalha_Em. */

INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas) 
VALUES (12345678966, 1, 32.5), (12345678966, 2, 7.5), (66688444476, 3, 40.0), (45345345376, 1, 20.0), (45345345376, 2, 20.0),
(33344555587, 2, 10.0), (33344555587, 3, 10.0), (33344555587, 10, 10.0), (33344555587, 20, 10.0), (99988777767, 30, 30.0),
(99988777767, 10, 10.0), (98798798733, 10, 35.0), (98798798733, 30, 5.0), (98765432168, 30, 20.0), (98765432168, 20, 15.0),
(88866555576, 20);

/*Pronto. Projeto finalizado!. */
