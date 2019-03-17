      *>================================================================  
       9000-abrir-i-pd01000 section.
           string lnk-dat-path delimited   by "  " "\EFD010.DAT" into wid-pd01000         
                                           
           open input pd01000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD010.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================  
       9000-abrir-io-pd01000 section.
           
           string lnk-dat-path delimited   by "  " "\EFD010.DAT" into wid-pd01000 
                                           
           open i-o pd01000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD010.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================
       9000-str-pd01000-gtr section.
       
            start pd01000 key is greater f01000-chave  
       
       exit.

      *>================================================================
       9000-ler-pd01000-ran section.
       
            read pd01000
        
       exit.
       
      *>================================================================
       9000-ler-pd01000-nex section.
       
            read pd01000 next
        
       exit.      
            
      *>================================================================
       9000-gravar-pd01000 section.
       
            write f01000-perfil
           
       exit.
       
      *>================================================================
       9000-regravar-pd01000 section.
       
            rewrite f01000-perfil
           
       exit.
      


