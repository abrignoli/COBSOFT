           select pd00500 assign to disk wid-pd00500
                organization        is indexed
                access mode         is dynamic
                record key          is f00500-chave = 
                                       f00500-cd-empresa
                                       f00500-cd-filial
                                       f00500-id-bairro
                alternate key       is f00500-chave-1 =
                                       f00500-cd-empresa
                                       f00500-cd-filial
                                       f00500-id-municipio
                                       f00500-cd-bairro                                       
                lock mode           is manual
                file status         is ws-resultado-acesso.

      


