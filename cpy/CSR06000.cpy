      *>================================================================================= 
       9000-abrir-i-pd06000 section.
           string lnk-dat-path delimited   by "  " "\EFD060.DAT" into wid-pd06000                             
                                           
           open input pd06000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD060.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd06000 section.
           string lnk-dat-path delimited   by "  " "\EFD060.DAT" into wid-pd06000                             
                                           
           open output pd06000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD060.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd06000 section.
           string lnk-dat-path delimited   by "  " "\EFD060.DAT" into wid-pd06000                             
                                           
           open i-o pd06000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD060.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd06000-grt section.
       
            start pd06000 key is greater f06000-chave
       
       exit.

      *>=================================================================================
       9000-str-pd06000-ngrt section.
       
            start pd06000 key is not greater f06000-chave
       
       exit.      
       
      *>=================================================================================
       9000-ler-pd06000-ran section.
       
            read pd06000

       exit. 
        
       *>=================================================================================
       9000-ler-pd06000-nex section.
       
            read pd06000 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd06000-pre section.
       
            read pd06000 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd06000 section.
       
            write f06000-estoque
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd06000 section.
       
            rewrite f06000-estoque
           
       exit.
     