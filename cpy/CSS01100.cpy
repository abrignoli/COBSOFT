           select pd01100 assign to disk wid-pd01100
                organization        is indexed
                access mode         is dynamic
                record key          is f01100-chave = 
                                       f01100-cd-empresa                
                                       f01100-cd-filial
                                       f01100-cd-perfil
                                       f01100-cd-programa
                lock mode           is manual
                file status         is ws-resultado-acesso.
