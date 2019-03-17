      *>================================================================================= 
       9000-abrir-i-pd00700 section.
           string lnk-dat-path delimited   by "  " "\EFD007.DAT" into wid-pd00700         
                                           
           open input pd00700
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD007.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd00700 section.
           string lnk-dat-path delimited   by "  " "\EFD007.DAT" into wid-pd00700
                                           
                                           
           open i-o pd00700
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD007.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.


      *>================================================================================= 
       9000-str-pd00700-gtr section.
       
            start pd00700 key is greater f00700-chave  
       
       exit.


      *>================================================================================= 
       9000-ler-pd00700-ran section.
       
            read pd00700
        
       exit.


      *>================================================================================= 
       9000-ler-pd00700-ran-1 section.
       
            read pd00700 key is f00700-chave-1 
        
       exit.       

      *>================================================================================= 
       9000-ler-pd00700-nex section.
       
            read pd00700 next
        
       exit.      
            

      *>================================================================================= 
       9000-gravar-pd00700 section.
       
            write f00700-empresa
           
       exit.
       
      *>================================================================================= 
       9000-regravar-pd00700 section.
       
            rewrite f00700-empresa
           
       exit.