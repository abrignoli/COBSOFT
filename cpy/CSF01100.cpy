       fd   pd01100.
       
       01   f01100-perfil-modulo.
            03 f01100-cd-empresa                   pic 9(03).
            03 f01100-cd-filial                    pic 9(04).
            03 f01100-cd-perfil                    pic 9(03).
            03 f01100-cd-programa                  pic x(08).
            03 f01100-id-consulta                  pic x(01).
               88 f01100-permite-consulta               value "S".
            03 f01100-id-inclusao                  pic x(01).
               88 f01100-permite-inclusao               value "S".
            03 f01100-id-manutencao                pic x(01).
               88 f01100-permite-manutencao             value "S".
            03 f01100-id-exclusao                  pic x(01).
               88 f01100-permite-exclusao               value "S".    

