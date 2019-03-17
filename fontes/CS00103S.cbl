      $set sourceformat"free"
       program-id. CS00103S.
      *>=================================================================================
      *>    
      *>                    Carregar Empresas - Usuário x Empresas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      
       
       copy CSS00700.cpy. *> Empresas
       copy CSS00900.cpy. *> Usuário x Empresa                   

      *>=================================================================================
       data division.
       
       copy CSF00700.cpy. *> Empresas
       copy CSF00900.cpy. *> Usuário x Empresa                           
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                                value "a".
       78   c-este-programa                         value "CS00103S".
       78   c-descricao-programa                    value "MENU PRINCIPAL".        
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       01   ws-campos-trabalho.
            03 ws-linha-display                    pic x(60).
            03 ws-cd-empresa                       pic 9(03).
            03 ws-cd-filial                        pic 9(04).
            03 ws-nr-linha                         pic 9(03).
            03 ws-qtde-empresas                    pic 9(03).
            03 ws-nome-empresa                     pic x(45).
            03 ws-id-encontrou-empresa             pic x(01).
               88 ws-nao-encontrou-empresa              value " ".
               88 ws-encontrou-empresa                  value "S".
 
       01   f-login-empresa.
            03 f-linha-divisao.
               05 filler                           pic x(01)    value "³".
               05 filler                           pic x(58)    value spaces.
               05 filler                           pic x(01)    value "³".
            03 f-linha-empresa.
               05 filler                           pic x(02)    value "³ ".
               05 f-cd-empresa                     pic 9(03).
               05 filler                           pic x(01)    value ".".
               05 f-cd-filial                      pic 9(04).
               05 filler                           pic x(03)    value " - ".
               05 f-nome-empresa                   pic x(45).
               05 filler                           pic x(02)    value " ³".
            03 f-linha-rodape.
               05 filler                           pic x(01)    value "À".
               05 filler                           pic x(58)    value all "Ä".
               05 filler                           pic x(01)    value "Ù".  
            
      *>=================================================================================
       linkage section.
       
       copy CSL00900.cpy.
         
      *>=================================================================================
       screen section.
       
       01   frm-login-empresa.
            03 blank screen.
            03 line 02 col 47   value "INFORME A EMPRESA:".
            03 line 04 col 31   value "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿".
            03 line 05 col 31   value "³                                                          ³".
                                                                        
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
       
            perform 9000-abrir-i-pd00700
            perform 9000-abrir-i-pd00900
            
            initialize                             wf-opcoes-frame
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
            perform until wf-frame-retornar
                      
                 evaluate wf-frame
                      when 0
                           perform 2100-tela-empresas
                      when 9
                           perform 2999-controle-frame
                      when other   
                           move "Frame invalido!"   to ws-mensagem
                           perform 9000-mensagem
                 end-evaluate
                           
            end-perform
       
       exit.
      *>=================================================================================
       2100-tela-empresas section.
       
            display                                frm-login-empresa
            
            if   lnk-login-master
                 perform 2200-login-master
            else
                 perform 2200-login-comum    
            end-if
                 
       exit. 
      *>=================================================================================
       2200-login-master section.
       
            move 06                                to ws-nr-linha
            
            initialize                             f00700-empresa
            perform 9000-str-pd00700-gtr
            perform 9000-ler-pd00700-nex
            perform until not ws-operacao-ok
            
                 perform 2300-linha-empresa
            
                 perform 9000-ler-pd00700-nex
            end-perform

            initialize                             f-linha-rodape
            move f-linha-rodape                    to ws-linha-display
            perform 2310-display-linha
            
            perform 8000-controle-frame 
                   
       exit.       
       
      *>=================================================================================
       2200-login-comum section.

            move 06                                to ws-nr-linha
            move 00                                to ws-qtde-empresas
            
            initialize                             f00900-usuario-empresa
            move lnk-id-usuario                    to f00900-id-usuario
            perform 9000-str-pd00900-gtr
            perform 9000-ler-pd00900-nex
            perform until not ws-operacao-ok
                 or f00900-id-usuario <> lnk-id-usuario
                 
                 initialize                        f00700-empresa 
                 move f00900-cd-empresa            to f00700-cd-empresa
                 move f00900-cd-filial             to f00700-cd-filial
                 perform 9000-ler-pd00700-ran
                 if   not ws-operacao-ok
                      exit perform cycle
                 end-if
                 
                 add 01                            to ws-qtde-empresas
                 
                 perform 2300-linha-empresa     
                 
                 perform 9000-ler-pd00900-nex
            end-perform
            
            initialize                             f-linha-rodape
            move f-linha-rodape                    to ws-linha-display
            perform 2310-display-linha
            
            if   ws-qtde-empresas greater zeros
                 perform 8000-controle-frame
            else
                 string "Nenhuma empresa vínculada ao usuário [" lnk-id-usuario "]" into ws-mensagem
                 perform 9000-mensagem
                 
                 set lnk-com-erros                 to true
                 
                 perform 9000-abortar         
            end-if  
       
       exit.       
      *>=================================================================================
       2300-linha-empresa section.
       
            initialize                             f-linha-empresa
            move f00700-cd-empresa                 to f-cd-empresa
            move f00700-cd-filial                  to f-cd-filial
            
            move spaces                            to ws-nome-empresa
            string f00700-razao-social " - " f00700-nome-fantasia delimited by "  " into ws-nome-empresa
            
            move ws-nome-empresa              to f-nome-empresa
            move f-linha-empresa                   to ws-linha-display
            
            perform 2310-display-linha
            
            initialize                             f-linha-divisao
            move f-linha-divisao                   to ws-linha-display
            perform 2310-display-linha

       exit.       
       
      *>=================================================================================
       2310-display-linha section.
       
            display ws-linha-display at line ws-nr-linha col 31
            
            add 01                                 to ws-nr-linha 
       
       exit.

      *>=================================================================================
       2200-carregar-empresa section.
       
            set ws-nao-encontrou-empresa           to true
            
            perform until ws-encontrou-empresa
                 
                 accept ws-cd-empresa at line 02 col 67 with update auto-skip
                 
                 accept ws-cd-filial at line 02 col 71 with update auto-skip
                 
                 if   ws-cd-empresa not equal zeros
                 and  ws-cd-filial not equal zeros
                      if   not lnk-login-master
                           initialize                   f00900-usuario-empresa
                           move lnk-id-usuario          to f00900-id-usuario
                           move ws-cd-empresa           to f00900-cd-empresa
                           move ws-cd-filial            to f00900-cd-filial 
                           perform 9000-ler-pd00900-ran
                           if   ws-operacao-ok
                                initialize                   f00700-empresa
                                move f00900-cd-empresa       to f00700-cd-empresa
                                move f00900-cd-filial        to f00700-cd-filial
                                perform 9000-ler-pd00700-ran
                                if   ws-operacao-ok
                                     set ws-encontrou-empresa    to true
                                end-if                       
                           end-if                       
                      else
                           initialize                   f00700-empresa
                           move ws-cd-empresa           to f00700-cd-empresa
                           move ws-cd-filial            to f00700-cd-filial
                           perform 9000-ler-pd00700-ran
                           if   ws-operacao-ok
                                set ws-encontrou-empresa    to true
                           end-if                         
                      end-if

                 end-if
                 
                 if   not ws-encontrou-empresa
                      string "Código de Empresa/Filial inválido! [" ws-cd-empresa "." ws-cd-filial "]" into ws-mensagem
                      perform 9000-mensagem 
                 end-if        
            
            end-perform
            
            move f00700-cd-empresa                 to lnk-cd-empresa
            move f00700-cd-filial                  to lnk-cd-filial
            move f00700-razao-social               to lnk-razao-social
            move f00700-nome-fantasia              to lnk-nome-fantasia
            
            set wf-frame-retornar                  to true 
       
       exit.
       
      *>=================================================================================
       2999-controle-frame section.
       
            evaluate wf-opcao
                 when 0
                      perform 2200-carregar-empresa     
                 when other
                      move "Opcão invalido!"       to ws-mensagem
                      perform 9000-mensagem
            end-evaluate
       
       exit.
             
      *>=================================================================================
       3000-finalizacao section.
       
            close pd00700
       
       exit.

      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
       
      *>=================================================================================
      *> Rotinas Genérias
      
       copy CSP00900.cpy.
                                                               
      *>=================================================================================
      *> Leituras
      
       copy CSR00700.cpy. *> Empresas
       copy CSR00900.cpy. *> Usuário x Empresa  