drop table Belepes;
drop table Vasarlas_Termek;
 drop table Vasarlas;
 drop table Termek;
drop table CsoportEdzes;
 drop table Terem;
 drop table EdzesTipus;
drop table Berlet;
 drop table Alkalmazott;
 drop table Kliens;
 drop table BerletTipus;


create table Terem(
    id integer primary key,
    szeles number,
    magas number,
    hossz number,
    nr integer
);

create table EdzesTipus(
    id integer primary key,
    nev varchar2(25),
    hossza_perc integer,
    max_letszam integer
);

create table Alkalmazott(
    id integer primary key,
    v_nev varchar2(25),
    k_nev varchar2(25),
    szuletes_nap date,
    felvettek date,
    tel varchar2(10),
    email varchar2(25)
);

create table Kliens(
    id integer primary key,
    v_nev varchar2(25),
    k_nev varchar2(25),
    szuletes_nap date,
    regisztralt date, 
    tel varchar2(10),
    email varchar2(25)
);

create table BerletTipus(
    id integer primary key,
    ar integer,
    alkalmak integer,
    honapok integer,
    nev varchar2(25)
);

create table Berlet(
    id integer primary key,
    alkalmazott_id integer not null,
    tipus_id integer,
    kliens_id integer not null,
    datum date,
    foreign key (alkalmazott_id) references Alkalmazott(id),
    foreign key (tipus_id) references BerletTipus(id),
    foreign key (kliens_id) references Kliens(id)
);

create table CsoportEdzes(
    id integer primary key,
    terem_id integer not null,
    tipus_id integer not null,
    alkalmazott_id integer not null,
    idopont date,
    foreign key (terem_id) references Terem(id),
    foreign key (tipus_id) references EdzesTipus(id),
    foreign key (alkalmazott_id) references Alkalmazott(id)
);

create table Belepes(
    id integer primary key,
    kliens_id integer not null,
    csoport_id integer not null,
    belepett date,
    foreign key (kliens_id) references Kliens(id),
    foreign key (csoport_id) references CsoportEdzes(id)
);

create table Vasarlas(
    id integer primary key,
    kliens_id integer not null,
    alkalmazott_id integer not null,
    datum date,
    foreign key (kliens_id) references Kliens(id),
    foreign key (alkalmazott_id) references Alkalmazott(id)
);

create table Termek(
    id integer primary key,
    nev varchar2(25),
    ar integer
);

CREATE TABLE Vasarlas_Termek(
    v_id integer NOT NULL,
    t_id integer NOT NULL,
    menyiseg integer,
    foreign key (v_id) REFERENCES Vasarlas(id), 
    foreign key (t_id) REFERENCES Termek(id)
);


INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 1, 15, 2.5, 20, 11);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 2, 10, 3, 20, 12);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 3, 10, 2.7, 25, 13);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 4, 20, 3, 20, 14);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 5, 10, 3, 30, 15);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 6, 15, 2.5, 20, 21);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 7, 10, 3, 20, 22);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 8, 10, 2.7, 25, 23);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 9, 20, 3, 20, 24);
INSERT INTO Terem ( id, szeles, magas, hossz, nr ) VALUES ( 10, 10, 3, 30, 25);


INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 1, 'Eroedzes-Kezdo', 60, 6);
INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 2, 'Eroedzes-Halado', 60, 12);
INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 3, 'Zumba', 60, 15);
INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 4, 'Sparthan', 60, 12);
INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 5, 'Crossfit-Kezdo', 45, 8);
INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 6, 'Crossfit-Halado', 45, 6);
INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 7, 'StreetWorkout', 60, 14);
INSERT INTO EdzesTipus( id, nev, hossza_perc, max_letszam) VALUES ( 8, 'Calisthenics', 60, 14);


INSERT INTO Alkalmazott( id, v_nev, k_nev, szuletes_nap, felvettek, tel, email)
VALUES (1, 'Katona', 'Ferenc', TO_Date( '02/11/1995', 'MM/DD/YYYY'), TO_Date( '12/10/2019', 'MM/DD/YYYY'), '7561234598', 'katonaf95@gmail.com' );
INSERT INTO Alkalmazott( id, v_nev, k_nev, szuletes_nap, felvettek, tel, email)
VALUES (2, 'Jozsa', 'Emese', TO_Date( '03/10/1987', 'MM/DD/YYYY'), TO_Date( '12/10/2018', 'MM/DD/YYYY'), '7563322518', 'emijozsa@yahoo.com' );
INSERT INTO Alkalmazott( id, v_nev, k_nev, szuletes_nap, felvettek, tel, email)
VALUES (3, 'Cseke', 'Attila', TO_Date( '03/06/1997', 'MM/DD/YYYY'), TO_Date( '01/07/2019', 'MM/DD/YYYY'), '7331221548', 'cseke97@gmail.com' );
INSERT INTO Alkalmazott( id, v_nev, k_nev, szuletes_nap, felvettek, tel, email)
VALUES (4, 'Nagy', 'Julia', TO_Date( '11/04/2000', 'MM/DD/YYYY'), TO_Date( '01/01/2021', 'MM/DD/YYYY'), '7231823348', 'julia_nagy@gmail.com' );


--1---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont)               --ero-edzes
VALUES( 1, 4, 1, 1, TO_Date( '10/05/2020 08:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont) 
VALUES( 2, 5, 2, 2, TO_Date( '10/05/2020 06:00:00 PM', 'MM/DD/YYYY HH:MI:SS PM'));

INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont)               --zumba
VALUES( 3, 6, 3, 4, TO_Date( '10/05/2020 10:00:00 PM', 'MM/DD/YYYY HH:MI:SS PM'));

INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont)               --cross-fit
VALUES( 4, 4, 5, 3, TO_Date( '10/07/2020 08:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont)
VALUES( 5, 5, 6, 3, TO_Date( '10/07/2020 06:00:00 PM', 'MM/DD/YYYY HH:MI:SS PM'));

INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont)               --zumba
VALUES( 6, 6, 3, 4, TO_Date( '10/07/2020 10:00:00 PM', 'MM/DD/YYYY HH:MI:SS PM'));

INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont)               --ero-edzes
VALUES( 7, 4, 1, 1, TO_Date( '10/09/2020 08:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'));
INSERT INTO CsoportEdzes( id, terem_id, tipus_id, alkalmazott_id, idopont) 
VALUES( 8, 5, 2, 1, TO_Date( '10/09/2020 10:00:00 PM', 'MM/DD/YYYY HH:MI:SS PM'));


--1---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 1, 120, NULL, 1, 'Berlet1');
INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 2, 200, NULL, 2, 'Berlet2');
INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 3, 100, 8, NULL, 'Berlet3');
INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 4, 200, 16, NULL, 'Berlet4');
INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 5, 100, NULL, 1, 'DiakBerlet1');
INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 6, 160, NULL, 2, 'DiakBerlet2');
INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 7, 80, 8, NULL, 'DiakBerlet3');
INSERT INTO BerletTipus( id, ar, alkalmak, honapok, nev ) VALUES ( 8, 160, 16, NULL, 'DiakBerlet4');


INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (1, 'Katona', 'Lajos', TO_Date( '02/11/1995', 'MM/DD/YYYY'), TO_Date( '10/05/2020', 'MM/DD/YYYY'), '7551234592', 'katonaf95@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (2, 'Marton', 'Kata', TO_Date( '02/11/1992', 'MM/DD/YYYY'), TO_Date( '10/05/2020', 'MM/DD/YYYY'), '7531234548', 'mkatalin@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (3, 'Gal', 'Lajos', TO_Date( '02/11/1989', 'MM/DD/YYYY'), TO_Date( '09/25/2020', 'MM/DD/YYYY'), '7464334598', 'galll@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (4, 'Szoke', 'Levente', TO_Date( '02/11/1999', 'MM/DD/YYYY'), TO_Date( '09/28/2020', 'MM/DD/YYYY'), '7561354533', 'levi_szoke@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (5, 'Szocs', 'Tamas', TO_Date( '02/11/2000', 'MM/DD/YYYY'), TO_Date( '09/25/2020', 'MM/DD/YYYY'), '7833334553', 'tomika2000@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (6, 'Kiss', 'Janos', TO_Date( '12/10/2001', 'MM/DD/YYYY'), TO_Date( '09/29/2020', 'MM/DD/YYYY'), '7833334553', 'caki@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (7, 'Lorincz', 'Bela', TO_Date( '02/01/1993', 'MM/DD/YYYY'), TO_Date( '10/01/2020', 'MM/DD/YYYY'), '7833334553', 'lbela@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (8, 'Jakab', 'Tamas', TO_Date( '04/10/1994', 'MM/DD/YYYY'), TO_Date( '10/02/2020', 'MM/DD/YYYY'), '7833334553', 'random1@gmail.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (9, 'Szocs', 'Szilard', TO_Date( '06/10/1989', 'MM/DD/YYYY'), TO_Date( '08/25/2021', 'MM/DD/YYYY'), '7833334553', 'random12@yahoo.com' );
INSERT INTO Kliens( id, v_nev, k_nev, szuletes_nap, regisztralt, tel, email)
VALUES (10, 'Balint', 'Tamas', TO_Date( '02/21/2004', 'MM/DD/YYYY'), TO_Date( '09/25/2020', 'MM/DD/YYYY'), '7833334553', 'random3@gmail.com' );


INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (1, 1, 1, 1, TO_Date( '10/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (2, 1, 1, 1, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (3, 1, 1, 2, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (4, 1, 1, 3, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (5, 1, 1, 4, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (6, 1, 1, 5, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (7, 1, 1, 6, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (8, 1, 1, 7, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (9, 1, 1, 8, TO_Date( '11/01/2020', 'MM/DD/YYYY'));
INSERT INTO Berlet( id, alkalmazott_id, tipus_id, kliens_id, datum )
VALUES (10, 1, 1, 9, TO_Date( '11/01/2020', 'MM/DD/YYYY'));


--2---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--147
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (1, 1, 1, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (2, 6, 1, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (3, 3, 1, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (4, 7, 1, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (5, 5, 1, TO_Date( '10/05/2020', 'MM/DD/YYYY'));

INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (6, 6, 2, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (7, 2, 2, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (8, 8, 2, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (9, 9, 2, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (10, 10, 2, TO_Date( '10/05/2020', 'MM/DD/YYYY'));

--152
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (11, 1, 3, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (12, 7, 3, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (13, 3, 3, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (14, 8, 3, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (15, 5, 3, TO_Date( '10/05/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (16, 2, 3, TO_Date( '10/05/2020', 'MM/DD/YYYY'));

--155
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (17, 1, 4, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (18, 6, 4, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (19, 3, 4, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (20, 7, 4, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (21, 5, 4, TO_Date( '10/07/2020', 'MM/DD/YYYY'));

INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (22, 6, 5, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (23, 2, 5, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (24, 8, 5, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (25, 9, 5, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (26, 10, 5, TO_Date( '10/07/2020', 'MM/DD/YYYY'));

--160
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (27, 1, 6, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (28, 7, 6, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (29, 3, 6, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (30, 8, 6, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (31, 5, 6, TO_Date( '10/07/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (32, 2, 6, TO_Date( '10/07/2020', 'MM/DD/YYYY'));

--163
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (33, 1, 7, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (34, 8, 7, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (35, 3, 7, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (36, 7, 7, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (37, 5, 7, TO_Date( '10/09/2020', 'MM/DD/YYYY'));

INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (38, 6, 8, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (39, 2, 8, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (40, 8, 8, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (41, 9, 8, TO_Date( '10/09/2020', 'MM/DD/YYYY'));
INSERT INTO Belepes( id, kliens_id, csoport_id, belepett ) VALUES (42, 10, 8, TO_Date( '10/09/2020', 'MM/DD/YYYY'));


--2---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO Termek( id, nev, ar ) VALUES (1, 'Kettlebell 4kg', 60);
INSERT INTO Termek( id, nev, ar ) VALUES (2, 'Kettlebell 8kg', 115);
INSERT INTO Termek( id, nev, ar ) VALUES (3, 'Kettlebell 16kg', 185);
INSERT INTO Termek( id, nev, ar ) VALUES (4, 'Edzokesztyu S', 50);
INSERT INTO Termek( id, nev, ar ) VALUES (5, 'Edzokesztyu M', 50);
INSERT INTO Termek( id, nev, ar ) VALUES (6, 'Edzokesztyu L', 50);
INSERT INTO Termek( id, nev, ar ) VALUES (7, 'Gumiszalag 5kg', 15);
INSERT INTO Termek( id, nev, ar ) VALUES (8, 'Gumiszalag 15kg', 25);
INSERT INTO Termek( id, nev, ar ) VALUES (9, 'Gumiszalag 25kg', 35);
INSERT INTO Termek( id, nev, ar ) VALUES (10, '100% Whey protein 2kg', 200);
INSERT INTO Termek( id, nev, ar ) VALUES (11, '100% Whey protein 1kg', 120);
INSERT INTO Termek( id, nev, ar ) VALUES (12, 'Multivitamin 30 pac', 95);   


INSERT INTO Vasarlas( id, kliens_id, alkalmazott_id, datum )
VALUES (1, 1, 1, TO_Date( '12/24/2020', 'MM/DD/YYYY'));
INSERT INTO Vasarlas( id, kliens_id, alkalmazott_id, datum )
VALUES (2, 2, 1, TO_Date( '11/23/2020', 'MM/DD/YYYY'));
INSERT INTO Vasarlas( id, kliens_id, alkalmazott_id, datum )
VALUES (3, 3, 1, TO_Date( '12/06/2020', 'MM/DD/YYYY'));
INSERT INTO Vasarlas( id, kliens_id, alkalmazott_id, datum )
VALUES (4, 4, 1, TO_Date( '11/16/2020', 'MM/DD/YYYY'));
INSERT INTO Vasarlas( id, kliens_id, alkalmazott_id, datum )
VALUES (5, 5, 1, TO_Date( '11/15/2020', 'MM/DD/YYYY'));
INSERT INTO Vasarlas( id, kliens_id, alkalmazott_id, datum )
VALUES (6, 6, 1, TO_Date( '11/15/2020', 'MM/DD/YYYY'));


INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (1, 3, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (1, 11, 2);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (1, 12, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (2, 6, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (2, 7, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (2, 10, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (2, 12, 2);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (3, 12, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (3, 10, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (4, 9, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (4, 1, 2);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (5, 3, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (5, 5, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (5, 10, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (5, 12, 2);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (6, 3, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (6, 11, 2);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (6, 5, 1);
INSERT INTO Vasarlas_Termek( v_id, t_id, menyiseg ) VALUES (6, 12, 2);


commit;