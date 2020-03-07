create or replace FUNCTION 
RF_4(hora_inicio_req IN TIMESTAMP, hora_fim_req IN TIMESTAMP, idEquipamento IN NUMBER)
RETURN ENERGIA_CUSTO_TABLE IS result_4 ENERGIA_CUSTO_TABLE;

    custo float;
    energia float;
    cursor c1 is (SELECT id, hora_inicio, hora_fim, total, kw, kwh, edificio_edificio_id FROM consumos_output WHERE equipamentos_equipamento_id = idEquipamento);
    
BEGIN
   
    custo := 0;
    energia := 0;
    
     FOR item IN c1 LOOP
        IF (hora_inicio_req >= item.hora_inicio) THEN
            IF (hora_inicio_req <= item.hora_fim) THEN
                IF(item.hora_fim >= hora_fim_req)THEN
                    custo := custo + calc_custo(item.id, hora_inicio_req, hora_fim_req, idEquipamento, item.kw, item.edificio_edificio_id ); 
                    energia := energia + (item.kw * DIFF_HOURS(hora_inicio_req, hora_fim_req));
                    dbms_output.put_line('custo 1º if = ' || custo);
                    dbms_output.put_line('energia 1º if = ' || energia);
                ELSE
                    custo := custo + calc_custo(item.id, hora_inicio_req, item.hora_fim, idEquipamento, item.kw, item.edificio_edificio_id ); 
                    energia := energia + (item.kw * DIFF_HOURS(hora_inicio_req, item.hora_fim));
                    dbms_output.put_line('custo 2º if = ' || custo);
                    dbms_output.put_line('energia 2º if = ' || energia);
                END IF;
           -- ELSE
             --   exit;
            END IF;          
        ELSE 
            IF (hora_fim_req >= item.hora_fim) THEN
                custo := custo + item.total;
                energia := energia + item.kwh;
                dbms_output.put_line('custo 3º if = ' || custo);
                dbms_output.put_line('energia 3º if = ' || energia);
            ELSE
                custo := custo + calc_custo(item.id, item.hora_inicio, hora_fim_req, idEquipamento, item.kw, item.edificio_edificio_id ); 
                energia := energia + item.kw * DIFF_HOURS(item.hora_inicio, hora_fim_req); 
               dbms_output.put_line('custo 4º if = ' || custo);
                dbms_output.put_line('energia 4º if = ' || energia);
            END IF;
        END IF;
    END LOOP;
    
    dbms_output.put_line('custo final = ' || custo);
    dbms_output.put_line('energia final = '|| energia);
    select ENERGIA_CUSTO(custo, energia) bulk collect into result_4 from dual;


    return result_4;
END RF_4;
