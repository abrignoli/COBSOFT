      *>================================================================================= 
       9000-abrir-i-pd00200 section.
           string lnk-dat-path delimited   by "  " "\EFD002.DAT" into wid-pd00200                             
                                           
           open input pd00200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD002.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd00200 section.
           string lnk-dat-path delimited   by "  " "\EFD002.DAT" into wid-pd00200                             
                                           
           open output pd00200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD002.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd00200 section.
           string lnk-dat-path delimited   by "  " "\EFD002.DAT" into wid-pd00200                             
                                           
           open i-o pd00200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD002.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd00200-grt section.
       
            start pd00200 key is greater f00200-chave
       
       exit.

      *>=================================================================================
       9000-str-pd00200-ngrt section.
       
            start pd00200 key is not greater f00200-chave
       
       exit.
       
      *>=================================================================================
       9000-ler-pd00200-ran section.
       
            read pd00200
       
       exit. 

      *>=================================================================================
       9000-ler-pd00200-ran-1 section.
       
            read pd00200 key is f00200-chave-1
       
       exit.
        
       *>=================================================================================
       9000-ler-pd00200-nex section.
       
            read pd00200 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd00200-pre section.
       
            read pd00200 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd00200 section.
       
            write f00200-pais
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd00200 section.
       
            rewrite f00200-pais
           
       exit.
      


