      *>================================================================  
       9000-abrir-i-pd01300 section.
           string lnk-dat-path delimited   by "  " "\EFD013.DAT" into wid-pd01300         
                                           
           open input pd01300
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD013.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================  
       9000-abrir-io-pd01300 section.
           
           string lnk-dat-path delimited   by "  " "\EFD013.DAT" into wid-pd01300 
                                           
           open i-o pd01300
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD013.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================
       9000-str-pd01300-gtr section.
       
            start pd01300 key is greater f01300-chave  
       
       exit.

      *>================================================================
       9000-ler-pd01300-ran section.
       
            read pd01300
        
       exit.
       
      *>================================================================
       9000-ler-pd01300-nex section.
       
            read pd01300 next
        
       exit.      
            
      *>================================================================
       9000-gravar-pd01300 section.
       
            write f01300-usuario-modulo
           
       exit.
       
      *>================================================================
       9000-regravar-pd01300 section.
       
            rewrite f01300-usuario-modulo
           
       exit.
     
      



      


