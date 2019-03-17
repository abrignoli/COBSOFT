           select pd02100 assign to disk wid-pd02100
                organization        is indexed
                access mode         is dynamic
                record key          is f02100-chave = 
                                       f02100-cd-empresa
                                       f02100-cd-filial
                                       f02100-cd-produto                                      
                lock mode           is manual
                file status         is ws-resultado-acesso.

      


