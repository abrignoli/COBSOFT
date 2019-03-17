           select pd00900 assign to disk wid-pd00900
                organization        is indexed
                access mode         is dynamic
                record key          is f00900-chave = 
                                       f00900-id-usuario
                                       f00900-cd-empresa
                                       f00900-cd-filial
                lock mode           is manual
                file status         is ws-resultado-acesso.
