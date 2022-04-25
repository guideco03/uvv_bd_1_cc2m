CREATE TABLE Funcionario (
                CPF CHAR(11) NOT NULL,
                Primeiro_Nome VARCHAR(15) NOT NULL,
                Nome_Meio CHAR(1),
                Ultimo_Nome VARCHAR(15) NOT NULL,
                Data_Nascimento DATE,
                Endereco VARCHAR(40),
                Sexo CHAR(1),
                Salario DECIMAL(10,2),
                CPF_Supervisor CHAR(11),
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

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('João', 'B', 'Silva', 12345678966, '09-01-1965', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, 33344555587, 5);

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('Fernando', 'T', 'Wong', 33344555587, '08-12-1955', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, 88866555576, 5);

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('Alice', 'J', 'Zelaya', 99988777767, '19-01-1968', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, 98765432168, 4);

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('Jennifer', 'S', 'Souza', 98765432168, '20-06-1941', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000, 88866555576, 4);

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('Ronaldo', 'K', 'Lima', 66688444476, '15-09-1962', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, 33344555587, 5);

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('Joice', 'A', 'Leite', 45345345376, '31-07-1972', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, 33344555587, 5);

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, CPF_Supervisor, Numero_Departamento)
VALUES ('André', 'V', 'Pereira', 98798798733, '29-03-1969', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, 98765432168, 4);

INSERT INTO Funcionarios (Primeiro_Nome, Nome_Meio, Ultimo_Nome, CPF, Data_Nascimento, Enedeco, Sexo, Salario, Numero_Departamento)
VALUES ('Jorge', 'E', 'Brito', 88866555576, '10-11-1937', 'Rua do Horto, 35, São Paulo, SP', 'M', 38000, 5);



INSERT INTO departamento (Nome_Departamento, Numero_Departamento, CPF_Gerente, Data_Inicio_Gerente)
VALUES ('Pesquisa', 5, 33344555587, '22-05-1988');

INSERT INTO departamento (Nome_Departamento, Numero_Departamento, CPF_Gerente, Data_Inicio_Gerente)
VALUES ('Administração', 4, 98765432168, '01-01-1995');

INSERT INTO departamento (Nome_Departamento, Numero_Departamento, CPF_Gerente, Data_Inicio_Gerente)
VALUES ('Matriz', 1, 88866555576, '19-06-1981');


INSERT INTO Localizacoes_Departamento (Numero_Departamento, Local)
VALUES (1, 'São Paulo');

INSERT INTO Localizacoes_Departamento (Numero_Departamento, Local)
VALUES (4, 'Mauá');

INSERT INTO Localizacoes_Departamento (Numero_Departamento, Local)
VALUES (5, 'Santo André');

INSERT INTO Localizacoes_Departamento (Numero_Departamento, Local)
VALUES (5, 'Itu');

INSERT INTO Localizacoes_Departamento (Numero_Departamento, Local)
VALUES (5, 'São Paulo');



INSERT INTO Projeto (Nome_Projeto, Numero_Projeto, Local_Projeto, Numero_Departamento)
VALUES ('ProdutoX', 1, 'Santo André', 5);

INSERT INTO Projeto (Nome_Projeto, Numero_Projeto, Local_Projeto, Numero_Departamento)
VALUES ('ProdutoY', 2, 'Itu', 5);

INSERT INTO Projeto (Nome_Projeto, Numero_Projeto, Local_Projeto, Numero_Departamento)
VALUES ('ProdutoZ', 3, 'São Paulo', 5);

INSERT INTO Projeto (Nome_Projeto, Numero_Projeto, Local_Projeto, Numero_Departamento)
VALUES ('Informatização', 10, 'Mauá', 4);

INSERT INTO Projeto (Nome_Projeto, Numero_Projeto, Local_Projeto, Numero_Departamento)
VALUES ('Reorgnização', 20, 'São Paulo', 1);

INSERT INTO Projeto (Nome_Projeto, Numero_Projeto, Local_Projeto, Numero_Departamento)
VALUES ('NovosBenefícios', 30, 'Mauá', 4);



INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (33344555587, 'Alicia', 'F', '05-04-1986', 'Filha');

INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (33344555587, 'Tiago', 'M', '25-10-1983', 'Filho');

INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (33344555587, 'Janaina', 'F', '03-05-1958', 'Esposa');

INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (98765432168, 'Antonio', 'M', '28-02-1942', 'Marido');

INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (12345678966, 'Michael', 'M', '04-01-1988', 'Filho');

INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (12345678966, 'Alicia', 'F', '30-12-1988', 'Filha');

INSERT INTO Dependente (CPF_Funcionario, Nome_Dependente, Sexo, Data_Nascimento, Parentesco)
VALUES (12345678966, 'Elizabeth', 'F', '05-05-1967', 'Esposa');



INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (12345678966, 1, 32.5);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (12345678966, 2, 7.5);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (66688444476, 3, 40.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (45345345376, 1, 20.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (45345345376, 2, 20.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (33344555587, 2, 10.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (33344555587, 3, 10.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (33344555587, 10, 10.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (33344555587, 20, 10.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (99988777767, 30, 30.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (99988777767, 10, 10.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (98798798733, 10, 35.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (98798798733, 30, 5.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (98765432168, 30, 20.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto, Horas)
VALUES (98765432168, 20, 15.0);

INSERT INTO Trabalha_Em (CPF_Funcionario, Numero_Projeto)
VALUES (88866555576, 20);


/* Primeiro foi criado todas as tabelas, com algumas alterações: o Varchar Endereco da Tabela Funcionarios precisou ser aumentado para 40 e 
o CPF_Supervisor dessa mesma tabela foi modificado para poder ser nulo); logo em seguida foram feitos os comandos para chaves e restrições, e por fim
os comandos de inserção de dados seguindo a ordem descrita pelo professor no PDF, utilizando os comandos INSERT INTO e VALUES. /*








