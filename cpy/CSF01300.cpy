       fd   pd01300.
       
       01   f01300-usuario-modulo.
            03 f01300-cd-empresa                   pic 9(03).
            03 f01300-cd-filial                    pic 9(04).
            03 f01300-id-usuario                   pic 9(11).
            03 f01300-cd-programa                  pic x(08).
            03 f01300-id-consulta                  pic x(01).
               88 f01300-permite-consulta               value "S".
            03 f00130-id-inclusao                  pic x(01).
               88 f01300-permite-inclusao               value "S".
            03 f01300-id-manutencao                pic x(01).
               88 f01300-permite-manutencao             value "S".
            03 f00130-id-exclusao                  pic x(01).
               88 f01300-permite-exclusao               value "S".      


