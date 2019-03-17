      *>================================================================================= 
       9000-abrir-i-pd02200 section.
           string lnk-dat-path delimited   by "  " "\EFD022.DAT" into wid-pd02200                             
                                           
           open input pd02200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD022.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd02200 section.
           string lnk-dat-path delimited   by "  " "\EFD022.DAT" into wid-pd02200                             
                                           
           open output pd02200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD022.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd02200 section.
           string lnk-dat-path delimited   by "  " "\EFD022.DAT" into wid-pd02200                             
                                           
           open i-o pd02200
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD022.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd02200-grt section.
       
            start pd02200 key is greater f02200-chave
       
       exit.

      *>=================================================================================
       9000-str-pd02200-ngrt section.
       
            start pd02200 key is not greater f02200-chave
       
       exit.      
       
      *>=================================================================================
       9000-ler-pd02200-ran section.
       
            read pd02200
       
       exit. 
        
       *>=================================================================================
       9000-ler-pd02200-nex section.
       
            read pd02200 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd02200-pre section.
       
            read pd02200 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd02200 section.
       
            write f02200-parametros-nfe
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd02200 section.
       
            rewrite f02200-parametros-nfe
           
       exit.
     