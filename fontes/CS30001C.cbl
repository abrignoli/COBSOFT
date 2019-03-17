      $set sourceformat"free"
       program-id. CS30001C.
      *>=================================================================================
      *>    
      *>                                Preços Produtos
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      
        
       copy CSS02200.cpy.  

      *>=================================================================================
       data division.      

       copy CSF02200.cpy.         
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS30001C".
       78   c-descricao-programa                   value "PARAMETROS NF-E".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       01   f-parametros-nfe.
            03 f-numero-documento                  pic 9(09).
            03 f-serie-documento                   pic 9(03).
      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-produto.
            03 line 11 col 16   pic x(17) value "Numero Documento:".
            03 line 11 col 34   pic 9(09) from f-numero-documento.
            03 line 13 col 17   pic x(16) value "Serie Documento:".
            03 line 13 col 34   pic 9(03) from f-serie-documento.

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

           perform 9000-abrir-io-pd02200        
       
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

            perform until f-numero-documento <> zeros
            
                accept f-numero-documento at line 11 col 34 with update auto-skip

            end-perform

            perform until f-serie-documento <> zeros
            
                accept f-serie-documento at line 13 col 34 with update auto-skip

            end-perform            

            move "Confirma inclusão do registro? [S/N]" to ws-mensagem
            perform 9000-mensagem

            if   ws-mensagem-opcao-sim

                 initialize                             f02200-parametros-nfe
                 move lnk-cd-empresa                    to f02200-cd-empresa
                 move lnk-cd-filial                     to f02200-cd-filial
                 move f-numero-documento                to f02200-numero-documento
                 move f-serie-documento                 to f02200-serie-documento

                 perform 9000-gravar-pd02200
                 if   not ws-operacao-ok
                      perform 9000-regravar-pd02200
                      if   not ws-operacao-ok
                           string "Erro ao gravar  f02200-parametros-nfe - " ws-resultado-acesso into ws-mensagem
                           perform 9000-mensagem
                      end-if
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

            close pd02200
       
       
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
       
            initialize                             f-parametros-nfe
            
            perform 9000-frame-padrao
            display frm-produto
       
       exit. 
                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão
       
      *>=================================================================================
      *> Leituras 

       copy CSR02200.cpy.