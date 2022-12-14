-- 1

CREATE DATABASE CLUBEDALEITURADB;

CREATE TABLE Revistas
(
    ID INT IDENTITY(1,1) NOT NULL,
    TipoColecao VARCHAR(100) NOT NULL,
    NumeroEdicao VARCHAR(5) NOT NULL,
    AnoRevista INT NOT NULL,
    CorCaixaArquivo VARCHAR(25) NULL,
    CONSTRAINT PK_RevistaID PRIMARY KEY(ID)
);


CREATE TABLE Amigos
(
    ID INT IDENTITY(1,1) NOT NULL,
    Nome VARCHAR(150) NOT NULL,
    NomeMaeAmigo VARCHAR(150) NOT NULL,
    TelefoneAmigo VARCHAR(20) NOT NULL,
    OrigemAmigo VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Amigo_ID PRIMARY KEY(ID)
);

CREATE TABLE Emprestimos
(
    ID INT IDENTITY (1,1) NOT NULL,
    NomeAmigo VARCHAR(150) NOT NULL,
    NomeRevista VARCHAR(100) NOT NULL,
    DataEmprestimo DATETIME NOT NULL,
    DataDevolucao DATETIME NULL,
    Preco MONEY NULL,
    RevistaID INT NOT NULL,
    AmigoID INT NOT NULL,
    CONSTRAINT PK_Emprestimo_Nome PRIMARY KEY(ID),
    CONSTRAINT FK_Revista_Emprestada FOREIGN KEY (RevistaID) REFERENCES Revistas(ID),
    CONSTRAINT FK_Amigo_Emprestimo FOREIGN KEY (AmigoID) REFERENCES Amigos(ID)
);

--2

INSERT INTO Revistas (TipoColecao, AnoRevista, NumeroEdicao, CorCaixaArquivo)
VALUES
('Batman - A Piada Mortal', 1992, '001', 'Branca'),
('Batman & Robin', 1977, '002', 'Preta'),
('Watchmen', 1979, '003', 'Azul'),
('Homem Aranha - A Última Caçada de Kraven', 1992, '004', 'Branca'),
('Sandman - Estação das Brumas', 1997, '005', 'Azul'),
('V de Vingança', 1993, '006', 'Branca'),
('Preacher: All in the Family', 2002, '007',  'Preta'),
('John Constantine, HellBlazer - Infernal', 1991, '008', 'Azul'),
('Patrulha do Destino', 1989, '009', 'Branca'),
('Y o Último Homem', 2002, '010', 'Preta');

INSERT INTO Amigos (Nome, NomeMaeAmigo, TelefoneAmigo, OrigemAmigo)
VALUES
('Maria Clara Leite', 'Joana Leite', '991111522', 'Escola'),
('Cecília Gomes Copelli', 'Marilaine Copelli', '984531912', 'Escola'),
('Lorenzo Copelli', 'Mari Branco', '999541213', 'Escola'),
('Laura Pereira', 'Zilda Pereira', '989546785', 'Prédio'),
('Alfredo Gustavo de Souza', 'Marisa Souza', '991528979', 'Prédio'),
('Flavio Neto', 'Luiza Neto', '991384919', 'Prédio');

INSERT INTO Emprestimos (NomeAmigo, NomeRevista, DataEmprestimo, DataDevolucao, RevistaID, AmigoID)
VALUES
('Maria Clara Leite', 'Homem Aranha - A Última Caçada de Kraven', '13-05-2019', '10-06-2019', 4, 1),
('Cecília Gomes Copelli', 'Batman - A Piada Mortal', '23-02-2022', '01-03-2022', 1, 2),
('Luiz Gustavo Souza', 'Batman & Robin', '18-11-2020', '13-12-2020', 2, 5),
('Maria Clara Leite', 'Preacher: All in the Family', '04-08-2022', NULL, 7, 1),
('Laura Pereira', 'V de Vingança', '27-01-2022', '01-03-2022', 6, 4),
('Flavio Neto', 'Sandman - Estação das Brumas', '22-07-2022', '01-08-2022', 5, 6),
('Lorenzo Copelli', 'Patrulha do Destino', '15-12-2021', '02-01-2022', 9, 3),
('Maria Clara Leite', 'John Constantine, HellBlazer - Infernal', '12-02-2022', NULL, 8, 1),
('Cecília Gomes Copelli', 'Y o Último Homem', '10-07-2022', '05-08-2022', 10, 2),
('Maria Clara Leite', 'Homem Aranha - A Última Caçada de Kraven', '05-08-2022', NULL, 4, 1);

-- 3

UPDATE Emprestimos SET Preco = 18.25 WHERE ID = 1;
UPDATE Emprestimos SET Preco = 15.25 WHERE ID = 2;
UPDATE Emprestimos SET Preco = 11.25 WHERE ID = 3;
UPDATE Emprestimos SET Preco = 12.25 WHERE ID = 4;
UPDATE Emprestimos SET Preco = 14.25 WHERE ID = 5;
UPDATE Emprestimos SET Preco = 15.25 WHERE ID = 6;
UPDATE Emprestimos SET Preco = 17.25 WHERE ID = 7;
UPDATE Emprestimos SET Preco = 21.25 WHERE ID = 8;
UPDATE Emprestimos SET Preco = 8.25 WHERE ID = 9;
UPDATE Emprestimos SET Preco = 5.25 WHERE ID = 10;

-- 4

SELECT A.ID AS 'IDENTIFICADOR', COALESCE(CAST (E.DataDevolucao as VARCHAR), 'NÃO DEVOLVIDO') AS 'DEVOLUÇÃO', A.Nome AS 'NOME', E.Preco AS 'PREÇO DA REVISTA'
FROM Emprestimos E
INNER JOIN Amigos A ON (E.AmigoID = A.ID)
INNER JOIN Revistas R ON (E.NomeRevista = R.TipoColecao)
WHERE E.Preco >= 12 AND E.Preco <= 16
ORDER BY E.DataDevolucao;

-- 5

SELECT E.ID AS 'IDENTIFICADOR', COALESCE(CAST (E.DataDevolucao as VARCHAR), 'NÃO DEVOLVIDO') AS 'DEVOLUÇÃO', E.Preco AS 'PREÇO DA REVISTA', E.NomeRevista AS 'TIPO DA COLEÇÃO'
FROM Revistas R INNER JOIN Emprestimos E ON (R.TipoColecao = E.NomeRevista)
WHERE E.NomeRevista LIKE '%Batman%' OR E.NomeRevista LIKE '%Homem Aranha%'
ORDER BY E.DataDevolucao;

-- 6

SELECT * FROM Amigos
WHERE Nome LIKE '%A%'
ORDER BY Nome;

SELECT * FROM Amigos
WHERE Nome LIKE 'A%'
ORDER BY Nome;

SELECT * FROM Amigos
WHERE Nome LIKE '%A'
ORDER BY Nome;

-- 7

SELECT AVG(Preco) AS 'MÉDIA DOS VALORES DAS REVISTAS - 2022' FROM Emprestimos E
INNER JOIN Revistas R ON (E.NomeRevista = R.TipoColecao)
WHERE DataDevolucao >= '01-01-2022' AND DataDevolucao <= '31-12-2022';

SELECT SUM(Preco) AS 'SOMA DOS VALORES DAS REVISTAS - 2022' FROM Emprestimos E
INNER JOIN Revistas R ON (E.NomeRevista = R.TipoColecao)
WHERE DataDevolucao >= '01-01-2022' AND DataDevolucao <= '31-12-2022';

SELECT MAX(Preco) AS 'REVISTA MAIS CARA - 2022' FROM Emprestimos E
INNER JOIN Revistas R ON (E.NomeRevista = R.TipoColecao)
WHERE DataDevolucao >= '01-01-2022' AND DataDevolucao <= '31-12-2022';

SELECT MIN(Preco) AS 'REVISTA MAIS BARATA' FROM Emprestimos E
INNER JOIN Revistas R ON (E.NomeRevista = R.TipoColecao)
WHERE DataDevolucao >= '01-01-2022' AND DataDevolucao <= '31-12-2022';

-- 8

SELECT COUNT(DISTINCT A.ID) AS 'QUANTIDADE DE AMIGOS', COUNT(E.ID) AS 'QUANTIDADE DE EMPRÉSTIMOS', COUNT(R.ID) AS 'QUANTIDADE DE REVISTAS'
FROM Amigos A
FULL JOIN Emprestimos E ON (A.Nome = E.NomeAmigo)
LEFT JOIN Revistas R ON (R.TipoColecao = E.NomeRevista);

-- 9

SELECT E.ID AS 'ID EMPRÉSTIMO', CAST(E.DataEmprestimo AS VARCHAR) AS 'DATA DE EMPRÉSTIMO',
COALESCE(CAST (E.DataDevolucao AS VARCHAR), 'NÃO DEVOLVIDO') AS 'DATA DE DEVOLUÇÃO',
E.Preco AS 'VALOR DO EMPRÉSTIMO', R.TipoColecao AS 'NOME DA REVISTA', E.NomeAmigo AS 'AMIGO QUE EMPRESTOU'
FROM Emprestimos E
INNER JOIN Revistas R ON (E.NomeRevista = R.TipoColecao)
ORDER BY E.DataDevolucao;

-- 10

DELETE FROM Emprestimos
DBCC CHECKIDENT (Emprestimos, Reseed, 0)

DELETE FROM Amigos
DBCC CHECKIDENT (Amigos, Reseed, 0)

DELETE FROM Revistas
DBCC CHECKIDENT (Revistas, Reseed, 0)