-- REQUISITO 1

create sequence edificio_teste_seq
    start with 20
    increment by 1;

create sequence divisao_teste_seq
    start with 50
    increment by 1;

create sequence equipamento_teste_seq
    start with 100
    increment by 1;
    
create sequence consumos_teste_seq
    start with 200
    increment by 1;

declare
    idEdificio integer;
    idDivisao integer;
    idEquipamento integer;
    idEdificio_teste integer;

begin
    -- EDIFICIO 1
    idEdificio := edificio_teste_seq.nextval;
    
    INSERT INTO edificio (edificio_id, localidade, coordenadas, area, n_divisoes, tipo_tarifa, endereco, tipo_edificio) 
    VALUES (idEdificio, 'Vila Franca de Xira', '40.883;-15.0477', 200, 2, 'uni', 'Rua da Industria', 'Centro Comercial - Teste');
    
    -- EDIFICIO 1, DIVISAO 1
    idDivisao := divisao_teste_seq.nextval;
        
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 1, 10, 3, 5, 1, idEdificio);
    
    idEquipamento := equipamento_teste_seq.nextval;
        
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id) 
    VALUES (idEquipamento, 'MacBook', 'AIR 2017', 'UDN3UADW83', 10, 50, 5, 'Computador', idDivisao, idEdificio);
    
    -- EDIFICIO 1, DIVISAO 2
    idDivisao := divisao_teste_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 2, 10, 3, 5, 2, idEdificio);
    
    idEquipamento := equipamento_teste_seq.nextval;
        
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id) 
    VALUES (idEquipamento, 'Samsung', 'GALAXY A5 2017', 'VN4W98EDJ84', 20, 20, 1, 'Telemóvel', idDivisao, idEdificio);
    
    idEquipamento := equipamento_teste_seq.nextval;
        
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id) 
    VALUES (idEquipamento, 'Samsung', 'Smartwatch', 'UNFC8E47', 10, 10, 1, 'Relógio', idDivisao, idEdificio);     
end;

-- SELECT ANTES DE ATUALIZACAO
SELECT edificio_id AS idEdificio_teste FROM edificio WHERE tipo_edificio = 'Centro Comercial - Teste';

-- UPDATE PARA ATUALIZAR VALOR
UPDATE edificio SET tipo_edificio = 'Habitacao - Teste' WHERE edificio_id = (SELECT edificio_id AS idEdificio_teste FROM edificio WHERE tipo_edificio = 'Centro Comercial - Teste'); 

-- SELECT DEPOIS DA ATUALIZACAO
SELECT edificio_id FROM edificio WHERE edificio_id = (SELECT edificio_id AS idEdificio_teste FROM edificio WHERE tipo_edificio = 'Habitacao - Teste');

-- REQUISITO 2 

declare
    idConsumos integer;
    idEquipamento integer;
    idEdificio integer;
    
begin
    idConsumos := consumos_teste_seq.nextval;
    idEquipamento := equipamento_teste_seq.currval;
    idEdificio := edificio_teste_seq.currval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, kwh, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 255, 1275, idEquipamento, idEdificio);
end;

-- SELECT BEFORE UPDATE
SELECT kwh FROM equipamentos_consumos WHERE kw = 255;

-- UPDATE PARA ATUALIZAR VALOR
UPDATE equipamentos_consumos SET kwh = 1300, kw = 260 WHERE kw = 255;

-- SELECT AFTER UPDATE
SELECT kwh FROM equipamentos_consumos WHERE kw = 260;

-- DELETE DOS DADOS CRIADOS
declare
    idEdificio integer;
    idConsumos integer;
    
begin
    idEdificio := edificio_teste_seq.currval;
    idConsumos := consumos_teste_seq.currval;
    
    DELETE FROM equipamentos_consumos WHERE id = idConsumos;
    DELETE FROM equipamentos WHERE edificio_edificio_id = idEdificio;
    DELETE FROM divisao WHERE edificio_id_fk = idEdificio;
    DELETE FROM edificio WHERE edificio_id = idEdificio;  
end;

-- SELECT QUE DEMONSTRA A ELIMINICAO DOS DADOS
SELECT * FROM edificio WHERE tipo_edificio = 'Habitacao - Teste';
SELECT kwh FROM equipamentos_consumos WHERE kw = 260;

DROP SEQUENCE consumos_output_seq;
DROP SEQUENCE consumos_teste_seq;
DROP SEQUENCE equipamento_teste_seq;
DROP SEQUENCE divisao_teste_seq;
DROP SEQUENCE edificio_teste_seq;

-- REQUISITO 3

---- (TRIGGER PARA TABELA CONSUMOS_OUTPUT)

-- REQUISITO 4

SELECT custo, energia FROM table(RF_4(to_date('2019-04-17 9:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 11));

-- REQUISITO 5

SELECT energia FROM table(RF_5_6(to_date('2019-04-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 2));

-- REQUISITO 6

SELECT custo, energia FROM table(RF_5_6(to_date('2019-04-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 1000));

-- REQUISITO 7

SELECT energia FROM table(RF_7_8('Alverca', 7));

-- REQUISITO 8

SELECT energia FROM table(RF_7_8('Alverca', 8));

-- REQUISITO 9 

---- (TRIGGER PARA TABELA ERROS)

-- REQUISITO 10 

SELECT * FROM tarifas_edificios where edificio_id_fk = 1 and rownum < 2 ORDER BY custo_tarifa;

-- REQUISITO 11

SELECT MIN(kw), MAX(kw), SUM(kw), AVG(kw) FROM consumos_output WHERE edificio_edificio_id = 2;

-- REQUISITO 12

SELECT tipo FROM table(RF_12);
