      $set sourceformat"free"
       program-id. CS20003C.
      *>=================================================================================
      *>    
      *>                                Cadastro de Paises
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.

       copy CSS01800.cpy.             
       copy CSS06000.cpy. 
         

      *>=================================================================================
       data division.
       
       copy CSF01800.cpy.
       copy CSF06000.cpy. 
              
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS20003C".
       78   c-descricao-programa                   value "ESTOQUE".
              
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-status-pais                      pic x(01).
               88 ws-pais-existente                     value "S".
            03 ws-cd-produto                       pic 9(09).    
            03 ws-id-validacao                     pic x(01).
               88 ws-validacao-ok                       value "S".
               88 ws-validacao-nok                      value "N".   
            
       01   f-estoque.
            03 f-cd-produto                        pic z(09).
            03 f-descricao-produto                 pic x(55).
            03 f-qtde-disponivel                   pic ---.---.--9,9999.
            03 f-qtde-reservada                    pic ---.---.--9,9999. 

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-estoque.
            03 line 11 col 18   pic x(15) value "Codigo Produto:".
            03 line 11 col 34   pic 9(09) from f-cd-produto.
            03 line 13 col 23   pic x(10) value "Descricao:". 
            03 line 13 col 34   pic x(55) from f-descricao-produto.
            03 line 15 col 11   pic x(22) value "Quantidade Disponivel:".
            03 line 15 col 34   pic ---.---.--9,9999 from f-qtde-disponivel.
            03 line 17 col 15   pic x(18) value "Quantidade Locada:".
            03 line 17 col 34   pic ---.---.--9,9999 from f-qtde-reservada.                                       
      
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
            
            perform 9000-abrir-io-pd06000
            perform 9000-abrir-i-pd01800
            
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
                          perform 9000-abortar
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

            initialize                                   f06000-estoque
            move lnk-cd-empresa                          to f06000-cd-empresa
            move lnk-cd-filial                           to f06000-cd-filial
            move f-cd-produto                            to f06000-cd-produto
            perform 9000-ler-pd06000-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro de leitura f01800-produto - " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            else
                 move f06000-qtde-disponivel              to f-qtde-disponivel
                 move f06000-qtde-reservada               to f-qtde-reservada                     
            end-if
            
            perform 8000-tela
            
            perform until exit

                accept f-qtde-disponivel at line 15 col 34 with update auto-skip

                exit perform
            
            end-perform


            perform until exit

                accept f-qtde-reservada at line 17 col 34 with update auto-skip

                exit perform
            
            end-perform

            initialize                             f06000-estoque
            move lnk-cd-empresa                    to f06000-cd-empresa
            move lnk-cd-filial                     to f06000-cd-filial
            move f-cd-produto                      to f06000-cd-produto
            move f-qtde-disponivel                 to f06000-qtde-disponivel
            move f-qtde-reservada                  to f06000-qtde-reservada
            perform 9000-gravar-pd06000
            if   not ws-operacao-ok
                 perform 9000-regravar-pd06000
                 if  not ws-operacao-ok
                     string "Erro ao movimentar estoque - " ws-resultado-acesso into ws-mensagem
                     perform 9000-mensagem
                 end-if   
            end-if                                   
       
       exit.
       
       *>=================================================================================
       2100-consulta section.

            if   not lnk-permite-consulta
                 exit section
            end-if       

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
                          perform 9000-abortar
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

            initialize                                   f06000-estoque
            move lnk-cd-empresa                          to f06000-cd-empresa
            move lnk-cd-filial                           to f06000-cd-filial
            move f-cd-produto                            to f06000-cd-produto
            perform 9000-ler-pd06000-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro de leitura f01800-produto - " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            else
                 move f06000-qtde-disponivel              to f-qtde-disponivel
                 move f06000-qtde-reservada               to f-qtde-reservada                     
            end-if
            
            perform 8000-tela

       
       exit.

      *>=================================================================================
       2100-manutencao section.
       
            if   not lnk-permite-manutencao
                 exit section
            end-if
            
            perform 8000-limpa-tela

            perform 2100-incluir
           
                  
       exit.

      *>=================================================================================
       2100-exclusao section.

            if   not lnk-permite-exclusao
                 exit section
            end-if

            perform 8000-limpa-tela

            perform 2100-incluir

   
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.

            if   not lnk-permite-consulta
                 exit section
            end-if

            perform 2100-incluir
                  
       
       exit.       
             
      *>=================================================================================
       3000-finalizacao section.
       
            close pd06000
       
       exit.
                                                          
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame

      *>================================================================================= 
       8000-tela section.
       
            perform 9000-frame-padrao

            display frm-estoque

       
       exit. 

      *>================================================================================= 
       8000-limpa-tela section.

            perform 9000-frame-padrao

            initialize                          f-estoque

            display frm-estoque       

       exit. 
                                      
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão
                          
      *>=================================================================================       
       9000-move-registros-frame section.
       

                   
       exit.

      *>=================================================================================       
       9000-move-registros-arquivo section.
          
                   
       exit.
       
      *>=================================================================================
       9000-validacao section.
       
            set ws-validacao-ok                    to true

       exit. 
                    
      *>=================================================================================
      *> Leituras
            
       copy CSR01800.cpy.
       copy CSR06000.cpy.
             