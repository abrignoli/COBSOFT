      *>================================================================  
       9000-abrir-i-pd00900 section.
           string lnk-dat-path delimited   by "  " "\EFD009.DAT" into wid-pd00900         
                                           
           open input pd00900
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD009.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================  
       9000-abrir-io-pd00900 section.
           
           string lnk-dat-path delimited   by "  " "\EFD009.DAT" into wid-pd00900 
                                           
           open i-o pd00900
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD009.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================
       9000-str-pd00900-gtr section.
       
            start pd00900 key is greater f00900-chave  
       
       exit.

      *>================================================================
       9000-str-pd00900-ngtr section.
       
            start pd00900 key is not greater f00900-chave  
       
       exit.

      *>================================================================
       9000-ler-pd00900-ran section.
       
            read pd00900
        
       exit.
       
      *>================================================================
       9000-ler-pd00900-nex section.
       
            read pd00900 next
        
       exit.      
            
      *>================================================================
       9000-gravar-pd00900 section.
       
            write f00900-usuario-empresa
           
       exit.
       
      *>================================================================
       9000-regravar-pd00900 section.
       
            rewrite f00900-usuario-empresa
           
       exit.
     
      


