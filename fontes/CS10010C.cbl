      $set sourceformat"free"
       program-id. CS10010C.
      *>=================================================================================
      *>    
      *>                        Gerenciador de Chamadas Assincronas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

       copy CSS00000.cpy.
       copy CSS01000.cpy.
       copy CSS01100.cpy.

      *>=================================================================================
       data division. 
            
       copy CSF00000.cpy.
       copy CSF01000.cpy.
       copy CSF01100.cpy.
             
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10010C".
       78   c-descricao-programa                   value "PERFIL x MODULOS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 stop-programa                       pic x(02).
       
       01   f-perfil-modulo.
            03 f-cd-perfil                         pic 9(03).
            03 f-nome-perfil                       pic x(55). 
            03 f-cd-programa                       pic x(08).
            03 f-nome-programa                     pic x(55).
            03 f-id-consulta                       pic x(01).
               88 f-permite-consulta                     value "S".
               88 f-nao-permite-consulta                 value "N".
            03 f-ds-consulta                       pic x(20).
            03 f-id-inclusao                       pic x(01).
               88 f-permite-inclusao                      value "S".
               88 f-nao-permite-inclusao                  value "N".
            03 f-ds-inclusao                       pic x(20).
            03 f-id-manutencao                     pic x(01).
               88 f-permite-manutencao                    value "S".
               88 f-nao-permite-manutencao                value "N".
            03 f-ds-manutencao                     pic x(20).
            03 f-id-exclusao                       pic x(01).
               88 f-permite-exclusao                     value "S".
               88 f-nao-permite-exclusao                 value "N".
            03 f-ds-exclusao                       pic x(20).
      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-perfil-modulo.
            03 line 11 col 19   pic x(14) value "Codigo Perfil:".
            03 line 11 col 34   pic 9(03) from f-cd-perfil.
            03 line 13 col 21   pic x(12) value "Nome Perfil:".
            03 line 13 col 34   pic x(55) from f-nome-perfil.
            03 line 15 col 17   pic x(16) value "Codigo Programa:".
            03 line 15 col 34   pic x(08) from f-cd-programa.
            03 line 15 col 43   pic x(01) value "-".
            03 line 15 col 45   pic x(55) from f-nome-programa.
            03 line 17 col 16   pic x(17) value "Permite Consulta:".
            03 line 17 col 34   pic x(01) from f-id-consulta.
            03 line 17 col 36   pic x(01) from "-".
            03 line 17 col 38   pic x(20) from f-ds-consulta.
            03 line 19 col 16   pic x(17) value "Permite Inclusao:".
            03 line 19 col 34   pic x(01) from f-id-inclusao.
            03 line 19 col 36   pic x(01) from "-".
            03 line 19 col 38   pic x(20) from f-ds-inclusao.
            03 line 21 col 14   pic x(19) value "Permite Manutencao:".
            03 line 21 col 34   pic x(01) from f-id-manutencao.
            03 line 21 col 36   pic x(01) from "-".
            03 line 21 col 38   pic x(20) from f-ds-manutencao.
            03 line 23 col 16   pic x(17) value "Permite Exclusao:".   
            03 line 23 col 34   pic x(01) from f-id-exclusao.
            03 line 23 col 36   pic x(01) from "-".
            03 line 23 col 38   pic x(20) from f-ds-exclusao.                               
      
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
           
           perform 9000-abrir-i-pd00000
           perform 9000-abrir-i-pd01000
           perform 9000-abrir-io-pd01100

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
            
            perform 9000-inclusao-manutencao 
            
       exit.
       
      *>=================================================================================
       2100-consulta section.

            if   not lnk-permite-consulta
                 exit section
            end-if       

            perform 8000-limpa-tela

            perform until exit
                        
                 accept f-cd-perfil at line 11 col 34 with update auto-skip
                 
                 initialize                        f01000-perfil
                 move lnk-cd-empresa               to f01000-cd-empresa
                 move lnk-cd-filial                to f01000-cd-filial
                 move f-cd-perfil                  to f01000-cd-perfil
                 perform 9000-ler-pd01000-ran
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro na leitura f01000-perfil - " f01000-perfil into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 else
                      if   ws-registro-inexistente
                           move "Perfil não cadastrado!" to ws-mensagem
                           perform 9000-mensagem 
                      else
                           move f01000-descricao-perfil  to f-nome-perfil
                           perform 8000-tela                          
                           exit perform
                      end-if     
                 end-if
                   
            end-perform
            
            perform until exit
                        
                 accept f-cd-programa at line 15 col 34 with update auto-skip
                 
                 move function upper-case(f-cd-programa)    to f-cd-programa
                 
                 initialize                        f00000-programas
                 move f-cd-programa                to f00000-cd-programa
                 perform 9000-ler-pd00000-ran
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro na leitura f00000-programas - " f00000-programas into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 else
                      if   ws-registro-inexistente
                           move "Programa não cadastrado!" to ws-mensagem
                           perform 9000-mensagem 
                      else
                           move f00000-descricao-programa  to f-nome-programa
                           perform 8000-tela                          
                           exit perform
                      end-if     
                 end-if                 
                 
            end-perform
            
            
            initialize                             f01100-perfil-modulo
            move lnk-cd-empresa                    to f01100-cd-empresa
            move lnk-cd-filial                     to f01100-cd-filial
            move f-cd-perfil                       to f01100-cd-perfil
            move f-cd-programa                     to f01100-cd-programa
            perform 9000-ler-pd01100-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro na leitura f01100-perfil-modulo - " f01100-perfil-modulo into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section
            else
                 if   ws-registro-inexistente
                      move "Programa não está vínculado ao perfil!" to ws-mensagem
                      perform 9000-mensagem
                      exit section
                 else
                      move f01100-id-consulta           to f-id-consulta
                      perform 9000-monta-descricao-consulta
                      move f01100-id-inclusao           to f-id-inclusao
                      perform 9000-monta-descricao-inclusao 
                      move f01100-id-manutencao         to f-id-manutencao
                      perform 9000-monta-descricao-manutencao
                      move f01100-id-exclusao           to f-id-exclusao
                      perform 9000-monta-descricao-exclusao
                      
                      perform 8000-tela
                 end-if            
            end-if                 

       exit.

      *>=================================================================================
       2100-manutencao section.

            if   not lnk-permite-manutencao
                 exit section
            end-if       

            perform 8000-limpa-tela
            
            perform 9000-inclusao-manutencao        
       
       exit.

      *>=================================================================================
       2100-exclusao section.

            if   not lnk-permite-exclusao
                 exit section
            end-if       

            perform 8000-limpa-tela

            perform until exit
                        
                 accept f-cd-perfil at line 11 col 34 with update auto-skip
                 
                 initialize                        f01000-perfil
                 move lnk-cd-empresa               to f01000-cd-empresa
                 move lnk-cd-filial                to f01000-cd-filial
                 move f-cd-perfil                  to f01000-cd-perfil
                 perform 9000-ler-pd01000-ran
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro na leitura f01000-perfil - " f01000-perfil into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 else
                      if   ws-registro-inexistente
                           move "Perfil não cadastrado!" to ws-mensagem
                           perform 9000-mensagem 
                      else
                           move f01000-descricao-perfil  to f-nome-perfil
                           perform 8000-tela                          
                           exit perform
                      end-if     
                 end-if
                   
            end-perform
            
            perform until exit
                        
                 accept f-cd-programa at line 15 col 34 with update auto-skip
                 
                 move function upper-case(f-cd-programa)    to f-cd-programa
                 
                 initialize                        f00000-programas
                 move f-cd-programa                to f00000-cd-programa
                 perform 9000-ler-pd00000-ran
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro na leitura f00000-programas - " f00000-programas into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 else
                      if   ws-registro-inexistente
                           move "Programa não cadastrado!" to ws-mensagem
                           perform 9000-mensagem 
                      else
                           move f00000-descricao-programa  to f-nome-programa
                           perform 8000-tela                          
                           exit perform
                      end-if     
                 end-if                 
                 
            end-perform
            
            
            initialize                             f01100-perfil-modulo
            move lnk-cd-empresa                    to f01100-cd-empresa
            move lnk-cd-filial                     to f01100-cd-filial
            move f-cd-perfil                       to f01100-cd-perfil
            move f-cd-programa                     to f01100-cd-programa
            perform 9000-ler-pd01100-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro na leitura f01100-perfil-modulo - " f01100-perfil-modulo into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section
            else
                 if   ws-registro-inexistente
                      move "Programa não está vínculado ao perfil!" to ws-mensagem
                      perform 9000-mensagem
                      exit section
                 else
                      move f01100-id-consulta           to f-id-consulta
                      perform 9000-monta-descricao-consulta
                      move f01100-id-inclusao           to f-id-inclusao
                      perform 9000-monta-descricao-inclusao 
                      move f01100-id-manutencao         to f-id-manutencao
                      perform 9000-monta-descricao-manutencao
                      move f01100-id-exclusao           to f-id-exclusao
                      perform 9000-monta-descricao-exclusao
                      
                      perform 8000-tela
                      
                      perform 9000-sleep-3s
                      
                      move "Confirma exclusão de registro? [S/N]"   to ws-mensagem
                      perform 9000-mensagem 
                      
                      if   ws-mensagem-opcao-sim
                           delete pd01100
                      end-if
                      
                      perform 8000-controle-frame                      
                 end-if            
            end-if                 
       
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.
       
       
       exit.  
      *>=================================================================================
       3000-finalizacao section.
       
            close pd00000
            close pd01000
            close pd01100
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
       
      *>=================================================================================
       8000-tela section.

            perform 9000-frame-padrao
            display frm-perfil-modulo
       
       exit.          

      *>=================================================================================
       8000-limpa-tela section.
       
            initialize                             f-perfil-modulo
            
            perform 9000-frame-padrao
            display frm-perfil-modulo

       exit.                                 
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================                          
       9000-monta-descricao-consulta section.

            move function upper-case(f-id-consulta)    to f-id-consulta
            
            evaluate true
                 when f-permite-consulta
                      move "SIM"              to f-ds-consulta
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when f-nao-permite-consulta
                      move "NAO"              to f-ds-consulta
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when other
                      move "INVALIDO"         to f-ds-consulta
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
            end-evaluate       
       
       exit.

      *>=================================================================================        
       9000-monta-descricao-inclusao section.

            move function upper-case(f-id-inclusao)    to f-id-inclusao
            
            evaluate true
                 when f-permite-inclusao
                      move "SIM"              to f-ds-inclusao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when f-nao-permite-inclusao
                      move "NAO"              to f-ds-inclusao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when other
                      move "INVALIDO"         to f-ds-inclusao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
            end-evaluate       
       
       exit.

      *>=================================================================================        
       9000-monta-descricao-manutencao section.

            move function upper-case(f-id-manutencao)    to f-id-manutencao
            
            evaluate true
                 when f-permite-manutencao
                      move "SIM"              to f-ds-manutencao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when f-nao-permite-manutencao
                      move "NAO"              to f-ds-manutencao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when other
                      move "INVALIDO"         to f-ds-manutencao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
            end-evaluate
                        
       exit.

      *>=================================================================================        
       9000-monta-descricao-exclusao section.
       
            move function upper-case(f-id-exclusao)    to f-id-exclusao
            
            evaluate true
                 when f-permite-exclusao
                      move "SIM"              to f-ds-exclusao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when f-nao-permite-exclusao
                      move "NAO"              to f-ds-exclusao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
                 when other
                      move "INVALIDO"         to f-ds-exclusao
                      perform 9000-frame-padrao
                      display frm-perfil-modulo
            end-evaluate
       
       exit.
       
      *>=================================================================================       
       9000-inclusao-manutencao section.

            perform until exit
                        
                 accept f-cd-perfil at line 11 col 34 with update auto-skip
                 
                 initialize                        f01000-perfil
                 move lnk-cd-empresa               to f01000-cd-empresa
                 move lnk-cd-filial                to f01000-cd-filial
                 move f-cd-perfil                  to f01000-cd-perfil
                 perform 9000-ler-pd01000-ran
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro na leitura f01000-perfil - " f01000-perfil into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 else
                      if   ws-registro-inexistente
                           move "Perfil não cadastrado!" to ws-mensagem
                           perform 9000-mensagem 
                      else
                           move f01000-descricao-perfil  to f-nome-perfil
                           perform 8000-tela                          
                           exit perform
                      end-if     
                 end-if
                   
            end-perform
            
            perform until exit
                        
                 accept f-cd-programa at line 15 col 34 with update auto-skip
                 
                 move function upper-case(f-cd-programa)    to f-cd-programa
                 
                 initialize                        f00000-programas
                 move f-cd-programa                to f00000-cd-programa
                 perform 9000-ler-pd00000-ran
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro na leitura f00000-programas - " f00000-programas into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 else
                      if   ws-registro-inexistente
                           move "Programa não cadastrado!" to ws-mensagem
                           perform 9000-mensagem 
                      else
                           move f00000-descricao-programa  to f-nome-programa
                           perform 8000-tela                          
                           exit perform
                      end-if     
                 end-if                 
                 
            end-perform
            
            
            initialize                             f01100-perfil-modulo
            move lnk-cd-empresa                    to f01100-cd-empresa
            move lnk-cd-filial                     to f01100-cd-filial
            move f-cd-perfil                       to f01100-cd-perfil
            move f-cd-programa                     to f01100-cd-programa
            perform 9000-ler-pd01100-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro na leitura f01100-perfil-modulo - " f01100-perfil-modulo into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section
            else
                 move f01100-id-consulta           to f-id-consulta
                 perform 9000-monta-descricao-consulta
                 move f01100-id-inclusao           to f-id-inclusao
                 perform 9000-monta-descricao-inclusao 
                 move f01100-id-manutencao         to f-id-manutencao
                 perform 9000-monta-descricao-manutencao
                 move f01100-id-exclusao           to f-id-exclusao
                 perform 9000-monta-descricao-exclusao
                 
                 perform 8000-tela       
            end-if                 
            
            
            
            perform until exit          
                 
                 accept f-id-consulta at line 17 col 34 with update auto-skip
                 
                 perform 9000-monta-descricao-consulta                 

                 if   f-permite-consulta
                 or   f-nao-permite-consulta
                      exit perform
                 end-if
                 
            end-perform
            
            perform until exit      
                 
                 accept f-id-inclusao at line 19 col 34 with update auto-skip
                 
                 perform 9000-monta-descricao-inclusao               

                 if   f-permite-inclusao
                 or   f-nao-permite-inclusao
                      exit perform
                 end-if
                 
            end-perform
            
            perform until exit               
                 
                 accept f-id-manutencao at line 21 col 34 with update auto-skip
                 
                 perform 9000-monta-descricao-manutencao                

                 if   f-permite-manutencao
                 or   f-nao-permite-manutencao
                      exit perform
                 end-if
                 
            end-perform
            
            perform until exit            
                 
                 accept f-id-exclusao at line 23 col 34 with update auto-skip
                 
                 perform 9000-monta-descricao-exclusao

                 if   f-permite-exclusao
                 or   f-nao-permite-exclusao
                      exit perform
                 end-if
                 
            end-perform
            
            move "Confirma inclusão/alteração de registro? [S/N]"   to ws-mensagem
            perform 9000-mensagem
            
            if   ws-mensagem-opcao-sim
            
                 initialize                        f01100-perfil-modulo
                 move lnk-cd-empresa               to f01100-cd-empresa
                 move lnk-cd-filial                to f01100-cd-filial
                 move f-cd-perfil                  to f01100-cd-perfil
                 move f-cd-programa                to f01100-cd-programa
                 move f-id-consulta                to f01100-id-consulta
                 move f-id-inclusao                to f01100-id-inclusao
                 move f-id-manutencao              to f01100-id-manutencao
                 move f-id-exclusao                to f01100-id-exclusao
                 perform 9000-gravar-pd01100
                 if   not ws-operacao-ok
                      perform 9000-regravar-pd01100
                      if   not ws-operacao-ok
                           string "Erro ao gravar f01100-perfil-modulo - " f01100-perfil-modulo into ws-mensagem
                           perform 9000-mensagem
                      end-if
                 end-if
            
            end-if       
       
       exit.                   
       
      *>=================================================================================
      *> Leituras

       copy CSR00000.cpy.
       copy CSR01000.cpy.
       copy CSR01100.cpy.       