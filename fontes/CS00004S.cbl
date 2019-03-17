      $set sourceformat"free"
       program-id. CS00004S.
      *>=================================================================================
      *>    
      *>                          Gerenciador de Relatórios
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
       78   c-este-programa                         value "CS00004S".

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
                                                                          
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
       
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
       
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
