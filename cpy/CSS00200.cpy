           select pd00200 assign to disk wid-pd00200
               organization        is indexed
               access mode         is dynamic
               record key          is f00200-chave = 
                                      f00200-cd-empresa
                                      f00200-cd-filial
                                      f00200-id-pais
               alternate key       is f00200-chave-1 =
                                      f00200-cd-empresa
                                      f00200-cd-filial
                                      f00200-cd-pais                                       
               lock mode           is manual
               file status         is ws-resultado-acesso.
      


