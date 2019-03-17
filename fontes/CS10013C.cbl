      $set sourceformat"free"
       program-id. CS10013C.
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
       78   c-este-programa                        value "CS10013C".
       78   c-descricao-programa                   value "FORNECEDORES".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 stop-programa                       pic x(02).

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-fornecedor.
            03 line 11 col 15   pic x(18) value "Codigo Fornecedor:".
            03 line 13 col 20   pic x(13) value "Razao Social:".
            03 line 15 col 19   pic x(14) value "Nome Fantasia:".
            03 line 17 col 21   pic x(12) value "Tipo Pessoa:".
            03 line 19 col 24   pic x(09) value "CNPJ/CPF:".
            03 line 19 col 59   pic x(03) value "IE:".
            03 line 21 col 29   pic x(04) value "CEP:".
            03 line 23 col 22   pic x(11) value "Logradouro:".
            03 line 25 col 15   pic x(18) value "Numero Logradouro:".
            03 line 25 col 55   pic x(07) value "Bairro:".
            03 line 27 col 23   pic x(10) value "Municipio:".
            03 line 29 col 30   pic x(03) value "UF:".
            03 line 29 col 57   pic x(05) value "Pais:".
            03 line 31 col 24   pic x(09) value "Telefone:".
            03 line 33 col 24   pic x(09) value "Telefone:".
            03 line 35 col 24   pic x(09) value "Telefone:".
            03 line 37 col 26   pic x(07) value "E-mail:".

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
            display frm-fornecedor
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