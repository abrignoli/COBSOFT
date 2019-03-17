      *>================================================================================= 
       9000-abrir-i-pd00400 section.
           string lnk-dat-path delimited   by "  " "\EFD004.DAT" into wid-pd00400                             
                                           
           open input pd00400
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD004.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd00400 section.
           string lnk-dat-path delimited   by "  " "\EFD004.DAT" into wid-pd00400                             
                                           
           open output pd00400
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD004.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd00400 section.
           string lnk-dat-path delimited   by "  " "\EFD004.DAT" into wid-pd00400                             
                                           
           open i-o pd00400
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD004.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd00400-grt section.
       
            start pd00400 key is greater f00400-chave
       
       exit.

      *>=================================================================================
       9000-str-pd00400-ngrt section.
       
            start pd00400 key is not greater f00400-chave
       
       exit.

      *>=================================================================================
       9000-ler-pd00400-ran section.
       
            read pd00400
       
       exit. 

      *>=================================================================================
       9000-ler-pd00400-ran-1 section.
       
            read pd00400 key is f00400-chave-1
       
       exit.
        
       *>=================================================================================
       9000-ler-pd00400-nex section.
       
            read pd00400 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd00400-pre section.
       
            read pd00400 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd00400 section.
       
            write f00400-municipio
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd00400 section.
       
            rewrite f00400-municipio
           
       exit.
     