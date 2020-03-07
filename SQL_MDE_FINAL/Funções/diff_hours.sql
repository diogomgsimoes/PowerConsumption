CREATE OR REPLACE FUNCTION 
DIFF_HOURS(inicio IN TIMESTAMP, fim IN TIMESTAMP) 
RETURN NUMBER
IS diff NUMBER;
 
begin
    diff := (
            EXTRACT (DAY FROM (fim - inicio))*24 + 
            EXTRACT (HOUR FROM (fim - inicio)) + 
            EXTRACT (MINUTE FROM (fim - inicio))/60 +
            EXTRACT (SECOND FROM (fim - inicio))/(60*60)
            );
    RETURN diff;
END DIFF_HOURS;
