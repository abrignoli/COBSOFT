      $set sourceformat"free"
       program-id. CS10011C.
      *>=================================================================================
      *>    
      *>                            USUARIO x PERFIL
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

       copy CSS00800.cpy.
       copy CSS01000.cpy.
       copy CSS01100.cpy.
       copy CSS01200.cpy.
       copy CSS01300.cpy.

      *>=================================================================================
       data division.      

       copy CSF00800.cpy.
       copy CSF01000.cpy.
       copy CSF01100.cpy.
       copy CSF01200.cpy.
       copy CSF01300.cpy.
                           
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10011C".
       78   c-descricao-programa                   value "USUARIO x PERFIL".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-nr-linha                         pic 9(02).
            03 ws-linha-display                    pic x(100).

       01   ws-quadros.
            03 ws-cabecalho-quadro.
               05 filler                           pic x(001) value all "Ú".
               05 filler                           pic x(114) value all "Ä". 
               05 filler                           pic x(001) value all "¿".   
            03 ws-linha-quadro.
               05 filler                           pic x(001) value all "³".
               05 filler                           pic x(114) value all " ". 
               05 filler                           pic x(001) value all "³". 
            03 ws-rodape-quadro.
               05 filler                           pic x(001) value all "À".
               05 filler                           pic x(114) value all "Ä". 
               05 filler                           pic x(001) value all "Ù". 
               
       01   f-usuario-perfil.
            03 f-cpf                               pic 9(11).
            03 f-nome-usuario                      pic x(55).
            03 f-cd-perfil                         pic 9(03).
            03 f-nome-perfil                       pic x(55).
            
      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-usuario-perfil.
            03 line 11 col 21   pic x(12) value "Login (CPF):".
            03 line 11 col 34   pic x(14) from ws-mascara-cpf.
            03 line 11 col 34   pic 9(03) from f-cpf(01:03).
            03 line 11 col 38   pic 9(03) from f-cpf(04:03).
            03 line 11 col 42   pic 9(03) from f-cpf(07:03).
            03 line 11 col 46   pic 9(02) from f-cpf(10:02).
            03 line 13 col 20   pic x(13) value "Nome Usuario:".
            03 line 13 col 34   pic x(55) from f-nome-usuario.
            03 line 15 col 19   pic x(14) value "Codigo Perfil:".
            03 line 15 col 34   pic 9(03) from f-cd-perfil.
            03 line 17 col 21   pic x(12) value "Nome Perfil:".
            03 line 17 col 34   pic x(55) from f-nome-perfil.
            
       01   frm-perfil-usuario.
            03 line 20 col 04   pic x(116) from ws-cabecalho-quadro.
            03 line 21 col 04   pic x(116) from ws-linha-quadro.            
            03 line 22 col 04   pic x(116) from ws-linha-quadro. 
            03 line 23 col 04   pic x(116) from ws-linha-quadro. 
            03 line 24 col 04   pic x(116) from ws-linha-quadro. 
            03 line 25 col 04   pic x(116) from ws-linha-quadro. 
            03 line 26 col 04   pic x(116) from ws-linha-quadro. 
            03 line 27 col 04   pic x(116) from ws-linha-quadro. 
            03 line 28 col 04   pic x(116) from ws-linha-quadro. 
            03 line 29 col 04   pic x(116) from ws-linha-quadro. 
            03 line 30 col 04   pic x(116) from ws-linha-quadro. 
            03 line 31 col 04   pic x(116) from ws-linha-quadro. 
            03 line 32 col 04   pic x(116) from ws-linha-quadro. 
            03 line 33 col 04   pic x(116) from ws-linha-quadro. 
            03 line 34 col 04   pic x(116) from ws-linha-quadro. 
            03 line 35 col 04   pic x(116) from ws-linha-quadro. 
            03 line 36 col 04   pic x(116) from ws-linha-quadro. 
            03 line 37 col 04   pic x(116) from ws-linha-quadro. 
            03 line 38 col 04   pic x(116) from ws-linha-quadro. 
            03 line 39 col 04   pic x(116) from ws-linha-quadro. 
            03 line 40 col 04   pic x(116) from ws-linha-quadro.
            03 line 41 col 04   pic x(116) from ws-linha-quadro.
            03 line 42 col 04   pic x(116) from ws-linha-quadro.
            03 line 43 col 04   pic x(116) from ws-linha-quadro.
            03 line 44 col 04   pic x(116) from ws-linha-quadro.
            03 line 45 col 04   pic x(116) from ws-linha-quadro.
            03 line 46 col 04   pic x(116) from ws-linha-quadro.
            03 line 47 col 04   pic x(116) from ws-linha-quadro.
            03 line 48 col 04   pic x(116) from ws-rodape-quadro.  
            
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
           
           perform 9000-abrir-i-pd00800
           perform 9000-abrir-i-pd01000
           perform 9000-abrir-i-pd01100
           perform 9000-abrir-io-pd01200
           perform 9000-abrir-io-pd01300
       
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
             
            perform until f-cpf <> zeros            
                 
                    accept f-cpf(01:03) at line 11 col 34 with update auto-skip

                    accept f-cpf(04:03) at line 11 col 38 with update auto-skip 

                    accept f-cpf(07:03) at line 11 col 42 with update auto-skip 

                    accept f-cpf(10:02) at line 11 col 46 with update auto-skip 
 
            end-perform 

            initialize                             f00800-usuario
            move f-cpf                             to f00800-id-usuario
            perform 9000-ler-pd00800-ran
            if   not ws-operacao-ok
                 string "Usuário não encontrado! - [" f-cpf "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame 
            else                
                 if   f00800-desenvolvimento
                      move "Usuário com perfil especial - Inclusão\alteração não permitida!" to ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame 
                      exit section                 
                 end-if 
                 
                 move f00800-nome-usuario          to f-nome-usuario
                 
                 perform 8000-tela
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

            if   not lnk-permite-consulta
                 exit section
            end-if       

            perform 8000-limpa-tela
             
            perform until f-cpf <> zeros            
                 
                    accept f-cpf(01:03) at line 11 col 34 with update auto-skip

                    accept f-cpf(04:03) at line 11 col 38 with update auto-skip 

                    accept f-cpf(07:03) at line 11 col 42 with update auto-skip 

                    accept f-cpf(10:02) at line 11 col 46 with update auto-skip 
 
            end-perform 

            initialize                             f00800-usuario
            move f-cpf                             to f00800-id-usuario
            perform 9000-ler-pd00800-ran
            if   not ws-operacao-ok
                 string "Usuário não encontrado! - [" f-cpf "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame 
            else                
                 if   f00800-desenvolvimento
                      move "Usuário com perfil especial - Exclusão não permitida!" to ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame 
                      exit section                 
                 end-if 
                 
                 move f00800-nome-usuario          to f-nome-usuario
                 
                 perform 8000-tela
                 
                 move "Excluir todos os perfil atrelado ao usuário? [S/N]" to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim

                      initialize                   f01200-usuario-perfil
                      move lnk-cd-empresa          to f01200-cd-empresa
                      move lnk-cd-filial           to f01200-cd-filial
                      move f-cpf                   to f01200-id-usuario
                      perform 9000-str-pd01200-gtr
                      perform 9000-ler-pd01200-nex
                      perform until not ws-operacao-ok
                           or f01200-id-usuario <> f-cpf
                           
                           delete pd01200
                                             
                           perform 9000-ler-pd01200-nex 
                      end-perform
                 
                      initialize                   f01300-usuario-modulo
                      move lnk-cd-empresa          to f01300-cd-empresa
                      move lnk-cd-filial           to f01300-cd-filial
                      move f-cpf                   to f01300-id-usuario
                      perform 9000-str-pd01300-gtr
                      perform 9000-ler-pd01300-nex
                      perform until not ws-operacao-ok
                           or f01300-id-usuario <> f-cpf
                           
                           delete pd01300
                                             
                           perform 9000-ler-pd01300-nex 
                      end-perform

                 
                 else
                      set ws-mensagem-opcao-sim    to true
                      
                      perform until ws-mensagem-opcao-nao
                           
                           set ws-mensagem-opcao-nao    to true

                           perform until exit
                           
                               accept f-cd-perfil at line 15 col 34 with update auto-skip
                               
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
                      
                           initialize                   f01200-usuario-perfil
                           move lnk-cd-empresa          to f01200-cd-empresa
                           move lnk-cd-filial           to f01200-cd-filial
                           move f-cpf                   to f01200-id-usuario
                           move f-cd-perfil             to f01200-cd-perfil
                           perform 9000-ler-pd01200-ran
                           if   not ws-operacao-ok
                                exit perform cycle 
                           end-if
                      
                           initialize                   f01300-usuario-modulo
                           move lnk-cd-empresa          to f01300-cd-empresa
                           move lnk-cd-filial           to f01300-cd-filial
                           move f-cpf                   to f01300-id-usuario
                           perform 9000-str-pd01300-gtr
                           perform 9000-ler-pd01300-nex
                           perform until not ws-operacao-ok
                                or f01300-id-usuario <> f-cpf
                                
                                delete pd01300
                                                  
                                perform 9000-ler-pd01300-nex 
                           end-perform

                           initialize                        f01200-usuario-perfil
                           move lnk-cd-empresa               to f01200-cd-empresa
                           move lnk-cd-filial                to f01200-cd-filial
                           move f-cpf                        to f01200-id-usuario
                           perform 9000-str-pd01200-gtr
                           perform 9000-ler-pd01200-nex
                           perform until not ws-operacao-ok
                                or f01200-id-usuario <> f-cpf
                                
                                initialize                   f01100-perfil-modulo
                                move lnk-cd-empresa          to f01100-cd-empresa
                                move lnk-cd-filial           to f01100-cd-filial
                                move f01200-cd-perfil        to f01100-cd-perfil
                                perform 9000-str-pd01100-gtr
                                perform 9000-ler-pd01100-nex
                                perform until not ws-operacao-ok
                                     or f01100-cd-perfil <> f01200-cd-perfil
                                     
                                     initialize                   f01300-usuario-modulo
                                     move lnk-cd-empresa          to f01300-cd-empresa
                                     move lnk-cd-filial           to f01300-cd-filial
                                     move f01100-cd-programa      to f01300-cd-programa
                                     move f01100-id-consulta      to f01300-id-consulta
                                     move f01100-id-inclusao      to f00130-id-inclusao   
                                     move f01100-id-manutencao    to f01300-id-manutencao
                                     move f01100-id-exclusao      to f00130-id-exclusao
                                     perform 9000-gravar-pd01300
                                     if   not ws-operacao-ok
                                          perform 9000-regravar-pd01300
                                          if   not ws-operacao-ok
                                               string "Erro ao gravar f01300-usuario-modulo - " ws-resultado-acesso into ws-mensagem
                                               perform 9000-mensagem
                                          end-if
                                     end-if
                                                                
                                     perform 9000-ler-pd01100-nex 
                                end-perform
                                
                               perform 9000-ler-pd01200-nex
                           end-perform 
                           
                      end-perform
                 
                 end-if 
                                  
            end-if        
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.
       
       
       exit.        
                   
      *>=================================================================================
       3000-finalizacao section.
       
            close pd00800
            close pd01000
       
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame

      *>=================================================================================       
       8000-tela section.
       
            perform 9000-frame-padrao
            display frm-usuario-perfil
            
            perform 9000-tela-perfil-usuario            
       
       exit.          

      *>=================================================================================       
       8000-limpa-tela section.
       
            initialize                             f-usuario-perfil
            
            perform 9000-frame-padrao
            display frm-usuario-perfil
            
            perform 9000-tela-perfil-usuario            
       
       exit.                                
      *>=================================================================================       
                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================                          
       9000-tela-perfil-usuario section.
       
            display frm-perfil-usuario
            
            if   f-cpf not greater zeros
                 exit section
            end-if
            
            move 21                                to ws-nr-linha
            
            initialize                             f01200-usuario-perfil
            move lnk-cd-empresa                    to f01200-cd-empresa
            move lnk-cd-filial                     to f01200-cd-filial
            move f-cpf                             to f01200-id-usuario
            perform 9000-str-pd01200-gtr
            perform 9000-ler-pd01200-nex
            perform until not ws-operacao-ok
                 or f01200-id-usuario <> f-cpf
                 
                 initialize                        f01000-perfil
                 move lnk-cd-empresa               to f01000-cd-empresa
                 move lnk-cd-filial                to f01000-cd-filial
                 move f01200-cd-perfil             to f01000-cd-perfil
                 perform 9000-ler-pd01000-ran
                 if   not ws-operacao-ok
                      exit perform cycle
                 end-if      
                 
                 move spaces                       to ws-linha-display
                 
                 string f01000-cd-perfil " - " f01000-descricao-perfil delimited by "  " into ws-linha-display

                 display ws-linha-display at line ws-nr-linha col 06 
                 
                 add 01                            to ws-nr-linha
                 
                 if   ws-nr-linha > 47
                      exit perform
                 end-if                   
                 
                 perform 9000-ler-pd01200-nex      
            end-perform     
       
       exit.                   
      *>=================================================================================
       9000-inclusao-manutencao section.

            perform until f-cpf <> zeros            
                 
                    accept f-cpf(01:03) at line 11 col 34 with update auto-skip

                    accept f-cpf(04:03) at line 11 col 38 with update auto-skip 

                    accept f-cpf(07:03) at line 11 col 42 with update auto-skip 

                    accept f-cpf(10:02) at line 11 col 46 with update auto-skip 
 
            end-perform 

            initialize                             f00800-usuario
            move f-cpf                             to f00800-id-usuario
            perform 9000-ler-pd00800-ran
            if   not ws-operacao-ok
                 string "Usuário não encontrado! - [" f-cpf "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame 
            else                
                 if   f00800-desenvolvimento
                      move "Usuário com perfil especial - Inclusão\alteração não permitida!" to ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame 
                      exit section                 
                 end-if 
                 
                 move f00800-nome-usuario          to f-nome-usuario
                 
                 perform 8000-tela
            end-if
            
            perform until exit
            
                accept f-cd-perfil at line 15 col 34 with update auto-skip
                
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
            
            move "Confirma inclusão\alteração do registro? [S/N]"   to ws-mensagem
            perform 9000-mensagem
            
            if   ws-mensagem-opcao-sim
                 
                 initialize                        f01200-usuario-perfil
                 move lnk-cd-empresa               to f01200-cd-empresa
                 move lnk-cd-filial                to f01200-cd-filial
                 move f-cpf                        to f01200-id-usuario
                 move f-cd-perfil                  to f01200-cd-perfil
                 perform 9000-gravar-pd01200
                 if   not ws-operacao-ok
                      perform 9000-regravar-pd01200
                      if   not ws-operacao-ok
                           string "Erro ao gravar f01200-usuario-perfil - " ws-resultado-acesso into ws-mensagem
                           perform 9000-mensagem
                           exit section
                      end-if
                 end-if
                 
                 *> Exclui todos os programas alterados ao usuário.
                 
                 initialize                        f01300-usuario-modulo
                 move lnk-cd-empresa               to f01300-cd-empresa
                 move lnk-cd-filial                to f01300-cd-filial
                 move f-cpf                        to f01300-id-usuario
                 perform 9000-str-pd01300-gtr
                 perform 9000-ler-pd01300-nex
                 perform until not ws-operacao-ok
                      or f01300-id-usuario <> f-cpf
                      
                      delete pd01300
                                        
                      perform 9000-ler-pd01300-nex 
                 end-perform
                 
                 initialize                        f01200-usuario-perfil
                 move lnk-cd-empresa               to f01200-cd-empresa
                 move lnk-cd-filial                to f01200-cd-filial
                 move f-cpf                        to f01200-id-usuario
                 perform 9000-str-pd01200-gtr
                 perform 9000-ler-pd01200-nex
                 perform until not ws-operacao-ok
                      or f01200-id-usuario <> f-cpf
                      
                      initialize                   f01100-perfil-modulo
                      move lnk-cd-empresa          to f01100-cd-empresa
                      move lnk-cd-filial           to f01100-cd-filial
                      move f01200-cd-perfil        to f01100-cd-perfil
                      perform 9000-str-pd01100-gtr
                      perform 9000-ler-pd01100-nex
                      perform until not ws-operacao-ok
                           or f01100-cd-perfil <> f01200-cd-perfil
                           
                           initialize                   f01300-usuario-modulo
                           move lnk-cd-empresa          to f01300-cd-empresa
                           move lnk-cd-filial           to f01300-cd-filial
                           move f01100-cd-programa      to f01300-cd-programa
                           move f01100-id-consulta      to f01300-id-consulta
                           move f01100-id-inclusao      to f00130-id-inclusao   
                           move f01100-id-manutencao    to f01300-id-manutencao
                           move f01100-id-exclusao      to f00130-id-exclusao
                           perform 9000-gravar-pd01300
                           if   not ws-operacao-ok
                                perform 9000-regravar-pd01300
                                if   not ws-operacao-ok
                                     string "Erro ao gravar f01300-usuario-modulo - " ws-resultado-acesso into ws-mensagem
                                     perform 9000-mensagem
                                end-if
                           end-if
                                                      
                           perform 9000-ler-pd01100-nex 
                      end-perform
                      
                     perform 9000-ler-pd01200-nex
                 end-perform 
                 
                 perform 8000-tela
                 
            end-if
       
       exit.
              
      *>=================================================================================
      *> Leituras
      
       copy CSR00800.cpy.
       copy CSR01000.cpy.
       copy CSR01100.cpy.
       copy CSR01200.cpy.
       copy CSR01300.cpy.            