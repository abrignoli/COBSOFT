           select pd00300 assign to disk wid-pd00300
                organization        is indexed
                access mode         is dynamic
                record key          is f00300-chave = 
                                       f00300-cd-empresa
                                       f00300-cd-filial
                                       f00300-id-estado
                alternate key       is f00300-chave-1 =
                                       f00300-cd-empresa
                                       f00300-cd-filial
                                       f00300-id-pais
                                       f00300-cd-estado                                 
                lock mode           is manual
                file status         is ws-resultado-acesso.
      


