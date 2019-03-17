      $set sourceformat"free"
       program-id. CS00000S.
      *>=================================================================================
      *>    
      *>                                     COBSOFT
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      


      *>=================================================================================
       data division.      
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "b".
       78   c-este-programa                        value "CS00000S".
       78   c-descricao-programa                   value "COBSOFT".
              
       copy CSC00900.cpy.
       copy CSW00900.cpy.
             
       78   c-validar-login                        value "CS00100S".
       78   c-recuperar-login                      value "CS00101S".
       78   c-login-empresa                        value "CS00103S".
       78   c-validar-ambiente                     value "CS00104S".
       78   c-nr-max-tentativas-login              value 3.
       78   c-menu-principal                       value "CS00000M".
     
       01   lw-login.
            03 lw-nr-tentativas                    pic 9(02).
            03 lw-id-retorno-usuario               pic x(01).
               88 lw-login-invalido                     value "I".
               88 lw-login-valido                       value "V".                   
       
       01   f-login.
            03 f-id-usuario                        pic x(11).
            03 f-pw-usuario                        pic x(15).                                                                 

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.

      *>========================================================================================
       screen section.
       
       01   frm-login.
            03 blank screen.
            03 line 18 col 57   value "COBSOFT".  
            03 line 20 col 45   value "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿".
            03 line 21 col 45   value "³                              ³".
            03 line 22 col 45   value "³                              ³".
            03 line 23 col 45   value "³ Usuario:                     ³".
            03 line 24 col 45   value "³                              ³".
            03 line 25 col 45   value "³                              ³".
            03 line 26 col 45   value "³   Senha:                     ³".
            03 line 27 col 45   value "³                              ³".
            03 line 28 col 45   value "³                              ³".
            03 line 29 col 45   value "³                              ³".
            03 line 30 col 45   value "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ".           
                                                                          
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
       
            initialize                              lnk-par
                                                    wf-opcoes-frame
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
            if   lnk-sem-erros
                 set lnk-carregar-diretorios        to true
                 call c-carregar-linkage using lnk-par
                 cancel c-carregar-linkage       
            end-if
            
            if   lnk-sem-erros
                 call c-validar-ambiente using lnk-par
                 cancel c-validar-ambiente    
            end-if
            
            if   lnk-sem-erros
                 
                 perform until wf-frame-retornar
                      
                      evaluate wf-frame
                           when 0
                                perform 2100-monta-login
                           when 9
                                perform 2999-controle-frame
                           when other   
                                move "Frame invalido!"   to ws-mensagem
                                perform 9000-mensagem
                      end-evaluate
                           
                 end-perform
            
            end-if
                                    
       
       exit.
      *>=================================================================================
       2100-monta-login section.
       
            initialize                             lw-login
            
            perform until lw-login-valido
                       or lw-nr-tentativas >= c-nr-max-tentativas-login
                       or lnk-com-erros
            
                 display frm-login
            
                 perform until f-id-usuario <> spaces
                      accept f-id-usuario at line 23 col 56 with update auto-skip
                 end-perform
            
                 perform until f-pw-usuario <> spaces
                      accept f-pw-usuario at line 26 col 56 with update auto-skip secure           
                 end-perform
                 
                 move f-id-usuario                 to lnk-id-usuario
                 move f-pw-usuario                 to lnk-pw-usuario 
                 call c-validar-login using lnk-par lw-login
                 cancel c-validar-login 
                 
                 initialize                        f-login 
            
            end-perform
            
            if   lnk-sem-erros
                 if  lw-nr-tentativas >= 3
                     call c-recuperar-login using lnk-par lw-login
                     cancel c-recuperar-login
                     perform 9000-abortar
                 end-if
            end-if
            
            if   lnk-sem-erros
                 call c-login-empresa using lnk-par
                 cancel c-login-empresa           
            end-if            
            
            if   lnk-sem-erros
                 set lnk-carregar-prametros        to true
                 call c-carregar-linkage using lnk-par
                 cancel c-carregar-linkage
            end-if
            
            if   lnk-sem-erros
                 perform 8000-controle-frame 
            else
                 set lnk-sem-erros                 to true
                 
                 perform 8000-inicia-frame
            end-if
            
       exit.
      
      *>=================================================================================
       2200-menu section.
       
            call c-menu-principal using lnk-par
            cancel c-menu-principal
       
       exit.
                    
      *>=================================================================================
       2999-controle-frame section.
       
            evaluate wf-opcao
                 when 0
                      perform 2200-menu     
                 when other
                      move "Opcão invalido!"       to ws-mensagem
                      perform 9000-mensagem
            end-evaluate
            
            set wf-frame-retornar                  to true                
       
       exit.  
       
      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão
       
      *>=================================================================================
      *> Leituras    