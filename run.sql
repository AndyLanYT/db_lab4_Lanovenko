-- FUNCTION

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

SELECT * FROM poems_count('LINA KOSTENKO')


-- PROCEDURE

CREATE OR REPLACE PROCEDURE poems_by_genre(genre text)
LANGUAGE plpgsql AS
$$
	DECLARE
		poem_rec record;
	BEGIN
		FOR poem_rec IN
			SELECT poems.poem_name
			FROM poems
			INNER JOIN genres ON poems.genre_id = genres.genre_id
			WHERE genres.genre_name = genre
		LOOP
			RAISE INFO 'Name: %', poem_rec.poem_name;
		END LOOP;
	END;
$$

CALL poems_by_genre('Love')


-- TRIGGER

CREATE TRIGGER short_name_insert
AFTER INSERT ON authors
FOR EACH ROW
EXECUTE FUNCTION short_name();


CREATE OR REPLACE FUNCTION short_name() RETURNS trigger AS
$$
	BEGIN
		UPDATE authors
		SET author_name = CONCAT(LEFT(author_name, 1), '. ', SPLIT_PART(author_name, ' ', 2))
		WHERE authors.author_id = NEW.author_id;
		RETURN NULL;
	END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM authors
INSERT INTO authors (author_name) VALUES ('TARAS SHEVCHENKO')
SELECT * FROM authors
