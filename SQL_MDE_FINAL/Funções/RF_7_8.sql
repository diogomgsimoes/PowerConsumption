create or replace FUNCTION 
RF_7_8(localidade_input IN varchar2, requisito IN NUMBER)
RETURN ENERGIA_CUSTO_TABLE IS result_7_8 ENERGIA_CUSTO_TABLE;

    consumo_localidade integer;
    consumo_medio_localidade integer;
    custo_edificio_localidade integer;
    counter integer;
    cursor c1 is (SELECT edificio_id FROM edificio WHERE localidade = localidade_input);
    
BEGIN

    consumo_localidade := 0;
    consumo_medio_localidade := 0;
    counter := 0;
    result_7_8 := ENERGIA_CUSTO_TABLE();
    
    FOR item IN c1 LOOP
         SELECT SUM(KWH) INTO custo_edificio_localidade FROM consumos_output WHERE edificio_edificio_id = item.edificio_id;
         consumo_localidade := consumo_localidade + custo_edificio_localidade;
         counter := counter +1;
    END LOOP;
    dbms_output.put_line(consumo_localidade);
    consumo_medio_localidade := consumo_localidade / counter;
    dbms_output.put_line(consumo_medio_localidade);

    IF(requisito = 7) THEN
        SELECT ENERGIA_CUSTO(NULL, consumo_medio_localidade) bulk collect into result_7_8 from dual;
    ELSE
        SELECT ENERGIA_CUSTO(NULL, consumo_localidade) bulk collect into result_7_8 from dual;
    END IF;
    
    return result_7_8;
    
end RF_7_8;
