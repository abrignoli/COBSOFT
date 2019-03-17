            select pd00100 assign to disk wid-pd00100
                 organization        is indexed
                 access mode         is dynamic
                 record key          is f00100-chave = 
                                        f00100-cd-empresa
                                        f00100-cd-filial
                                        f00100-programa-principal
                                        f00100-cd-programa
                 alternate key       is f00100-chave-1 =
                                        f00100-cd-empresa
                                        f00100-cd-filial
                                        f00100-programa-principal
                                        f00100-operacao-programa
                 lock mode           is manual
                 file status         is ws-resultado-acesso.
      


