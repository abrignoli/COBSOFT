      *>================================================================================= 
       9000-abrir-i-pd00500 section.
           string lnk-dat-path delimited   by "  " "\EFD005.DAT" into wid-pd00500                             
                                           
           open input pd00500
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD005.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd00500 section.
           string lnk-dat-path delimited   by "  " "\EFD005.DAT" into wid-pd00500                             
                                           
           open output pd00500
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD005.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd00500 section.
           string lnk-dat-path delimited   by "  " "\EFD005.DAT" into wid-pd00500                             
                                           
           open i-o pd00500
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD005.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd00500-grt section.
       
            start pd00500 key is greater f00500-chave
       
       exit.

      *>=================================================================================
       9000-str-pd00500-ngrt section.
       
            start pd00500 key is not greater f00500-chave
       
       exit.

      *>=================================================================================
       9000-ler-pd00500-ran section.
       
            read pd00500
       
       exit. 

      *>=================================================================================
       9000-ler-pd00500-ran-1 section.
       
            read pd00500 key is f00500-chave-1
       
       exit.
        
       *>=================================================================================
       9000-ler-pd00500-nex section.
       
            read pd00500 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd00500-pre section.
       
            read pd00500 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd00500 section.
       
            write f00500-bairro
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd00500 section.
       
            rewrite f00500-bairro
           
       exit.
     