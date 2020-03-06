create or replace FUNCTION 
calc_custo(consumo_id IN NUMBER, inicio_equip IN TIMESTAMP, fim_equip IN TIMESTAMP, equip_id IN NUMBER, potencia_equip IN NUMBER, edif_id IN NUMBER) 
RETURN NUMBER IS custo_total NUMBER;
   
    diff float;
    hora_final_tarifa_anterior timestamp;
    hora_inicial_tarifa timestamp;
    hora_final_tarifa timestamp;
   
    BEGIN 
    
        custo_total := 0;
        hora_final_tarifa_anterior := inicio_equip;
        
        FOR item IN (SELECT hora_inicio, hora_fim, custo_tarifa FROM tarifas_edificios WHERE edificio_id_FK = edif_id) LOOP
            hora_inicial_tarifa := update_dias(item.hora_inicio, inicio_equip);
            hora_final_tarifa := update_dias(item.hora_fim, fim_equip);
            DBMS_OUTPUT.PUT_LINE( consumo_id || hora_inicial_tarifa || ' TOMA CARALHO ' || hora_final_tarifa );
            IF (hora_final_tarifa_anterior >= hora_inicial_tarifa) AND (hora_final_tarifa_anterior <= hora_final_tarifa) THEN
                IF fim_equip <= hora_final_tarifa THEN
                    diff := DIFF_HOURS(hora_final_tarifa_anterior, fim_equip);
                    dbms_output.put_line(diff);
                    if(diff>0) THEN
                        custo_total := custo_total + (item.custo_tarifa)*potencia_equip*diff;
                    END IF;
                    dbms_output.put_line(custo_total);
                ELSE
                    diff := DIFF_HOURS(hora_final_tarifa_anterior, hora_final_tarifa);
                    dbms_output.put_line(diff);
                    if(diff>0) then
                        custo_total := custo_total + (item.custo_tarifa)*potencia_equip*diff;
                    end if;
                    dbms_output.put_line(custo_total);
                END IF;
            END IF;
        hora_final_tarifa_anterior := hora_final_tarifa;
        END LOOP;
        RETURN custo_total;
END;create or replace FUNCTION 
calc_custo(consumo_id IN NUMBER, inicio_equip IN TIMESTAMP, fim_equip IN TIMESTAMP, equip_id IN NUMBER, potencia_equip IN NUMBER, edif_id IN NUMBER) 
RETURN NUMBER IS custo_total NUMBER;
   
    diff float;
    hora_final_tarifa_anterior timestamp;
    hora_inicial_tarifa timestamp;
    hora_final_tarifa timestamp;
   
    BEGIN 
    
        custo_total := 0;
        hora_final_tarifa_anterior := inicio_equip;
        
        FOR item IN (SELECT hora_inicio, hora_fim, custo_tarifa FROM tarifas_edificios WHERE edificio_id_FK = edif_id) LOOP
            hora_inicial_tarifa := update_dias(item.hora_inicio, inicio_equip);
            hora_final_tarifa := update_dias(item.hora_fim, fim_equip);
            DBMS_OUTPUT.PUT_LINE( consumo_id || hora_inicial_tarifa || ' TOMA CARALHO ' || hora_final_tarifa );
            IF (hora_final_tarifa_anterior >= hora_inicial_tarifa) AND (hora_final_tarifa_anterior <= hora_final_tarifa) THEN
                IF fim_equip <= hora_final_tarifa THEN
                    diff := DIFF_HOURS(hora_final_tarifa_anterior, fim_equip);
                    dbms_output.put_line(diff);
                    if(diff>0) THEN
                        custo_total := custo_total + (item.custo_tarifa)*potencia_equip*diff;
                    END IF;
                    dbms_output.put_line(custo_total);
                ELSE
                    diff := DIFF_HOURS(hora_final_tarifa_anterior, hora_final_tarifa);
                    dbms_output.put_line(diff);
                    if(diff>0) then
                        custo_total := custo_total + (item.custo_tarifa)*potencia_equip*diff;
                    end if;
                    dbms_output.put_line(custo_total);
                END IF;
            END IF;
        hora_final_tarifa_anterior := hora_final_tarifa;
        END LOOP;
        RETURN custo_total;
END;