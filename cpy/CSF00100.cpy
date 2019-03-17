       fd   pd00100.
       
       01   f00100-modulos.
            03 f00100-cd-empresa                   pic 9(03).
            03 f00100-cd-filial                    pic 9(04).
            03 f00100-programa-principal           pic x(08).
            03 f00100-cd-programa                  pic x(08).
            03 f00100-tipo-programa                pic x(01).
               88 f00100-programa-logico                value "L".
               88 f00100-programa-fisico                value "F".
            03 f00100-operacao-programa            pic 9(02).
            03 f00100-descricao-programa           pic x(55). 
      


