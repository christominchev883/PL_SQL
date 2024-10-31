CREATE OR REPLACE PROCEDURE delete_person(
       p_name IN cmi_test_person.vorname%TYPE
     
       ) IS
       
       BEGIN
         DELETE FROM cmi_test_person p
         
         WHERE p.vorname = p_name;
         
         COMMIT;
         
         dbms_output.put_line('Die folgende Person wurde gelöscht: ' || p_name);
         END delete_person;




         ---------------





         BEGIN
           delete_person('Ico');
           END;
