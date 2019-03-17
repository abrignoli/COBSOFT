      $set sourceformat"free"
       program-id. CS10007C.
      *>=================================================================================
      *>    
      *>                        Gerenciador de Chamadas Assincronas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.

       copy CSS00800.cpy.      

      *>=================================================================================
       data division.      

       copy CSF00800.cpy. 
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10007C".
       78   c-descricao-programa                   value "USUARIOS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-status-usuario                   pic x(01).
               88 ws-usuario-existente                  value "S".
               88 ws-usuario-inexistente                value " ".
            03 ws-nr-random                        pic 9(06).
            03 ws-id-validacao                     pic x(01).
               88 ws-validacao-ok                       value "S".
               88 ws-validacao-nok                      value "N".
       
       01   f-usuario.
            03 f-cpf                               pic 9(11).
            03 f-nome-usuario                      pic x(55).
            03 f-data-nascimento                   pic 9(08).
            03 f-sexo                              pic x(01).
               88 f-masculino                           value "M".
               88 f-feminino                            value "F".
            03 f-ds-sexo                           pic x(20).   
            03 f-email                             pic x(55).
            03 f-id-atribuir-acesso                pic x(01).
               88 f-permite-atribuir-acesso             value "S".
               88 f-nao-permite-atribuir-acesso         value "N".
            03 f-ds-atribuir-acesso                pic x(20).
            03 f-id-status-usuario                 pic x(01).
               88 f-inativo                             value "I".
               88 f-bloqueado                           value "B".
               88 f-em-aprovacao                        value "E".
               88 f-ativo                               value "A".
            03 f-ds-status-usuario                 pic x(20). 
            03 f-id-trocar-senha                   pic x(01).
               88 f-trocar-senha                         value "S".
            03 f-id-perfil-especial                pic x(01).
               88 f-desenvolvimento                     value "D".
  
            
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
            03 line 15 col 17   pic x(16) value "Data Nascimento:".
            03 line 15 col 34   pic x(10) from ws-mascara-data.
            03 line 15 col 34   pic 9(02) from f-data-nascimento(01:02).
            03 line 15 col 37   pic 9(02) from f-data-nascimento(03:02).
            03 line 15 col 40   pic 9(04) from f-data-nascimento(05:04).
            03 line 17 col 28   pic x(05) value "Sexo:".
            03 line 17 col 34   pic x(01) from f-sexo.
            03 line 17 col 36   pic x(01) value "-".
            03 line 17 col 38   pic x(20) from f-ds-sexo.
            03 line 19 col 26   pic x(07) value "E-mail:".
            03 line 19 col 34   pic x(55) from f-email.
            03 line 21 col 17   pic x(16) value "Atribuir Acesso:".
            03 line 21 col 34   pic x(01) from f-id-atribuir-acesso.
            03 line 21 col 36   pic x(01) value "-".
            03 line 21 col 38   pic x(20) from f-ds-atribuir-acesso.
            03 line 23 col 18   pic x(15) value "Status Usuario:".  
            03 line 23 col 34   pic x(01) from f-id-status-usuario.
            03 line 23 col 36   pic x(01) value "-".
            03 line 23 col 38   pic x(20) from f-ds-status-usuario.                                    
      
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

           perform 9000-abrir-io-pd00800
           
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
 
            perform until f-cpf <> zeros            
                 
                    accept f-cpf(01:03) at line 11 col 34 with update auto-skip

                    accept f-cpf(04:03) at line 11 col 38 with update auto-skip 

                    accept f-cpf(07:03) at line 11 col 42 with update auto-skip 

                    accept f-cpf(10:02) at line 11 col 46 with update auto-skip 
 
            end-perform

            set ws-usuario-inexistente             to true 
            
            initialize                             f00800-usuario
            move f-cpf                             to f00800-id-usuario
            perform 9000-ler-pd00800-ran
            if   ws-operacao-ok
                 string "Usuário já utilizado! [" f-cpf "]" into ws-mensagem
                 perform 9000-mensagem
                 
                 set ws-usuario-existente          to true
                 
                 perform 9000-move-registros-frame
            end-if     
            
            perform until f-nome-usuario <> spaces
                 accept f-nome-usuario at line 13 col 34 with update auto-skip 
            end-perform
            
            perform until exit
                 
                 if   f-data-nascimento greater zeros
                      exit perform
                 end-if
                 
                 accept f-data-nascimento(01:02) at line 15 col 34 with update auto-skip
                 
                 accept f-data-nascimento(03:02) at line 15 col 37 with update auto-skip
                 
                 accept f-data-nascimento(05:04) at line 15 col 40 with update auto-skip 
                 
            end-perform
            
            perform until exit
            
                if   f-masculino
                or   f-feminino
                     exit perform 
                end-if
                
                 accept f-sexo at line 17 col 34 with update auto-skip
                
                 perform 9000-monta-descricao-sexo
                
            end-perform
            
            perform until f-email <> spaces
                 accept f-email at line 19 col 34 with update auto-skip
            end-perform
            
            perform until exit

                 if   f-permite-atribuir-acesso
                 or   f-nao-permite-atribuir-acesso
                      exit perform
                 end-if

                 accept f-id-atribuir-acesso at line 21 col 34 with update auto-skip

                 perform 9000-monta-descricao-atribuir-acesso
                        
            end-perform
            
            perform until exit

                 if   f-inativo
                 or   f-bloqueado
                 or   f-em-aprovacao
                 or   f-ativo
                      exit perform
                 end-if
                    
                 accept f-id-status-usuario at line 23 col 34 with update auto-skip

                 perform 9000-monta-descricao-status-usuario
 
            end-perform

            if   not ws-usuario-existente
                 
                 move "Confirma inclusão do registro? [S/N]"    to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim

                      initialize                   f00800-usuario
                      move f-cpf                   to f00800-id-usuario

                      compute ws-nr-random = function random * 333333333 
                      
                      move ws-nr-random            to f00800-pw-usuario
                      
                      string "Senha do usuário: [" f00800-pw-usuario "]" into ws-mensagem 
                      perform 9000-mensagem

                      move f-nome-usuario          to f00800-nome-usuario

                      move f-data-nascimento       to ws-data
                      move ws-dia                  to ws-dia-inv
                      move ws-mes                  to ws-mes-inv
                      move ws-ano                  to ws-ano-inv
                      move ws-data-inv             to f00800-data-nascimento
                      
                      move f-sexo                  to f00800-sexo
                      move f-email                 to f00800-email
                      move f-id-atribuir-acesso    to f00800-id-atribuir-acesso
                      
                      move "A"                     to f00800-id-status-usuario
                      move "S"                     to f00800-id-trocar-senha
                      
                      accept ws-data-inv           from date yyyymmdd
                      move ws-data-inv             to f00800-data-criacao

                      accept ws-horas              from time
                      move ws-horas                to f00800-hora-criacao

                      perform 9000-gravar-pd00800
                      
                      if   not ws-operacao-ok
                           string "Erro de gravação - f00800-usuario [" f00800-usuario "]" into ws-mensagem
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
            else
                 perform 9000-move-registros-frame
            end-if
            
            if   f00800-desenvolvimento
                 string "Usuário não pode ser editado! - [" f-cpf "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section            
            end-if   

            perform until exit

                 accept f-nome-usuario at line 13 col 34 with update auto-skip

                 if   f-nome-usuario <> spaces
                      exit perform
                 end-if
                     
            end-perform
            
            perform until exit             
                 
                 accept f-data-nascimento(01:02) at line 15 col 34 with update auto-skip
                 
                 accept f-data-nascimento(03:02) at line 15 col 37 with update auto-skip
                 
                 accept f-data-nascimento(05:04) at line 15 col 40 with update auto-skip
 
                 if   f-data-nascimento greater zeros
                      exit perform
                 end-if
                 
            end-perform
            
            perform until exit
                
                 accept f-sexo at line 17 col 34 with update auto-skip
                
                 perform 9000-monta-descricao-sexo

                 if   f-masculino
                 or   f-feminino
                      exit perform 
                 end-if
                
            end-perform
            
            perform until exit

                 accept f-email at line 19 col 34 with update auto-skip

                 if    f-email <> spaces
                       exit perform
                 end-if

            end-perform
            
            perform until exit

                 accept f-id-atribuir-acesso at line 21 col 34 with update auto-skip

                 perform 9000-monta-descricao-atribuir-acesso

                 if   f-permite-atribuir-acesso
                 or   f-nao-permite-atribuir-acesso
                      exit perform
                 end-if
                        
            end-perform
            
            perform until exit
                    
                 accept f-id-status-usuario at line 23 col 34 with update auto-skip

                 perform 9000-monta-descricao-status-usuario

                 if   f-inativo
                 or   f-bloqueado
                 or   f-em-aprovacao
                 or   f-ativo
                      exit perform
                 end-if
 
            end-perform                

            move "Confirma alteração do registro? [S/N]"    to ws-mensagem
            perform 9000-mensagem
                 
            if   ws-mensagem-opcao-sim

                 initialize                        f00800-usuario
                 move f-cpf                        to f00800-id-usuario
                 perform 9000-ler-pd00800-ran
                 if   not ws-operacao-ok
                      string "Usuário não encontrado! - [" f-cpf "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section 
                 end-if

                 move f-nome-usuario               to f00800-nome-usuario
                 move f-data-nascimento            to ws-data
                 move ws-dia                       to ws-dia-inv
                 move ws-mes                       to ws-mes-inv
                 move ws-ano                       to ws-ano-inv
                 move ws-data-inv                  to f00800-data-nascimento                                 
                 move f-sexo                       to f00800-sexo
                 move f-email                      to f00800-email
                 move f-id-atribuir-acesso         to f00800-id-atribuir-acesso
                 move f-id-status-usuario          to f00800-id-status-usuario

                 perform 9000-regravar-pd00800

                 if   not ws-operacao-ok
                      string "Erro de gravação - f00800-nome-usuario [" f00800-nome-usuario "]" into ws-mensagem
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
                 perform 9000-move-registros-frame
                 
                 perform 9000-validacao
                 
                 if   ws-validacao-ok
                      perform 9000-sleep-3s
                 
                      move "Confirma exclusão de registro? [S/N]"   to ws-mensagem
                      perform 9000-mensagem 
                 
                      if   ws-mensagem-opcao-sim
                           delete pd00800
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
    
            close pd00800
              
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
                               
      *>=================================================================================  
       8000-tela section.                                                                  
                                                                                                          
            perform 9000-frame-padrao                                                      
            display frm-usuario                                                                                                                                                                                          
                                                                                           
       exit.                                                                               

      *>=================================================================================  
       8000-limpa-tela section.                                                                  
                                                                                           
            initialize                             f-usuario                               
                                                                                           
            perform 9000-frame-padrao                                                      
            display frm-usuario                                                                                                            
                                                                                           
       exit.                                                                                                                 
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================       
       9000-move-registros-frame section.
       
            initialize                             f-usuario
            move f00800-id-usuario                 to f-cpf                                                      
            move f00800-nome-usuario               to f-nome-usuario                      
            move f00800-data-nascimento            to f-data-nascimento                   
            move f00800-sexo                       to f-sexo
            perform 9000-monta-descricao-sexo            
            move f00800-email                      to f-email                      
            move f00800-id-atribuir-acesso         to f-id-atribuir-acesso
            perform 9000-monta-descricao-atribuir-acesso
            move f00800-id-status-usuario          to f-id-status-usuario
            perform 9000-monta-descricao-status-usuario
                                  
       exit.

      *>=================================================================================       
       9000-move-registros-arquivo section.
       

                   
       exit. 

      *>=================================================================================         
       9000-monta-descricao-sexo section.

            move function upper-case(f-sexo)       to f-sexo
            
            evaluate true
                 when f-masculino
                      move "MASCULINO"             to f-ds-sexo
                      perform 8000-tela
                 when f-feminino
                      move "FEMININO"              to f-ds-sexo
                      perform 8000-tela                     
                 when other
                      move "INVALIDO"              to f-ds-sexo
                      perform 8000-tela                   
            end-evaluate

       exit.

      *>=================================================================================         
       9000-monta-descricao-atribuir-acesso section.

            move function upper-case(f-id-atribuir-acesso)  to f-id-atribuir-acesso

            evaluate true

                 when f-permite-atribuir-acesso
                      move "SIM"                   to f-ds-atribuir-acesso
                      perform 8000-tela
                 when f-nao-permite-atribuir-acesso
                      move "NAO"                   to f-ds-atribuir-acesso
                      perform 8000-tela                     
                 when other
                      move "INVALIDO"              to f-ds-atribuir-acesso
                      perform 8000-tela 
            end-evaluate  

       exit.   

      *>=================================================================================         
       9000-monta-descricao-status-usuario section.

            move function upper-case(f-id-status-usuario)  to f-id-status-usuario

            evaluate true

                 when f-inativo
                      move "INATIVO"               to f-ds-status-usuario
                      perform 8000-tela
                 when f-bloqueado
                      move "BLOQUEADO"             to f-ds-status-usuario
                      perform 8000-tela
                 when f-em-aprovacao
                      move "EM APROVACAO"          to f-ds-status-usuario
                      perform 8000-tela
                 when f-ativo
                      move "ATIVO"                 to f-ds-status-usuario
                      perform 8000-tela                     
                 when other
                      move "INVALIDO"              to f-ds-status-usuario
                      perform 8000-tela 
            end-evaluate 

       exit.

      *>=================================================================================
       9000-validacao section.
       
            set ws-validacao-ok                    to true

            if   f00800-desenvolvimento
                 string "Usuário não pode ser excluído! - [" f-cpf "]" into ws-mensagem
                 perform 9000-mensagem
                 set ws-validacao-nok              to true
                 exit section            
            end-if             
       
       exit.  
           
      *>=================================================================================
      *> Leituras

       copy CSR00800.cpy.  