      *>================================================================  
       9000-abrir-i-pd00800 section.
           string lnk-dat-path delimited   by "  " "\EFD008.DAT" into wid-pd00800         
                                           
           open input pd00800
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD008.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================  
       9000-abrir-io-pd00800 section.
           
           string lnk-dat-path delimited   by "  " "\EFD008.DAT" into wid-pd00800 
                                           
           open i-o pd00800
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD008.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================
       9000-str-pd00800-gtr section.
       
            start pd00800 key is greater f00800-chave  
       
       exit.

      *>================================================================
       9000-ler-pd00800-ran section.
       
            read pd00800
        
       exit.
       
      *>================================================================
       9000-ler-pd00800-nex section.
       
            read pd00800 next
        
       exit.      
            
      *>================================================================
       9000-gravar-pd00800 section.
       
            write f00800-usuario
           
       exit.
       
      *>================================================================
       9000-regravar-pd00800 section.
       
            rewrite f00800-usuario
           
       exit.
      


