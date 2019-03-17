      $set sourceformat"free"
       program-id. CS10008C.
      *>=================================================================================
      *>    
      *>                              Usuarios x Empresas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

       copy CSS00700.cpy.
       copy CSS00800.cpy. 
       copy CSS00900.cpy.

      *>=================================================================================
       data division.
             
       copy CSF00700.cpy.
       copy CSF00800.cpy. 
       copy CSF00900.cpy.
     
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10008C".
       78   c-descricao-programa                   value "USUARIOS X EMPRESAS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-id-validacao                     pic x(01).
               88 ws-validacao-ok                       value "S".
               88 ws-validacao-nok                      value "N".
            03 ws-nr-linha                         pic 9(02).
            03 ws-linha-display                    pic x(53).

       01   ws-quadros.
            03 ws-cabecalho-quadro.
               05 filler                           pic x(01) value all "Ú".
               05 filler                           pic x(55) value all "Ä". 
               05 filler                           pic x(01) value all "¿".   
            03 ws-linha-quadro.
               05 filler                           pic x(01) value all "³".
               05 filler                           pic x(55) value all " ". 
               05 filler                           pic x(01) value all "³". 
            03 ws-rodape-quadro.
               05 filler                           pic x(01) value all "À".
               05 filler                           pic x(55) value all "Ä". 
               05 filler                           pic x(01) value all "Ù". 
                                        
       01   f-usuario-empresa.
            03 f-cpf                               pic 9(11).
            03 f-nome-usuario                      pic x(55).
            03 f-cd-empresa                        pic 9(03).
            03 f-cd-filial                         pic 9(04).
       
      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-usuario.
            03 line 11 col 21   pic x(12) value "Login (CPF):".
            03 line 11 col 34   pic x(14) from ws-mascara-cpf.
            03 line 11 col 34   pic 9(03) from f-cpf(01:03).
            03 line 11 col 38   pic 9(03) from f-cpf(04:03).
            03 line 11 col 42   pic 9(03) from f-cpf(07:03).
            03 line 11 col 46   pic 9(02) from f-cpf(10:02).
            03 line 13 col 20   pic x(13) value "Nome Usuario:".
            03 line 13 col 34   pic x(55) from f-nome-usuario.
            03 line 15 col 18   pic x(15) value "Codigo Empresa:".
            03 line 15 col 34   pic 9(03) from f-cd-empresa.
            03 line 17 col 19   pic x(14) value "Codigo Filial:".
            03 line 17 col 34   pic 9(04) from f-cd-filial.
            
       01   frm-empresa.
            03 line 19 col 29   pic x(08) value "EMPRESAS".
            03 line 20 col 04   pic x(57) from ws-cabecalho-quadro.
            03 line 21 col 04   pic x(57) from ws-linha-quadro.
            03 line 22 col 04   pic x(57) from ws-linha-quadro.
            03 line 23 col 04   pic x(57) from ws-linha-quadro.
            03 line 24 col 04   pic x(57) from ws-linha-quadro.
            03 line 25 col 04   pic x(57) from ws-linha-quadro.
            03 line 26 col 04   pic x(57) from ws-linha-quadro.
            03 line 27 col 04   pic x(57) from ws-linha-quadro.
            03 line 28 col 04   pic x(57) from ws-linha-quadro.
            03 line 29 col 04   pic x(57) from ws-linha-quadro.
            03 line 30 col 04   pic x(57) from ws-linha-quadro.
            03 line 31 col 04   pic x(57) from ws-linha-quadro.
            03 line 32 col 04   pic x(57) from ws-linha-quadro.
            03 line 33 col 04   pic x(57) from ws-linha-quadro.
            03 line 34 col 04   pic x(57) from ws-linha-quadro.
            03 line 35 col 04   pic x(57) from ws-linha-quadro.
            03 line 36 col 04   pic x(57) from ws-linha-quadro.
            03 line 37 col 04   pic x(57) from ws-linha-quadro.
            03 line 38 col 04   pic x(57) from ws-linha-quadro.
            03 line 39 col 04   pic x(57) from ws-linha-quadro.
            03 line 40 col 04   pic x(57) from ws-linha-quadro.
            03 line 41 col 04   pic x(57) from ws-linha-quadro.
            03 line 42 col 04   pic x(57) from ws-linha-quadro.
            03 line 43 col 04   pic x(57) from ws-linha-quadro.
            03 line 44 col 04   pic x(57) from ws-linha-quadro.
            03 line 45 col 04   pic x(57) from ws-linha-quadro.
            03 line 46 col 04   pic x(57) from ws-linha-quadro.
            03 line 47 col 04   pic x(57) from ws-linha-quadro.
            03 line 48 col 04   pic x(57) from ws-rodape-quadro. 
       
       01   frm-usuario-empresa.
            03 line 19 col 82   pic x(18) value "USUARIO X EMPRESAS".
            03 line 20 col 63   pic x(57) from ws-cabecalho-quadro.
            03 line 21 col 63   pic x(57) from ws-linha-quadro.
            03 line 22 col 63   pic x(57) from ws-linha-quadro.
            03 line 23 col 63   pic x(57) from ws-linha-quadro.
            03 line 24 col 63   pic x(57) from ws-linha-quadro.
            03 line 25 col 63   pic x(57) from ws-linha-quadro.
            03 line 26 col 63   pic x(57) from ws-linha-quadro.
            03 line 27 col 63   pic x(57) from ws-linha-quadro.
            03 line 28 col 63   pic x(57) from ws-linha-quadro.
            03 line 29 col 63   pic x(57) from ws-linha-quadro.
            03 line 30 col 63   pic x(57) from ws-linha-quadro.
            03 line 31 col 63   pic x(57) from ws-linha-quadro.
            03 line 32 col 63   pic x(57) from ws-linha-quadro.
            03 line 33 col 63   pic x(57) from ws-linha-quadro.
            03 line 34 col 63   pic x(57) from ws-linha-quadro.
            03 line 35 col 63   pic x(57) from ws-linha-quadro.
            03 line 36 col 63   pic x(57) from ws-linha-quadro.
            03 line 37 col 63   pic x(57) from ws-linha-quadro.
            03 line 38 col 63   pic x(57) from ws-linha-quadro.
            03 line 39 col 63   pic x(57) from ws-linha-quadro.
            03 line 40 col 63   pic x(57) from ws-linha-quadro.
            03 line 41 col 63   pic x(57) from ws-linha-quadro.
            03 line 42 col 63   pic x(57) from ws-linha-quadro.
            03 line 43 col 63   pic x(57) from ws-linha-quadro.
            03 line 44 col 63   pic x(57) from ws-linha-quadro.
            03 line 45 col 63   pic x(57) from ws-linha-quadro.
            03 line 46 col 63   pic x(57) from ws-linha-quadro.
            03 line 47 col 63   pic x(57) from ws-linha-quadro.
            03 line 48 col 63   pic x(57) from ws-rodape-quadro.                     
       
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
           
           perform 9000-abrir-i-pd00700
           perform 9000-abrir-i-pd00800
           perform 9000-abrir-io-pd00900

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

            perform 9000-incluir-manutencao
                              
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
                      move "Usuário com perfil especial - Inclusão não permitida!" to ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame 
                      exit section                 
                 end-if 
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
            
            perform 9000-incluir-manutencao
      
       exit.

      *>=================================================================================
       2100-exclusao section.

            if   not lnk-permite-exclusao
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
                      move "Usuário com perfil especial - exclusão não permitida!" to ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame 
                      exit section                 
                 end-if 
                 perform 9000-move-registros-frame
                 
                 move "Excluir todas as empresas atreladas ao usuário? [S/N]" to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim
                 
                      initialize                   f00900-usuario-empresa
                      move f-cpf                   to f00900-id-usuario
                      perform 9000-str-pd00900-gtr
                      perform 9000-ler-pd00900-nex
                      perform until not ws-operacao-ok
                           or f00900-id-usuario <> f-cpf
                           
                           delete pd00900
                             
                           perform 9000-ler-pd00900-nex
                      end-perform
                      
                 else
                      set ws-mensagem-opcao-sim              to true
                      
                      perform until ws-mensagem-opcao-nao
                           
                           set ws-mensagem-opcao-nao         to true
                           
                           move zeros                        to f-cd-empresa
                           move zeros                        to f-cd-filial
                           
                           perform until f-cd-empresa <> zeros
                                accept f-cd-empresa at line 15 col 34 with update auto-skip 
                           end-perform
                           
                           perform until f-cd-filial <> zeros
                                accept f-cd-filial at line 17 col 34 with update auto-skip
                           end-perform
                           
                           initialize                             f00700-empresa
                           move f-cd-empresa                      to f00700-cd-empresa
                           move f-cd-filial                       to f00700-cd-filial
                           perform 9000-ler-pd00700-ran
                           if   not ws-operacao-ok
                                string "Empresa não cadastrada! [" f-cd-empresa "." f-cd-filial "]" into ws-mensagem
                                perform 9000-mensagem
                                exit perform cycle
                           end-if 
                           
                           initialize                             f00900-usuario-empresa
                           move f-cpf                             to f00900-id-usuario
                           move f-cd-empresa                      to f00900-cd-empresa
                           move f-cd-filial                       to f00900-cd-filial
                           perform 9000-ler-pd00900-ran
                           if   ws-operacao-ok
                                delete pd00900 
                           else
                                string "Usuário não vínculado à [" f-cd-empresa "." f-cd-filial "]!" into ws-mensagem
                                perform 9000-mensagem
                           end-if
                           
                           perform 8000-tela
                           
                      end-perform     
                           
                 end-if

                 perform 8000-controle-frame
            end-if 
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.
       
       
       exit.        
             
      *>=================================================================================
       3000-finalizacao section.

            close pd00700
            close pd00800
            close pd00900

       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
       
      *>=================================================================================
       8000-tela section.
                  
            perform 9000-frame-padrao
            display frm-usuario
            
            perform 9000-tela-empresa
            
            perform 9000-tela-usuario-empresa
       
       exit.          

      *>=================================================================================
       8000-limpa-tela section.
       
            initialize                             f-usuario-empresa
            
            perform 9000-frame-padrao
            display frm-usuario
            
            perform 9000-tela-empresa
            
            perform 9000-tela-usuario-empresa
       
       exit.                                  
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================       
       9000-move-registros-frame section.
       
            initialize                             f-usuario-empresa
            move f00800-id-usuario                 to f-cpf
            move f00800-nome-usuario               to f-nome-usuario

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
       9000-tela-empresa section.
        
            display frm-empresa
            
            move 21                                to ws-nr-linha
            
            initialize                             f00700-empresa
            perform 9000-str-pd00700-gtr
            perform 9000-ler-pd00700-nex
            perform until not ws-operacao-ok
            
                 if   f00700-empresa-inativa
                      perform 9000-ler-pd00700-nex
                 end-if   
            
                 move spaces                       to ws-linha-display
                 
                 string f00700-cd-empresa "." f00700-cd-filial " - " f00700-razao-social " - " f00700-nome-fantasia delimited by "  " into ws-linha-display 
                    
                 move function upper-case(ws-linha-display) to ws-linha-display
                 
                 display ws-linha-display at line ws-nr-linha col 06 
                 
                 add 01                            to ws-nr-linha
                 
                 if   ws-nr-linha > 47
                      exit perform
                 end-if   
                 
                 perform 9000-ler-pd00700-nex
            end-perform
       
       exit.

      *>=================================================================================
       9000-tela-usuario-empresa section.
       
            display frm-usuario-empresa
            
            move 21                                to ws-nr-linha
            
            if   f-cpf not greater zeros
                 exit section
            end-if
            
            initialize                             f00900-usuario-empresa
            move f-cpf                             to f00900-id-usuario
            perform 9000-str-pd00900-gtr
            perform 9000-ler-pd00900-nex
            perform until not ws-operacao-ok
                 or   f00900-id-usuario <> f-cpf
                 
                 initialize                        f00700-empresa
                 move f00900-cd-empresa            to f00700-cd-empresa
                 move f00900-cd-filial             to f00700-cd-filial
                 perform 9000-ler-pd00700-ran                         
                 
                 move spaces                       to ws-linha-display
                 
                 string f00700-cd-empresa "." f00700-cd-filial " - " f00700-razao-social " - " f00700-nome-fantasia delimited by "  " into ws-linha-display 
                    
                 move function upper-case(ws-linha-display) to ws-linha-display
                 
                 display ws-linha-display at line ws-nr-linha col 65 
                 
                 add 01                            to ws-nr-linha
                 
                 if   ws-nr-linha > 47
                      exit perform
                 end-if
                  
                 perform 9000-ler-pd00900-nex
                    
            end-perform                              
       
       exit.
       
      *>=================================================================================       
       9000-incluir-manutencao section.

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
                 exit section
            end-if
            
            perform 9000-move-registros-frame
            
            if   f00800-desenvolvimento
                 move "Usuário com perfil especial - Inclusão não permitida!" to ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame 
                 exit section                 
            end-if   
            
            set ws-mensagem-opcao-sim              to true
            
            perform until ws-mensagem-opcao-nao
                 
                 set ws-mensagem-opcao-nao         to true
                 
                 move zeros                        to f-cd-empresa
                 move zeros                        to f-cd-filial
                 
                 perform until f-cd-empresa <> zeros
                      accept f-cd-empresa at line 15 col 34 with update auto-skip 
                 end-perform
                 
                 perform until f-cd-filial <> zeros
                      accept f-cd-filial at line 17 col 34 with update auto-skip
                 end-perform
                 
                 initialize                             f00700-empresa
                 move f-cd-empresa                      to f00700-cd-empresa
                 move f-cd-filial                       to f00700-cd-filial
                 perform 9000-ler-pd00700-ran
                 if   not ws-operacao-ok
                      string "Empresa não cadastrada! [" f-cd-empresa "." f-cd-filial "]" into ws-mensagem
                      perform 9000-mensagem
                      exit perform cycle
                 end-if 
                 
                 initialize                             f00900-usuario-empresa
                 move f-cpf                             to f00900-id-usuario
                 move f-cd-empresa                      to f00900-cd-empresa
                 move f-cd-filial                       to f00900-cd-filial
                 perform 9000-ler-pd00900-ran
                 if   ws-operacao-ok
                      string "Usuário já vinculado a unidade [" f-cd-empresa "." f-cd-filial "]! Deseja remover? [S/N]" into ws-mensagem
                      perform 9000-mensagem
                      
                      if   ws-mensagem-opcao-sim
                           delete pd00900
                      end-if   
                 else
                      move "Confirma inclusão de registro? [S/N]" to ws-mensagem
                      perform 9000-mensagem
                         
                      initialize                        f00900-usuario-empresa
                      move f-cpf                        to f00900-id-usuario
                      move f-cd-empresa                 to f00900-cd-empresa
                      move f-cd-filial                  to f00900-cd-filial
                      
                      perform 9000-gravar-pd00900
                      
                      if   not ws-operacao-ok
                           string "Erro de gravação - f00900-usuario-empresa [" f00900-usuario-empresa "]" into ws-mensagem
                           perform 9000-mensagem                
                      end-if
                 end-if
                 
                 perform 8000-tela
                 
                 move "Víncular\Remover usuário a outra empresa? [S/N]?" to ws-mensagem
                 perform 9000-mensagem
            
            end-perform         
       
       exit.
                        
      *>=================================================================================
      *> Leituras

       copy CSR00700.cpy.
       copy CSR00800.cpy. 
       copy CSR00900.cpy.