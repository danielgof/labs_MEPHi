ALTER SESSION SET NLS_LANGUAGE = 'RUSSIAN'  ;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ',.';


CREATE TABLE countries ( 
    country_id    INTEGER NOT NULL, 
    country_name  VARCHAR2(128 CHAR) NOT NULL 
);

ALTER TABLE countries ADD CONSTRAINT countries_pk PRIMARY KEY ( country_id );

ALTER TABLE countries ADD CONSTRAINT countries_country_name_un UNIQUE ( country_name );

CREATE TABLE grand_prix ( 
    prix_id               INTEGER NOT NULL, 
    name                  VARCHAR2(128 CHAR) NOT NULL, 
    "number"              INTEGER NOT NULL, 
    "date"                DATE NOT NULL, 
    location              VARCHAR2(128 CHAR) NOT NULL, 
    countries_country_id  INTEGER NOT NULL 
);

ALTER TABLE grand_prix ADD CONSTRAINT grand_prix_pk PRIMARY KEY ( prix_id );

ALTER TABLE grand_prix ADD CONSTRAINT grand_prix_name_un UNIQUE ( name );

ALTER TABLE grand_prix ADD CONSTRAINT grand_prix_date_un UNIQUE ( "date" );

ALTER TABLE grand_prix ADD CONSTRAINT grand_prix_c_c_id_un UNIQUE ( countries_country_id );

ALTER TABLE grand_prix ADD CONSTRAINT grand_prix_number_un UNIQUE ( "number" );

CREATE TABLE racers ( 
    racer_id              INTEGER NOT NULL, 
    last_name             VARCHAR2(128 CHAR) NOT NULL, 
    first_name            VARCHAR2(128 CHAR) NOT NULL, 
    birthday              DATE NOT NULL, 
    victories             INTEGER, 
    countries_country_id  INTEGER NOT NULL, 
    teams_team_id         INTEGER NOT NULL, 
    car_number            INTEGER, 
    role                  INTEGER NOT NULL 
);

ALTER TABLE racers ADD CONSTRAINT racers_pk PRIMARY KEY ( racer_id );

ALTER TABLE racers 
    ADD CONSTRAINT racers_l_n_f_n_birth_un UNIQUE ( last_name, first_name, birthday );

CREATE TABLE results ( 
    result_id           INTEGER NOT NULL, 
    time                VARCHAR2(256 CHAR), 
    leading             INTEGER, 
    place               INTEGER, 
    score               INTEGER, 
    racers_racer_id     INTEGER NOT NULL, 
    grand_prix_prix_id  INTEGER NOT NULL 
);

ALTER TABLE results ADD CONSTRAINT results_pk PRIMARY KEY ( result_id );

ALTER TABLE results ADD CONSTRAINT results_grand_prix_prix_id_un UNIQUE ( grand_prix_prix_id, racers_racer_id );

CREATE TABLE teams ( 
    team_id               INTEGER NOT NULL, 
    name                  VARCHAR2(128 CHAR) NOT NULL, 
    motor                 VARCHAR2(128 CHAR) NOT NULL, 
    countries_country_id  INTEGER NOT NULL 
);

ALTER TABLE teams ADD CONSTRAINT teams_pk PRIMARY KEY ( team_id );

ALTER TABLE teams ADD CONSTRAINT teams_name_un UNIQUE ( name );

ALTER TABLE grand_prix 
    ADD CONSTRAINT grand_prix_countries_fk FOREIGN KEY ( countries_country_id ) 
        REFERENCES countries ( country_id );

ALTER TABLE racers 
    ADD CONSTRAINT racers_countries_fk FOREIGN KEY ( countries_country_id ) 
        REFERENCES countries ( country_id );

ALTER TABLE racers 
    ADD CONSTRAINT racers_teams_fk FOREIGN KEY ( teams_team_id ) 
        REFERENCES teams ( team_id );

ALTER TABLE results 
    ADD CONSTRAINT results_grand_prix_fk FOREIGN KEY ( grand_prix_prix_id ) 
        REFERENCES grand_prix ( prix_id );

ALTER TABLE results 
    ADD CONSTRAINT results_racers_fk FOREIGN KEY ( racers_racer_id ) 
        REFERENCES racers ( racer_id );

ALTER TABLE teams 
    ADD CONSTRAINT teams_countries_fk FOREIGN KEY ( countries_country_id ) 
        REFERENCES countries ( country_id );
        
        
        
        
        
        
        
        
        
          CREATE SEQUENCE country_id_seq INCREMENT BY 2 START WITH 2 NOCYCLE ORDER  
    MAXVALUE 500;

INSERT INTO countries VALUES (country_id_seq.nextval,'Germany');

INSERT INTO countries VALUES (country_id_seq.nextval,'France');

INSERT INTO countries VALUES (country_id_seq.nextval,'Austria');

INSERT INTO countries VALUES (country_id_seq.nextval,'Italy');

INSERT INTO countries VALUES (country_id_seq.nextval,'Great Britain');

INSERT INTO countries VALUES (country_id_seq.nextval,'Hungary');

INSERT INTO countries VALUES (country_id_seq.nextval,'Switzerland');

INSERT INTO countries VALUES (country_id_seq.nextval,'Monte Carlo');

INSERT INTO countries VALUES (country_id_seq.nextval,'Finland');

INSERT INTO countries VALUES (country_id_seq.nextval,'Belgium');

INSERT INTO countries VALUES (country_id_seq.nextval,'Spain');












CREATE SEQUENCE grand_prix_id_seq INCREMENT BY 3 START WITH 3 NOCYCLE ORDER  
    MAXVALUE 150;

INSERT INTO grand_prix VALUES (grand_prix_id_seq.nextval,'Red Bull Ring',1, 
    to_date('05.06.2020','DD.MM.YYYY'), 'Spielberg',  
    (SELECT country_id FROM countries WHERE country_name='Austria'));

INSERT INTO grand_prix VALUES (grand_prix_id_seq.nextval,'Hungaroring',3, 
    to_date('19.06.2020','DD.MM.YYYY') , 'Modernod', 
    (SELECT country_id FROM countries WHERE country_name='Hungary'));

INSERT INTO grand_prix VALUES (grand_prix_id_seq.nextval,'Silverstone',4, 
    to_date('02.07.2020','DD.MM.YYYY') , 'Silverstone',  
    (SELECT country_id FROM countries WHERE country_name='Great Britain'));

INSERT INTO grand_prix VALUES (grand_prix_id_seq.nextval,'Barcelona-Catalunya',5,  
    to_date('16.07.2020','DD.MM.YYYY'), 'Barcelona', 
    (SELECT country_id FROM countries WHERE country_name='Spain'));

INSERT INTO grand_prix VALUES (grand_prix_id_seq.nextval,'Spa-Francorchamps',7, 
    to_date('30.07.2020','DD.MM.YYYY'), 'Francorchamps', 
    (SELECT country_id FROM countries WHERE country_name='Belgium'));
    
    
    
    
    
    
    
    
    
    
  CREATE SEQUENCE teams_id_seq INCREMENT BY 7 START WITH 7 NOCYCLE ORDER  
    MAXVALUE 210;

INSERT INTO teams VALUES (teams_id_seq.nextval,'Mercedes','Mercedes M10 EQ', 
    (SELECT country_id FROM countries WHERE country_name='Germany'));

INSERT INTO teams VALUES (teams_id_seq.nextval,'Ferrari','Ferrari 064', 
    (SELECT country_id FROM countries WHERE country_name='Italy'));

INSERT INTO teams VALUES (teams_id_seq.nextval,'Red Bull','Honda RA620', 
    (SELECT country_id FROM countries WHERE country_name='Austria'));

INSERT INTO teams VALUES (teams_id_seq.nextval,'Renault','Renault RS30', 
    (SELECT country_id FROM countries WHERE country_name='France'));

INSERT INTO teams VALUES (teams_id_seq.nextval,'Willams','Mercedes M10 EQ', 
    (SELECT country_id FROM countries WHERE country_name='Great Britain'));

























CREATE SEQUENCE racers_id_seq INCREMENT BY 5 START WITH 5 NOCYCLE ORDER 
    MAXVALUE 500;

INSERT INTO racers VALUES (racers_id_seq.nextval,'Vettel','Sebastian', 
    to_date( '03.07.1987', 'DD.MM.YYYY'),35, 
    (SELECT country_id FROM countries WHERE country_name='Germany'), 
    (SELECT team_id FROM teams WHERE name='Mercedes'), 
    77777, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Hamilton','Lewis',  
    to_date( '07.01.1985', 'DD.MM.YYYY'),20, 
    (SELECT country_id FROM countries WHERE country_name='Great Britain'), 
    (SELECT team_id FROM teams WHERE name='Ferrari'), 
    12356, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Raikonen','Kimmi',  
    to_date( '17.10.1979', 'DD.MM.YYYY'),21, 
    (SELECT country_id FROM countries WHERE country_name='Finland'), 
    (SELECT team_id FROM teams WHERE name='Red Bull'), 
    65812, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Gasly','Pierre', 
    to_date( '07.02.1996', 'DD.MM.YYYY'),7, 
    (SELECT country_id FROM countries WHERE country_name='France'), 
    (SELECT team_id FROM teams WHERE name='Red Bull'), 
    2365841, 
    2 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Leclerc','Charles',  
    to_date( '16.10.1997', 'DD.MM.YYYY'),5, 
    (SELECT country_id FROM countries WHERE country_name='Monte Carlo'), 
    (SELECT team_id FROM teams WHERE name='Mercedes'), 
    21341136, 
    2 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Russell', 'George', 
    to_date( '15.02.1998', 'DD.MM.YYYY'),8, 
    (SELECT country_id FROM countries WHERE country_name='Great Britain'), 
    (SELECT team_id FROM teams WHERE name='Red Bull'), 
    89456, 
    1 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Norris','Lando',  
    to_date('13.11.1999', 'DD.MM.YYYY'),9, 
    (SELECT country_id FROM countries WHERE country_name='Great Britain'), 
    (SELECT team_id FROM teams WHERE name='Renault'), 
    236581, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Hulkenberg', 'Nico', 
    to_date( '19.08.1987', 'DD.MM.YYYY'),0, 
    (SELECT country_id FROM countries WHERE country_name='Germany'), 
    (SELECT team_id FROM teams WHERE name='Mercedes'),
    15684, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Riccardo','Daniel',  
    to_date('01.07.1989', 'DD.MM.YYYY'),0, 
    (SELECT country_id FROM countries WHERE country_name='Austria'), 
    (SELECT team_id FROM teams WHERE name='Mercedes'), 
    236478, 
    1 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Resta', 'Paul', 
    to_date( '16.04.1986', 'DD.MM.YYYY'),5, 
    (SELECT country_id FROM countries WHERE country_name='Great Britain'), 
    (SELECT team_id FROM teams WHERE name='Renault'), 
    23165, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Giovinazzi','Antonio', 
    to_date( '14.01.1993','DD.MM.YYYY'),4, 
    (SELECT country_id FROM countries WHERE country_name='Italy'), 
    (SELECT team_id FROM teams WHERE name='Willams'), 
    8945612, 
    2 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Luzzi', 'Vitantonio', 
    to_date( '16.07.1980' ,'DD.MM.YYYY'),12, 
    (SELECT country_id FROM countries WHERE country_name='Italy'), 
    (SELECT team_id FROM teams WHERE name='Mercedes'), 
    23489, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Grosjean', 'Romani', 
    to_date( '17.04.1986', 'DD.MM.YYYY'),17, 
    (SELECT country_id FROM countries WHERE country_name='Switzerland'), 
    (SELECT team_id FROM teams WHERE name='Ferrari'), 
    46824, 
    1 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Mitter', 'Gerhard', 
    to_date( '23.05.1994', 'DD.MM.YYYY'),28, 
    (SELECT country_id FROM countries WHERE country_name='Germany'), 
    (SELECT team_id FROM teams WHERE name='Willams'), 
    123648, 
    3 
    );

INSERT INTO racers VALUES (racers_id_seq.nextval,'Bottas', 'Valtteri', 
    to_date( '01.10.1983', 'DD.MM.YYYY'),21, 
    (SELECT country_id FROM countries WHERE country_name='Finland'), 
    (SELECT team_id FROM teams WHERE name='Ferrari'), 
    12380, 
    2 
    );














        
        
        CREATE SEQUENCE results_id_seq INCREMENT BY 7 START WITH 7 NOCYCLE ORDER 
    MAXVALUE 700000;

INSERT INTO  results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,17,330,1,7,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Vettel' 
        AND first_name='Sebastian' 
        AND birthday=to_date( '03.07.1987', 'DD.MM.YYYY')));  

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,27,339,0,8,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Hulkenberg' 
        AND first_name='Nico' 
        AND birthday=to_date( '19.08.1987', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Resta' 
        AND first_name='Paul' 
        AND birthday=to_date( '16.04.1986', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,3,307,2,3,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Hamilton' 
        AND first_name='Lewis'  
        AND birthday=to_date( '07.01.1985', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Norris' 
        AND first_name='Lando' 
        AND birthday=to_date('13.11.1999', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,12,314,0,4,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Riccardo' 
        AND first_name='Daniel' 
        AND birthday=to_date('01.07.1989', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,21,303,1,2,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Raikonen' 
        AND first_name='Kimmi' 
        AND birthday=to_date( '17.10.1979', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,5,320,0,5,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Mitter' 
        AND first_name='Gerhard' 
        AND birthday=to_date( '23.05.1994', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Bottas' 
        AND first_name='Valtteri' 
        AND birthday=to_date( '01.10.1983', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,10,349,0,10,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Gasly' 
        AND first_name='Pierre' 
        AND birthday=to_date( '07.02.1996', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,2,344,0,9,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Luzzi' 
        AND first_name='Vitantonio' 
        AND birthday=to_date( '16.07.1980' ,'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Grosjean' 
        AND first_name='Romani' 
        AND birthday=to_date( '17.04.1986', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,7,300,1,1,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Leclerc' 
        AND first_name='Charles' 
        AND birthday=to_date( '16.10.1997', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,22,329,0,6,
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Russell' 
        AND first_name='George' 
        AND birthday=to_date( '15.02.1998', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Red Bull Ring'),
    (SELECT racer_id FROM racers WHERE last_name='Giovinazzi' 
        AND first_name='Antonio' 
        AND birthday=to_date( '14.01.1993','DD.MM.YYYY')));














INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,17,300,1,1,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Vettel' 
        AND first_name='Sebastian' 
        AND birthday=to_date( '03.07.1987', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,27,359,0,7,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Hulkenberg' 
        AND first_name='Nico' 
        AND birthday=to_date( '19.08.1987', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Resta' 
        AND first_name='Paul' 
        AND birthday=to_date( '16.04.1986', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,3,351,2,6,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Hamilton' 
        AND first_name='Lewis' 
        AND birthday=to_date( '07.01.1985', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Norris' 
        AND first_name='Lando' 
        AND birthday=to_date('13.11.1999', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,12,364,0,8,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Riccardo' 
        AND first_name='Daniel' 
        AND birthday=to_date('01.07.1989', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,21,330,1,4,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Raikonen' 
        AND first_name='Kimmi' 
        AND birthday=to_date( '17.10.1979', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,5,341,0,5,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Mitter' 
        AND first_name='Gerhard' 
        AND birthday=to_date( '23.05.1994', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Bottas' 
        AND first_name='Valtteri' 
        AND birthday=to_date( '01.10.1983', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,10,384,0,10,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Gasly' 
        AND first_name='Pierre' 
        AND birthday=to_date( '07.02.1996', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,2,310,0,3,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Luzzi' 
        AND first_name='Vitantonio' 
        AND birthday=to_date( '16.07.1980' ,'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Grosjean' 
        AND first_name='Romani' 
        AND birthday=to_date( '17.04.1986', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,7,301,1,2,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Leclerc' 
        AND first_name='Charles' 
        AND birthday=to_date( '16.10.1997', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,22,374,0,9,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Russell' 
        AND first_name='George' 
        AND birthday=to_date( '15.02.1998', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL,
    (SELECT prix_id FROM grand_prix WHERE name = 'Hungaroring'),
    (SELECT racer_id FROM racers WHERE last_name='Giovinazzi' 
        AND first_name='Antonio' 
        AND birthday=to_date( '14.01.1993','DD.MM.YYYY')));
    
INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,17,346,1,6,
    (SELECT prix_id FROM grand_prix WHERE name = 'Silverstone'),
    (SELECT racer_id FROM racers WHERE last_name='Vettel' 
        AND first_name='Sebastian' 
        AND birthday=to_date( '03.07.1987', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,27,338,0,5,
    (SELECT prix_id FROM grand_prix WHERE name = 'Silverstone'),
    (SELECT racer_id FROM racers WHERE last_name='Hulkenberg' 
        AND first_name='Nico' 
        AND birthday=to_date( '19.08.1987', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Silverstone'),
    (SELECT racer_id FROM racers WHERE last_name='Resta' 
        AND first_name='Paul' 
        AND birthday=to_date( '16.04.1986', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,3,320,2,4,
    (SELECT prix_id FROM grand_prix WHERE name = 'Silverstone'),
    (SELECT racer_id FROM racers WHERE last_name='Hamilton' 
        AND first_name='Lewis' 
        AND birthday=to_date( '07.01.1985', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL,
    (SELECT prix_id FROM grand_prix WHERE name = 'Silverstone'),
    (SELECT racer_id FROM racers WHERE last_name='Norris' 
        AND first_name='Lando' 
        AND birthday=to_date('13.11.1999', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,12,313,0,3,
    (SELECT prix_id FROM grand_prix WHERE name = 'Silverstone'),
    (SELECT racer_id FROM racers WHERE last_name='Riccardo' 
        AND first_name='Daniel' 
        AND birthday=to_date('01.07.1989', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,21,350,1,7,
    (SELECT prix_id FROM grand_prix WHERE name = 'Silverstone'),
    (SELECT racer_id FROM racers WHERE last_name='Raikonen' 
        AND first_name='Kimmi' 
        AND birthday=to_date( '17.10.1979', 'DD.MM.YYYY')));
        
        
        
        
        
        
        
        
        
        
        
        
        
        INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,5,305,1,3,
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Mitter' 
        AND first_name='Gerhard' 
        AND birthday=to_date( '23.05.1994', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Bottas' 
        AND first_name='Valtteri' 
        AND birthday=to_date( '01.10.1983', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID)
  VALUES (results_id_seq.nextval,10,316,4,2,
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Gasly' 
        AND first_name='Pierre' 
        AND birthday=to_date( '07.02.1996', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,2,354,7,6,
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Luzzi' 
        AND first_name='Vitantonio' 
        AND birthday=to_date( '16.07.1980' ,'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Grosjean' 
        AND first_name='Romani' 
        AND birthday=to_date( '17.04.1986', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID)
  VALUES (results_id_seq.nextval,7,327,0,8,
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Leclerc' 
        AND first_name='Charles' 
        AND birthday=to_date( '16.10.1997', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, 0, NULL, 
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Russell' 
        AND first_name='George' 
        AND birthday=to_date( '15.02.1998', 'DD.MM.YYYY')));

INSERT INTO results(RESULT_ID ,TIME ,LEADING ,PLACE ,SCORE ,GRAND_PRIX_PRIX_ID,RACERS_RACER_ID) 
  VALUES (results_id_seq.nextval,NULL, NULL, NULL, NULL,
    (SELECT prix_id FROM grand_prix WHERE name = 'Spa-Francorchamps'),
    (SELECT racer_id FROM racers WHERE last_name='Giovinazzi' 
        AND first_name='Antonio' 
        AND birthday=to_date( '14.01.1993','DD.MM.YYYY')));
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        --0
select r.last_name,
       sum(res.score)
  from racers r,
       results res
  where r.racer_id = res.result_id
  group by r.last_name;

        
        
        
        
            --1
select name,
       (
         select count(*)
           from results res
             left join racers r
               on res.racers_racer_id = r.racer_id
           where r.teams_team_id = t.team_id
             and place = '1'
       ) "COUNT"
  from teams t;
  
  
  
  
  
  
  
  --2
select country_name
  from countries c
  where c.country_id in
    (
      select gp.countries_country_id
        from grand_prix gp
        where gp.prix_id in
          (
            select res.grand_prix_prix_id
              from results res
              where time =
                (
                  select min(time)
                    from results
                    where time > 0
                )
          )
    );
    
  
  
  
  
  
  
   --3
delete from results res
  where res.racers_racer_id in
    (
      select racers_racer_id
        from
        (
          select racers_racer_id,
                 sum(score) "total"
            from results
            group by racers_racer_id
        )
        where "total" is null
          or "total" = 0
    );







--4
update racers
  set
  car_number = car_number + 1
  where
  car_number > 12;
select *
  from racers;
  
  
  
  




--5
alter table teams add trophies integer;
select *
  from teams;
  
  
  
  
  
  
  
    --6
alter table results add constraint score_ch check (score < 26);
  
    
    
    
    
    
    
    
    
    
   -- 0
create trigger racers_bd
  before delete
  on racers
  for each row
declare
  sum_score_less_zero exception;
  v_score_id          number;
begin

  select sum(score)
    into v_score_id
    from results r
    where r.racers_racer_id = :old.racer_id
    group by racers_racer_id;

  if v_score_id > 0
  then
    raise sum_score_less_zero;
  end if;

exception
  when sum_score_less_zero then dbms_output.put_line('Нельзя удалить гонщика у которого кол-во набранных очков по результатам гран-при = 0!');
end;
/






create trigger racer_bu
  before update of car_number
  on racers
  for each row
declare
  sum_score_less_zero exception;
  v_score_id          number;
begin

  select sum(score)
    into v_score_id
    from results r
    where r.racers_racer_id = :old.racer_id
    group by racers_racer_id;

  if v_score_id > 0
  then
    raise sum_score_less_zero;
  end if;

exception
  when sum_score_less_zero then dbms_output.put_line('Нельзя удалить гонщика у которого кол-во набранных очков по результатам гран-при = 0!');
end;



delete from racers
  where racer_id = 115;


update racers
  set car_number = 11111
  where racer_id = 15;


update racers
  set car_number = 11111
  where racer_id = 5;


 DROP TRIGGER racers_bd; 

    
    
-- 1
create or replace function fn_get_racer_place(p_racer_id number)
  return number
  as
  begin
    for i in
    (
      select row_number() over (order by sum(rs.score) desc, rac.car_number asc) place,
             rs.racers_racer_id,
             sum(rs.score) ssum,
             rac.car_number
        from results rs
          left join racers rac
            on rs.racers_racer_id = rac.racer_id
        group by rs.racers_racer_id,
                 rac.car_number
        order by sum(rs.score) desc
    )
    loop
      if (p_racer_id = i.racers_racer_id)
      then
        return i.place;
      else
        null;
      end if;
    end loop;

  exception
    when others then null;

  end;


select fn_get_racer_place(115) from dual



select fn_get_racer_place(racer_id) from racers order by racer_id;

select fn_get_racer_place(racer_id) from racers where racer_id = 5;

select * from results where RACERS_RACER_ID = 5;

select * from racers;




-- 2
select avg(t.place) avg_place,
       t.first_name,
       t.name
  from
  (
    select row_number() over (partition by gp.name order by nvl(sum(rs.score), 0) desc, gp.name) place,
           rac.first_name,
           nvl(sum(rs.score), 0) ssum,
           gp.name
      from results rs
        left join grand_prix gp
          on rs.grand_prix_prix_id = gp.prix_id
        left join racers rac
          on rs.racers_racer_id = rac.racer_id
      group by rac.first_name,
               gp.name

      order by sum(rs.score) desc
  ) t

  group by t.first_name,
           t.name
  order by 1,
           3 asc;







-- 3
create view v_racers (
  last_name,
  first_name,
  victories,
  team_name,
  car_number
) as

    select distinct rac.last_name,
                    rac.first_name,
                    rac.victories,
                    t.name team_name,
                    rac.car_number
      from racers rac
        left join results r
          on rac.racer_id = r.racers_racer_id
        left join grand_prix gp
          on r.grand_prix_prix_id = gp.prix_id
        left join teams t
          on rac.teams_team_id = t.team_id;



create trigger v_racers_update
  instead of update
  on v_racers
  for each row
begin
  update racers
    set
    victories = :new.victories
    where
    last_name = :new.last_name
    and first_name = :new.first_name;
end;



update v_racers
  set
  victories = 777
  where
  last_name = 'Hamilton'
  and first_name = 'Lewis';
  
  
  
  
SELECT * FROM v_racers;

SELECT * FROM racers;





-- 4
create sequence seq_stack
start with 1000000000000000
increment by 1;

create table stack (
  id         number,
  data_stack varchar2(64) not null,
  constraint pk_stack_id primary key (id)
);

create or replace procedure proc_stack_init
  as
    v_count  number;
    v_str_no varchar2(200) := 'Не далось инифиализировать стек, т.к. стек пустой!';
  begin
    select count(*)
      into v_count
      from stack;

    if v_count = 0
    then
      dbms_output.put_line(v_str_no);
    else
      dbms_output.put_line('-- id --  | -- Данные --');
      for i in
      (
        select id,
               data_stack
          from stack
          order by id asc
      )
      loop
        dbms_output.put_line(i.id || ' | ' || i.data_stack);
      end loop;
    end if;
  end;


create or replace procedure proc_stack_top
  as
    v_count  number;
    v_str_no varchar2(200) := 'Не далось просмотреть вершину стека, т.к. стек пустой!';
  begin
    select count(*)
      into v_count
      from stack;

    if v_count = 0
    then
      dbms_output.put_line(v_str_no);
    else
      dbms_output.put_line('-- id --  | -- Данные --');
      for i in
      (
        select id,
               data_stack
          from stack
          order by id asc
        fetch first 5 rows only
      )
      loop
        dbms_output.put_line(i.id || ' | ' || i.data_stack);
      end loop;
    end if;
  end;


create or replace procedure proc_stack_emty
  as
    v_count   number;
    v_str_yes varchar2(100) := 'Стек успешно очищен!';
    v_str_no  varchar2(200) := 'Не далось очистить стек, т.к. стек пустой!';
  begin
    select count(*)
      into v_count
      from stack;

    if v_count = 0
    then
      dbms_output.put_line(v_str_no);
    else
      for i in
      (
        select min(id) min_id,
               max(id) max_id
          from stack
          order by id asc
      )
      loop
        delete from stack
          where id between i.min_id and i.max_id;

        dbms_output.put_line(v_str_yes);
      end loop;
    end if;
  end;


create or replace procedure proc_stack_pop
  as
    v_count   number;
    v_str_yes varchar2(100) := 'Верхний элемент стека удален!';
    v_str_no  varchar2(200) := 'Не далось удалить верхний элемент стека, т.к. стек пустой!';
  begin
    select count(*)
      into v_count
      from stack;

    if v_count = 0
    then
      dbms_output.put_line(v_str_no);
    else
      for i in
      (
        select min(id) min_id
          from stack
          order by id asc
      )
      loop
        delete from stack
          where id = i.min_id;

        dbms_output.put_line(v_str_yes);
      end loop;
    end if;
  end;


create or replace procedure proc_stack_push(p_stack_data varchar2)
  as
    v_lengh  number;
    v_count  number;
    v_min_id number;
    v_str    varchar2(100) := 'Данные успешно добавлены в стек!';
  begin

    v_lengh := length(p_stack_data);

    if p_stack_data is null
    then
      dbms_output.put_line('Вы не указали значение для добавления в стек!');
    elsif v_lengh > 64
    then
      dbms_output.put_line('Допустимая длинна данных - 64 символа! Длинна вашего данного - ' || v_lengh || ' символа.');
    else
      select count(id)
        into v_count
        from stack
        order by id asc;

      if v_count = 0
      then
        insert into stack
        values (seq_stack.nextval, p_stack_data);

        dbms_output.put_line(v_str);

      else
        select min(id)
          into v_min_id
          from stack
          order by id asc;

        insert into stack
        values (v_min_id - 1, p_stack_data);

        dbms_output.put_line(v_str);

      end if;

    end if;
  end;


create or replace procedure proc_stack(p_command    varchar2 default 'init', -- дейтсвия со стеком push/pop/empty/init/top
                                       p_stack_data varchar2 -- данные)
  as
  begin
    if p_command is not null
    then
      -- добавление элемента н авершину стека
      if p_command = 'push'
      then
        proc_stack_push(p_stack_data);

      --  удаление элемента с вершины стека
      elsif p_command = 'pop'
      then
        proc_stack_pop;

      --  очитска стека
      elsif p_command = 'empty'
      then
        proc_stack_emty;

      --  инициализация стека
      elsif p_command = 'init'
      then
        proc_stack_init;

      --  просмотр вершины стека
      elsif p_command = 'top'
      then
        proc_stack_top;

      else
        dbms_output.put_line('Вы указали неверную команду! Укажите одну из команд push/pop/empty/init/top');
      end if;
    else
      dbms_output.put_line('Введите название команды!');
    end if;
  end;


-- Вызов стека (пример)
begin
  proc_stack('init', ' вg 7777');
end;
