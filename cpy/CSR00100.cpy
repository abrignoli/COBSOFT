      *>================================================================  
       9000-abrir-io-pd00100 section.
           
           string lnk-dat-path delimited   by "  " "\EFD001.DAT" into wid-pd00100
                                           
           open i-o pd00100
           if   not ws-operacao-ok
                
                string "Erro de abertura arquivo EFD001.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                perform 9000-mensagem
                perform 9000-abortar

           end-if
           
       exit.
      
      *>================================================================
       9000-str-pd00100-grt section.
       
            start pd00100 key is greater f00100-chave
       
       exit.      
      
      *>================================================================
       9000-ler-pd00100-ran section.
       
            read pd00100
       
       exit.

      *>================================================================
       9000-ler-pd00100-ran-1 section.
       
            read pd00100 key f00100-chave-1
       
       exit.
              
      *>================================================================
       9000-ler-pd00100-nex section.
       
            read pd00100 next
       
       exit.
       
      *>================================================================
       9000-gravar-pd00100 section.
       
            write f00100-modulos
           
       exit.
       
      *>================================================================
       9000-regravar-pd00100 section.
       
            rewrite f00100-modulos
           
       exit.