      $set sourceformat"free"
       program-id. ProgramaTemplate.
      *>=================================================================================
      *>    
      *>                    Gerenciador de Chamadas do Projeto
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
       78   c-este-programa                         value "ProgramaTemplate".     
                                                                          
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
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
