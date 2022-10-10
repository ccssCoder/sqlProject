/
set serveroutput on;
/

-- 1
--modositjuk 1 termek arat a megadatott arra
    CREATE OR REPLACE PROCEDURE modosit_termek_ar
        (termek_nev varchar2, ujar number)
    IS
        v_id number(5);
        v_ar number(5);
    BEGIN
        select id, ar into v_id, v_ar from termek where nev = termek_nev;
        
        update Termek set ar = ujar where id = v_id;

        dbms_output.put_line('regi ar: ' || v_ar);
        dbms_output.put_line('uj ar: ' || ujar);
        
        EXCEPTION 
            when no_data_found then dbms_output.put_line('Nincs ilyen termék!');
    END modosit_termek_ar;
    /

    select * from termek;

    -- megfelelo eset
    EXECUTE modosit_termek_ar('Kettlebell 4kg',60);
    select * from termek where nev = 'Kettlebell 4kg';

    -- nincs ilyen termek
    EXECUTE modosit_termek_ar('Kettlebell 5.5g',60);
    select * from termek where nev = 'Kettlebell 5.5kg';
--

-- 2
-- seged fugggveny a kovetkezo feladathoz
    create or replace FUNCTION LETEZIK_TERMEK
        (pTermek_Nev varchar2)
    RETURN number
    IS
        v_id number(5);
    BEGIN
        select id into v_id from termek where nev = pTermek_Nev; 
        RETURN v_id;
        EXCEPTION
            when no_data_found then  return -1;
    END LETEZIK_TERMEK;

    -- megfelelo eset
    select letezik_termek('Kettlebell 5kg') from dual;
    -- nincs ilyen termek
    select letezik_termek('Kettlebell 5.5kg') from dual;
--

-- 3
--valaki vasarol egy termeket, ha nincs olyan termek az uzletben akkor szurjuk be hogy kovetkezokor legyen
    create or replace PROCEDURE VASAROL
        (pKliens_Nev varchar2, pTermek_Nev varchar2, pDarab number)
    IS
        v_idKliens number(5);
        v_idTermek number(5);
        v_db number(5);
    BEGIN
        select id into v_idKliens from kliens where v_nev || ' ' || k_nev = pKliens_Nev; 

        v_idTermek := LETEZIK_TERMEK(pTermek_Nev);

        if v_idTermek < 0 
        then 
            dbms_output.put_line('Nem volt ilyen termek, viszont beszurasra kerult, kerjuk adjon árat neki később!');
            select max(id)+1 into v_idTermek from termek;

            insert into termek( id, nev, ar )
            VALUES (v_idTermek, pTermek_Nev, NULL); 
        else
            insert into vasarlas(id, kliens_id, alkalmazott_id, datum)
            VALUES ((select max(id)+1 from vasarlas)+1, v_idKliens, 1, sysdate);

            insert into vasarlas_termek(v_id, T_id, menyiseg)
            VALUES (v_idKliens, v_idTermek, pDarab);

            dbms_output.put_line('Megtortent a vasarlas, tablaba beszurva');
        end if;

        EXCEPTION 
            when no_data_found then dbms_output.put_line('Nincs ilyen szemely');
    END VASAROL;

    EXECUTE VASAROL('Katona Lajos','Kalcium tabletta',3);

    select te.nev, te.ar, vt.menyiseg, kl.v_nev || + ' ' || + kl.k_nev as "Nev", v.datum 
    from vasarlas v
    join vasarlas_termek vt on vt.v_id = v.id
    join termek te on vt.t_id=te.id
    join kliens kl on kl.id = v.kliens_id
    order by v.datum desc;
--

-- 4 
--adott kliens milyen termeket vasarolt utoljara
    create or replace PROCEDURE kiirat_utolso_vasarlas_adatok
        (kliens_nev varchar2)
    IS
        v_tnev varchar2(25);
        v_date date;
        v_db number;
        v_value number;
    BEGIN
        SELECT t.nev, v.datum, vt.menyiseg, (t.ar * vt.menyiseg) as "Kifizetés"
        INTO v_tnev, v_date, v_db, v_value
        FROM vasarlas v
        JOIN vasarlas_termek vt ON v.id = vt.v_id
        JOIN termek t ON vt.t_id = t.id
        JOIN kliens k ON v.kliens_id = k.id 
        WHERE k.v_nev || ' ' || k.k_nev = kliens_nev
        order by v.datum desc
        fetch first 1 rows only;

        dbms_output.put_line(v_tnev || '  ' || v_date || '  ' ||  v_db || '  ' || v_value);

        EXCEPTION 
            when no_data_found then dbms_output.put_line('A kliensnek nincsenek vasarlasai!');
    END kiirat_utolso_vasarlas_adatok;

    BEGIN
        kiirat_utolso_vasarlas_adatok('Katona Lajos');
    END;
    /

    select * from kliens;
--

-- 5
-- Berlet validacioja
    create or replace FUNCTION berlet_valid(p_KliensId number)
    RETURN number
    IS
        v_honap number(5);
        v_alkalmak number(5);
        v_datum date;
        v_berlet_id number(5);          -- utoljara kiallitott berlet id-ja
        v_belepes_alkalmak number(5);   -- kliens hanyszor lepett be ide mentem
    BEGIN
        select bt.id, bt.datum, btt.alkalmak, btt.honapok
        into v_berlet_id, v_datum, v_alkalmak, v_honap
        from berlet bt 
        join berlettipus btt on bt.tipus_id = btt.id
        where kliens_id = p_KliensId
        order by datum desc
        fetch first 1 rows only;
        
        --ha a honapok null, akkor a berlet ugy volt kiallitva, hogy "x" alkalomra van kiallitva
        if v_honap is null then
            -- megkell szamoljam, hogy hanyszor lepett be a berlet kiallitasa ota
            select count(*)
            into v_belepes_alkalmak
            from berlet bt
            join berlettipus btt on bt.tipus_id = btt.id
            join belepes bp on bp.kliens_id = bt.kliens_id
            where bt.kliens_id = p_KliensId and bt.id = v_berlet_id;
            
            if v_belepes_alkalmak <= v_alkalmak then
                return 1;
            else
                return -1;
            end if;
        else
            -- a rendszer szerinti idő a kiállitási dátum és a bérlet hónap között van
            if sysdate < ADD_MONTHS(v_datum,v_honap) then
                return 1;
            else
                return -1;
            end if;
        end if;
        
        EXCEPTION 
            when no_data_found then dbms_output.put_line('Kliens nem szerepel a rendszerben!');
    END berlet_valid;
    /

    select berlet_valid(1) from dual;

    -- belepeseket tudom szamszerusitve ellenorizni
    select *
    from berlet bt
    join berlettipus btt on bt.tipus_id = btt.id
    join belepes bp on bp.kliens_id = bt.kliens_id
    where bt.kliens_id = 1
    order by datum desc;

    -- utoljara kiallitott datumot tudom ellenorizni
    select bt.id, datum, alkalmak, honapok
    from berlet bt 
    join berlettipus btt on bt.tipus_id = btt.id
    where kliens_id = 1
    order by datum desc
    fetch first 1 rows only;

    select berlet_valid(1) from dual;
    select berlet_valid(2) from dual;
--

-- 6 - trigger
-- ha egy termek ara modosul vagy beszurjuk, ne tudjunk negativ erteket betenni
    CREATE OR REPLACE TRIGGER negative_ar
    BEFORE INSERT OR UPDATE ON termek
    FOR EACH ROW

    DECLARE
        va  NUMBER;
    BEGIN
        If (INSERTING or UPDATING) then 
            va  :=  :NEW.AR;
            if va < 0 then
                RAISE_APPLICATION_ERROR(-20101, 'Negativ ar!!! Nem lehet negativ erteke egy termeknek!');
                ROLLBACK;
            end if;
        END IF;  
    END;
    /

    select * from termek;

    update termek set ar = 100 where nev = 'Kettlebell 5kg';
    update termek set ar = 120 where nev = 'Kalcium tabletta';
--


-- 
    --Jelentkeztetni valakit 1 csoportos edzesre, ha betelt a letszam, akkor elutasitodik?
    -- valid a berlete?
    -- a csoportos edzesek van letszama! van hely?
--