      $set sourceformat"free"
       program-id. CS10015C.
      *>=================================================================================
      *>    
      *>                                Cadastro de Produtos
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      
        
       copy CSS01800.cpy.

      *>=================================================================================
       data division.      

       copy CSF01800.cpy.
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10015C".
       78   c-descricao-programa                   value "PRODUTOS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-cd-produto                       pic 9(09).

       01   f-produto.
            03 f-cd-produto                        pic 9(09).
            03 f-descricao-produto                 pic x(55).
            03 f-descricao-abreviada               pic x(55).
            03 f-cd-categoria                      pic 9(09).
            03 f-ean                               pic 9(13).
            03 f-ncm                               pic 9(08).
            03 f-data-inclusao                     pic 9(08).
            03 f-data-exclusao                     pic 9(08).
            03 f-unidade-medida                    pic x(10).
            03 f-fator-conversao                   pic 9(09).
            03 f-peso-bruto                        pic zzzzzzzzz,zzzz.
            03 f-peso-liquido                      pic zzzzzzzzz,zzzz.       

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-produto.
            03 line 11 col 18   pic x(15) value "Codigo Produto:".
            03 line 11 col 34   pic 9(09) from f-cd-produto.
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

           initialize                             wf-opcoes-frame

           perform 9000-abrir-io-pd01800        
       
       exit.
        
      *>=================================================================================
       2000-processamento section.

             perform until wf-frame-retornar
                      
                 evaluate wf-frame
                      when 0
                           perform 8000-tela
                           perform 8000-controle-frame
                      when 9
                           perform 2999-controle-frame
                      when other   
                           move "Frame invalido!"   to ws-mensagem
                           perform 9000-mensagem
                 end-evaluate
                           
            end-perform       
       
       exit.
      *>=================================================================================
       2999-controle-frame section.
        
            perform 8000-accept-opcao
            
            evaluate wf-opcao
                when 01
                     perform 2100-incluir
                when 02
                     perform 2100-consulta
                when 03
                     perform 2100-manutencao
                when 04
                     perform 2100-exclusao
                when 05
                     perform 2100-relatorio
                when 99
                     set wf-frame-retornar         to true                       
                when other    
                     move "Opcao invalida!"   to ws-mensagem
                     perform 9000-mensagem            
            end-evaluate

       exit. 

      *>=================================================================================
       2100-incluir section.

            if   not lnk-permite-inclusao
                 exit section
            end-if       

            perform 8000-limpa-tela 

            initialize                             f01800-produto
            move lnk-cd-empresa                    to f01800-cd-empresa
            move lnk-cd-filial                     to f01800-cd-filial
            move 999999999                         to f01800-cd-produto
            perform 9000-str-pd01800-ngrt
            perform 9000-ler-pd01800-pre
            if   ws-operacao-ok
            and  f01800-cd-empresa equal lnk-cd-empresa
            and  f01800-cd-filial  equal lnk-cd-filial
                 add 1                             to f01800-cd-produto
                 move f01800-cd-produto            to ws-cd-produto
            else
                 move 1                            to ws-cd-produto                                            
            end-if            

            move ws-cd-produto                     to f-cd-produto
            
            perform 8000-tela

            perform until f-descricao-produto <> spaces
                 accept f-descricao-produto at line 13 col 34 with update auto-skip  
            end-perform

            perform until f-descricao-abreviada <> spaces
                 accept f-descricao-abreviada at line 15 col 34 with update auto-skip
            end-perform

            perform until f-cd-categoria <> spaces
                 accept f-cd-categoria at line 17 col 34 with update auto-skip 
            end-perform

            initialize                             f01800-produto
            move lnk-cd-empresa                    to f01800-cd-empresa
            move lnk-cd-filial                     to f01800-cd-filial
            move f-cd-produto                      to f01800-cd-produto
            move f-descricao-produto               to f01800-descricao-produto
            perform 9000-gravar-pd01800
            if   not ws-operacao-ok
                 perform 9000-regravar-pd01800
                 if    not ws-operacao-ok
                       string "Erro ao gravar produto! - " ws-resultado-acesso into ws-mensagem
                       perform 9000-mensagem
                 end-if
            end-if
    
            

       exit.


      *>=================================================================================
       2100-consulta section.

       exit.


      *>=================================================================================
       2100-manutencao section.

       exit.


      *>=================================================================================
       2100-exclusao section.

       exit.


      *>=================================================================================
       2100-relatorio section.

       exit.
      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame

      *>=================================================================================
       8000-tela section.
                  
            perform 9000-frame-padrao
            display frm-produto
       
       exit.          

      *>=================================================================================
       8000-limpa-tela section.
       
            initialize                             f-produto
            
            perform 9000-frame-padrao
            display frm-produto
       
       exit. 
                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão
       
      *>=================================================================================
      *> Leituras 

       copy CSR01800.cpy.