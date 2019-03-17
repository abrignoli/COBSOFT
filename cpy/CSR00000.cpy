      *>================================================================  
       9000-abrir-io-pd00000 section.
       
            string lnk-dat-path delimited   by "  " "\EFD000.DAT" into wid-pd00000                       
                                           
            open i-o pd00000
            if   not ws-operacao-ok
                
                 string "Erro de abertura arquivo EFD000.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                 perform 9000-mensagem
                 perform 9000-abortar

            end-if
           
       exit.

      *>================================================================  
       9000-abrir-i-pd00000 section.
       
            string lnk-dat-path delimited   by "  " "\EFD000.DAT" into wid-pd00000                       
                                           
            open input pd00000
            if   not ws-operacao-ok
                
                 string "Erro de abertura arquivo EFD000.DAT - Status [" ws-resultado-acesso "]" into ws-mensagem
                
                 perform 9000-mensagem
                 perform 9000-abortar

            end-if
           
       exit.       
      *>================================================================
       9000-ler-pd00000-ran section.
       
            read pd00000
       
       exit.
             
      *>================================================================
       9000-gravar-pd00000 section.
       
            write f00000-programas
           
       exit.
       
      *>================================================================
       9000-regravar-pd00000 section.
       
            rewrite f00000-programas
           
       exit.
      


