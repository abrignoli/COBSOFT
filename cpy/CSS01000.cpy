           select pd01000 assign to disk wid-pd01000
                organization        is indexed
                access mode         is dynamic
                record key          is f01000-chave = 
                                       f01000-cd-empresa                
                                       f01000-cd-filial
                                       f01000-cd-perfil
                lock mode           is manual
                file status         is ws-resultado-acesso.
