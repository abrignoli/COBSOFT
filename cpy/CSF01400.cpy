       fd pd01400.

       01   f01400-cliente.
            03 f01400-cd-empresa                   pic 9(03).
            03 f01400-cd-filial                    pic 9(04).
            03 f01400-cd-cliente                   pic 9(09).
            03 f01400-razao-social                 pic x(55).
            03 f01400-nome-fantasia                pic x(55).
            03 f01400-tipo-pessoa                  pic x(01).
               88 f01400-pessoa-fisica                 value "F".
               88 f01400-pessoa-juridica               value "J".
            03 f01400-cgc                          pic 9(14).
            03 f01400-ie                           pic x(11).
            03 f01400-id-logradouro                pic 9(09).
            03 f01400-nr-endereco                  pic x(10).
            03 f01400-nr-telefone-1                pic 9(14).
            03 f01400-nr-telefone-2                pic 9(14).
            03 f01400-nr-telefone-3                pic 9(14).
            03 f01400-email                        pic x(55).
            03 f01400-id-status                    pic x(01).
               88 f01400-cliente-ativo                  value "A".
               88 f01400-cliente-inativo                value "I".
               88 f01400-cliente-bloqueado              value "B".
