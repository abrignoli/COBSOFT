           select pd01800 assign to disk wid-pd01800
                organization        is indexed
                access mode         is dynamic
                record key          is f01800-chave = 
                                       f01800-cd-empresa
                                       f01800-cd-filial
                                       f01800-cd-produto                                      
                lock mode           is manual
                file status         is ws-resultado-acesso.

      


