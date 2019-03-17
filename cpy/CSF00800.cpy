       fd   pd00800.
       
       01   f00800-usuario.
            03 f00800-id-usuario                   pic 9(11).
            03 f00800-pw-usuario                   pic x(15).
            03 f00800-nome-usuario                 pic x(55).
            03 f00800-data-nascimento              pic 9(08).
            03 f00800-sexo                         pic x(01).
               88 f00800-masculino                     value "M".
               88 f00800-feminino                      value "F".
            03 f00800-email                        pic x(55).
            03 f00800-id-atribuir-acesso           pic x(01).
               88 f00800-permite-atribuir-acesso       value "S".
            03 f00800-id-status-usuario            pic x(01).
               88 f00800-inativo                       value "I".
               88 f00800-bloqueado                     value "B".
               88 f00800-em-aprovacao                  value "E".
               88 f00800-ativo                         value "A".
            03 f00800-id-trocar-senha              pic x(01).
               88 f00800-trocar-senha                  value "S".
            03 f00800-id-perfil-especial           pic x(01).
               88 f00800-desenvolvimento               value "D".
            03 f00800-data-criacao                 pic 9(08).
            03 f00800-hora-criacao                 pic 9(08).
            03 f00800-data-ultimo-login            pic 9(08).
            03 f00800-hora-ultimo-login            pic 9(08).
            03 f00800-maquina-login                pic x(55).   
            
            
            
      


