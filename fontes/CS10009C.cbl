      $set sourceformat"free"
       program-id. CS10009C.
      *>=================================================================================
      *>    
      *>                        Gerenciador de Chamadas Assincronas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

       copy CSS01000.cpy.

      *>=================================================================================
       data division.      
 
       copy CSF01000.cpy.
     
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10009C".
       78   c-descricao-programa                   value "PERFIL".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-status-perfil                    pic x(01).
               88 ws-perfil-existente                   value "S".
               88 ws-perfil-inexistente                 value " ".
            03 ws-id-validacao                     pic x(01).
               88 ws-validacao-ok                       value "S".
               88 ws-validacao-nok                      value "N".
            
       01   f-perfil.
            03 f-cd-perfil                         pic 9(03).
            03 f-descricao-perfil                  pic x(55).
      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-perfil.
            03 line 11 col 19   pic x(14) value "Codigo Perfil:".
            03 line 11 col 34   pic 9(03) from f-cd-perfil.
            03 line 13 col 21   pic x(12) value "Nome Perfil:". 
            03 line 13 col 34   pic x(55) from f-descricao-perfil.                                 
       
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

           perform 9000-abrir-io-pd01000

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
 
            perform until f-cd-perfil <> zeros            
                 accept f-cd-perfil at line 11 col 34 with update auto-skip 
            end-perform

            initialize                             f01000-perfil
            move lnk-cd-empresa                    to f01000-cd-empresa
            move lnk-cd-filial                     to f01000-cd-filial
            move f-cd-perfil                       to f01000-cd-perfil
            perform 9000-ler-pd01000-ran
            if   ws-operacao-ok
                 string "Perfil já cadastrado! [" f-cd-perfil "]" into ws-mensagem
                 perform 9000-mensagem
                 
                 set ws-perfil-existente           to true
                 
                 perform 9000-move-registros-frame
            end-if
            
            perform until f-descricao-perfil <> spaces
                 accept f-descricao-perfil at line 13 col 34 with update auto-skip
            end-perform

            if   not ws-perfil-existente
                 
                 move "Confirma inclusão do registro? [S/N]"    to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim

                      initialize                   f01000-perfil
                      move lnk-cd-empresa          to f01000-cd-empresa
                      move lnk-cd-filial           to f01000-cd-filial
                      move f-cd-perfil             to f01000-cd-perfil
                      move f-descricao-perfil      to f01000-descricao-perfil

                      perform 9000-gravar-pd01000
                      
                      if   not ws-operacao-ok
                           string "Erro de gravação - f01000-perfil [" f01000-perfil "]" into ws-mensagem
                           perform 9000-mensagem
                      end-if  

                 end-if

             end-if            
       exit.
       
      *>=================================================================================
       2100-consulta section.

            if   not lnk-permite-consulta
                 exit section
            end-if       

            perform 8000-limpa-tela 
 
            perform until f-cd-perfil <> zeros            
                 accept f-cd-perfil at line 11 col 34 with update auto-skip 
            end-perform

            initialize                             f01000-perfil
            move lnk-cd-empresa                    to f01000-cd-empresa
            move lnk-cd-filial                     to f01000-cd-filial
            move f-cd-perfil                       to f01000-cd-perfil
            perform 9000-ler-pd01000-ran
            if   not ws-operacao-ok
                 string "Pefil não Cadastrado! - [" f-cd-perfil "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame 
            else
                 perform 9000-move-registros-frame
                 perform 8000-controle-frame
            end-if      
   
       exit.

      *>=================================================================================
       2100-manutencao section.

            if   not lnk-permite-manutencao
                 exit section
            end-if       

            perform 8000-limpa-tela 
 
            perform until f-cd-perfil <> zeros            
                 accept f-cd-perfil at line 11 col 34 with update auto-skip 
            end-perform

            initialize                             f01000-perfil
            move lnk-cd-empresa                    to f01000-cd-empresa
            move lnk-cd-filial                     to f01000-cd-filial
            move f-cd-perfil                       to f01000-cd-perfil
            perform 9000-ler-pd01000-ran
            if   not ws-operacao-ok
                 string "Usuário não Cadastrado! - [" f-cd-perfil "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section 
            else
                 perform 9000-move-registros-frame
            end-if     

            perform until exit

                 accept f-descricao-perfil at line 13 col 34 with update auto-skip

                 if   f-descricao-perfil <> spaces
                      exit perform
                 end-if
            end-perform

            move "Confirma alteração do registro? [S/N]"    to ws-mensagem
            perform 9000-mensagem
                 
            if   ws-mensagem-opcao-sim

                 initialize                        f01000-perfil
                 move lnk-cd-empresa               to f01000-cd-empresa
                 move lnk-cd-filial                to f01000-cd-filial
                 move f-cd-perfil                  to f01000-cd-perfil
                 perform 9000-ler-pd01000-ran
                 if   not ws-operacao-ok
                      string "Perfil não Cadastrado! - [" f-cd-perfil "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section 
                 end-if
                 
                 move f-descricao-perfil      to f01000-descricao-perfil

                 perform 9000-regravar-pd01000

                 if   not ws-operacao-ok
                      string "Erro de gravação - f01000-perfil [" f01000-perfil "]" into ws-mensagem
                      perform 9000-mensagem
                 end-if 

            end-if       
       exit.

      *>=================================================================================
       2100-exclusao section.

            if   not lnk-permite-exclusao
                 exit section
            end-if       

            perform 8000-limpa-tela 
 
            perform until f-cd-perfil <> zeros            
                 accept f-cd-perfil at line 11 col 34 with update auto-skip 
            end-perform

            initialize                             f01000-perfil
            move lnk-cd-empresa                    to f01000-cd-empresa
            move lnk-cd-filial                     to f01000-cd-filial
            move f-cd-perfil                       to f01000-cd-perfil
            perform 9000-ler-pd01000-ran
            if   not ws-operacao-ok
                 string "Perfil não Cadastrado! - [" f-cd-perfil "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame 
            else
                 perform 9000-move-registros-frame
                 
                 perform 9000-validacao
                 
                 if   ws-validacao-ok
                      perform 9000-sleep-3s
                 
                      move "Confirma exclusão de registro? [S/N]"   to ws-mensagem
                      perform 9000-mensagem 
                 
                      if   ws-mensagem-opcao-sim
                           delete pd01000
                      end-if
                 end-if                 
                 
                 perform 8000-controle-frame
            end-if      
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.
       
       
       exit.        
             
      *>=================================================================================
       3000-finalizacao section.

            close pd01000

       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
       
      *>=================================================================================
       8000-tela section.
                  
            perform 9000-frame-padrao
            display frm-perfil
       
       exit.          

      *>=================================================================================
       8000-limpa-tela section.
       
            initialize                             f-perfil
            
            perform 9000-frame-padrao
            display frm-perfil
       
       exit.                                  
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================       
       9000-move-registros-frame section.
       
            initialize                             f-perfil
            move f01000-cd-perfil                  to f-cd-perfil
            move f01000-descricao-perfil           to f-descricao-perfil

            perform 8000-tela
                                  
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

       copy CSR01000.cpy. 