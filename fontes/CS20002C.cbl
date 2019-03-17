      $set sourceformat"free"
       program-id. CS20002C.
      *>=================================================================================
      *>    
      *>                          Gerenciador de Relat�rios
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
       78   c-estoque                               value "CS20003C".

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
       
            call c-estoque using lnk-par
            cancel c-estoque
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
       
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
