      *>================================================================  
       9000-abrir-i-pd01100 section.
           string lnk-dat-path delimited   by "  " "\EFD011.DAT" into wid-pd01100         
                                           
           open input pd01100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD011.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================  
       9000-abrir-io-pd01100 section.
           
           string lnk-dat-path delimited   by "  " "\EFD011.DAT" into wid-pd01100 
                                           
           open i-o pd01100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD011.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================
       9000-str-pd01100-gtr section.
       
            start pd01100 key is greater f01100-chave  
       
       exit.

      *>================================================================
       9000-ler-pd01100-ran section.
       
            read pd01100
        
       exit.
       
      *>================================================================
       9000-ler-pd01100-nex section.
       
            read pd01100 next
        
       exit.      
            
      *>================================================================
       9000-gravar-pd01100 section.
       
            write f01100-perfil-modulo
           
       exit.
       
      *>================================================================
       9000-regravar-pd01100 section.
       
            rewrite f01100-perfil-modulo
           
       exit.