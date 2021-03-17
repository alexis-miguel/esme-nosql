-- TP1 Alexis DA CUNHA MIGUEL 

-- EXERCICE 1 -- 

-- Dans un premier temps, nous créons le répertoire elections

CREATE KEYSPACE elections
    WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor' : 1};

-- Créations des tables --

CREATE TABLE administre  (
	Nom_A text Primary KEY,
	Prenom_A text,
	Adresse text,
	NIN varint,


);

CREATE TABLE Candidat (
    Nom_P text ,
    Prenom_P text,
    Parti_politique text,
    nbr_vote int ,
    PRIMARY KEY (parti_politique,nbr_vote,nom_P),) 
    WITH CLUSTERING ORDER BY (nbr_vote desc); 


CREATE TABLE Vote  (
	Nom_A text,
	Nom_P text,
	PRIMARY KEY(Nom_A, Nom_P)
);

SELECT * FROM Candidat; 

-- INSERTIONS DES PERSONNES --

INSERT INTO Candidat (Nom_P , Prenom_P , Parti_politique , nbr_vote)
VALUES ('toto1', 'tot', 'A', 1);

INSERT INTO Candidat (Nom_P , Prenom_P , Parti_politique , nbr_vote)
VALUES ('toto2', 'tott', 'B', 2);

INSERT INTO Candidat (Nom_P , Prenom_P , Parti_politique , nbr_vote)
VALUES ('toto3', 'tottt', 'C', 4);

INSERT INTO Candidat (Nom_P , Prenom_P , Parti_politique , nbr_vote)
VALUES ('toto4', 'totttt', 'A', 2);



INSERT INTO administre (Nom_A, Prenom_A, Adresse, NIN)
VALUES ('Paul', 'Paulo', '15 avenue de paris', 1);

INSERT INTO administre (Nom_A, Prenom_A, Adresse, NIN)
VALUES ('Jacque', 'Jacqueo', '16 avenue de paris', 2);

INSERT INTO administre (Nom_A, Prenom_A, Adresse, NIN)
VALUES ('Bernard', 'Bernardo', '17 avenue de paris', 3);

INSERT INTO administre (Nom_A, Prenom_A, Adresse, NIN)
VALUES ('Marc', 'Marco', '18 avenue de paris', 4);



INSERT INTO Vote (NOM_A, NOM_P)
VALUES ('Paul', 'toto1');

INSERT INTO Vote (NOM_A, NOM_P)
VALUES ('Jacque', 'toto2');

INSERT INTO Vote (NOM_A, NOM_P)
VALUES ('Bernard', 'toto3');

INSERT INTO Vote (NOM_A, NOM_P)
VALUES ('Marc', 'toto4');

-- // 1. Quel parti politique a réuni le plus de voix ?

-- 1er méthode qui n'est pas optimisée 

SELECT * FROM Candidat WHERE parti_politique = 'A';
SELECT * FROM Candidat WHERE parti_politique = 'B';
SELECT * FROM Candidat WHERE parti_politique = 'C'; 

-- 2eme méthode optimisée

Select  parti_politique, sum(nbr_vote) from candidat group by parti_politique; 


-- //2. Quel candidat a gagné les élections ? --


SELECT MAX (nbr_vote),Nom_P,Prenom_P FROM candidat;


-- // 3. Le candidat ayant gagné les élections vient-il du parti politique ayant eu la majorité des voix ? --

SELECT MAX (nbr_vote),Nom_P,Prenom_P,Parti_politique FROM candidat;
SELECT parti_politique, sum(nbr_vote) FROM candidat GROUP BY parti_politique ;


--  EXERCICE 2 -- 


-- // 1. Quel est le parti politique ayant eu le plus de voix ?
-- // 2. Quel est le parti politique ayant eu le moins de voix ?

CREATE TABLE gagnant_candidat (
    Nom_C text ,
    Prenom_C text,
    Parti_politique text,
    nbr_vote int,
    commune text,
    PRIMARY KEY (parti_politique,nbr_vote),) 
    WITH CLUSTERING ORDER BY (nbr_vote desc); 


INSERT INTO gagnant_candidat (Nom_C , Prenom_C , Parti_politique , nbr_vote, commune)
VALUES ('lolo1', 'lol', 'A', 1, 'Trappes');

INSERT INTO gagnant_candidat (Nom_C , Prenom_C , Parti_politique , nbr_vote, commune)
VALUES ('lolo2', 'loll', 'B', 2, 'Poissy');

INSERT INTO gagnant_candidat (Nom_C , Prenom_C , Parti_politique , nbr_vote, commune)
VALUES ('lolo3', 'lolll', 'C', 3, 'Versailles');

INSERT INTO gagnant_candidat (Nom_C , Prenom_C , Parti_politique , nbr_vote, commune)
VALUES ('lolo4', 'lollll', 'A', 4, 'Rambouillet');


Select parti_politique, sum(nbr_vote) from gagnant_candidat group by parti_politique; 
