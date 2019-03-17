           select pd00600 assign to disk wid-pd00600
                organization        is indexed
                access mode         is dynamic
                record key          is f00600-chave = 
                                       f00600-cd-empresa
                                       f00600-cd-filial
                                       f00600-id-logradouro
                alternate key       is f00600-chave-1 =
                                       f00600-cd-empresa
                                       f00600-cd-filial
                                       f00600-id-bairro
                                       f00600-cep
                alternate key       is f00600-chave-2 =
                                       f00600-cd-empresa
                                       f00600-cd-filial
                                       f00600-cep
                                       f00600-id-bairro                                                                                            
                lock mode           is manual
                file status         is ws-resultado-acesso.
      


