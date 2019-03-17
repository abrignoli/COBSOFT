      *>================================================================================= 
       9000-abrir-i-pd00300 section.
           string lnk-dat-path delimited   by "  " "\EFD003.DAT" into wid-pd00300                             
                                           
           open input pd00300
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD003.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd00300 section.
           string lnk-dat-path delimited   by "  " "\EFD003.DAT" into wid-pd00300                             
                                           
           open output pd00300
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD003.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd00300 section.
           string lnk-dat-path delimited   by "  " "\EFD003.DAT" into wid-pd00300                             
                                           
           open i-o pd00300
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD003.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd00300-grt section.
       
            start pd00300 key is greater f00300-chave
       
       exit.

      *>=================================================================================
       9000-str-pd00300-grt-1 section.
       
            start pd00300 key is greater f00300-chave-1
       
       exit.
      *>=================================================================================
       9000-str-pd00300-ngrt section.
       
            start pd00300 key is not greater f00300-chave
       
       exit.       

      *>=================================================================================
       9000-ler-pd00300-ran section.
       
            read pd00300
       
       exit. 

      *>=================================================================================
       9000-ler-pd00300-ran-1 section.
       
            read pd00300 key is f00300-chave-1
       
       exit.
        
       *>=================================================================================
       9000-ler-pd00300-nex section.
       
            read pd00300 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd00300-pre section.
       
            read pd00300 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd00300 section.
       
            write f00300-estado
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd00300 section.
       
            rewrite f00300-estado
           
       exit.
     