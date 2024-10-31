CREATE OR REPLACE PROCEDURE einfügen_name_familienname (v_name IN cmi_test_person.vorname%TYPE, v_familienname IN cmi_test_familien.familienname%TYPE) IS
person_id cmi_test_person.id%TYPE;
familien_id cmi_test_familien.id%TYPE;


BEGIN
 
SELECT NVL(MAX(ID), 0) + 1
INTO   person_id
FROM   cmi_test_person;


INSERT INTO cmi_test_person (id, vorname)
VALUES (person_id, v_name);


SELECT NVL(MAX(ID), 0) + 1
INTO familien_id
FROM cmi_test_familien;

INSERT INTO cmi_test_familien(id, familienname)
SELECT familien_id, v_familienname
FROM dual
WHERE NOT EXISTS (SELECT 1 FROM cmi_test_familien c WHERE c.familienname = v_familienname);

COMMIT;
END einfügen_name_familienname;

----

BEGIN
  
einfügen_name_familienname('Martin', 'Günter');
END;

--





