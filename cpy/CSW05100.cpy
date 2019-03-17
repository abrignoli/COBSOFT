       01   wf05100-item-nota-fiscal.
            03 wf05100-chave.
               05 wf05100-cd-empresa               pic 9(03).
               05 wf05100-cd-filial                pic 9(04).
               05 wf05100-tipo-nota                pic 9(02).
                  88 wf05100-nota-entrada              value 00.
                  88 wf05100-nota-saida                value 01.
               05 wf05100-numero-documento         pic 9(09).
               05 wf05100-serie-documento          pic x(03).
               05 wf05100-cd-destinatario          pic 9(09).
               05 wf05100-sequencia                pic 9(09).
            03 wf05100-cd-mercadoria               pic 9(09).
            03 wf05100-cst                         pic 9(04).
            03 wf05100-cfop                        pic 9(04).
            03 wf05100-cd-unidade-medida           pic 9(09).
            03 wf05100-quantidade-mercadoria       pic 9(09)v9(06).
            03 wf05100-valor-unitario              pic 9(09)v9(06).
            03 wf05100-valor-total                 pic 9(09)v9(02).
            03 wf05100-base-icms                   pic 9(09)v9(02).
            03 wf05100-valor-icms                  pic 9(09)v9(02).
            03 wf05100-valor-ipi                   pic 9(09)v9(02).
            03 wf05100-aliq-icms                   pic 9(09)v9(02).
            03 wf05100-aliq-ipi                    pic 9(09)v9(02).
            03 filler                              pic x(91).
