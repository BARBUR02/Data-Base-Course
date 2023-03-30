-- drop table log;
-- drop table reservation;
-- drop table person;
-- drop table trip;

-- 1 a)
-- First I filled database with mock data including DDL and DML
-- provided by class instructor, then
-- I created dict table countries which will in the future
-- be extension of TRIP table
create table countries
(
  country_id int generated always as identity not null,
  country_name varchar(50),
  constraint country_pk primary key ( country_id ) enable
);

-- 1 b)
-- I created procedure fill_unique_countries
-- which already prepared for me COUNTRIES table filled
-- with data corresponding to given mock data by instuctor
CREATE OR REPLACE PROCEDURE fill_unique_countries
IS
    c_count number;
BEGIN
    FOR i in (SELECT country FROM TRIP) LOOP
            SELECT COUNT(*) INTO c_count FROM COUNTRIES WHERE country_name=i.country;
            IF c_count=0 then
                insert into countries(country_name)
                values(i.country);
                dbms_output.Put_line('Country added : ' || i.country);
            end if;
    end loop;
end;

begin
    fill_unique_countries;
end;

-- 1 c)
-- I dropped all data excluding newly created COUNTRIES table
-- and changed DDL in order to meet the given requirements
-- (modifying data type of country column in TRIP table,
-- adding extra data to PERSON and RESERVATION table,
-- properly linking described tables (LOG table for the time only created
-- and linked -> no data included there yet) )

-- =======================================
drop table log;
drop table reservation;
drop table person;
drop table trip;

-- =======================================
-- DDL
create table person
(
  person_id int generated always as identity not null,
  firstname varchar(50),
  lastname varchar(50),
  constraint person_pk primary key ( person_id ) enable
);

create table trip
(
  trip_id int generated always as identity not null,
  trip_name varchar(100),
  country int,
  trip_date date,
  max_no_places int,
  constraint trip_pk primary key ( trip_id ) enable
);

alter table trip
add constraint trip_fk2 foreign key
( country ) references countries (country_id) enable;

create table reservation
(
  reservation_id int generated always as identity not null,
  trip_id int,
  person_id int,
  status char(1),
  constraint reservation_pk primary key ( reservation_id ) enable
);


alter table reservation
add constraint reservation_fk1 foreign key
( person_id ) references person ( person_id ) enable;

alter table reservation
add constraint reservation_fk2 foreign key
( trip_id ) references trip ( trip_id ) enable;

alter table reservation
add constraint reservation_chk1 check
(status in ('N','P','C')) enable;


create table log
(
	log_id int  generated always as identity not null,
	reservation_id int not null,
	log_date date  not null,
	status char(1),
	constraint log_pk primary key ( log_id ) enable
);

alter table log
add constraint log_chk1 check
(status in ('N','P','C')) enable;

alter table log
add constraint log_fk1 foreign key
( reservation_id ) references reservation ( reservation_id ) enable;

-- =======================================
-- 2.
-- inserting values

-- trip
insert into trip(trip_name, country, trip_date, max_no_places)
values ('Wycieczka do Paryza', 1, to_date('2022-09-12','YYYY-MM-DD'), 3);

insert into trip(trip_name, country, trip_date,  max_no_places)
values ('Piękny Kraków', 2, to_date('2023-07-03','YYYY-MM-DD'), 2);

insert into trip(trip_name, country, trip_date,  max_no_places)
values ('Znów do Francji', 1, to_date('2023-05-01','YYYY-MM-DD'), 2);

insert into trip(trip_name, country, trip_date,  max_no_places)
values ('Hel', 2, to_date('2023-05-01','YYYY-MM-DD'), 2);

-- =======================================

-- person
-- provided data

insert into person(firstname, lastname)
values ('Jan', 'Nowak');

insert into person(firstname, lastname)
values ('Jan', 'Kowalski');

insert into person(firstname, lastname)
values ('Jan', 'Nowakowski');

insert into person(firstname, lastname)
values ('Adam', 'Kowalski');

insert into person(firstname, lastname)
values  ('Novak', 'Nowak');

insert into person(firstname, lastname)
values ('Piotr', 'Piotrowski');

/* My data : */

insert into person( firstname, lastname)
values ('Jakub', 'Konieczny');

insert into person(firstname, lastname)
values ('Tomasz', 'Jackowski');

insert into person(firstname, lastname)
values ('Andzelika', 'Nowakowska');

insert into person(firstname, lastname)
values ('Kamil', 'Kaczmarczyk');

-- =======================================

-- reservation
-- trip 1
insert into reservation(trip_id, person_id, status)
values (1, 1, 'P');

insert into reservation(trip_id, person_id, status)
values (1, 2, 'C');

insert into reservation(trip_id, person_id, status)
values (1, 6, 'N');

-- trip 2
insert into reservation(trip_id, person_id, status)
values (2, 3, 'P');

insert into reservation(trip_id, person_id, status)
values (2, 4, 'C');

insert into reservation(trip_id, person_id, status)
values (2, 5, 'P');

-- trip 3
insert into reservation(trip_id, person_id, status)
values (3, 7, 'P');
insert into reservation(trip_id, person_id, status)
values (3, 8, 'P');

-- trip 4
insert into reservation(trip_id, person_id, status)
values (4, 9, 'P');
insert into reservation(trip_id, person_id, status)
values (4, 10, 'N');

-- =======================================

SELECT * FROm person;
SELECT * FROm trip;
SELECT * FROM RESERVATION;
SELECt * FROM LOG;
SELECT * FROm person;
SELECT * FROm countries;

-- =======================================

SELECT COUNT(*) FROM person;
SELECT COUNT(*) FROM reservation;
SELECT COUNT(*) FROM trip;

-- =======================================

-- 3. In order to create views and make future modifications
-- more conveniently function get_available_places(int tripID) is
-- created to calculate avaiable places based on tripID
CREATE OR REPLACE FUNCTION get_available_places(
    tripID number
) RETURN Number
IS
max_place_num number :=0;
booked_cnt number := 0;
BEGIN
    SELECT max_no_places INTO max_place_num FROM TRIP WHERE trip.trip_id=tripID;
    SELECT COUNT(*) INTO booked_cnt FROM reservation R inner join Trip T ON
        R.trip_id=T.trip_id
    WHERE status IN ('P','N') AND T.trip_id=tripID;
--     dbms_output.PUT_LINE('Trip ID: '|| tripID || 'max_place_num: ' || max_place_num || '  booked_cnt: '|| booked_cnt);
    RETURN max_place_num-booked_cnt;
end;

-- Testing function on our first 4 trips:
    BEGIN
    FOR i IN 1..4 LOOP
        dbms_output.PUT_LINE('Trip id: '||i||'  avaiable num of places: '|| get_available_places(i));
--         get_available_places(i);
        end loop;
    end;

-- =======================================
-- Creating views:
-- Reservations (country,trip_date,trip_name,firstname,lastname,reservation_id,status)
CREATE OR REPLACE VIEW Reservations AS
SELECT country_name AS COUNTRY,trip_date,trip_name,firstname,lastname,reservation_id,status
FROM reservation INNER JOIN person p on reservation.person_id = p.person_id
INNER JOIN TRIP T on reservation.trip_id = T.TRIP_ID
INNER JOIN COUNTRIES C on C.country_id=T.country;


-- Trips(country, trip_date, trip_name, no_places, no_available_places)
CREATE OR REPLACE VIEW Trips AS
SELECT  country_name,trip_date,trip_name,max_no_places as NO_PLACES,
    get_available_places(T.trip_id) AS NO_AVAILABLE_PLACES
    FROM TRIP T
        INNER  JOIN COUNTRIES C on C.country_id = T.country;

-- Available Trips(country, trip_date, trip_name, no_places, no_available_places)
CREATE OR REPLACE VIEW AvailableTrips AS
SELECT  * FROM Trips WHERE NO_AVAILABLE_PLACES>0 AND trip_date>CURRENT_DATE;


-- CREATE OR REPLACE VIEW AvailableTrips AS
-- SELECT  country_name,trip_date,trip_name,max_no_places as NO_PLACES,
--     get_available_places(T.trip_id) AS NO_AVAILABLE_PLACES
--     FROM TRIP T INNER  JOIN COUNTRIES C on C.country_id = T.country
--     WHERE get_available_places(T.trip_id)>0;

-- =======================================
SELECT * FROM AvailableTrips;
SELECT * FROM reservations;
SELECT * FROM TRIPs;

-- =======================================

-- 4. Creating procedures and functions
-- Trip Participants

-- Defining types :
CREATE OR REPLACE TYPE trip_participants_t as OBJECT
(
country varchar(50),
trip_date date,
trip_name varchar(100),
firstname varchar(50),
lastname varchar(50),
reservation_id int,
status char(1)
);

CREATE OR REPLACE TYPE trip_participants_table IS TABLE OF TRIP_PARTICIPANTS_T;

CREATE OR REPLACE FUNCTION  TripParticipants(tripID number)
    RETURN trip_participants_table
AS
    ret_tab trip_participants_table;
    row_counter int;
    no_trip_exception EXCEPTION ;
BEGIN
    SELECT COUNT(*) into row_counter FROM TRIP T
    WHERE T.trip_id=tripID;
    IF row_counter=0 THEN
        raise no_trip_exception;
    end if;
    SELECT trip_participants_t(country_name,trip_date,trip_name,firstname,lastname,reservation_id,status)
    BULK COLLECT INTO ret_tab FROM RESERVATION R INNER JOIN TRIP T ON T.trip_id=R.trip_id
    INNER JOIN PERSON P on P.person_id=R.person_id INNER JOIN COUNTRIES C on C.country_id = T.country
    WHERE T.trip_id=tripID;
    RETURN ret_tab;
exception
    when no_trip_exception then
        raise_application_error(-20001,'Given trip ID does not exist!');
        RAISE;
    when others then
        raise_application_error(-20001,'An error occured!');
        RAISE;
end;

--PersonReservations(person_id)
CREATE OR REPLACE FUNCTION  PersonReservations(personID number)
    RETURN trip_participants_table
AS
    ret_tab trip_participants_table;
    row_counter int;
    no_trip_exception EXCEPTION ;
BEGIN
    SELECT COUNT(*) into row_counter FROM Person P
    WHERE P.person_id=personID;
    IF row_counter=0 THEN
        raise no_trip_exception;
    end if;
    SELECT trip_participants_t(country_name,trip_date,trip_name,firstname,lastname,reservation_id,status)
    BULK COLLECT INTO ret_tab FROM RESERVATION R INNER JOIN TRIP T ON T.trip_id=R.trip_id
    INNER JOIN PERSON P on P.person_id=R.person_id INNER JOIN COUNTRIES C on C.country_id = T.country
    WHERE P.person_id=personID;
    RETURN ret_tab;

exception
    when no_trip_exception then
        raise_application_error(-20001,'Given person ID does not exist!');
        RAISE;
    when others then
        raise_application_error(-20001,'An error occured');
        RAISE;
end;


--     AvailableTrips(country, date_from, date_to)

DROP TYPE available_trip_table;
DROP TYPE available_trip_t;


CREATE OR REPLACE TYPE available_trip_t as OBJECT
(
    country_name varchar(50),
    trip_date date,
    trip_name varchar(100),
    max_no_places int,
    available_places int
);

CREATE OR REPLACE TYPE available_trip_table IS TABLE OF available_trip_t;

CREATE OR REPLACE FUNCTION AvailableTrips_F(country_n varchar , startDate date, endDate date)
    RETURN available_trip_table
IS
    ret_tab available_trip_table;
    invalidDate EXCEPTION;
BEGIN
    IF startDate>endDate then
        raise invalidDate;
    end if;

    SELECT available_trip_t( T.country_name, T.trip_date, T.trip_name, T.NO_PLACES, T.NO_AVAILABLE_PLACES)
    BULK COLLECT INTO ret_tab
    FROM  TRIPS T
    WHERE T.country_name=country_n AND startDate<= T.trip_date AND endDate>= T.trip_date;

    RETURN ret_tab;

    exception
        WHEN invalidDate THEN
            raise_application_error(-20001,'Incorrect dates');
            RAISE;
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20001,'No trips to given country scheduled');
            RAISE;
        WHEN OTHERS THEN
            raise_application_error(-20001,'Error Occured');
            RAISE;
end;

-- =======================================
-- Tests:
SELECT * FROM (TRIPPARTICIPANTS(3));
SELECT  * FROM (PersonReservations(1));
SELECT * FROM AvailableTrips_F('Francja','2023-04-04','2023-12-12');

SELECT * fROm TRIP



-- 5. Procedures
-- a) AddReservation(trip_id, person_id)

-- Helping function to determine if trip is in the future relatively
-- from today
CREATE FUNCTION Is_future(tripID int)
RETURN boolean
IS
    result int;
BEGIN
    SELECT COUNT(*) into result FROM TRIPS WHERE trip_date>=CURRENT_DATE;
    IF result > 0 then
        return True;
    end if;
    return FALSE;
end;

CREATE FUNCTION EXISTS_trip(tripID int)
RETURN boolean
AS
    result int;
BEGIN
    SELECT COUNT(*) into result FROM TRIP WHERE trip_id=tripID;
    IF result > 0 THEN
        return TRUE;
    end if;
    return False;
end;


CREATE FUNCTION EXISTS_person(personID int)
RETURN boolean
AS
    result int;
BEGIN
    SELECT COUNT(*) into result FROM PERSON WHERE person_id=personID;
    IF result > 0 THEN
        return TRUE;
    end if;
    return False;
end;

CREATE FUNCTION EXISTS_reservation(reservationID int)
RETURN boolean
AS
    result int;
BEGIN
    SELECT COUNT(*) into result FROM RESERVATION WHERE reservation_id=reservationID;
    IF result > 0 THEN
        return TRUE;
    end if;
    return False;
end;

-- Testing function
BEGIN
    FOR i in 1..4 LOOP
        IF IS_FUTURE(i) then
            dbms_output.PUT_LINE('Trip: '|| i || ' is OK');
        end if;
        end loop;
end;

-- a) AddReservation procedure:
CREATE OR REPLACE PROCEDURE AddReservation(tripID int, personID int)
as
    already_gone Exception ;
    already_booked Exception;
    person_err Exception ;
    trip_err Exception;
    resID int;
BEGIN
    IF NOT EXISTS_trip(tripID) THEN
        raise trip_err;
    end if;

    IF NOT EXISTS_person(personID) THEN
        raise person_err;
    end if;

    IF NOT IS_FUTURE(tripID) THEN
        raise already_gone;
    end if;
    IF GET_AVAILABLE_PLACES(tripID) =0 THEN
        raise already_booked;
    end if;

    INSERT INTO RESERVATION(trip_id, person_id, status) VALUES (tripID,personID,'N')
    returning reservation_id into resID;
--     sekwencja pobrac
    INSERT INTO LOG (reservation_id, log_date, status) VALUES (resID, CURRENT_DATE, 'N');
    DBMS_OUTPUT.PUT_LINE('Reservation added : '|| 'tripID :' || tripID || 'personID'|| personID);

    exception
        WHEN already_gone THEN
            raise_application_error(-20001,'This trip is not avaiable in the future (already ended)');
            RAISE;
        WHEN already_booked THEN
            raise_application_error(-20001,'This trip is not avaiable - all places booked');
            RAISE;
        WHEN trip_err THEN
            raise_application_error(-20001,'This trip doesnt exist');
            RAISE;
        WHEN person_err THEN
            raise_application_error(-20001,'This Person doesnt exist');
            RAISE;
        WHEN others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;




SELECT * FROM TRIP;
SELECT * FROM  RESERVATION;
SELECT * FROM TRIPS;

-- Preparing data for tests
UPDATE TRIP SET MAX_NO_PLACES=4
WHERE trip_id IN (3,4);


-- 5 b)
CREATE OR REPLACE PROCEDURE ModifyReservationStatus(reservationID int , statusC char )
AS
    tripID int;
    curr_status char(1);
    res_err EXCEPTION;
    status_err EXCEPTION;
    already_ok EXCEPTION ;
BEGIN
    SELECT trip_id, status into tripID,curr_status FROM Reservation WHERE reservation_id=reservationID;
    IF NOT EXISTS_reservation(reservationID) THEN
        RAISE res_err;
    end if;
    IF NOT statusC IN ('N', 'P', 'C') THEN
        RAISE status_err;
    end if;
    IF curr_status = statusC THEN
            raise already_ok;
    end if;
    IF statusC ='C' THEN
        update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
        INSERT INTO LOG (reservation_id, log_date, status) VALUES (reservationID, CURRENT_DATE, statusC);
    end if;
    IF statusC IN ('P','N') THEN
        IF curr_status IN ('P','N') THEN
            update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
            INSERT INTO LOG (reservation_id, log_date, status) VALUES (reservationID, CURRENT_DATE, statusC);
        else
            IF get_available_places(tripID)>0 THEN
            update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
            INSERT INTO LOG (reservation_id, log_date, status) VALUES (reservationID, CURRENT_DATE, statusC);
            end if;
        end if;
    end if;
    exception
        when status_err THEN
            raise_application_error(-20001,'Incorrect status given (possible: C N P)');
            RAISE;
        when res_err THEN
            raise_application_error(-20001,'Reservation of given ID doesnt exist');
            RAISE;
        when already_ok THEN
            raise_application_error(-20001,'Status already satisfied');
            RAISE;
        when others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;


--  5 c)
CREATE OR REPLACE PROCEDURE ModifyNoPlaces(tripID int, no_places int)
IS
    curr_max int;
    reduce_err EXCEPTION;
BEGIN
    SELECT max_no_places INTO curr_max FROM TRIP WHERE trip_id=tripID;
    IF (  no_places - curr_max) <= -(get_available_places(tripID)) THEN
        raise reduce_err;
    end if;
    UPDATE TRIP SET max_no_places=no_places WHERE trip_id=tripID;
    exception
        WHEN reduce_err THEN
            raise_application_error(-20001,'Cannot reduce below current reservation number');
            RAISE;
        WHEN OTHERS THEN
            raise_application_error(-20001,'An error occured');
            RAISE;
end;

--     Testing procedures :
SELECT * FROM Reservation;
BEGIN
    ModifyReservationStatus(3,'P');
end;
BEGIN
    ModifyNoPlaces(3,8);
end;
BEGIN
    AddReservation(2,6);
end;
BEGIN
    AddReservation(3,2);
end;

-- Zadanie 6
-- Testsing

SELECT * FROM PERSON;
SELECT * FROM LOG;
SELECT * FROM Reservations;
SELECT * FROM TRIPS;
SELECT * FROM TRip;
SELECT * FROm RESERVATION;


BEGIN
    AddReservation(4,3);
end;
BEGIN
    ModifyReservationStatus(22,'P');
end;

--  Zadanie 7
-- Suffiksujemy nowe prodecudy (usuwamy linie z logami )

CREATE OR REPLACE PROCEDURE ModifyReservationStatus2(reservationID int , statusC char )
AS
    tripID int;
    curr_status char(1);
    res_err EXCEPTION;
    status_err EXCEPTION;
    already_ok EXCEPTION ;
BEGIN
    SELECT trip_id, status into tripID,curr_status FROM Reservation WHERE reservation_id=reservationID;
    IF NOT EXISTS_reservation(reservationID) THEN
        RAISE res_err;
    end if;
    IF NOT statusC IN ('N', 'P', 'C') THEN
        RAISE status_err;
    end if;
    IF curr_status = statusC THEN
            raise already_ok;
    end if;
    IF statusC ='C' THEN
        update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
    end if;
    IF statusC IN ('P','N') THEN
        IF curr_status IN ('P','N') THEN
            update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
        else
            IF get_available_places(tripID)>0 THEN
            update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
            end if;
        end if;
    end if;
    exception
        when status_err THEN
            raise_application_error(-20001,'Incorrect status given (possible: C N P)');
            RAISE;
        when res_err THEN
            raise_application_error(-20001,'Reservation of given ID doesnt exist');
            RAISE;
        when already_ok THEN
            raise_application_error(-20001,'Status already satisfied');
            RAISE;
        when others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;


CREATE OR REPLACE PROCEDURE AddReservation2(tripID int, personID int)
as
    already_gone Exception ;
    already_booked Exception;
    person_err Exception ;
    trip_err Exception;
    resID int;
BEGIN
    IF NOT EXISTS_trip(tripID) THEN
        raise trip_err;
    end if;

    IF NOT EXISTS_person(personID) THEN
        raise person_err;
    end if;

    IF NOT IS_FUTURE(tripID) THEN
        raise already_gone;
    end if;
    IF GET_AVAILABLE_PLACES(tripID) =0 THEN
        raise already_booked;
    end if;

    INSERT INTO RESERVATION(trip_id, person_id, status) VALUES (tripID,personID,'N')
    returning reservation_id into resID;
--     sekwencja pobrac
    DBMS_OUTPUT.PUT_LINE('Reservation added : '|| 'tripID :' || tripID || 'personID'|| personID);

    exception
        WHEN already_gone THEN
            raise_application_error(-20001,'This trip is not avaiable in the future (already ended)');
            RAISE;
        WHEN already_booked THEN
            raise_application_error(-20001,'This trip is not avaiable - all places booked');
            RAISE;
        WHEN trip_err THEN
            raise_application_error(-20001,'This trip doesnt exist');
            RAISE;
        WHEN person_err THEN
            raise_application_error(-20001,'This Person doesnt exist');
            RAISE;
        WHEN others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;


CREATE OR REPLACE TRIGGER tr_update_log
    AFTER INSERT OR UPDATE
    ON RESERVATION
    FOR EACH ROW
BEGIN
    INSERT INTO LOG(reservation_id, log_date, status) VALUES
    (:NEW.reservation_id,current_date,:NEW.status);
end;

DROP TRIGGER tr_deletion_guard;
CREATE OR REPLACE TRIGGER tr_deletion_guard
    BEFORE DELETE
    ON RESERVATION
    FOR EACH ROW
BEGIN
    raise_application_error(-20001,'Records cannot be deleted ');
end;

BEGIN
    AddReservation2(3,10);
end;

BEGIN
    ModifyReservationStatus2(21,'P');
end;

SELECT * FROM  TRIPS;
SELECT * FROM TRIP;
SELECT * FROM Log;
SELECT * FROm RESERVATION;
DELETE FROM RESERVATION WHERE reservation_id=10;


-- ZADANIE 8
DROP PROCEDURE ModifyReservationStatus3;
CREATE OR REPLACE PROCEDURE ModifyReservationStatus3(reservationID int , statusC char )
AS
    tripID int;
    curr_status char(1);
    res_err EXCEPTION;
    status_err EXCEPTION;
    already_ok EXCEPTION ;
BEGIN
    SELECT trip_id, status into tripID,curr_status FROM Reservation WHERE reservation_id=reservationID;
    IF NOT EXISTS_reservation(reservationID) THEN
        RAISE res_err;
    end if;
    IF NOT statusC IN ('N', 'P', 'C') THEN
        RAISE status_err;
    end if;
    IF curr_status = statusC THEN
            raise already_ok;
    end if;
    IF statusC ='C' THEN
        update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
    end if;
    IF statusC IN ('P','N') THEN
        update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
    end if;
    exception
        when status_err THEN
            raise_application_error(-20001,'Incorrect status given (possible: C N P)');
            RAISE;
        when res_err THEN
            raise_application_error(-20001,'Reservation of given ID doesnt exist');
            RAISE;
        when already_ok THEN
            raise_application_error(-20001,'Status already satisfied');
            RAISE;
        when others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;

DROP PROCEDURE AddReservation3;
CREATE OR REPLACE PROCEDURE AddReservation3(tripID int, personID int)
as
    already_gone Exception ;
    person_err Exception ;
    trip_err Exception;
BEGIN
    IF NOT EXISTS_trip(tripID) THEN
        raise trip_err;
    end if;

    IF NOT EXISTS_person(personID) THEN
        raise person_err;
    end if;

    IF NOT IS_FUTURE(tripID) THEN
        raise already_gone;
    end if;

    INSERT INTO RESERVATION(trip_id, person_id, status) VALUES (tripID,personID,'N');
--     sekwencja pobrac
    DBMS_OUTPUT.PUT_LINE('Reservation added : '|| 'tripID :' || tripID || 'personID'|| personID);

    exception
        WHEN already_gone THEN
            raise_application_error(-20001,'This trip is not avaiable in the future (already ended)');
            RAISE;
        WHEN trip_err THEN
            raise_application_error(-20001,'This trip doesnt exist');
            RAISE;
        WHEN person_err THEN
            raise_application_error(-20001,'This Person doesnt exist');
            RAISE;
        WHEN others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;


DROP TRIGGER  tr_check_availability;
CREATE OR REPLACE TRIGGER tr_check_availability
    BEFORE INSERT OR UPDATE
    ON RESERVATION
    FOR EACH ROW
BEGIN
        IF :OLD.status NOT IN ('N','P') AND  NOT( (get_available_places(:NEW.trip_id)>0)) THEN
            raise_application_error(-20001,'No places available');
        end if;
end;

-- Tests
BEGIN
    ADDRESERVATION3(4,7);
end;



BEGIN
    DBMS_OUTPUT.PUT_LINE(get_available_places(4));
end;

BEGIN
    MODIFYRESERVATIONSTATUS3(42,'P');
end;

SELECT * FROM RESERVATION;
SELECT * FROm TRip;
SELECT * FROM LOG;
-- ZADANIE 9
-- Adding redundant information in table trip:
ALTER TABLE TRIP
ADD no_available_places int default 0 not null ;

SELECT * FROM TRIPs;
SELECT * FROm LOg;

-- Procedure to update column no_available_places
CREATE OR REPLACE PROCEDURE evaluate_new_value
IS
    cursor csr is (SELECT trip_id , get_available_places(trip_id) AS available FROM trip);
BEGIN
    FOR i in csr LOOP
        UPDATE TRIP SET trip.no_available_places = i.available
        WHERE trip_id=i.trip_id;
        end loop;
end;

SELECT * FROM TRIP;

--     Using function
BEGIN
    evaluate_new_value();
end;

SELECT * FROM TRIP;
SELECT * FROM TRIPS;



-- repairing views (making them more efficient and using extra position)
-- Trips(country, trip_date, trip_name, no_places, no_available_places)
CREATE OR REPLACE VIEW Trips4 AS
SELECT  country_name,trip_date,trip_name,max_no_places as NO_PLACES,
    no_available_places
    FROM TRIP T INNER  JOIN COUNTRIES C on C.country_id = T.country;

-- Available Trips(country, trip_date, trip_name, no_places, no_available_places)
CREATE OR REPLACE VIEW AvailableTrips4 AS
SELECT  country_name,trip_date,trip_name,max_no_places as NO_PLACES,
    no_available_places
    FROM TRIP T INNER  JOIN COUNTRIES C on C.country_id = T.country
    WHERE T.no_available_places>0 AND trip_date>CURRENT_DATE;


SELECT * FROM AvailableTrips4;
SELECT * FROM Trips4;

DROP PROCEDURE  ModifyReservationStatus4;
CREATE OR REPLACE PROCEDURE ModifyReservationStatus4(reservationID int , statusC char )
AS
    tripID int;
    availablePlaces int;
    curr_status char(1);
    res_err EXCEPTION;
    status_err EXCEPTION;
    already_ok EXCEPTION ;
    already_booked EXCEPTION ;
BEGIN
    SELECT trip_id, status into tripID,curr_status FROM Reservation WHERE reservation_id=reservationID;
    SELECT no_available_places INTO availablePlaces FROM TRIP WHERE trip_id=tripID;
    IF NOT EXISTS_reservation(reservationID) THEN
        RAISE res_err;
    end if;
    IF NOT statusC IN ('N', 'P', 'C') THEN
        RAISE status_err;
    end if;
    IF curr_status = statusC THEN
            raise already_ok;
    end if;
    IF statusC ='C' THEN
        update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
        UPDATE TRIP SET no_available_places=availablePlaces+1 WHERE trip_id=tripID;
    end if;
    IF statusC IN ('P','N') THEN
        IF curr_status IN ('P','N') THEN
            update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
        else
            IF availablePlaces>0 THEN
            update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
            UPDATE TRIP SET no_available_places=availablePlaces-1 WHERE trip_id=tripID;
            ELSE
                raise already_booked;
            end if;
        end if;
    end if;

    exception
        when status_err THEN
            raise_application_error(-20001,'Incorrect status given (possible: C N P)');
            RAISE;
        when res_err THEN
            raise_application_error(-20001,'Reservation of given ID doesnt exist');
            RAISE;
        when already_booked THEN
            raise_application_error(-20001,'No places available');
            RAISE;
        when already_ok THEN
            raise_application_error(-20001,'Status already satisfied');
            RAISE;
        when others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;


DROP PROCEDURE   AddReservation4;
CREATE OR REPLACE PROCEDURE AddReservation4(tripID int, personID int)
as
    already_gone Exception ;
    already_booked Exception;
    person_err Exception ;
    trip_err Exception;
    availablePlaces int;
BEGIN
    SELECT no_available_places INTO availablePlaces FROM TRIP WHERE trip_id=tripID;

    IF NOT EXISTS_trip(tripID) THEN
        raise trip_err;
    end if;

    IF NOT EXISTS_person(personID) THEN
        raise person_err;
    end if;

    IF NOT IS_FUTURE(tripID) THEN
        raise already_gone;
    end if;
    IF availablePlaces =0 THEN
        raise already_booked;
    end if;

    INSERT INTO RESERVATION(trip_id, person_id, status) VALUES (tripID,personID,'N');
    UPDATE TRIP SET no_available_places=availablePlaces-1 WHERE trip_id=tripID;
    DBMS_OUTPUT.PUT_LINE('Reservation added : '|| 'tripID :' || tripID || 'personID'|| personID);

    exception
       WHEN already_gone THEN
            DBMS_OUTPUT.PUT_LINE('This trip is not avaiable in the future (already ended)');
            raise_application_error(-20001,'This trip is not avaiable in the future (already ended)');
            RAISE;
        WHEN already_booked THEN
            DBMS_OUTPUT.PUT_LINE('This trip is not avaiable - all places booked');
            raise_application_error(-20001,'This trip is not avaiable - all places booked');
            RAISE;
        WHEN trip_err THEN
            DBMS_OUTPUT.PUT_LINE('This trip doesnt exist');
            raise_application_error(-20001,'This trip doesnt exist');
            RAISE;
        WHEN person_err THEN
            DBMS_OUTPUT.PUT_LINE('This Person doesnt exist');
            raise_application_error(-20001,'This Person doesnt exist');
            RAISE;
        WHEN others THEN
            DBMS_OUTPUT.PUT_LINE('Error occured');
            raise_application_error(-20001,'Error occured');
            RAISE;
end;


SELECT * FROM AvailableTrips4;
SELECT * FROM TRIPPARTICIPANTS(1);
SELECT * FROM PersonReservations(2);
SELECT * FROM AvailableTrips_F('Polska','2021-11-11','2034-11-11');

DROP PROCEDURE  ModifyNoPlaces4;
CREATE OR REPLACE PROCEDURE ModifyNoPlaces4(tripID int, no_places int)
IS
    curr_max int;
    availablePlaces int;
    reduce_err EXCEPTION;
BEGIN
    SELECT no_available_places INTO availablePlaces FROM TRIP WHERE trip_id=tripID;
    SELECT max_no_places INTO curr_max FROM TRIP WHERE trip_id=tripID;
    IF (  no_places - curr_max ) <= -(availablePlaces) THEN
        raise reduce_err;
    end if;
    UPDATE TRIP SET max_no_places=no_places WHERE trip_id=tripID;
    UPDATE TRIP SET no_available_places=no_places-curr_max+availablePlaces  WHERE trip_id=tripID;
    exception
        WHEN reduce_err THEN
            raise_application_error(-20001,'Cannot reduce below current reservation number');
            RAISE;
end;


-- Testing
SELECT * FROM TRIP;
SELECT * FROM TRIPS;
SELECT * FROm TRIP;
SELECT * FROM TRIPS4;

-- Testing

BEGIN
    MODIFYNOPLACES4(2,5);
end;

BEGIN
    AddReservation4(4,7);
end;

SELECT * FROm RESERVATION;

SELECT * FROM TripParticipants(2);
SELECT * FROM LOG;

-- ZADANIE 10
DROP PROCEDURE  ModifyReservationStatus5;
CREATE OR REPLACE PROCEDURE ModifyReservationStatus5(reservationID int , statusC char )
AS
    tripID int;
    availablePlaces int;
    curr_status char(1);
    res_err EXCEPTION;
    status_err EXCEPTION;
    already_ok EXCEPTION ;
    no_places Exception ;
BEGIN
    SELECT trip_id, status into tripID,curr_status FROM Reservation WHERE reservation_id=reservationID;
    SELECT no_available_places INTO availablePlaces FROM TRIP WHERE trip_id=tripID;
    IF NOT EXISTS_reservation(reservationID) THEN
        RAISE res_err;
    end if;
    IF NOT statusC IN ('N', 'P', 'C') THEN
        RAISE status_err;
    end if;
    IF curr_status = statusC THEN
            raise already_ok;
    end if;
    IF statusC ='C' THEN
        update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
        UPDATE TRIP SET no_available_places=availablePlaces+1 WHERE trip_id=tripID;
    end if;
    IF statusC IN ('P','N') THEN
        IF curr_status IN ('P','N') THEN
            update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
        ELSE
            IF availablePlaces >0 THEN
                update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
            else
                raise no_places;
            end if;
        end if;
        update RESERVATION SET status=statusC WHERE reservation_id=reservationID;
    end if;

    exception
        when status_err THEN
            raise_application_error(-20001,'Incorrect status given (possible: C N P)');
            RAISE;
        when res_err THEN
            raise_application_error(-20001,'Reservation of given ID doesnt exist');
            RAISE;
        when already_ok THEN
            raise_application_error(-20001,'Status already satisfied');
            RAISE;
        when no_places THEN
            raise_application_error(-20001,'No places avaiable');
            RAISE;
        when others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;

DROP PROCEDURE  AddReservation5;
CREATE OR REPLACE PROCEDURE AddReservation5(tripID int, personID int)
as
    availablePlaces number;
        no_places exception ;
    already_gone Exception ;
    person_err Exception ;
    trip_err Exception;
BEGIN
    SELECT trip.no_available_places into availablePlaces FROM TRIP WHERE  trip_id=tripID;
    IF NOT EXISTS_trip(tripID) THEN
        raise trip_err;
    end if;

    IF NOT EXISTS_person(personID) THEN
        raise person_err;
    end if;

    IF NOT IS_FUTURE(tripID) THEN
        raise already_gone;
    end if;

    IF availablePlaces<=0 THEN
        raise no_places;
    end if;

    INSERT INTO RESERVATION(trip_id, person_id, status) VALUES (tripID,personID,'N');
    DBMS_OUTPUT.PUT_LINE('Reservation added : '|| 'tripID :' || tripID || 'personID'|| personID);

    exception
       WHEN already_gone THEN
            raise_application_error(-20001,'This trip is not avaiable in the future (already ended)');
            RAISE;
        WHEN trip_err THEN
            raise_application_error(-20001,'This trip doesnt exist');
            RAISE;
        WHEN person_err THEN
            raise_application_error(-20001,'This Person doesnt exist');
            RAISE;
        WHEN no_places THEN
            raise_application_error(-20001,'No places available');
            RAISE;
        WHEN others THEN
            raise_application_error(-20001,'Error occured');
            RAISE;
end;

DROP PROCEDURE  ModifyNoPlaces5;
CREATE OR REPLACE PROCEDURE ModifyNoPlaces5(tripID int, no_places int)
IS
    curr_max int;
    availablePlaces int;
    reduce_err EXCEPTION;
BEGIN
    SELECT no_available_places INTO availablePlaces FROM TRIP WHERE trip_id=tripID;
    SELECT max_no_places INTO curr_max FROM TRIP WHERE trip_id=tripID;
    IF (  no_places - curr_max ) <= -(availablePlaces) THEN
        raise reduce_err;
    end if;
    UPDATE TRIP SET max_no_places=no_places WHERE trip_id=tripID;
    exception
        WHEN reduce_err THEN
            raise_application_error(-20001,'Cannot reduce below current reservation number');
            RAISE;
        WHEN OTHERS THEN
            raise_application_error(-20001,'An error occured');
            RAISE;
end;


-- Triggers for managing TRIP table:
DROP TRIGGER  trip_update_available;
CREATE OR REPLACE TRIGGER trip_update_available
    BEFORE  UPDATE OF max_no_places
    ON TRIP
    FOR EACH ROW
BEGIN
    :new.no_available_places := :new.max_no_places - :old.max_no_places + :old.no_available_places;
end;

DROP TRIGGER  res_add_available;
CREATE OR REPLACE TRIGGER res_add_available
    AFTER INSERT ON RESERVATION
    FOR EACH ROW
BEGIN
    UPDATE TRIP SET trip.no_available_places= trip.no_available_places-1 WHERE trip_id=:NEW.trip_id;
end;

DROP TRIGGER  res_mod_available;
CREATE OR REPLACE TRIGGER res_mod_available
    AFTER UPDATE OF STATUS ON RESERVATION
    FOR EACH ROW
BEGIN
    IF :NEW.STATUS='C' THEN
        UPDATE TRIP SET trip.no_available_places= trip.no_available_places+1 WHERE trip_id=:NEW.trip_id;
    end if;
    IF :OLD.STATUS='C' THEN
        UPDATE TRIP SET trip.no_available_places= trip.no_available_places-1 WHERE trip_id=:NEW.trip_id;
    end if;
end;


SELECT * FROM TRIP;
SELECT * FROM TRIPs;
BEGIN
    ModifyNoPlaces5(4,8);
end;
SELECT * FROM TRIPPARTICIPANTS(1);
BEGIN
    MODIFYRESERVATIONSTATUS5(44,'C');
end;

SELECT * FROM Reservation;
SELECT * FROM LOG;
SELECT * FROM TRIPS;
SELECT * FROM TRIP;