           select pd00700 assign to disk wid-pd00700
                organization        is indexed
                access mode         is dynamic
                record key          is f00700-chave = 
                                       f00700-cd-empresa
                                       f00700-cd-filial
                alternate key       is f00700-chave-1 = 
                                       f00700-cnpj
                lock mode           is manual
                file status         is ws-resultado-acesso.
      


