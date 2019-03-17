           select pd06000 assign to disk wid-pd06000
                organization        is indexed
                access mode         is dynamic
                record key          is f06000-chave =
                                       f06000-cd-empresa
                                       f06000-cd-filial
                                       f06000-cd-produto                                      
                lock mode           is manual
                file status         is ws-resultado-acesso.
      


