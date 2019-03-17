      $set sourceformat"free"
       program-id. CS00104S.
      *>=================================================================================
      *>    
      *>                                Validação Ambiente
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.
            
       copy CSS00700.cpy.           

      *>=================================================================================
       data division.
       
       copy CSF00700.cpy.      
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS00104S".
       
       copy CSW00900.cpy.
       
       78   c-impotar-configuracao                 value "CS00005S".     

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
       
            *> Tenta abrir o arquivo de Empresas e Parâmentros se não existir
            *> Entende-se que a base está zerada, logo será permitido a inicialização
            *> dos registros
            
            string lnk-dat-path delimited   by "  " "\EFD007.DAT" into wid-pd00700
            open input pd00700
            if   not ws-operacao-ok
                 call c-impotar-configuracao using lnk-par
                 cancel c-impotar-configuracao                 
            else
                set lnk-sem-erros                  to true
            end-if

       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   
