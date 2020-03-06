DELETE FROM equipamentos_consumos CASCADE;
DELETE FROM consumos_output CASCADE;
DELETE FROM tarifas_edificios CASCADE;
DELETE FROM erros CASCADE;
DELETE FROM equipamentos CASCADE;
DELETE FROM divisao CASCADE;
DELETE FROM edificio CASCADE;

DROP SEQUENCE edificio_seq;
DROP SEQUENCE divisao_seq;
DROP SEQUENCE equipamento_seq;
DROP SEQUENCE consumos_seq;

create sequence edificio_seq
    start with 1
    increment by 1;

create sequence divisao_seq
    start with 1
    increment by 1;
    
create sequence equipamento_seq
    start with 1
    increment by 1;

create sequence consumos_seq
    start with 1
    increment by 1;

declare
    idEdificio integer;
    idDivisao integer;
    idEquipamento integer;
    idConsumos integer;

begin
    idEdificio := edificio_seq.nextval;
    idDivisao := divisao_seq.nextval;
    idEquipamento := equipamento_seq.nextval;
    idConsumos := consumos_seq.nextval;
    
    /* edificio 1 */
    
    INSERT INTO edificio (edificio_id, localidade, coordenadas, area, n_divisoes, tipo_tarifa, endereco, tipo_edificio) 
    VALUES (idEdificio, 'Alverca', '37.883;-8.0477', 100, 3, 'uni', 'Rua 25 de Abril', 'Centro Comercial');
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), 0.1621, idEdificio);
    
    /* edificio 1 divisao 1 */

    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 2, 10, 3, 5, 2, idEdificio);
    
    /* edificio 1 divisao 1 equipamento 1*/
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Siemens', 'HOT_IN_HERE', 'E13245CF', 200, 1000, 5, 'Ar condicionado', idDivisao, idEdificio, to_date('2019-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-18 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-19 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, idEquipamento, idEdificio);
    
    /* edificio 1 divisao 1 equipamento 2*/    

    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Cisco', 'CALL_ME_MAYBE', '28DNUWCN', 100, 500, 5, 'Telefone', idDivisao, idEdificio, to_date('2019-04-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 800, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-03-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-03-19 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 500, idEquipamento, idEdificio);
    
    /* edificio 1 divisao 2 */
    
    idDivisao := divisao_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 1, 20, 3, 4, 3, idEdificio);
    
    /* edificio 1 divisao 2 equipamento 1*/
    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Lenovo', 'LEGION', 'W34FNM983W', 100, 200, 2, 'Computador', idDivisao, idEdificio, to_date('2019-04-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-17 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 200, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-07-20 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-07-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 200, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-01-30 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-01-30 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, idEquipamento, idEdificio);

    /* edificio 1 divisao 2 equipamento 2*/
    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'HP', 'SPITTIN_PAPER', 'SEGVT4W', 50, 100, 2, 'Impressora', idDivisao, idEdificio, to_date('2019-04-17 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2017-02-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2017-02-10 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), 50, idEquipamento, idEdificio);

    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2017-02-11 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2017-02-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2017-02-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2017-02-11 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, idEquipamento, idEdificio);
    
    /* edificio 1 divisao 2 equipamento 3*/
    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Logitech', 'DPI_MONSTER', 'E54BTDV4', 10, 10, 1, 'Rato', idDivisao, idEdificio, to_date('2019-04-17 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2018-03-17 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2018-03-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2018-06-18 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2018-06-18 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2018-09-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2018-09-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 15, idEquipamento, idEdificio);
    
    /* edificio 1 divisao 3 */
    
    idDivisao := divisao_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 1, 70, 3, 10, 1, idEdificio); 
    
    /* edificio 1 divisao 3 equipamento 1*/
    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Jademar', 'LET_THERE_BE_LIGHT', 'Q23VW594MTF', 12, 12, 1, 'Lampada', idDivisao, idEdificio, to_date('2019-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-11-09 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-11-09 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 12, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-11-06 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-11-06 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 11, idEquipamento, idEdificio);
    
    
      
    /* edificio 2 */
     
    idEdificio := edificio_seq.nextval;
    
    INSERT INTO edificio (edificio_id, localidade, coordenadas, area, n_divisoes, tipo_tarifa, endereco, tipo_edificio) 
    VALUES (idEdificio, 'Alverca', '38.883;-9.0477', 200, 2, 'bi', 'Praca Malvarosa', 'Habitacao');
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.1837, idEdificio);
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), 0.4389, idEdificio);
    
    
    /* edificio 2 divisao 1 */
    
    idDivisao := divisao_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 2, 10, 3, 5, 1, idEdificio);
    
    /* edificio 2 divisao 1 equipamento 1*/

    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'BOSCH', 'I_SEE_FIRE', 'JDE85NE7', 1000, 6000, 6, 'Fogao', idDivisao, idEdificio, to_date('2019-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2017-05-10 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2017-05-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2017-06-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2017-06-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 800, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2017-03-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2017-03-10 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6000, idEquipamento, idEdificio);
    
    
    /* edificio 2 divisao 2 */
    
    idDivisao := divisao_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 1, 25, 2, 10, 2, idEdificio);
    
    /* edificio 2 divisao 2 equipamento 1*/

    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'INDESIT', 'COLD_AS_ICE', '5B5EETEVD5', 300, 3000, 10, 'Frigorifico', idDivisao, idEdificio, to_date('2019-04-17 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-25 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-25 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2018-01-18 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2018-01-18 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-02-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-02-15 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2500, idEquipamento, idEdificio);
    
    /* edificio 2 divisao 1 equipamento 1*/
    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Samsung', 'MICROWAVINGS', 'W35G4FEE45', 200, 1000, 5, 'Microondas', idDivisao, idEdificio, to_date('2019-04-17 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-02-17 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-02-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 250, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-12-17 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-12-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-12-05 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-12-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 500, idEquipamento, idEdificio);



     /* edificio 3 */
     
    idEdificio := edificio_seq.nextval;
    
    INSERT INTO edificio (edificio_id, localidade, coordenadas, area, n_divisoes, tipo_tarifa, endereco, tipo_edificio) 
    VALUES (idEdificio, 'Albufeira', '18.500;-2.000', 25, 1, 'uni', 'Quinta do Poco', 'Fabrica');
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.2367, idEdificio);
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.4214, idEdificio);
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), 0.1383, idEdificio);
    
    
    /* edificio 3 divisão 1*/
    
    idDivisao := divisao_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 1, 25, 2, 10, 1, idEdificio);
    
    /* edificio 3 divisão 1 equipamento 1*/
   
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Armil', 'TOO_HOT_HOT_DAMN', 'W98TE5V4U7', 1000, 20000, 20, 'Forno Industrial', idDivisao, idEdificio, to_date('2019-04-17 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-07-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-07-17 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 20000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-08-17 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-17 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 20000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-09-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-09-17 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 25000, idEquipamento, idEdificio);

    
    /* edificio 4 */
     
    idEdificio := edificio_seq.nextval;
    
    INSERT INTO edificio (edificio_id, localidade, coordenadas, area, n_divisoes, tipo_tarifa, endereco, tipo_edificio) 
    VALUES (idEdificio, 'Braga', '22.500;2.000', 300, 3, 'tri', 'Axa', 'Escola');
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.1928, idEdificio);
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.3726, idEdificio);
    
    INSERT INTO tarifas_edificios (hora_inicio, hora_fim, custo_tarifa, edificio_id_fk) 
    VALUES (to_date('2019-04-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 23:59:59', 'YYYY-MM-DD HH24:MI:SS'), 0.2387, idEdificio);
    
    
    /* edificio 4 divisão 1 */
    
    idDivisao := divisao_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 1, 100, 3, 5, 2, idEdificio);
    
    /* edificio 4 divisão 1 equipamento 1*/
    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Epson', 'SPECTRUM', 'IJS4TDV5U', 100, 500, 5, 'Projetor', idDivisao, idEdificio, to_date('2019-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-02-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-02-10 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 750, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-01-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-01-22 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 600, idEquipamento, idEdificio);
    
    /* edificio 4 divisão 1 equipamento 2*/

    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'Asus', 'ROG', 'KMUS4VTI4', 100, 200, 2, 'Computador', idDivisao, idEdificio, to_date('2019-04-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-08-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-08-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 200, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-03-17 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-03-17 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 200, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, idEquipamento, idEdificio);
    
    
    /* edificio 4 divisão 2*/
    
    idDivisao := divisao_seq.nextval;
    
    INSERT INTO divisao (divisao_id, piso, area, altura, n_janelas, n_equipamentos, edificio_id_fk) 
    VALUES (idDivisao, 2, 100, 3, 5, 1, idEdificio);
    
    /* edificio 4 divisão 2 equipamento 1*/
    
    idEquipamento := equipamento_seq.nextval;
    
    INSERT INTO equipamentos (equipamento_id, fabricante, modelo, referencia, tensao, potencia, corrente, nome, divisao_divisao_id, edificio_edificio_id, hora_inicio, hora_fim) 
    VALUES (idEquipamento, 'LG', 'MICRO', 'MISE5UVT5', 200, 1000, 5, 'Microondas', idDivisao, idEdificio, to_date('2019-04-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-02-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-02-19 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 900, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-04-11 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-04-11 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, idEquipamento, idEdificio);
    
    idConsumos := consumos_seq.nextval;
    
    INSERT INTO equipamentos_consumos (id, hora_inicio, hora_fim, kw, equipamentos_equipamento_id, edificio_edificio_id) 
    VALUES (idConsumos, to_date('2019-03-17 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2019-03-17 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1000, idEquipamento, idEdificio);
    
end;