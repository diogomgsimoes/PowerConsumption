create or replace TRIGGER OUTPUT_TRIGGER 
    AFTER INSERT ON equipamentos_consumos 
    FOR EACH ROW

DECLARE 
    idEquipamento integer;
    idEdificio integer;
    potencia integer;
    potencia_teste integer;
    hora_inicio timestamp;
    hora_fim timestamp;
    hora_inicio_teste timestamp;
    hora_fim_teste timestamp;
    idConsumos integer;
    boolean_start boolean;
    boolean_end boolean;
    energia integer;
    custo float;
    
BEGIN
    idEdificio := :new.edificio_edificio_id;
    idEquipamento := :new.equipamentos_equipamento_id;
    idConsumos := :new.id;
    
    SELECT potencia INTO potencia FROM equipamentos WHERE equipamento_id = idEquipamento;
    
    potencia_teste := :new.kw;
    hora_inicio_teste := :new.hora_inicio;
    hora_fim_teste := :new.hora_fim;
    SELECT hora_inicio INTO hora_inicio FROM equipamentos WHERE equipamento_id = idEquipamento;
    hora_inicio := update_dias(hora_inicio, hora_inicio_teste);
    SELECT hora_fim INTO hora_fim FROM equipamentos WHERE equipamento_id = idEquipamento;
    hora_fim := update_dias(hora_fim, hora_fim_teste);
    energia := :new.kw * diff_hours(hora_inicio_teste, hora_fim_teste);
    
    IF hora_inicio != hora_inicio_teste THEN
        boolean_start := TRUE;
    ELSE 
        boolean_start:= FALSE;
    END IF;
    
    IF hora_fim != hora_fim_teste THEN
        boolean_end := TRUE;
    ELSE
        boolean_end := FALSE;
    END IF;
       
    custo := CALC_CUSTO(idConsumos, hora_inicio_teste, hora_fim_teste, idEquipamento, potencia_teste, idEdificio);
    dbms_output.put_line(idConsumos || hora_inicio_teste || hora_fim_teste || idEquipamento || potencia_teste ||idEdificio);

    IF (potencia != potencia_teste) THEN
        IF (boolean_end OR boolean_start) THEN
            INSERT INTO consumos_output (id, hora_inicio, hora_fim, kw, total, erro, kwh, equipamentos_equipamento_id, edificio_edificio_id) 
            VALUES (idConsumos, hora_inicio_teste, hora_fim_teste, potencia_teste, custo, 'Erro no horário de funcionamento e na potência', energia, idEquipamento, idEdificio);
            INSERT INTO erros (id, equipamento, tipo) VALUES (idConsumos, idEquipamento, 'Erro no horário de funcionamento e na potência');
        ELSE 
            INSERT INTO consumos_output (id, hora_inicio, hora_fim, kw, total, erro, kwh, equipamentos_equipamento_id, edificio_edificio_id) 
            VALUES (idConsumos, hora_inicio_teste, hora_fim_teste, potencia_teste, custo, 'Erro de potência',  energia, idEquipamento, idEdificio);
            INSERT INTO erros (id, equipamento, tipo) VALUES (idConsumos, idEquipamento, 'Erro de potência');
        END IF;
        
    ELSE
        IF (boolean_end OR boolean_start) THEN
            INSERT INTO consumos_output (id, hora_inicio, hora_fim, kw, total, erro, kwh, equipamentos_equipamento_id, edificio_edificio_id) 
            VALUES (idConsumos, hora_inicio_teste, hora_fim_teste, potencia_teste, custo, 'Erro no horário de funcionamento',  energia, idEquipamento, idEdificio);
            INSERT INTO erros (id, equipamento, tipo) VALUES (idConsumos, idEquipamento, 'Erro no horário de funcionamento');
        ELSE 
            INSERT INTO consumos_output (id, hora_inicio, hora_fim, kw, total, erro,  kwh, equipamentos_equipamento_id, edificio_edificio_id) 
            VALUES (idConsumos, hora_inicio_teste, hora_fim_teste, potencia_teste, custo, 'Nada a apresentar',  energia, idEquipamento, idEdificio);
        END IF;
    END IF;
END;
