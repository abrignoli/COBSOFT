      $set sourceformat"free"
       program-id. CS00106S.
      *>=================================================================================
      *>    
      *>                              Impressão NF-e
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      
       
       copy CSS00700.cpy.
       copy CSS01400.cpy.
       copy CSS01800.cpy.
       copy CSS05000.cpy.
       copy CSS05100.cpy.
       
             select arqpcl assign to disk wid-arqpcl
                   organization   is line sequential
                   access mode    is sequential
                   file status    is ws-resultado-acesso.

      *>=================================================================================
       data division.      

       copy CSF00700.cpy.
       copy CSF01400.cpy.
       copy CSF01800.cpy.
       copy CSF05000.cpy.
       copy CSF05100.cpy.

       fd   arqpcl.

       01   rl-registro-em-pcl.
            03 rl-linha-em-pcl                     pic x(256).
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS00106S".
       78   c-descricao-programa                   value "IMPRESSÃO NFE".
       78   pcl-writer                             value "pcl6".
       78   c-aguardar-execucao                    value "0003".
       
       
       01   ws-campos-trabalho.
            03 ws-status-code                      pic x(02)  comp-5.
            03 ws-nfe-pcl                          pic x(255).
            03 ws-nfe-pdf                          pic x(255).            
            03 ws-nfe-mascara-pcl                  pic x(255).
            03 ws-nfe-dados-pcl                    pic x(255).
            03 ws-codigo-esc-comp                  pic x(01) comp-x value 027. 
            03 ws-codigo-esc redefines ws-codigo-esc-comp pic x(01).
            03 ws-pos-y                            pic 9(04).
            03 ws-random                           pic s9v9(17).
            03 ws-chave-random                     pic x(045).
            03 ws-index                            pic 9(04).
            03 ws-numero                           pic 9(01).
            03 ws-char redefines ws-numero         pic x(01).
   
       01   lk-logradouro.
            03 lk-id-cep                           pic x(01).
               88 lk-encontrou-cep                      value "S".
               88 lk-nao-encontrou-cep                  value "N".     
            03 lk-id-logradouro                    pic 9(09).
            03 lk-cep                              pic 9(08).
            03 lk-endereco                         pic x(55).
            03 lk-bairro                           pic x(55).
            03 lk-municipio                        pic x(55).
            03 lk-uf                               pic x(02).
            03 lk-pais                             pic x(55).             
       
       01   r01-canhoto-nfe.
            03 r01-razao-social                    pic x(55).
            03 r01-numero-documento                pic 999.999.999.
            03 r01-serie-documento                 pic 999.
       
       01   r02-mestre-nfe.
            03 r02-tipo-documento                  pic 9(01).
            03 r02-numero-documento                pic 999.999.999.
            03 r02-serie-documento                 pic 999.            
            03 r02-controle-fisico                 pic x(45).
            03 r02-chave-acesso                    pic x(45).
            03 r02-natureza-operacao               pic x(55).
            03 r02-protocolo-autorizacao           pic x(15).
            03 r02-inscricao-estadual              pic x(11).
            03 r02-inscricao-estadual-subst        pic x(11).
            03 r02-cnpj                            pic x(18).

       01   r03-destinatario.
            03 r03-razao-social                    pic x(55).
            03 r03-cgc                             pic x(18).
            03 r03-data-emissao                    pic 99/99/9999.
            03 r03-endereco                        pic x(55).
            03 r03-bairro                          pic x(30).
            03 r03-cep                             pic x(09).
            03 r03-data-saida                      pic 99/99/9999.
            03 r03-municipio                       pic x(55).
            03 r03-telefone                        pic x(20).
            03 r03-unidade-federativa              pic x(02).
            03 r03-inscricao-estadual              pic x(11).
            03 r03-hora-saida                      pic x(08).

       01   r04-fatura.
            03 r04-numero-documento                pic 999.999.999.
            03 r04-parcela-documento               pic 9(02).
            03 r04-valor-original                  pic zzz.zzz.zz9,99.
            03 r04-valor-desconto                  pic zzz.zzz.zz9,99.
            03 r04-valor-liquido                   pic zzz.zzz.zz9,99.

       01   r05-calculo-imposto.
            03 r05-base-icms                       pic zzz.zzz.zz9,99.
            03 r05-valor-icms                      pic zzz.zzz.zz9,99.
            03 r05-base-icms-st                    pic zzz.zzz.zz9,99.
            03 r05-valor-icms-st                   pic zzz.zzz.zz9,99.
            03 r05-valor-total-produtos            pic zzz.zzz.zz9,99.
            03 r05-valor-frete                     pic zzz.zzz.zz9,99.
            03 r05-valor-seguro                    pic zzz.zzz.zz9,99.
            03 r05-valor-desconto                  pic zzz.zzz.zz9,99.
            03 r05-valor-outras-despesas           pic zzz.zzz.zz9,99.
            03 r05-valor-ipi                       pic zzz.zzz.zz9,99.
            03 r05-valor-total-nota-fiscal         pic zzz.zzz.zz9,99.                      

       01   r06-transportador.
            03 r06-razao-social                    pic x(55).
            03 r06-codigo-antt                     pic x(15).
            03 r06-placa-veiculo                   pic x(08).
            03 r06-uf-veiculo                      pic x(02).
            03 r06-cgc                             pic x(18).
            03 r06-endereco                        pic x(55).
            03 r06-municipio                       pic x(55).
            03 r06-unidade-federativa              pic x(02).
            03 r06-inscricao-estadual              pic x(11).
            03 r06-quantidade                      pic zzz.zzz.zz9,99.
            03 r06-especie                         pic zzz.zzz.zz9,99.
            03 r06-marca                           pic zzz.zzz.zz9,99.
            03 r06-numeracao                       pic zzz.zzz.zz9,99.
            03 r06-peso-bruto                      pic zzz.zzz.zz9,99.
            03 r06-peso-liquido                    pic zzz.zzz.zz9,99.

       01   r07-produto.
            03 r07-cogido-produto                  pic 9(09).
            03 r07-descricao-produto               pic x(30).
            03 r07-ncm                             pic 9(08).
            03 r07-cst                             pic 9(03).
            03 r07-cfop                            pic 9(04).
            03 r07-unidade-medida                  pic x(03).
            03 r07-quantiade                       pic zzz.zzz.zz9,99.
            03 r07-valor-unitario                  pic zzz.zzz.zz9,99.
            03 r07-valor-desconto                  pic zzz.zzz.zz9,99.
            03 r07-valor-total                     pic zzz.zzz.zz9,99.
            03 r07-base-icms                       pic zzz.zzz.zz9,99.
            03 r07-valor-icms                      pic zzz.zzz.zz9,99.
            03 r07-valor-ipi                       pic zzz.zz9,99.
            03 r07-aliq-icms                       pic z9,9.
            03 r07-aliq-ipi                        pic z9,9.                                   

       01   lk-parametros-nfe.
            03 lk-numero-documento                  pic 9(09).
            03 lk-serie-documento                   pic 9(03).
       
       copy CSW00900.cpy.

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
                                                                          
      *>=================================================================================
       procedure division using lnk-par.
       
      *>=================================================================================

       0000-controle section.
            perform 1000-inicializacao
            perform 2000-processamento
            perform 3000-finalizacao.
       0000-saida.    
            exit program
            stop run
       exit.
       
      *>=================================================================================
       1000-inicializacao section.

            perform 9000-abrir-i-pd00700
            perform 9000-abrir-i-pd01400
            perform 9000-abrir-i-pd01800
            perform 9000-abrir-i-pd05000
            perform 9000-abrir-i-pd05100
            
            move "..\cgi\NFE.PCL"                  to ws-nfe-mascara-pcl                 

       exit.
        
      *>=================================================================================
       2000-processamento section.

            move lnk-linha-comando                  to lk-parametros-nfe

            initialize                              f05000-mestre-nota-fiscal
            move lnk-cd-empresa                     to f05000-cd-empresa
            move lnk-cd-filial                      to f05000-cd-filial
            move 01                                 to f05000-tipo-nota
            move lk-numero-documento                to f05000-numero-documento
            move lk-serie-documento                 to f05000-serie-documento
            perform 9000-str-pd05000-grt
            perform 9000-ler-pd05000-nex
            perform until not ws-operacao-ok
                or f05000-cd-empresa        <> lnk-cd-empresa
                or f05000-cd-filial         <> lnk-cd-filial
                or f05000-tipo-nota         <> 01
                or f05000-numero-documento  <> lk-numero-documento
                or f05000-serie-documento   <> lk-serie-documento
                
                perform 2010-criar-arquivo-pcl
                perform 2300-monta-working-pcl
                perform 2300-write-mestre-pcl
                
                move 3800                          to ws-pos-y
                
                initialize                         f05100-item-nota-fiscal
                move f05000-cd-empresa             to f05100-cd-empresa                                
                move f05000-cd-filial              to f05100-cd-filial                                     
                move f05000-tipo-nota              to f05100-tipo-nota                                         
                move f05000-numero-documento       to f05100-numero-documento                                         
                move f05000-serie-documento        to f05100-serie-documento                           
                move f05000-cd-destinatario        to f05100-cd-destinatario                                                   
                move f05000-sequencia              to f05100-sequencia                   
                perform 9000-str-pd05100-grt                
                perform 9000-ler-pd05100-nex
                perform until not ws-operacao-ok
                     or f05100-cd-empresa        <> f05000-cd-empresa      
                     or f05100-cd-filial         <> f05000-cd-filial       
                     or f05100-tipo-nota         <> f05000-tipo-nota       
                     or f05100-numero-documento  <> f05000-numero-documento
                     or f05100-serie-documento   <> f05000-serie-documento 
                     or f05100-cd-destinatario   <> f05000-cd-destinatario
                     
                     perform 2300-monta-working-produto-pcl
                     
                     perform 2300-write-produto-pcl
                     
                     perform 9000-ler-pd05100-nex                             
                end-perform
                
                close arqpcl
                
                perform 2400-gerar-pdf-nfe                

                perform 9000-ler-pd05000-nex
            end-perform
       
       exit.
      *>=================================================================================
       2010-criar-arquivo-pcl section.

            accept ws-horas                        from time
            accept ws-data-inv                     from date yyyymmdd
       
            string lnk-tmp-path "\" c-este-programa "_" lnk-id-usuario "_"  ws-data-inv "_" ws-horas ".WRK" delimited by "  " into wid-arqpcl                                                                                                                                                                       
            open output arqpcl
            close arqpcl
            open extend arqpcl
            
            move wid-arqpcl                        to ws-nfe-dados-pcl

            accept ws-horas                        from time
            accept ws-data-inv                     from date yyyymmdd
            
            string lnk-tmp-path "\" c-este-programa "_" lnk-id-usuario "_"  ws-data-inv "_" ws-horas ".WRK" delimited by "  " into ws-nfe-pcl 

            perform until wid-arqpcl <> ws-nfe-pcl

                accept ws-horas                        from time
                accept ws-data-inv                     from date yyyymmdd
                
                string lnk-tmp-path "\" c-este-programa "_" lnk-id-usuario "_"  ws-data-inv "_" ws-horas ".WRK" delimited by "  " into ws-nfe-pcl 

            end-perform                                                                                                                                                                       

       exit.
      *>=================================================================================
       2300-monta-working-pcl section.
       
            initialize                             f00700-empresa
            move lnk-cd-empresa                    to f00700-cd-empresa
            move lnk-cd-filial                     to f00700-cd-filial
            perform 9000-ler-pd00700-ran
            if    not ws-operacao-ok
                  exit section
            end-if
     
            *>================================================================
            *>                         CANHOTO NFE
            *>================================================================
            
            initialize                             r01-canhoto-nfe 
            move f00700-razao-social               to r01-razao-social
            move f05000-numero-documento           to r01-numero-documento
            move f05000-serie-documento            to r01-serie-documento

            *>================================================================
            *>                          MESTRE NFE
            *>================================================================
            
            initialize                             r02-mestre-nfe
            move 1                                 to r02-tipo-documento
            move f05000-numero-documento           to r02-numero-documento
            move f05000-serie-documento            to r02-serie-documento
            move spaces                            to r02-controle-fisico
            perform 9000-calcula-nr-random
            move ws-chave-random                   to r02-chave-acesso
            move "VENDA DE MERCADORIAS"            to r02-natureza-operacao
            perform 9000-calcula-nr-random
            move ws-chave-random                   to r02-protocolo-autorizacao
            move f00700-ie                         to r02-inscricao-estadual
            move spaces                            to r02-inscricao-estadual-subst
            string f00700-cnpj(01:02) "." f00700-cnpj(03:03) "." 
                   f00700-cnpj(06:03) "/" f00700-cnpj(09:04) "-"f00700-cnpj(13:02) into r02-cnpj

            move spaces                            to ws-nfe-pdf
            string lnk-nfe-path "\" f05000-numero-documento "_" f05000-serie-documento "_" ws-chave-random ".PDF" delimited by "  " into ws-nfe-pdf

            *>================================================================
            *>                      DESTINATÁRIO NFE
            *>================================================================
            
             initialize                            f01400-cliente
             move lnk-cd-empresa                   to f01400-cd-empresa
             move lnk-cd-filial                    to f01400-cd-filial
             move f05000-cd-destinatario           to f01400-cd-cliente
             perform 9000-ler-pd01400-ran                                           
             if    not ws-operacao-ok
                   exit section
             end-if
             
             initialize                            r03-destinatario
             move f01400-razao-social              to r03-razao-social
             if   f01400-pessoa-juridica
                  string f01400-cgc(01:02) "." f01400-cgc(03:03) "." f01400-cgc(06:03) "/" f01400-cgc(09:04) "-"f01400-cgc(13:02) into r03-cgc      
             else
                  string f01400-cgc(05:03) "." f01400-cgc(08:03) "." f01400-cgc(11:03) "-" f01400-cgc(13:02) into r03-cgc
             end-if
             move f05000-data-operacao              to ws-data-inv
             move ws-dia-inv                        to ws-dia
             move ws-mes-inv                        to ws-mes
             move ws-ano-inv                        to ws-ano
             move ws-data                           to r03-data-emissao
             initialize                             lk-logradouro
             move f01400-id-logradouro              to lk-id-logradouro
             call c-pesquisar-cep using lnk-par lk-logradouro
             cancel c-pesquisar-cep
             move lk-endereco                       to r03-endereco
             move lk-bairro                         to r03-bairro
             string lk-cep(01:05) "-" lk-cep(06:03) into r03-cep
             move f05000-data-saida                 to ws-data-inv
             move ws-dia-inv                        to ws-dia
             move ws-mes-inv                        to ws-mes
             move ws-ano-inv                        to ws-ano
             move ws-data                           to r03-data-saida
             move lk-municipio                      to r03-municipio
             string "+ " f01400-nr-telefone-1(01:02) " (" f01400-nr-telefone-1(03:03) ") " 
                    f01400-nr-telefone-1(06:05) "-" f01400-nr-telefone-1(11:04) into r03-telefone
             move lk-uf                             to r03-unidade-federativa                         
             move f01400-ie                         to r03-inscricao-estadual
             string f05000-hora-saida ":" f05000-minuto-saida into r03-hora-saida
                          
            *>================================================================
            *>                       FATURA NFE
            *>================================================================                           
             
            initialize                             r04-fatura
            move f05000-numero-documento           to r04-numero-documento
            move zeros                             to r04-parcela-documento
            move f05000-valor-total                to r04-valor-original
            move zeros                             to r04-valor-desconto
            move f05000-valor-total                to r04-valor-liquido

            *>================================================================
            *>                          IMPOSTO NFE
            *>================================================================
            
            initialize                             r05-calculo-imposto
            move f05000-base-icms                  to r05-base-icms
            move f05000-valor-icms                 to r05-valor-icms
            move f05000-base-icms-st               to r05-base-icms-st
            move f05000-valor-icms-st              to r05-valor-icms-st
            move f05000-valor-total-produtos       to r05-valor-total-produtos
            move f05000-valor-frete                to r05-valor-frete
            move f05000-valor-seguro               to r05-valor-seguro
            move f05000-valor-desconto             to r05-valor-desconto
            move f05000-valor-outras-despesas      to r05-valor-outras-despesas
            move f05000-valor-ipi                  to r05-valor-ipi
            move f05000-valor-total                to r05-valor-total-nota-fiscal
            
            *>================================================================
            *>                    TRANSPORTADOR NFE
            *>================================================================            
            
            initialize                             r06-transportador
            move "ÁGIL TRANSPORTE"                 to r06-razao-social
            move "123456789012345"                 to r06-codigo-antt
            move "PLA-0000"                        to r06-placa-veiculo
            move "SC"                              to r06-uf-veiculo
            move "45.647.004/0001-02"              to r06-cgc
            move "RUA ANTÔNIO TREIS 1160"          to r06-endereco
            move "BLUMENAU"                        to r06-municipio
            move "SC"                              to r06-unidade-federativa
            move "300.765.134"                     to r06-inscricao-estadual
            move 1                                 to r06-quantidade
            move zeros                             to r06-especie 
            move zeros                             to r06-marca
            move zeros                             to r06-numeracao
            move zeros                             to r06-peso-bruto
            move zeros                             to r06-peso-liquido                        

       exit.      

      *>=================================================================================
       2300-monta-working-produto-pcl section.

            initialize                             r07-produto
            move f05100-cd-mercadoria              to r07-cogido-produto

            initialize                             f01800-produto
            move lnk-cd-empresa                    to f01800-cd-empresa
            move lnk-cd-filial                     to f01800-cd-filial
            move f05100-cd-mercadoria              to f01800-cd-produto
            perform 9000-ler-pd01800-ran
            if   not ws-operacao-ok
                 exit section
            end-if

            move f01800-descricao-produto           to r07-descricao-produto
            move f01800-ncm                         to r07-ncm
            move zeros                              to r07-cst
            move zeros                              to r07-cfop
            move "UN"                               to r07-unidade-medida
            
            move f05100-quantidade-mercadoria       to r07-quantiade
            move f05100-valor-unitario              to r07-valor-unitario
            move f05100-valor-total                 to r07-valor-total
        
            move zeros                              to r07-valor-desconto
            
            move f05100-base-icms                   to r07-base-icms
            move f05100-valor-icms                  to r07-valor-icms
            move f05100-valor-ipi                   to r07-valor-ipi
            move f05100-aliq-icms                   to r07-aliq-icms
            move f05100-aliq-ipi                    to r07-aliq-ipi            
                 
       exit.

             
      *>=================================================================================
       2300-write-mestre-pcl section.
       
            move 027                               to ws-codigo-esc-comp    

            *>================================================================
            *>                         CANHOTO NFE
            *>================================================================
            
            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "E" ws-codigo-esc "&l1H" ws-codigo-esc "&f3200y2X" into rl-linha-em-pcl
            write rl-registro-em-pcl
            
            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "(19U" ws-codigo-esc "(s16602t0b0s6.00v1P" into rl-linha-em-pcl
            write rl-registro-em-pcl
            
            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p500x170Y" r01-razao-social into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4250x270Y" r01-numero-documento into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4250x370Y" r01-serie-documento into rl-linha-em-pcl
            write rl-registro-em-pcl                        

            *>================================================================
            *>                          MESTRE NFE
            *>================================================================

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "(19U" ws-codigo-esc "(s16602t0b0s7.00v1P" into rl-linha-em-pcl
            write rl-registro-em-pcl            

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2550x770Y" r02-tipo-documento into rl-linha-em-pcl
            write rl-registro-em-pcl   

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2350x900Y" r02-numero-documento into rl-linha-em-pcl
            write rl-registro-em-pcl  

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2350x970Y" r02-serie-documento into rl-linha-em-pcl
            write rl-registro-em-pcl  

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3030x900Y" r02-chave-acesso into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "(19U" ws-codigo-esc "(s16602t0b0s6.00v1P" into rl-linha-em-pcl
            write rl-registro-em-pcl
              
            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x1270Y" r02-natureza-operacao into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3500x1280Y" r02-protocolo-autorizacao into rl-linha-em-pcl
            write rl-registro-em-pcl                     

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x1430Y" r02-inscricao-estadual into rl-linha-em-pcl
            write rl-registro-em-pcl            

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3126x1430Y" r02-cnpj into rl-linha-em-pcl
            write rl-registro-em-pcl

            *>================================================================
            *>                      DESTINATÁRIO NFE
            *>================================================================

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x1730Y" r03-razao-social into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3060x1730Y" r03-cgc into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4150x1730Y" r03-data-emissao into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x1880Y" r03-endereco into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2470x1880Y" r03-bairro into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3560x1880Y" r03-cep into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4150x1880Y" r03-data-saida into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x2030Y" r03-municipio into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1160x2030Y" r03-telefone into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2250x2030Y" r03-unidade-federativa into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3060x2030Y" r03-inscricao-estadual into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4150x2030Y" r03-hora-saida into rl-linha-em-pcl
            write rl-registro-em-pcl

            *>================================================================
            *>                       FATURA NFE
            *>================================================================ 

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x2330Y" r04-numero-documento into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1208x2330Y" r04-valor-original into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2356x2330Y" r04-valor-desconto into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3404x2330Y" r04-valor-liquido into rl-linha-em-pcl
            write rl-registro-em-pcl

            *>================================================================
            *>                          IMPOSTO NFE
            *>================================================================

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x2630Y" r05-base-icms into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p990x2630Y" r05-valor-icms into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1910x2630Y" r05-base-icms-st into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2830x2630Y" r05-valor-icms-st into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3750x2630Y" r05-valor-total-produtos into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x2780Y" r05-valor-frete into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p835x2780Y" r05-valor-seguro into rl-linha-em-pcl
            write rl-registro-em-pcl 

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1600x2780Y" r05-valor-desconto into rl-linha-em-pcl
            write rl-registro-em-pcl 

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2365x2780Y" r05-valor-outras-despesas into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3130x2780Y" r05-valor-ipi into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3895x2780Y" r05-valor-total-nota-fiscal into rl-linha-em-pcl
            write rl-registro-em-pcl

            *>================================================================
            *>                    TRANSPORTADOR NFE
            *>================================================================  

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x3080Y" r06-razao-social into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2572x3080Y" r06-codigo-antt into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3172x3080Y" r06-placa-veiculo into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3772x3080Y" r06-uf-veiculo into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3972x3080Y" r06-cgc into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x3230Y" r06-endereco into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1972x3230Y" r06-municipio into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3772x3230Y" r06-unidade-federativa into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3972x3230Y" r06-inscricao-estadual into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x3380Y" r06-quantidade into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p835x3380Y" r06-especie into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1600x3380Y" r06-marca into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2365x3380Y" r06-numeracao into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3120x3380Y" r06-peso-bruto into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3895x3380Y" r06-peso-liquido into rl-linha-em-pcl
            write rl-registro-em-pcl
         
       exit. 

      *>=================================================================================
       2300-write-produto-pcl section.

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p60x" ws-pos-y "Y" r07-cogido-produto into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p470x" ws-pos-y "Y" r07-descricao-produto into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1630x" ws-pos-y "Y" r07-ncm into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p1935x" ws-pos-y "Y" r07-cst into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2075x" ws-pos-y "Y" r07-cfop into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2220x" ws-pos-y "Y" r07-unidade-medida into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2365x" ws-pos-y "Y" r07-quantiade into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2665x" ws-pos-y "Y" r07-valor-unitario into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p2965x" ws-pos-y "Y" r07-valor-desconto into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3265x" ws-pos-y "Y" r07-valor-total into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3565x" ws-pos-y "Y" r07-base-icms into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p3865x" ws-pos-y "Y" r07-valor-icms into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4165x" ws-pos-y "Y" r07-valor-ipi into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4360x" ws-pos-y "Y" r07-aliq-icms into rl-linha-em-pcl
            write rl-registro-em-pcl

            move spaces                            to rl-linha-em-pcl
            string ws-codigo-esc "*p4500x" ws-pos-y "Y" r07-aliq-ipi into rl-linha-em-pcl
            write rl-registro-em-pcl

            add 70                                to ws-pos-y

       exit.

      *>=================================================================================       
       2400-gerar-pdf-nfe section.
       
            move spaces                            to ws-command-exec
            string "copy /y /b " ws-nfe-mascara-pcl " + " ws-nfe-dados-pcl " " ws-nfe-pcl " > nul" x"00"
               delimited by "  " into ws-command-exec
            call "SYSTEM" using ws-command-exec

            move spaces                            to ws-command-exec
            string "..\cgi\" pcl-writer " -dNOPAUSE -sDEVICE=pdfwrite "
                   "-sOutputFile=" ws-nfe-pdf
                   " " ws-nfe-pcl x"00"
               delimited by "  " into ws-command-exec
            move c-aguardar-execucao               to ws-flags
            call "CBL_EXEC_RUN_UNIT" using        ws-command-exec
                                     by value     length of ws-command-exec
                                     by reference ws-run-unit-id
                                     by value     ws-stack-size
                                                  ws-flags
                                     returning    ws-status-code

       
       exit.

      *>=================================================================================
       9000-calcula-nr-random section.

            accept ws-horas                        from time
            move function random(ws-horas) to ws-random        
             
            move 1                                 to ws-index

            perform 45 times
               move function random() to ws-random
               multiply ws-random by 1000 giving ws-numero
               string ws-char into ws-chave-random with pointer ws-index
            end-perform
            
       exit.
              
      *>=================================================================================
       3000-finalizacao section.
       
            close pd05000
       
       exit.  
                                                
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================
      *> Leituras

       copy CSR00700.cpy.
       copy CSR01400.cpy.
       copy CSR01800.cpy. 
       copy CSR05000.cpy.
       copy CSR05100.cpy.