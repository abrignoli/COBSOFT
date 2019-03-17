      *>================================================================================= 
       9000-abrir-i-pd05100 section.
           string lnk-dat-path delimited   by "  " "\EFD051.DAT" into wid-pd05100                             
                                           
           open input pd05100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD051.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
       
      *>================================================================================= 
       9000-abrir-o-pd05100 section.
           string lnk-dat-path delimited   by "  " "\EFD051.DAT" into wid-pd05100                             
                                           
           open output pd05100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD051.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>================================================================================= 
       9000-abrir-io-pd05100 section.
           string lnk-dat-path delimited   by "  " "\EFD051.DAT" into wid-pd05100                             
                                           
           open i-o pd05100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD051.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.

      *>=================================================================================
       9000-str-pd05100-grt section.
       
            start pd05100 key is greater f05100-chave
       
       exit.

      *>=================================================================================
       9000-str-pd05100-ngrt section.
       
            start pd05100 key is not greater f05100-chave
       
       exit.      
       
      *>=================================================================================
       9000-ler-pd05100-ran section.
       
            read pd05100

       exit. 
        
       *>=================================================================================
       9000-ler-pd05100-nex section.
       
            read pd05100 next
       
       exit. 
             
      *>=================================================================================
       9000-ler-pd05100-pre section.
       
            read pd05100 previous
       
       exit.              
             
      *>=================================================================================
       9000-gravar-pd05100 section.
       
            write f05100-item-nota-fiscal
           
       exit.
       
      *>=================================================================================
       9000-regravar-pd05100 section.
       
            rewrite f05100-item-nota-fiscal
           
       exit.
     