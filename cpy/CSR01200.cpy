        *>================================================================  
       9000-abrir-i-pd01200 section.
           string lnk-dat-path delimited   by "  " "\EFD012.DAT" into wid-pd01200         
                                           
           open input pd01200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD012.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================  
       9000-abrir-io-pd01200 section.
           
           string lnk-dat-path delimited   by "  " "\EFD012.DAT" into wid-pd01200 
                                           
           open i-o pd01200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD012.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================
       9000-str-pd01200-gtr section.
       
            start pd01200 key is greater f01200-chave  
       
       exit.

      *>================================================================
       9000-ler-pd01200-ran section.
       
            read pd01200
        
       exit.
       
      *>================================================================
       9000-ler-pd01200-nex section.
       
            read pd01200 next
        
       exit.      
            
      *>================================================================
       9000-gravar-pd01200 section.
       
            write f01200-usuario-perfil
           
       exit.
       
      *>================================================================
       9000-regravar-pd01200 section.
       
            rewrite f01200-usuario-perfil
           
       exit.
      


