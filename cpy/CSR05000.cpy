      *>================================================================================= 
       9000-abrir-i-pd05000 section.
           string lnk-dat-path delimited   by "  " "\EFD050.DAT" into wid-pd05000                             
                                           
           open input pd05000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD050.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd05000 section.
           string lnk-dat-path delimited   by "  " "\EFD050.DAT" into wid-pd05000                             
                                           
           open output pd05000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD050.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd05000 section.
           string lnk-dat-path delimited   by "  " "\EFD050.DAT" into wid-pd05000                             
                                           
           open i-o pd05000
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD050.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd05000-grt section.
       
            start pd05000 key is greater f05000-chave
       
       exit.

      *>=================================================================================
       9000-str-pd05000-ngrt section.
       
            start pd05000 key is not greater f05000-chave
       
       exit.      
       
      *>=================================================================================
       9000-ler-pd05000-ran section.
       
            read pd05000

       exit. 
        
       *>=================================================================================
       9000-ler-pd05000-nex section.
       
            read pd05000 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd05000-pre section.
       
            read pd05000 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd05000 section.
       
            write f05000-mestre-nota-fiscal
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd05000 section.
       
            rewrite f05000-mestre-nota-fiscal
           
       exit.
     