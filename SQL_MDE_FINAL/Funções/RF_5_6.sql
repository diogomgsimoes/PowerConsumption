create or replace FUNCTION 
RF_5_6(inicio_query IN TIMESTAMP, fim_query IN TIMESTAMP, min IN NUMBER, max IN NUMBER)
RETURN ENERGIA_CUSTO_TABLE IS result_5_6 ENERGIA_CUSTO_TABLE;

    energia float;
    custo float;
    cursor c1 is (SELECT id, hora_inicio, hora_fim, kw, total, kwh, EQUIPAMENTOS_EQUIPAMENTO_ID, EDIFICIO_EDIFICIO_ID FROM consumos_output 
                    WHERE (EDIFICIO_EDIFICIO_ID > min and EDIFICIO_EDIFICIO_ID < max));
    
    BEGIN
        
        energia := 0;
        custo := 0;
        result_5_6 := ENERGIA_CUSTO_TABLE();
        
          FOR item in c1 LOOP
            IF (inicio_query <= item.hora_inicio and fim_query >= item.hora_fim) THEN
                custo := custo + item.total;
                energia := energia + item.kwh;     
            ELSIF (inicio_query >= item.hora_inicio and fim_query >= item.hora_fim and inicio_query <= item.hora_fim) THEN
                custo := custo + calc_custo(item.id, inicio_query, item.hora_fim, item.EQUIPAMENTOS_EQUIPAMENTO_ID, item.kw, item.EDIFICIO_EDIFICIO_ID);
                energia := energia + calc_energia(item.EQUIPAMENTOS_EQUIPAMENTO_ID, inicio_query, item.hora_fim, item.kw);  
            ELSIF (inicio_query <= item.hora_inicio and fim_query <= item.hora_fim and fim_query >= item.hora_inicio) THEN
                custo := custo + calc_custo(item.id, item.hora_inicio, fim_query, item.EQUIPAMENTOS_EQUIPAMENTO_ID, item.kw, item.EDIFICIO_EDIFICIO_ID);
                energia := energia + calc_energia(item.EQUIPAMENTOS_EQUIPAMENTO_ID, item.hora_inicio, fim_query, item.kw);
            ELSIF (inicio_query >= item.hora_inicio and fim_query <= item.hora_fim)  THEN
                custo := custo + calc_custo(item.id, inicio_query, fim_query, item.EQUIPAMENTOS_EQUIPAMENTO_ID, item.kw, item.EDIFICIO_EDIFICIO_ID);
                energia := energia + calc_energia(item.EQUIPAMENTOS_EQUIPAMENTO_ID, inicio_query, fim_query, item.kw);
            END IF;
        END LOOP;

    select ENERGIA_CUSTO(custo, energia) bulk collect into result_5_6 from dual;
    
   
  RETURN result_5_6;
END RF_5_6;
