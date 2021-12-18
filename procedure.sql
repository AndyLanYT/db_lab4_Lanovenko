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
