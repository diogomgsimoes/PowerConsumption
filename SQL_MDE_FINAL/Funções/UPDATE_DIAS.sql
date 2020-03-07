create or replace FUNCTION 
UPDATE_DIAS(alvo IN TIMESTAMP, referencia IN TIMESTAMP) 
RETURN TIMESTAMP
IS alterado TIMESTAMP;

dataReferencia varchar(11);
horasAlvo varchar(8);
timestampFinal varchar(19);
 
begin

    dataReferencia := to_char(referencia, 'YYYY-MM-DD');
    dataReferencia := dataReferencia || ' ' ;
    horasAlvo := to_char(alvo, 'HH24:MI:SS');
    
    timestampFinal := dataReferencia || horasAlvo;

    alterado := to_date(timestampFinal, 'YYYY-MM-DD HH24:MI:SS');

    RETURN alterado;
END UPDATE_DIAS;
