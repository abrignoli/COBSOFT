       fd   pd00700. 
      
       01   f00700-empresa.
            03 f00700-cd-empresa                   pic 9(03).
            03 f00700-cd-filial                    pic 9(04).
            03 f00700-razao-social                 pic x(55).
            03 f00700-nome-fantasia                pic x(55).
            03 f00700-cnpj                         pic 9(14).
            03 f00700-ie                           pic x(11).
            03 f00700-id-logradouro                pic 9(09).
            03 f00700-nr-endereco                  pic x(10).
            03 f00700-nr-telefone-1                pic 9(14).
            03 f00700-nr-telefone-2                pic 9(14).
            03 f00700-nr-telefone-3                pic 9(14).
            03 f00700-email                        pic x(55).
            03 f00700-id-status                    pic x(01).
               88 f00700-empresa-ativa                 value "A".
               88 f00700-empresa-inativa               value "I".
               88 f00700-empresa-bloqueada             value "B".
      


