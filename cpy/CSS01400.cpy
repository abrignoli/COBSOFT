           select pd01400 assign to disk wid-pd01400
                organization        is indexed
                access mode         is dynamic
                record key          is f01400-chave = 
                                       f01400-cd-empresa
                                       f01400-cd-filial
                                       f01400-cd-cliente
                alternate key       is f01400-chave-1 =
                                       f01400-cgc                                       
                lock mode           is manual
                file status         is ws-resultado-acesso.

      


