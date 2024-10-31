CREATE OR REPLACE PROCEDURE update_person(
       p_name IN cmi_test_person.vorname%TYPE,
       p_taetigkeit IN cmi_test_person.taetigkeit%TYPE
       ) IS
       
       BEGIN
         UPDATE cmi_test_person p
         SET p.taetigkeit = p_taetigkeit
         WHERE p.vorname = p_name;
         
         COMMIT;
         
         dbms_output.put_line('Die neue Tätigkeit lautet: ' || p_taetigkeit);
         END update_person;
         
         BEGIN
           update_person('Ico', 'Administrator');
           END;
