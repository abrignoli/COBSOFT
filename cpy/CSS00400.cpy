           select pd00400 assign to disk wid-pd00400
                organization        is indexed
                access mode         is dynamic
                record key          is f00400-chave = 
                                       f00400-cd-empresa
                                       f00400-cd-filial
                                       f00400-id-municipio
                alternate key       is f00400-chave-1 =
                                       f00400-cd-empresa
                                       f00400-cd-filial
                                       f00400-id-estado
                                       f00400-cd-municipio                                       
                lock mode           is manual
                file status         is ws-resultado-acesso.
