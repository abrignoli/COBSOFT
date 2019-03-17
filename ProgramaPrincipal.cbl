      $set sourceformat"free"
       program-id. ProgramaPrincipal.
      *>=================================================================================
      *>    
      *>                      Gerenciador de Chamadas do Projeto
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      


      *>=================================================================================
       data division.      
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                                value "a".
       78   c-este-programa                         value "ProgramaPrincipal".
       78   c-frame-principal                       value "CS00000S".
       78   c-controle-assincrono                   value "CS00001S".
       
       
       01   ws-campos-trabalho.
            03 ws-linha-commando                    pic x(500)  value spaces.

       copy CSL00900.cpy.     
                 
                                                                          
      *>=================================================================================
       procedure division.
       
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
       
            accept ws-linha-commando                from command-line
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
            if   ws-linha-commando equal spaces
                 call c-frame-principal using lnk-par
                 cancel c-frame-principal
            else
                 call c-controle-assincrono using lnk-par
                 cancel c-controle-assincrono
            end-if      
       
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
