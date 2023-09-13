CREATE OR REPLACE FUNCTION update_bed_count()
    RETURNS TRIGGER AS
$$
BEGIN

    UPDATE Больница
    SET Число_коек = (SELECT SUM(Число_коек)
                      FROM Палата
                      WHERE Палата.Код_больницы = NEW.Код_больницы)
    WHERE Код_больницы = NEW.Код_больницы;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_bed_count_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON Палата
    FOR EACH ROW
EXECUTE FUNCTION update_bed_count();


CREATE OR REPLACE FUNCTION decrease_bed_count()
    RETURNS TRIGGER AS
$$
BEGIN

    UPDATE Больница
    SET Число_коек = Число_коек - OLD.Число_коек
    WHERE Код_больницы = OLD.Код_больницы;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER decrease_bed_count_trigger
    BEFORE DELETE
    ON Палата
    FOR EACH ROW
EXECUTE FUNCTION decrease_bed_count();


CREATE OR REPLACE FUNCTION check_bed_number()
    RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS (SELECT 1
               FROM Палата
               WHERE Палата.Код_больницы = NEW.Код_больницы
                 AND Палата.Номер_палаты = NEW.Номер_палаты
                 AND NEW.Номер_койки > Палата.Число_коек) THEN
        RAISE EXCEPTION 'Номер койки пациента больше, чем количество коек в палате';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_bed_number_trigger
    BEFORE INSERT
    ON Размещение
    FOR EACH ROW
EXECUTE FUNCTION check_bed_number();