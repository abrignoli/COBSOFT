      $set sourceformat"free"
       program-id. CS10018C.
      *>=================================================================================
      *>    
      *>                                Preços Produtos
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      
        
       copy CSS01800.cpy.
       copy CSS02100.cpy.  

      *>=================================================================================
       data division.      

       copy CSF01800.cpy.
       copy CSF02100.cpy.         
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10018C".
       78   c-descricao-programa                   value "PRECOS PRODUTOS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-cd-produto                       pic 9(09).
            03 ws-vl-unitario                      pic 9(09)v9(02).   

       01   f-produto.
            03 f-cd-produto                        pic zzzzzzzzz.
            03 f-descricao-produto                 pic x(55).
            03 f-vl-unitario                       pic zzz.zzz.zzz,zz.
      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-produto.
            03 line 11 col 18   pic x(15) value "Codigo Produto:".
            03 line 11 col 34   pic 9(09) from f-cd-produto.
            03 line 13 col 23   pic x(10) value "Descricao:".
            03 line 13 col 34   pic x(55) from f-descricao-produto.
            03 line 15 col 19   pic x(15) value "Valor Unitario:".
            03 line 15 col 34   pic zzz.zzz.zzz,zz from f-vl-unitario.

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
           
           perform 9000-abrir-i-pd01800
           perform 9000-abrir-io-pd02100        
       
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

            perform until exit
            
                accept f-cd-produto at line 11 col 34 with update auto-skip

                move f-cd-produto              to ws-cd-produto

                if   ws-cd-produto greater zeros
                     initialize                f01800-produto
                     move lnk-cd-empresa       to f01800-cd-empresa
                     move lnk-cd-filial        to f01800-cd-filial
                     move ws-cd-produto        to f01800-cd-produto
                     perform 9000-ler-pd01800-ran
                     if   not ws-operacao-ok
                     and  not ws-registro-inexistente
                          string "Erro de leitura f01800-produto - " ws-resultado-acesso into ws-mensagem
                          perform 9000-mensagem
                     else
                          if   ws-registro-inexistente
                               string "Produto não cadastrado! [" ws-cd-produto "]" into ws-mensagem
                               perform 9000-mensagem                              
                          else
                               move f01800-cd-produto           to f-cd-produto
                               move f01800-descricao-produto    to f-descricao-produto

                               perform 8000-tela

                               exit perform        
                          end-if      
                     end-if                          
                end-if                     

            end-perform

            perform until exit
                
                move zeros                         to ws-vl-unitario
                
                accept f-vl-unitario at line 15 col 34 with update auto-skip

                move f-vl-unitario                 to ws-vl-unitario

                if   ws-vl-unitario greater zeros
                     exit perform
                end-if                

            end-perform

            move "Confirma inclusão do registro? [S/N]" to ws-mensagem
            perform 9000-mensagem

            if   ws-mensagem-opcao-sim

                 initialize                             f02100-preco-produto
                 move lnk-cd-empresa                    to f02100-cd-empresa
                 move lnk-cd-filial                     to f02100-cd-filial
                 move f-cd-produto                      to f02100-cd-produto
                 move ws-vl-unitario                    to f02100-vl-unitario
                 move function numval(lnk-id-usuario)   to f02100-id-usuario
                 
                 accept ws-data-inv                     from date yyyymmdd
                 accept ws-horas                        from time

                 move ws-data-inv                       to f02100-data-alteracao
                 move ws-horas                          to f02100-hora-alteracao

                 perform 9000-gravar-pd02100
                 if   not ws-operacao-ok
                      perform 9000-regravar-pd02100
                      if   not ws-operacao-ok
                           string "Erro ao gravar  f02100-preco-produto - " ws-resultado-acesso into ws-mensagem
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

            close pd01800
            close pd02100
       
       
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
       copy CSR02100.cpy.