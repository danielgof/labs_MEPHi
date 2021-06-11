CREATE TABLE calendar (
    id_calendar      INTEGER NOT NULL,
    name_of_race     VARCHAR2(32 CHAR) NOT NULL,
    num_among_races  INTEGER NOT NULL,
    date_of_race     DATE NOT NULL,
    place_of_race    VARCHAR2(32 CHAR) NOT NULL,
    id_country       INTEGER NOT NULL
);

ALTER TABLE calendar ADD CONSTRAINT calendar_pk PRIMARY KEY ( id_calendar );

ALTER TABLE calendar ADD CONSTRAINT calendar_num_un UNIQUE ( num_among_races );

ALTER TABLE calendar ADD CONSTRAINT calenda_un UNIQUE ( id_country );

CREATE TABLE country (
    id_country       INTEGER NOT NULL,
    name_of_country  VARCHAR2(32 CHAR) NOT NULL
);

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( id_country );

CREATE TABLE racers (
    id_racers      INTEGER NOT NULL,
    family_name    VARCHAR2(32 CHAR) NOT NULL,
    name           VARCHAR2(32 CHAR) NOT NULL,
    date_of_birth  DATE NOT NULL,
    num_of_wins    INTEGER NOT NULL,
    driver_num     INTEGER NOT NULL CHECK(driver_num > 0),
    id_country     INTEGER NOT NULL
);

ALTER TABLE racers ADD CONSTRAINT racers_pk PRIMARY KEY ( id_racers );

CREATE TABLE results (
    id_results              INTEGER NOT NULL,
    position_in_race        INTEGER NOT NULL,
    sum_of_points           INTEGER NOT NULL,
    time_of_race            DATE NOT NULL,
    num_of_circles_in_lead  INTEGER NOT NULL,
    id_teams                INTEGER NOT NULL,
    id_racers               INTEGER NOT NULL,
    id_calendar             INTEGER NOT NULL
);

ALTER TABLE results ADD CONSTRAINT results_pk PRIMARY KEY ( id_results );

ALTER TABLE results ADD CONSTRAINT results_un UNIQUE ( id_calendar,
                                                       id_racers );

CREATE TABLE teams (
    id_teams           INTEGER NOT NULL,
    name_of_team       VARCHAR2(32 CHAR) NOT NULL,
    engine_motherland  VARCHAR2(32 BYTE) NOT NULL,
    id_country         INTEGER NOT NULL
);

ALTER TABLE teams ADD CONSTRAINT teams_pk PRIMARY KEY ( id_teams );

ALTER TABLE calendar
    ADD CONSTRAINT calendar_country_fkv2 FOREIGN KEY ( id_country )
        REFERENCES country ( id_country );

ALTER TABLE racers
    ADD CONSTRAINT racers_country_fk FOREIGN KEY ( id_country )
        REFERENCES country ( id_country );

ALTER TABLE results
    ADD CONSTRAINT results_calendar_fkv2 FOREIGN KEY ( id_calendar )
        REFERENCES calendar ( id_calendar );

ALTER TABLE results
    ADD CONSTRAINT results_racers_fk FOREIGN KEY ( id_racers )
        REFERENCES racers ( id_racers );

ALTER TABLE results
    ADD CONSTRAINT results_teams_fk FOREIGN KEY ( id_teams )
        REFERENCES teams ( id_teams );

ALTER TABLE teams
    ADD CONSTRAINT teams_country_fk FOREIGN KEY ( id_country )
        REFERENCES country ( id_country );
        
        
        
        
CREATE SEQUENCE country_id_seq INCREMENT BY 2 START WITH 2 NOCYCLE ORDER 
    MAXVALUE 500;
    
    
INSERT INTO country VALUES (country_id_seq.nextval, 'Germany');
INSERT INTO country VALUES (country_id_seq.nextval, 'France');
INSERT INTO country VALUES (country_id_seq.nextval, 'Australia');
INSERT INTO country VALUES (country_id_seq.nextval, 'Italy');
INSERT INTO country VALUES (country_id_seq.nextval, 'Great Britan');




CREATE SEQUENCE id_calendar_seq INCREMENT BY 2 START WITH 2 NOCYCLE ORDER
    MAXVALUE 150;


INSERT INTO calendar VALUES (id_calendar_seq.nextval, 'Red Bull Ring', 1,
    to_date('05.06.2020', 'DD.MM.YYYY'), 'Spiebelrg',
    (SELECT id_country FROM country WHERE name_of_country = 'Australia'));
INSERT INTO calendar VALUES (id_calendar_seq.nextval, 'Hockenheimring Baden-W?rttemberg', 2,
    to_date('19.06.2020', 'DD.MM.YYYY'), 'Baden-W?rttemberg',
    (SELECT id_country FROM country WHERE name_of_country = 'Germany'));
INSERT INTO calendar VALUES (id_calendar_seq.nextval, 'Spa-Francorchamps', 3,
    to_date('02.07.2020', 'DD.MM.YYYY'), 'Francorchamps',
    (SELECT id_country FROM country WHERE name_of_country = 'France'));
INSERT INTO calendar VALUES (id_calendar_seq.nextval, 'Hungaroring', 4,
    to_date('16.07.2020', 'DD.MM.YYYY'), 'Modernod',
    (SELECT id_country FROM country WHERE name_of_country = 'Italy'));
INSERT INTO calendar VALUES (id_calendar_seq.nextval, 'Silverstone', 5,
    to_date('30.07.2020', 'DD.MM.YYYY'), 'Silverstone',
    (SELECT id_country FROM country WHERE name_of_country = 'Great Britan'));

    
    
    
    
CREATE SEQUENCE teams_id_seq INCREMENT BY 2 START WITH 2 NOCYCLE ORDER
    MAXVALUE 200;
    
    
INSERT INTO teams VALUES (teams_id_seq.nextval, 'Aston Martin', 'Japan',
    (SELECT id_country FROM country WHERE name_of_country = 'Great Britan')); 
INSERT INTO teams VALUES (teams_id_seq.nextval, 'Ferrari', 'Germany',
    (SELECT id_country FROM country WHERE name_of_country = 'Italy')); 
INSERT INTO teams VALUES (teams_id_seq.nextval, 'Reno', 'Australia',
    (SELECT id_country FROM country WHERE name_of_country = 'France'));     
INSERT INTO teams VALUES (teams_id_seq.nextval, 'Mercedes', 'Germany',
    (SELECT id_country FROM country WHERE name_of_country = 'Germany'));     
INSERT INTO teams VALUES (teams_id_seq.nextval, 'Luzzi', 'Japan',
    (SELECT id_country FROM country WHERE name_of_country = 'Australia'));  
    
    
    
SELECT * FROM teams


CREATE SEQUENCE racers_id_seq INCREMENT BY 2 START WITH 2 NOCYCLE ORDER
    MAXVALUE 200;
    
INSERT INTO racers VALUES (racers_id_seq.nextval, 'Vettel', 'Sebastian',
     to_date('03.07.1987', 'DD.MM.YYYY'), 1, 35,
    (SELECT id_country FROM country WHERE name_of_country = 'Germany'));
INSERT INTO racers VALUES (racers_id_seq.nextval, 'Ricardo', 'Daniel',
     to_date('17.10.1979', 'DD.MM.YYYY'), 1, 22,
    (SELECT id_country FROM country WHERE name_of_country = 'Australia'));
INSERT INTO racers VALUES (racers_id_seq.nextval, 'Gasly', 'Pierre',
     to_date('02.07.1996', 'DD.MM.YYYY'), 2, 16,
    (SELECT id_country FROM country WHERE name_of_country = 'France'));    
INSERT INTO racers VALUES (racers_id_seq.nextval, 'Raikkon', 'Kimmy',
     to_date('19.06.1979', 'DD.MM.YYYY'), 0, 67,
    (SELECT id_country FROM country WHERE name_of_country = 'Italy'));
INSERT INTO racers VALUES (racers_id_seq.nextval, 'Hamilton', 'Lewis',
     to_date('07.01.1985', 'DD.MM.YYYY'), 5, 1,
    (SELECT id_country FROM country WHERE name_of_country = 'Great Britan'));
INSERT INTO racers VALUES (racers_id_seq.nextval, 'Noris', 'Lando',
     to_date('13.11.1999', 'DD.MM.YYYY'), 5, 12,
    (SELECT id_country FROM country WHERE name_of_country = 'Great Britan'));

   
SELECT * FROM results
    
CREATE SEQUENCE results_id_seq INCREMENT BY 2 START WITH 2 NOCYCLE ORDER
    MAXVALUE 200;  
 
INSERT INTO results VALUES (results_id_seq.nextval, 2, 57, to_date('07.01.02', 'SS.MI.HH'), 1,
    (SELECT id_country FROM country WHERE name_of_country = 'Great Britan'),
    (SELECT id_racers FROM racers WHERE name = 'Lewis'),
    (SELECT id_calendar FROM calendar WHERE name_of_race = 'Silverstone'));  
INSERT INTO results VALUES (results_id_seq.nextval, 4, 45, to_date('07.15.02', 'SS.MI.HH'), 3,
    (SELECT id_country FROM country WHERE name_of_country = 'Italy'),
    (SELECT id_racers FROM racers WHERE name = 'Kimmy'),
    (SELECT id_calendar FROM calendar WHERE name_of_race = 'Spa-Francorchamps'));  
INSERT INTO results VALUES (results_id_seq.nextval, 4, 67, to_date('07.50.01', 'SS.MI.HH'), 4,
    (SELECT id_country FROM country WHERE name_of_country = 'Australia'),
    (SELECT id_racers FROM racers WHERE name = 'Daniel'),
    (SELECT id_calendar FROM calendar WHERE name_of_race = 'Hockenheimring Baden-W?rttemberg')); 
INSERT INTO results VALUES (results_id_seq.nextval, 1, 71, to_date('09.47.02', 'SS.MI.HH'), 5,
    (SELECT id_country FROM country WHERE name_of_country = 'France'),
    (SELECT id_racers FROM racers WHERE name = 'Pierre'),
    (SELECT id_calendar FROM calendar WHERE name_of_race = 'Hockenheimring Baden-W?rttemberg')); 
INSERT INTO results VALUES (results_id_seq.nextval, 3, 47, to_date('07.15.02', 'SS.MI.HH'), 2,
    (SELECT id_country FROM country WHERE name_of_country = 'Germany'),
    (SELECT id_racers FROM racers WHERE name = 'Sebastian'),
    (SELECT id_calendar FROM calendar WHERE name_of_race = 'Red Bull Ring')); 
INSERT INTO results VALUES (results_id_seq.nextval, 3, 0, to_date('07.15.02', 'SS.MI.HH'), 2,
    (SELECT id_country FROM country WHERE name_of_country = 'Great Britan'),
    (SELECT id_racers FROM racers WHERE name = 'Lando'),
    (SELECT id_calendar FROM calendar WHERE name_of_race = 'Red Bull Ring')); 


   
    
SELECT * FROM results
    
    
    
--0+

      
SELECT r.family_name, SUM(s.sum_of_points) FROM racers r, results s
    WHERE r.id_racers = s.id_results GROUP BY r.family_name;


--1+

SELECT name, (SELECT count(*) FROM results res WHERE res.id_racers = t.id_racers and position_in_race = 1)
    "COUNT" FROM racers t;

--2+

SELECT name_of_country, (SELECT cl.id_country FROM calendar cl WHERE cl.id_calendar = 
    (SELECT res.id_calendar FROM results res WHERE time_of_race = 
    (SELECT MIN(time_of_race) FROM results))) "MIN_TIME" FROM country;
    
    
--SELECT name_of_country, (SELECT name FROM (SELECT count(*) FROM results res WHERE res.id_racers = t.id_racers and MIN(time_of_race))
    --"COUNT" FROM racers t)) FROM country; 
    
--SELECT name, family_name, MIN(time_of_race), (SELECT COUNT(*) FROM results res WHERE res.id_racers = t.id_racers and position_in_race = 1 and HAVING MIN(time_of_race))
    --"COUNT" FROM racers t;

--SELECT min(time_of_race), (SELECT c.name_of_country from results r join teams t on r.id_teams = t.id_teams join country c on t.id_country = c.id_country) FROM results r;


--3+

DELETE FROM results res WHERE res.id_racers IN
    (SELECT id_racers FROM (SELECT id_racers, SUM(sum_of_points) AS total_score FROM results GROUP BY id_racers) 
    WHERE total_score IS NULL OR total_score=0);
        
--4+

UPDATE racers
	SET driver_num = driver_num + 1
WHERE driver_num > 12
 
--5+

ALTER TABLE teams ADD trophies integer
    
--6+

ALTER TABLE results ADD CONSTRAINT check_sum_of_points CHECK (sum_of_points < 25);


--trigers

DROP TRIGGER racers_bd; 

   -- 0
create trigger racers_bd
  before delete
  on racers
  for each row
declare
  sum_score_less_zero exception;
  v_sum_of_point_id          number;
begin

  select sum(sum_of_points)
    into v_sum_of_points_id
    from results r
    where r.id_racers = :old.id_racers
    group by id_racers;

  if v_sum_of_point_id > 0
  then
    raise sum_score_less_zero;
  end if;

exception
  when sum_score_less_zero then dbms_output.put_line('Íåëüçÿ óäàëèòü ãîíùèêà ó êîòîðîãî êîë-âî íàáðàííûõ î÷êîâ ïî ðåçóëüòàòàì ãðàí-ïðè = 0!');
end;
/





--0

CREATE OR REPLACE TRIGER update_cars
    FOR UPDATE OF driver_num ON results
    COMPOUND TRIGER
        upd_driver_num boolean;
        ndriver_num integer;
    BEFORE EACH ROW IS
        BEGIN
            NCARS :=: NEW.CAR;
            IF :old.id_racer=:NEW.id_racer AND :new.driver_num := old.driver_num
                AND :old.sum_of_points := 0 THEN
                upd_driver_num := TRUE;
        ELSE IF :OLD.SCORE > 0 THEN RAISE_APPLICATION_ERRROR(-2000, 'Íåëüçÿ ìåíÿòü íîìåð ìàøèíû');
            END IF;
        END IF;
    END BEFORE EACH ROW;
    AFTER STATEMENT IS
        BEGIN
        IF upd_driver_num THEN
            UPDATE results SET driver_num = ndriver_num;
        END IF;
    END AFTER STATEMENT;
END;
/
        
CREATE OR REPLACE TRIGGER delete_racers;
    AFTER DELETE ON racers
    FOR EACH ROW 
    DECLARE 
        score integer;
    BEGIN
        SELECT score INTO scores FROM results WHERE id_racers=:old.id_racers ORDER BY score 


--1



--2



--3



--4