      *>================================================================================= 
       9000-abrir-i-pd02100 section.
           string lnk-dat-path delimited   by "  " "\EFD021.DAT" into wid-pd02100                             
                                           
           open input pd02100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD021.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd02100 section.
           string lnk-dat-path delimited   by "  " "\EFD021.DAT" into wid-pd02100                             
                                           
           open output pd02100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD021.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd02100 section.
           string lnk-dat-path delimited   by "  " "\EFD021.DAT" into wid-pd02100                             
                                           
           open i-o pd02100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD021.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd02100-grt section.
       
            start pd02100 key is greater f02100-chave
       
       exit.

      *>=================================================================================
       9000-str-pd02100-ngrt section.
       
            start pd02100 key is not greater f02100-chave
       
       exit.      
       
      *>=================================================================================
       9000-ler-pd02100-ran section.
       
            read pd02100
       
       exit. 
        
       *>=================================================================================
       9000-ler-pd02100-nex section.
       
            read pd02100 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd02100-pre section.
       
            read pd02100 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd02100 section.
       
            write f02100-preco-produto
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd02100 section.
       
            rewrite f02100-preco-produto
           
       exit.
     