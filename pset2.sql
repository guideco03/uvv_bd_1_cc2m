/*Questão 1*/
SELECT Numero_Departamento,
AVG (Salario) FROM FUNCIONARIOS
GROUP BY Numero_Departamento
ORDER BY Numero_Departamento;


/*Questão 2*/
SELECT Sexo,
AVG (Salario) FROM FUNCIONARIOS
GROUP BY Sexo
ORDER BY Sexo;


/*Questão 3*/
SELECT 
d.Nome_Departamento AS "Nome Departamento",
CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome ' ') AS "Nome Completo",
f.Data_Nascimento AS "Data Nascimento",
EXTRACT (year FROM age (f.Data_Nascimento)) AS "Idade",
CONCAT ('R$', ROUND((f.salario),2)) as "Salário"
FROM elmarsi.Departamento AS d 
JOIN elmarsi.Funcionario AS f ON f.Numero_Departamento = d.Numero_Departamento
ORDER BY Nome_Departamento;


/*Questão 4*/
SELECT CONCAT (Primeiro_Nome, ' ', Nome_Meio, ' ', Ultimo_Nome, ' ') AS "Nome Completo",
DATE_PART('year', AGE(Data_Nascimento)) AS "Idade",
Salario,
CASE 
    WHEN Salario < 35000 THEN Salario * 1.2
    ELSE Salario * 1.15
END AS "Reajuste de Salário"
FROM elmasri.Funcionario;


/*Questão 5*/
SELECT d.Nome_Departamento, CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome) AS "Nome Completo",
f.Salario,
CASE 
    WHEN f.Cpf = d.Cpf_Gerente THEN 'Gerente'
    ELSE 'Funcionario'
END AS "Posição",
FROM elmarsi.Departamento AS d JOIN elmarsi.Funcionario AS f ON d.Numero_Departamento = f.Numero_Departamento
ORDER BY d.Nome_Departamento ASC, f.Salario DESC;


/*Questão 6*/
SELECT CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome ' ') AS "Nome Funcionário",
dp.Nome_Dependente AS "Nome Dependente",
DATE_PART('year', AGE(dp.Data_Nascimento)) AS "Idade",

CASE
    WHEN dp.sexo = 'M' THEN 'Masculino'
    ELSE 'Feminino'
END AS "Sexo Dependente"

FROM elmasri.Dependente AS dp
INNER JOIN elmasri.Funcionario AS f ON f.Cpf = dp.Cpf_funcionario;


/*Questão 7*/
SELECT CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome, ' ') AS "Nome Completo",
f.Salario,
d.Nome_Departamento,
d.Numero_Departamento
FROM elmarsi.Funcionario AS f 
JOIN Departamento d ON f.Numero_Departamento = d.Numero_Departamento
WHERE Cpf NOT IN (SELECT Cpf_Funcionario FROM elmarsi.Dependente);


/*Questão 8*/
SELECT CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', Ultimo_Nome, ' ') AS "Nome Completo",
d.Nome_Departamento AS "Departamento",
p.Nome_Projeto AS "Projeto",
t.Horas_Trabalhadas AS "Horas Trabalhadas"
FROM elmasri.Departamento AS d 
INNER JOIN elmasri.Projeto AS p ON p.Numero_Departamento = d.Numero_Departamento
INNER JOIN elmasri.Trabalha_Em AS tbm ON tbm.Numero_Projeto = p.Numero_Projeto
INNER JOIN elmasri.Funcionario AS f ON f.Cpf = tbm.Cpf_Funcionario;


/*Questão 9*/
SELECT d.Nome_Departamento AS "Nome Departamento", 
p.Nome_Projeto AS "Nome Projeto",
SUM (t.horas) AS "Horas Trabalhadas"
FROM elmarsi.Departamento AS d
JOIN elmasri.Projeto AS p
ON d.Numero_Departamento = p.Numero_Departamento
JOIN elmasri.Trabalha_Em AS t
ON t.Numero_projeto = p.Numero_Projeto
GROUP BY d.Nome_Departamento, p.Nome_Projeto
ORDER BY d.Nome_Departamento ASC;


/*Questão 10*/
SELECT Numero_Departamento,
AVG (Salario) AS "Média por Departamento",
FROM Funcionarios
GROUP BY Numero_Departamento;


/*Questão 11*/
SELECT CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome, ' ') AS "Nome Completo Funcionário",
p.Nome_Projeto AS "Nome Projeto",
CONCAT('R$ ', (tbm.Horas * 50)) AS "Salário por Hora"
FROM elmasri.Funcionario AS f
JOIN elmasri.Trabalha_Em AS t
ON t.Cpf_Funcionario = f.Cpf
GROUP BY f.Cpf;


/*Questão 12*/
SELECT d.Nome_Departamento AS "Nome_Departamento",
p.Nome_Projeto AS "Nome Projeto",
SELECT CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome, ' ') AS "Nome Completo Funcionário",
FROM elmasri.Funcionario AS f
JOIN elmasri.Trabalha_Em AS t
ON t.Cpf_Funcionario = f.cpf
JOIN elmasri.Projeto AS p
ON p.Numero_Projeto = t.Numero_Projeto
JOIN elmasri.Departamento AS d
ON p.Numero_Departamento = d.Numero_Departamento
WHERE tbm.horas IS NULL;


/*Questão 13*/
SELECT CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome, ' ') AS "Nome Completo Funcionário",
Sexo,
DATE_PART('year', AGE(Data_Nascimento)) AS "Idade"
FROM elmasri.Funcionario UNION
SELECT Nome_Dependente,
Sexo,
DATE_PART('year', AGE(Data_Nascimento)) AS "Idade"
FROM elmasri.Dependente
ORDER BY Idade DESC;


/*Questão 14*/
/SELECT d.Nome_Departamento,
COUNT(f.Cpf) AS "Numero Funcionario"
FROM elmasri.Funcionario AS f
JOIN elmasri.Departamento AS d
ON d.Numero_Departamento = f.Numero_Departamento
GROUP BY d.nome_departamento;


/*Questão 15*/
SELECT CONCAT (f.Primeiro_Nome, ' ', f.Nome_Meio, '.', f.Ultimo_Nome, ' ') AS "Nome Completo Funcionário",
d.Nome_Departamento AS "Nome Departamento",
p.Nome_Projeto AS "Nome Projeto",
FROM elmasri.Funcionario AS f
JOIN elmasri.Departamento AS d
ON f.Numero_Departamento = d.Numero_Departamento
JOIN elmasri.Trabalha_Em AS t
ON t.Cpf_Funcionario = f.Cpf
JOIN elmasri.Projeto AS p
ON t.Numero_Projeto = p.Numero_Projeto;
