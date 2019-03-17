      *>=================================================================================
       9000-mensagem section.

            call c-mensagem using lnk-par ws-parametros-mensagem
            cancel c-mensagem

            move spaces                            to ws-mensagem
           
       exit.
       
      *>=================================================================================
       9000-abortar section.
       
            perform 3000-finalizacao
            perform 0000-saida
            
       exit.

      *>=================================================================================
       9000-frame-padrao section.
       
            move c-este-programa                   to lnk-cd-programa
            move c-versao                          to lnk-vs-programa
            move c-descricao-programa              to lnk-ds-programa
            call c-frame-padrao using lnk-par
            cancel c-frame-padrao
            
            move spaces                            to lnk-ds-funcao 
              
       exit.

      *>=================================================================================
       9000-sleep section.
            
            call c-sleep using ws-nr-segundos
            cancel c-sleep
       
       exit.

      *>=================================================================================
       9000-sleep-1s section.
            
            move 01                                to ws-nr-segundos
            call c-sleep using ws-nr-segundos
            cancel c-sleep
       
       exit. 
      *>=================================================================================
       9000-sleep-3s section.
            
            move 03                                to ws-nr-segundos
            call c-sleep using ws-nr-segundos
            cancel c-sleep
       
       exit. 