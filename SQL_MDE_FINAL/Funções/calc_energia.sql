create or replace FUNCTION 
CALC_ENERGIA(equip_id IN NUMBER, inicio_equip IN TIMESTAMP, fim_equip IN TIMESTAMP, potencia_equip IN NUMBER) 
RETURN INTEGER 
IS energia FLOAT;

    diff float; 

BEGIN
    diff := DIFF_HOURS(inicio_equip, fim_equip);
    
    energia := diff*potencia_equip;
    
    RETURN energia;
END CALC_ENERGIA;
