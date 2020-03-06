create or replace FUNCTION 
RF_12
RETURN ERROR_NAME_TABLE IS result_12 ERROR_NAME_TABLE;

    cursor c1 is (SELECT tipo FROM erros);
    counter_potencia integer;
    counter_horario integer;
    counter_potencia_horario integer;
    erro varchar2(64);
    
BEGIN
    
    counter_potencia := 0;
    counter_horario := 0;
    counter_potencia_horario :=0;
    erro := '';
    result_12 := ERROR_NAME_TABLE();
    
    FOR item in c1 LOOP
        IF item.tipo = 'Erro de potência' THEN
            counter_potencia := counter_potencia +1;
        ELSIF item.tipo = 'Erro no horário de funcionamento' THEN
            counter_horario := counter_horario +1;
        ELSIF item.tipo = 'Erro no horário de funcionamento e na potência' THEN
            counter_potencia_horario := counter_potencia_horario + 1;
        END IF;
    END LOOP;

    IF counter_potencia > counter_horario AND counter_potencia > counter_potencia_horario THEN
        select ERROR_NAME(counter_potencia, 'Erro de potência') bulk collect into result_12 from dual;
    ELSE
        IF counter_horario > counter_potencia AND counter_horario > counter_potencia_horario THEN
            select ERROR_NAME(counter_horario, 'Erro no horário de funcionamento') bulk collect into result_12 from dual;
        ELSE
            select ERROR_NAME(counter_potencia_horario, 'Erro no horário de funcionamento e na potência') bulk collect into result_12 from dual;
        END IF;
    END IF;

    return result_12;
END RF_12;
