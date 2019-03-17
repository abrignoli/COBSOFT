      $set sourceformat"free"
       program-id. CS10017C.
      *>=================================================================================
      *>    
      *>                        Gerenciador de Chamadas Assincronas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      


      *>=================================================================================
       data division.      
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10017C".
       78   c-descricao-programa                   value "MATERIAIS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 stop-programa                       pic x(02).

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-material.
            03 line 11 col 17   pic x(16) value "Codigo Material:".
            03 line 13 col 23   pic x(10) value "Descricao:".
            03 line 15 col 13   pic x(20) value "Descricao Abreviada:".
            03 line 17 col 16   pic x(17) value "Codigo Categoria:".
            03 line 19 col 13   pic x(20) value "Descricao Categoria: ".
            03 line 21 col 22   pic x(11) value "Codigo EAN:".
            03 line 23 col 29   pic x(04) value "NCM:".
            03 line 25 col 19   pic x(14) value "Data Inclusao:".
            03 line 25 col 48   pic x(14) value "Data Exclusao:".
            03 line 27 col 15   pic x(18) value "Unidade de Medida:".
            03 line 29 col 14   pic x(19) value "Fator de Conversao:".
            03 line 31 col 22   pic x(11) value "Peso Bruto:".
            03 line 31 col 49   pic x(13) value "Peso Liquido:".


      *>=================================================================================
       procedure division using lnk-par.
       
      *>=================================================================================

       0000-controle section.
            perform 1000-inicializacao
            perform 2000-processamento
            perform 3000-finalizacao.
       0000-saida.    
            exit program
            stop run
       exit.
       
      *>=================================================================================
       1000-inicializacao section.
       
            perform 9000-frame-padrao
            display frm-material
            accept stop-programa
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
       
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão
       
      *>=================================================================================
      *> Leituras 