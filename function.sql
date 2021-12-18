    CREATE OR REPLACE FUNCTION poems_count(author text) RETURNS int AS
    $$
        DECLARE
            res integer;
        BEGIN
            SELECT COUNT(*) INTO res
            FROM poems
            INNER JOIN authors ON poems.author_id = authors.author_id
            WHERE authors.author_name = author;
            
            RETURN res;
        END;
    $$ LANGUAGE 'plpgsql';
