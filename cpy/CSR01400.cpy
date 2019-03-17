      *>================================================================================= 
       9000-abrir-i-pd01400 section.
           string lnk-dat-path delimited   by "  " "\EFD014.DAT" into wid-pd01400                             
                                           
           open input pd01400
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD014.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd01400 section.
           string lnk-dat-path delimited   by "  " "\EFD014.DAT" into wid-pd01400                             
                                           
           open output pd01400
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD014.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd01400 section.
           string lnk-dat-path delimited   by "  " "\EFD014.DAT" into wid-pd01400                             
                                           
           open i-o pd01400
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD014.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd01400-grt section.
       
            start pd01400 key is greater f01400-chave
       
       exit.

      *>=================================================================================
       9000-str-pd01400-ngrt section.
       
            start pd01400 key is not greater f01400-chave
       
       exit.

      *>=================================================================================
       9000-str-pd01400-grt-1 section.
       
            start pd01400 key is greater f01400-chave-1
       
       exit.

      *>=================================================================================
       9000-str-pd01400-ngrt-1 section.
       
            start pd01400 key is not greater f01400-chave-1
       
       exit.

      *>=================================================================================
       9000-str-pd01400-grt-2 section.
       
            start pd01400 key is greater f01400-chave-1
       
       exit.

      *>=================================================================================
       9000-str-pd01400-ngrt-2 section.
       
            start pd01400 key is not greater f01400-chave-1
       
       exit.       
       
      *>=================================================================================
       9000-ler-pd01400-ran section.
       
            read pd01400
       
       exit. 

      *>=================================================================================
       9000-ler-pd01400-ran-1 section.
       
            read pd01400 key is f01400-chave-1
       
       exit.
        
       *>=================================================================================
       9000-ler-pd01400-nex section.
       
            read pd01400 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd01400-pre section.
       
            read pd01400 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd01400 section.
       
            write f01400-cliente
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd01400 section.
       
            rewrite f01400-cliente
           
       exit.
     