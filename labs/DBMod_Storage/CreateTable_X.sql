-- Oracle Database 18c Administration Workshop
-- Oracle Server Technologies - Curriculum Development
--
-- ***Training purposes only***
-- ***Not appropriate for production use***
--
-- If the table exists drop it silently
DECLARE
  dummy CHAR(1);
BEGIN
  SELECT 'X' INTO DUMMY FROM USER_TABLES WHERE table_name = 'X';
  EXECUTE IMMEDIATE 'DROP TABLE X PURGE';
EXCEPTION
WHEN NO_DATA_FOUND THEN
  NULL;
END;
/
SET echo ON
CREATE TABLE x
  (a CHAR(1000)
  ) TABLESPACE inventory;
INSERT INTO x 
  VALUES ('a');
INSERT INTO x
SELECT * FROM x;
INSERT INTO x
SELECT * FROM x;
INSERT INTO x
SELECT * FROM x;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
INSERT INTO x
SELECT * FROM x ;
COMMIT;
quit
