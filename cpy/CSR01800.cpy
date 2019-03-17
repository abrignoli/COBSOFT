      *>================================================================================= 
       9000-abrir-i-pd01800 section.
           string lnk-dat-path delimited   by "  " "\EFD018.DAT" into wid-pd01800                             
                                           
           open input pd01800
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD018.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd01800 section.
           string lnk-dat-path delimited   by "  " "\EFD018.DAT" into wid-pd01800                             
                                           
           open output pd01800
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD018.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd01800 section.
           string lnk-dat-path delimited   by "  " "\EFD018.DAT" into wid-pd01800                             
                                           
           open i-o pd01800
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD018.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd01800-grt section.
       
            start pd01800 key is greater f01800-chave
       
       exit.

      *>=================================================================================
       9000-str-pd01800-ngrt section.
       
            start pd01800 key is not greater f01800-chave
       
       exit.      
       
      *>=================================================================================
       9000-ler-pd01800-ran section.
       
            read pd01800
       
       exit. 
        
       *>=================================================================================
       9000-ler-pd01800-nex section.
       
            read pd01800 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd01800-pre section.
       
            read pd01800 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd01800 section.
       
            write f01800-produto
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd01800 section.
       
            rewrite f01800-produto
           
       exit.
     