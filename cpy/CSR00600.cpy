      *>================================================================================= 
       9000-abrir-i-pd00600 section.
           string lnk-dat-path delimited   by "  " "\EFD006.DAT" into wid-pd00600                             
                                           
           open input pd00600
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD006.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd00600 section.
           string lnk-dat-path delimited   by "  " "\EFD006.DAT" into wid-pd00600                             
                                           
           open output pd00600
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD006.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd00600 section.
           string lnk-dat-path delimited   by "  " "\EFD006.DAT" into wid-pd00600                             
                                           
           open i-o pd00600
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD006.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd00600-grt section.
       
            start pd00600 key is greater f00600-chave
       
       exit.

      *>=================================================================================
       9000-str-pd00600-ngrt section.
       
            start pd00600 key is not greater f00600-chave
       
       exit.

      *>=================================================================================
       9000-str-pd00600-grt-1 section.
       
            start pd00600 key is greater f00600-chave-1
       
       exit.

      *>=================================================================================
       9000-str-pd00600-ngrt-1 section.
       
            start pd00600 key is not greater f00600-chave-1
       
       exit.

      *>=================================================================================
       9000-str-pd00600-grt-2 section.
       
            start pd00600 key is greater f00600-chave-2
       
       exit.

      *>=================================================================================
       9000-str-pd00600-ngrt-2 section.
       
            start pd00600 key is not greater f00600-chave-2
       
       exit.       
       
      *>=================================================================================
       9000-ler-pd00600-ran section.
       
            read pd00600
       
       exit. 

      *>=================================================================================
       9000-ler-pd00600-ran-1 section.
       
            read pd00600 key is f00600-chave-1
       
       exit.
        
       *>=================================================================================
       9000-ler-pd00600-nex section.
       
            read pd00600 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd00600-pre section.
       
            read pd00600 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd00600 section.
       
            write f00600-logradouro
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd00600 section.
       
            rewrite f00600-logradouro
           
       exit.
     