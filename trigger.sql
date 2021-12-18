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
