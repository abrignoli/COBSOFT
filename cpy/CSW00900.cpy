       78   c-carregar-linkage                     value "CS00002S".
       78   c-mensagem                             value "CS00003S".
       78   c-sleep                                value "CS00006S".
       78   c-frame-padrao                         value "CS00000F".
       78   c-pesquisar-cep                        value "CS10001P".
       78   c-proximo-documento                    value "CS00105S".

       78   c-caracteres-invalidos                 value "«¡√¿¬’”“‘ …⁄‹ŸÕÃŒÁ·„‡‚ıÛÚÙÍÈ˙¸˘ÌÏÓ".
       78   c-caracteres-invalidos-conv            value "CAAAAOOOOEEUUUIIIcaaaaooooeeuuuiii".

       01   ws-campos-work.
            03 ws-parametros-mensagem.
               05 ws-mensagem                      pic x(560).
               05 ws-mensagem-opcao                pic x(02).
                  88 ws-mensagem-opcao-sim              value "S".
                  88 ws-mensagem-opcao-nao              value "N".
            03 ws-resultado-acesso                 pic x(02).
               88 ws-acesso-invalido                   value "47", "48", "49".
               88 ws-operacao-ok                       value "00", "02".
               88 ws-eof-arquivo                       value "10".
               88 ws-registro-inexistente              value "23".
               88 ws-registro-existente                value "22".
               88 ws-arquivo-inexistente               value "35".
               88 ws-arquivo-locado                    value "9A".
               88 ws-registro-locado                   value "9D".
            03 ws-resultado-acesso-xml             pic s9(09)  value zeros.
               88 ws-operacao-ok-xml                   value 0 thru 999999999.
            03 ws-parametros-cbl-run.
               05 ws-command-exec                  pic x(500)  value spaces.
               05 ws-run-unit-id                   pic x(08)   comp-5.
               05 ws-stack-size                    pic x(04)   comp-5.
               05 ws-flags                         pic x(04)   comp-5 value zeros.
            03 ws-cbl-status-code                  pic x(02)   comp-5.
            03 ws-cbl-status-code-x                pic x(05).
            03 ws-data                             pic 9(08).
            03 filler redefines ws-data.
               05 ws-dia                           pic 9(02).
               05 ws-mes                           pic 9(02).
               05 ws-ano                           pic 9(04).
            03 ws-data-inv                         pic 9(08).
            03 filler redefines ws-data-inv.
               05 ws-ano-inv                       pic 9(04).
               05 ws-mes-inv                       pic 9(02).
               05 ws-dia-inv                       pic 9(02).
            03 ws-horas                            pic 9(08).
            03 ws-hh-mm-ss redefines ws-horas.
               05 ws-horas-hh                      pic 9(02).
               05 ws-horas-mm                      pic 9(02).
               05 ws-horas-ss                      pic 9(02).
               05 filler                           pic 9(02).
            03 ws-mascara-cnpj                     pic x(18)    value "  .   .   /    -   ".
            03 ws-mascara-cpf                      pic x(14)    value "   .   .   -  ".
            03 ws-mascara-cep                      pic x(09)    value "     -   ".
            03 ws-mascara-telefone                 pic x(20)    value "+   (   )      -    ".
            03 ws-mascara-data                     pic x(10)    value "  /  /    ".
            03 ws-nr-segundos                      pic 9(06).   
