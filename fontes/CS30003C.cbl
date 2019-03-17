      $set sourceformat"free"
       program-id. CS30003C.
      *>=================================================================================
      *>    
      *>                        Gerenciador de Chamadas Assincronas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.

       copy CSS01400.cpy.
       copy CSS01800.cpy.
       copy CSS02100.cpy.
       copy CSS05000.cpy.
       copy CSS05100.cpy.
       copy CSS06000.cpy.  

            select arq-nfe assign to disk wid-arq-nfe
                organization             is indexed
                access mode              is dynamic
                record key               is nfe-sequencia
                alternate key            is nfe-cd-mercadoria                                                               
                lock mode                is manual
                file status              is ws-resultado-acesso. 

      *>=================================================================================
       data division.

       copy CSF01400.cpy.      
       copy CSF01800.cpy.
       copy CSF02100.cpy.
       copy CSF05000.cpy.
       copy CSF05100.cpy.    
       copy CSF06000.cpy.

       fd   arq-nfe.

       01   nfe.
            05 nfe-sequencia                       pic 9(09). *> 001 - 999999999
            03 nfe-cd-mercadoria                   pic 9(09).
            03 nfe-cd-unidade-medida               pic 9(02).
            03 nfe-quantidade-mercadoria           pic 9(06)v9(04).
            03 nfe-valor-unitario                  pic 9(09)v9(02).
            03 nfe-valor-total                     pic 9(09)v9(02).

      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS30003C".
       78   c-descricao-programa                   value "EMISSAO NF-E".
       78   c-impressao-nfe                        value "CS00106S".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       copy CSW05000.cpy.
       copy CSW05100.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-ctrl-execucao                    pic x(01).
               88 ws-habilita-confirmar-cancelar        value "S".
            
            03 ws-id-produto                       pic x(01).
               88 ws-produto-nao-cadastrado             value "N".
               88 ws-produto-cadastrado                 value "S".     
            03 ws-id-produto-preco                 pic x(01).
               88 ws-produto-preco-nao-cadastrado       value "N".
               88 ws-produto-preco-cadastrado           value "S".             
            03 ws-id-produto-lista                 pic x(01).
               88 ws-produto-nao-consta-lista           value "N".
               88 ws-produto-consta-lista               value "S".
            03 ws-id-produto-excluido              pic x(01).
               88 ws-produto-nao-excluido-lista         value "N".
               88 ws-produto-excluido-lista             value "S".
            03 ws-id-produto-estoque               pic x(01).
               88 ws-produto-indisponivel-estoque       value "N".
               88 ws-produto-disponivel-estoque         value "S".
            03 ws-nr-coluna                        pic 9(09).
            03 ws-nr-linha                         pic 9(09).
            03 ws-ds-funcao                        pic x(19).
            03 ws-linha-display                    pic x(111).
            03 ws-id-finalizar-pedido              pic x(01).
               88 ws-finalizar-pedido                   value "S".
               88 ws-nao-finalizar-pedido               value "N".
            03 ws-produto.
               07 ws-sequencia-produto             pic 9(09).
               07 ws-codigo-produto                pic 9(09).
               07 ws-qtde-produto                  pic 9(06)v9(04).
               07 ws-valor-unitario-produto        pic 9(09)v9(02).
               07 ws-valor-total-produto           pic 9(09)v9(02).
               07 ws-qtde-disponivel               pic s9(09)v9(04).
               07 ws-qtde-reservada                pic s9(09)v9(04).  
            03 ws-total-produto.
               07 ws-valor-total                   pic 9(10)v9(02).
       01   ws-linha-nfe-itens.
            03 ws-ln-cd-produto                    pic zzzzzzzzz.
            03 filler                              pic x(03) value " ³ ".
            03 ws-ln-ds-produto                    pic x(45).
            03 filler                              pic x(03) value " ³ ".
            03 ws-ln-un-produto                    pic x(02).
            03 filler                              pic x(03) value " ³ ".
            03 ws-ln-qtde-produto                  pic zzz.zzz,zzzz.
            03 filler                              pic x(03) value " ³ ".
            03 ws-ln-vl-unitario-produto           pic zzz.zzz.zzz,zz.
            03 filler                              pic x(03) value " ³ ".
            03 ws-ln-vl-total-produto              pic zzz.zzz.zzz,zz. 
                          
     
       01   ws-quadros.
            03 ws-cabecalho-quadro.
               05 filler                           pic x(001) value all "Ú".
               05 filler                           pic x(114) value all "Ä". 
               05 filler                           pic x(001) value all "¿".   
            03 ws-linha-quadro.
               05 filler                           pic x(001) value all "³".
               05 filler                           pic x(114) value all " ". 
               05 filler                           pic x(001) value all "³". 
            03 ws-rodape-quadro.
               05 filler                           pic x(001) value all "À".
               05 filler                           pic x(114) value all "Ä". 
               05 filler                           pic x(001) value all "Ù". 

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

       01   lk-parametros-nfe.
            03 lk-numero-documento                 pic 9(09).
            03 lk-serie-documento                  pic 9(03).

       01   f-cliente.
            03 f-cd-cliente                        pic 9(09).
            03 f-razao-social                      pic x(55).
            03 f-nome-fantasia                     pic x(55).
            03 f-tipo-pessoa                       pic x(01).
               88 f-pessoa-fisica                       value "F".
               88 f-pessoa-juridica                     value "J".
            03 f-ds-tipo-pessoa                    pic x(30).
            03 f-cpf                               pic 9(11).
            03 f-cnpj                              pic 9(14).
            03 f-ie                                pic x(11).
            03 f-id-logradouro                     pic 9(09).
            03 f-cep                               pic 9(08).
            03 f-endereco                          pic x(55).
            03 f-nr-endereco                       pic x(10).
            03 f-bairro                            pic x(55).
            03 f-municipio                         pic x(55).
            03 f-uf                                pic x(02).
            03 f-nome-pais                         pic x(55).
            03 f-nr-telefone-1                     pic 9(14).
            03 f-nr-telefone-2                     pic 9(14).
            03 f-nr-telefone-3                     pic 9(14).
            03 f-email                             pic x(55).
            03 f-id-status                         pic x(01).
               88 f-cliente-ativo                       value "A".
               88 f-cliente-inativo                     value "I".
               88 f-cliente-bloqueado                   value "B".
            03 f-ds-status                         pic x(30).

       01   f-produto.
            03 f-cd-produto                        pic zzzzzzzzz. 
            03 f-descricao-produto                 pic x(55).
            03 f-qtde-produto                      pic zzz.zzz,zzzz.
            03 f-vl-unitario-produto               pic zzz.zzz.zzz,zz.
            03 f-vl-total-produto                  pic zzz.zzz.zzz,zz.            

       01   f-produto-total.
            03 f-vl-total                          pic z.zzz.zzz.zzz,zz.
    
      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-cliente.
            03 line 11 col 18   pic x(15) value "Codigo Cliente:".
            03 line 11 col 34   pic 9(09) from f-cd-cliente.
            03 line 13 col 20   pic x(13) value "Razao Social:".
            03 line 13 col 34   pic x(55) from f-razao-social.
            03 line 15 col 19   pic x(14) value "Nome Fantasia:".
            03 line 15 col 34   pic x(55) from f-nome-fantasia.
            03 line 17 col 21   pic x(12) value "Tipo Pessoa:".
            03 line 17 col 34   pic x(01) from f-tipo-pessoa.
            03 line 17 col 36   pic x(01) value "-". 
            03 line 17 col 38   pic x(30) from f-ds-tipo-pessoa.
            03 line 19 col 24   pic x(09) value "CNPJ/CPF:".
            03 line 19 col 59   pic x(03) value "IE:".
            03 line 19 col 63   pic x(11) from f-ie.
            03 line 21 col 29   pic x(04) value "CEP:".
            03 line 21 col 34   pic x(09) from ws-mascara-cep.
            03 line 21 col 34   pic 9(05) from f-cep(01:05).
            03 line 21 col 40   pic 9(03) from f-cep(06:03).
            03 line 23 col 24   pic x(09) value "Endereco:".
            03 line 23 col 34   pic x(55) from f-endereco.
            03 line 25 col 17   pic x(16) value "Numero Endereco:".
            03 line 25 col 34   pic x(10) from f-nr-endereco.
            03 line 25 col 55   pic x(07) value "Bairro:".
            03 line 25 col 63   pic x(55) from f-bairro.
            03 line 27 col 23   pic x(10) value "Municipio:".
            03 line 27 col 34   pic x(55) from f-municipio.
            03 line 29 col 30   pic x(03) value "UF:".
            03 line 29 col 34   pic x(02) from f-uf.
            03 line 29 col 57   pic x(05) value "Pais:".
            03 line 29 col 63   pic x(55) from f-nome-pais.
            03 line 31 col 24   pic x(09) value "Telefone:".
            03 line 31 col 34   pic x(20) from ws-mascara-telefone.
            03 line 31 col 35   pic 9(02) from f-nr-telefone-1(01:02).
            03 line 31 col 39   pic 9(03) from f-nr-telefone-1(03:03).
            03 line 31 col 44   pic 9(05) from f-nr-telefone-1(06:05).
            03 line 31 col 50   pic 9(04) from f-nr-telefone-1(11:04).
            03 line 33 col 24   pic x(09) value "Telefone:".
            03 line 33 col 34   pic x(20) from ws-mascara-telefone.
            03 line 33 col 35   pic 9(02) from f-nr-telefone-2(01:02).
            03 line 33 col 39   pic 9(03) from f-nr-telefone-2(03:03).
            03 line 33 col 44   pic 9(05) from f-nr-telefone-2(06:05).
            03 line 33 col 50   pic 9(04) from f-nr-telefone-2(11:04).            
            03 line 35 col 24   pic x(09) value "Telefone:".
            03 line 35 col 34   pic x(20) from ws-mascara-telefone.
            03 line 35 col 35   pic 9(02) from f-nr-telefone-3(01:02).
            03 line 35 col 39   pic 9(03) from f-nr-telefone-3(03:03).
            03 line 35 col 44   pic 9(05) from f-nr-telefone-3(06:05).
            03 line 35 col 50   pic 9(04) from f-nr-telefone-3(11:04).            
            03 line 37 col 26   pic x(07) value "E-mail:".
            03 line 37 col 34   pic x(55) from f-email.
            03 line 39 col 18   pic x(15) value "Status Cliente:".
            03 line 39 col 34   pic x(01) from f-id-status.
            03 line 39 col 36   pic x(01) value "-".
            03 line 39 col 38   pic x(30) from f-ds-status.

       01   frm-produto.
            03 line 11 col 10   pic x(15) value "Codigo Cliente:".
            03 line 11 col 26   pic 9(09) from f-cd-cliente.
            03 line 11 col 50   pic x(14) value "Nome Fantasia:".
            03 line 11 col 65   pic x(55) from f-nome-fantasia.
            03 line 13 col 10   pic x(15) value "Codigo produto:".
            03 line 13 col 26   pic z(09) from f-cd-produto.
            03 line 13 col 46   pic x(18) value "Descricao Produto:".
            03 line 13 col 65   pic x(55) from f-descricao-produto. 
            03 line 15 col 14   pic x(11) value "Quantidade:".
            03 line 15 col 26   pic zzz.zzz,zzzz from f-qtde-produto.       
            03 line 15 col 49   pic x(15) value "Valor Unitario:".
            03 line 15 col 65   pic zzz.zzz.zzz,zz from f-vl-unitario-produto. 
            03 line 15 col 89   pic x(14) value "Total Produto:". 
            03 line 15 col 104  pic zzz.zzz.zzz,zz from f-vl-total-produto.
            03 line 49 col 91   pic x(12) value "VALOR TOTAL:".
            03 line 49 col 104  pic z.zzz.zzz.zzz,zz from f-vl-total.  

       01   frm-quadro-produto.
            03 line 017 col 004   pic x(116) from ws-cabecalho-quadro.
            03 line 018 col 004   pic x(116) from ws-linha-quadro.
            03 line 018 col 006   pic x(009) value "Cod. Prod".
            03 line 018 col 016   pic x(001) value "³".
            03 line 018 col 039   pic x(009) value "Descricao".
            03 line 018 col 064   pic x(001) value "³".
            03 line 018 col 066   pic x(002) value "UN".
            03 line 018 col 069   pic x(001) value "³".
            03 line 018 col 072   pic x(010) value "Quantidade".
            03 line 018 col 084   pic x(001) value "³".
            03 line 018 col 086   pic x(014) value "Valor Unitario".
            03 line 018 col 101   pic x(001) value "³".
            03 line 018 col 104   pic x(013) value "Total Produto".
            03 line 019 col 004   pic x(116) from ws-rodape-quadro.

            03 line 020 col 004   pic x(116) from ws-cabecalho-quadro.
            03 line 021 col 004   pic x(116) from ws-linha-quadro.            
            03 line 022 col 004   pic x(116) from ws-linha-quadro. 
            03 line 023 col 004   pic x(116) from ws-linha-quadro. 
            03 line 024 col 004   pic x(116) from ws-linha-quadro. 
            03 line 025 col 004   pic x(116) from ws-linha-quadro. 
            03 line 026 col 004   pic x(116) from ws-linha-quadro. 
            03 line 027 col 004   pic x(116) from ws-linha-quadro. 
            03 line 028 col 004   pic x(116) from ws-linha-quadro. 
            03 line 029 col 004   pic x(116) from ws-linha-quadro. 
            03 line 030 col 004   pic x(116) from ws-linha-quadro. 
            03 line 031 col 004   pic x(116) from ws-linha-quadro. 
            03 line 032 col 004   pic x(116) from ws-linha-quadro. 
            03 line 033 col 004   pic x(116) from ws-linha-quadro. 
            03 line 034 col 004   pic x(116) from ws-linha-quadro. 
            03 line 035 col 004   pic x(116) from ws-linha-quadro. 
            03 line 036 col 004   pic x(116) from ws-linha-quadro. 
            03 line 037 col 004   pic x(116) from ws-linha-quadro. 
            03 line 038 col 004   pic x(116) from ws-linha-quadro. 
            03 line 039 col 004   pic x(116) from ws-linha-quadro. 
            03 line 040 col 004   pic x(116) from ws-linha-quadro.
            03 line 041 col 004   pic x(116) from ws-linha-quadro.
            03 line 042 col 004   pic x(116) from ws-linha-quadro.
            03 line 043 col 004   pic x(116) from ws-linha-quadro.
            03 line 044 col 004   pic x(116) from ws-linha-quadro.
            03 line 045 col 004   pic x(116) from ws-linha-quadro.
            03 line 046 col 004   pic x(116) from ws-linha-quadro.
            03 line 047 col 004   pic x(116) from ws-rodape-quadro.

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
       
            initialize                             wf-opcoes-frame

            perform 9000-abrir-i-pd01400
            perform 9000-abrir-i-pd01800
            perform 9000-abrir-i-pd02100
            perform 9000-abrir-io-pd05000
            perform 9000-abrir-io-pd05100
            perform 9000-abrir-io-pd06000
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
             perform until wf-frame-retornar
                      
                 evaluate wf-frame
                      when 0
                           perform 8000-tela-cliente
                           perform 8000-controle-frame
                      when 9
                           perform 2999-controle-frame
                      when other   
                           move "Frame invalido!"   to ws-mensagem
                           perform 9000-mensagem
                 end-evaluate
                           
            end-perform
       
       exit.

      *>=================================================================================
       3000-finalizacao section.

            close pd01400
            close pd01800
            close pd02100
       
       exit. 

      *>=================================================================================
       2999-controle-frame section.
        
            perform 8000-accept-opcao
            
            evaluate wf-opcao
                when 01
                     perform 2100-emitir
                when 02 
                     perform 2100-confirmar
                when 03
                     if   ws-habilita-confirmar-cancelar
                          set wf-frame-retornar    to true
                     end-if
                when 99
                     set wf-frame-retornar         to true                       
                when other    
                     move "Opcao invalida!"   to ws-mensagem
                     perform 9000-mensagem            
            end-evaluate
       
       exit.
      *>=================================================================================
       2100-emitir section.

            if   not lnk-permite-inclusao
                 exit section
            end-if

            accept ws-horas                        from time
            accept ws-data-inv                     from date yyyymmdd
            
            string lnk-tmp-path "\" c-este-programa "_" lnk-id-usuario "_" ws-data-inv "_" ws-horas ".WRK" delimited by "  " into wid-arq-nfe
            open output arq-nfe
            close arq-nfe
            open i-o arq-nfe
            
            perform 2200-cliente       

            perform 9000-sleep-1s

            perform 2200-produto

            set ws-habilita-confirmar-cancelar      to true

       exit.

      *>=================================================================================
       2100-confirmar section.

            if   not ws-habilita-confirmar-cancelar
                 exit section
            end-if

            perform 2300-emitir-nota-fiscal

            move lk-parametros-nfe          to lnk-linha-comando
            
            call c-impressao-nfe using lnk-par
            cancel c-impressao-nfe 
  
       exit.

      *>================================================================================= 
       2200-cliente section. 

            perform 8000-limpa-tela-cliente

            perform until exit

                 accept f-tipo-pessoa at line 17 col 34 with update auto-skip

                 perform 9000-monta-descricao-tipo-pessoa 

                 if   f-pessoa-fisica
                 or   f-pessoa-juridica
                      exit perform
                 end-if   

            end-perform

            if   f-pessoa-fisica
                 
                 display ws-mascara-cpf at line 19 col 34

                 perform until f-cpf <> zeros            
                      
                         accept f-cpf(01:03) at line 19 col 34 with update auto-skip
                
                         accept f-cpf(04:03) at line 19 col 38 with update auto-skip 
                 
                         accept f-cpf(07:03) at line 19 col 42 with update auto-skip 
                 
                         accept f-cpf(10:02) at line 19 col 46 with update auto-skip 
                 
                 end-perform

            else
                 display ws-mascara-cnpj at line 19 col 34

                 perform until f-cnpj <> zeros
                 
                      accept f-cnpj(01:02) at line 19 col 34 with update auto-skip
                                             
                      accept f-cnpj(03:03) at line 19 col 37 with update auto-skip
                                                 
                      accept f-cnpj(06:03) at line 19 col 41 with update auto-skip
                                              
                      accept f-cnpj(09:04) at line 19 col 45 with update auto-skip
                                          
                      accept f-cnpj(13:02) at line 19 col 50 with update auto-skip    
                 
                 end-perform
            end-if

            initialize                             f01400-cliente
            if   f-pessoa-fisica
                 move f-cpf                        to f01400-cgc
            else
                 move f-cnpj                       to f01400-cgc
            end-if
            perform 9000-ler-pd01400-ran-1
            if   not ws-operacao-ok
                 move "Cliente não cadastrado!" to ws-mensagem
                 perform 9000-mensagem
                 exit section   
            end-if

            perform 9000-move-registros-frame

       exit.

      *>=================================================================================
       2200-produto section.

            perform 8000-tela-produto

            move zeros                             to ws-valor-total
                                                      f-vl-total

            set ws-nao-finalizar-pedido            to true
            
            perform until ws-finalizar-pedido
                
                perform until exit
                    
                    initialize                         f-produto
                                                       ws-produto
                    perform 8000-tela-produto
                    
                    accept f-cd-produto at line 13 col 26 with update auto-skip
                    move f-cd-produto                   to ws-codigo-produto

                    if   ws-codigo-produto greater zeros
                         *> Monta descrição produto informado na lista
                         perform 2200-descricao-produto
                         
                         *> Verifica se o produto já foi adicionado à lista, se sim, abre manutenção
                         if   ws-produto-cadastrado
                              perform 2200-verificar-produto-lista
                         end-if     

                         *> Se o produto não consta na lista, então busca o preço do produto
                         if   ws-produto-cadastrado
                         and  ws-produto-nao-consta-lista
                              perform 2200-preco-produto
                         end-if     

                         if   ws-produto-cadastrado
                         and  (ws-produto-preco-cadastrado or ws-produto-consta-lista) 
                              exit perform
                         end-if                       
                    else
                        move "Incluir outro produto? [S/N]" to ws-mensagem
                        perform 9000-mensagem

                        if   ws-mensagem-opcao-nao
                            exit section
                        end-if
                    end-if                     
                end-perform

                if   ws-produto-nao-excluido-lista     

                     perform until exit
                     
                         accept f-qtde-produto at line 15 col 26 with update auto-skip
                         move f-qtde-produto            to ws-qtde-produto
                     
                         perform 9000-verifica-estoque

                         if   ws-produto-disponivel-estoque
                              exit perform
                         end-if

                     end-perform
                     
                     perform 2200-total-produto
                     
                     if   ws-produto-consta-lista
                          perform 2200-regravar-temporario-nfe
                     else
                          perform 2200-gravar-temporario-nfe
                     end-if
                
                end-if                

                perform 2200-total-pedido
                
                perform 8000-tela-produto

            end-perform

            initialize                              f-produto
            perform 8000-tela-produto

       exit.
      *>=================================================================================
       2200-descricao-produto section.

            set ws-produto-nao-cadastrado          to true
            
            initialize                f01800-produto
            move lnk-cd-empresa       to f01800-cd-empresa
            move lnk-cd-filial        to f01800-cd-filial
            move ws-codigo-produto    to f01800-cd-produto
            perform 9000-ler-pd01800-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro de leitura f01800-produto - " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
            else
                 if   ws-registro-inexistente
                      string "Produto não cadastrado! [" ws-codigo-produto "]" into ws-mensagem
                      perform 9000-mensagem                              
                 else
                      set ws-produto-cadastrado        to true
                      
                      move f01800-cd-produto           to f-cd-produto
                      move f01800-descricao-produto    to f-descricao-produto

                      perform 8000-tela-produto
                 end-if     
            end-if
       
       exit.
      *>=================================================================================
       2200-preco-produto section.

            set ws-produto-preco-nao-cadastrado    to true 
            
            initialize                       f02100-preco-produto
            move lnk-cd-empresa              to f02100-cd-empresa
            move lnk-cd-filial               to f02100-cd-filial
            move f-cd-produto                to f02100-cd-produto
            perform 9000-ler-pd02100-ran
            if   not ws-operacao-ok
                 if   ws-registro-inexistente
                      string "Produto [ " f-cd-produto "] não possuí preço cadastrado!" into ws-mensagem
                      perform 9000-mensagem
                      
                      initialize             f-produto
                      perform 8000-tela-produto                                             
                 else
                      string "Erro de leitura f02100-preco-produto - " ws-resultado-acesso into ws-mensagem
                      perform 9000-abortar
                      perform 9000-mensagem   
                 end-if                         
            else
                 set ws-produto-preco-cadastrado   to true 
                 
                 move f02100-vl-unitario     to f-vl-unitario-produto
                                             ws-valor-unitario-produto
                 perform 8000-tela-produto
            end-if   
       
       exit.              
      *>================================================================================= 
       2200-verificar-produto-lista section.
       
            set ws-produto-nao-consta-lista        to true
            set ws-produto-nao-excluido-lista      to true
            
            initialize                             nfe
            move ws-codigo-produto                 to nfe-cd-mercadoria 
            read arq-nfe key is nfe-cd-mercadoria
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "2200 - Erro de leitura nfe - Status: " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar           
            end-if
            
            if   ws-operacao-ok
                 string "O produto [" ws-codigo-produto "] já consta na lista! Deseja excluir? [S/N]" into ws-mensagem
                 perform 9000-mensagem

                if   ws-mensagem-opcao-sim
                     set ws-produto-excluido-lista     to true
                     
                     delete arq-nfe 
                else
                     set ws-produto-consta-lista       to true
                     
                     move nfe-quantidade-mercadoria    to f-qtde-produto
                     move nfe-valor-unitario           to f-vl-unitario-produto
                                                          ws-valor-unitario-produto
                     move nfe-valor-total              to f-vl-total-produto
                     
                     perform 8000-tela-produto
                end-if  
            end-if
       
       exit.

      *>=================================================================================
       2200-total-produto section.

            move zeros                             to ws-valor-total-produto 
             
            compute ws-valor-total-produto rounded = ws-valor-unitario-produto * ws-qtde-produto
            
            move ws-valor-total-produto            to f-vl-total-produto        
       
       exit.
       
      *>=================================================================================
       2200-total-pedido section.
       
            move zeros                             to ws-valor-total

            initialize                             nfe
            move 999999999                         to nfe-sequencia
            start arq-nfe key is not greater nfe-sequencia
            read arq-nfe previous
            perform until not ws-operacao-ok
                  
                 add nfe-valor-total          to ws-valor-total 
             
                 read arq-nfe previous   
            end-perform
            
            move ws-valor-total                    to f-vl-total
                    
       exit.
              
      *>=================================================================================
       2200-gravar-temporario-nfe section.
       
            move zeros                          to ws-sequencia-produto
            
            initialize                          nfe
            move 99999999                       to nfe-sequencia
            start arq-nfe key is not greater nfe-sequencia
            read arq-nfe previous
            if   ws-operacao-ok
                 add 1                                 to nfe-sequencia
                 move nfe-sequencia                    to ws-sequencia-produto
            else
                 move 1                                to ws-sequencia-produto                                            
            end-if
            
            
            initialize                          nfe
            move ws-sequencia-produto           to nfe-sequencia
            move f-cd-produto                   to nfe-cd-mercadoria
            move ws-qtde-produto                to nfe-quantidade-mercadoria
            move ws-valor-unitario-produto      to nfe-valor-unitario
            move ws-valor-total-produto         to nfe-valor-total
            write nfe
            if   not ws-operacao-ok
                 string "Erro ao gravar nfe - Status " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if
       
       exit.  

      *>=================================================================================
       2200-regravar-temporario-nfe section.
            
            initialize                             nfe
            move ws-codigo-produto                 to nfe-cd-mercadoria 
            read arq-nfe key is nfe-cd-mercadoria
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "2200 - Erro de leitura nfe - Status: " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar           
            end-if
            
            if   ws-operacao-ok
                 move ws-qtde-produto                to nfe-quantidade-mercadoria
                 move ws-valor-unitario-produto      to nfe-valor-unitario
                 move ws-valor-total-produto         to nfe-valor-total
                 rewrite nfe
                 if   not ws-operacao-ok
                      string "Erro ao regravar nfe - Status " ws-resultado-acesso into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if
            end-if
       
       exit.       
              
      *>================================================================================= 
       2300-emitir-nota-fiscal section.
    
            initialize                             nfe
            move 000000001                         to nfe-sequencia
            read arq-nfe
            if   not ws-operacao-ok
                 move "Não foram informados itens para venda!"  to ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if

            call c-proximo-documento using lnk-par
            cancel c-proximo-documento

            initialize                             lk-parametros-nfe
            move lnk-numero-documento              to lk-numero-documento
            move lnk-serie-documento               to lk-serie-documento 
            
            initialize                             wf05000-mestre-nota-fiscal
            move lnk-cd-empresa                    to wf05000-cd-empresa
            move lnk-cd-filial                     to wf05000-cd-filial
            move 01                                to wf05000-tipo-nota
            move f-cd-cliente                      to wf05000-cd-destinatario
            move lnk-numero-documento              to wf05000-numero-documento
            move lnk-serie-documento               to wf05000-serie-documento
            move zeros                             to wf05000-sequencia

            accept ws-data-inv                     from date yyyymmdd
            accept ws-horas                        from time

            move ws-data-inv                       to wf05000-data-operacao
            move ws-horas(01:06)                   to wf05000-horario-operacao

            move function numval(lnk-id-usuario)   to wf05000-id-usuario-operacao

            move ws-data-inv                       to wf05000-data-saida
            move ws-horas(01:06)                   to wf05000-horario-saida

            move ws-data-inv                       to wf05000-data-entrega
            move ws-horas(01:06)                   to wf05000-horario-entrega   
            
            perform 9000-descarregar-itens-nfe
            
            perform 9000-mestre-nota-fiscal
                      
            write f05000-mestre-nota-fiscal
            if   not ws-operacao-ok
                 string "Erro ao gravar f05001-mestre-nota-fiscal - " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if
            
            string "Nota fiscal [" wf05000-numero-documento "/" wf05000-serie-documento "] emitda com sucesso!" into ws-mensagem
            perform 9000-mensagem
            
            perform 8000-inicia-frame
       exit.
       
      *>=================================================================================
       9000-descarregar-itens-nfe section.

            initialize                            wf05100-item-nota-fiscal
            move wf05000-cd-empresa               to wf05100-cd-empresa
            move wf05000-cd-empresa               to wf05100-cd-empresa
            move wf05000-cd-filial                to wf05100-cd-filial
            move wf05000-tipo-nota                to wf05100-tipo-nota
            move wf05000-cd-destinatario          to wf05100-cd-destinatario
            move wf05000-numero-documento         to wf05100-numero-documento
            move wf05000-serie-documento          to wf05100-serie-documento
            move wf05000-sequencia                to wf05100-sequencia

            initialize                             nfe
            start arq-nfe key is greater nfe-sequencia 
            read arq-nfe next
            perform until not ws-operacao-ok

                add 01                             to wf05100-sequencia
                
                move nfe-cd-mercadoria             to wf05100-cd-mercadoria
                
                *> Buscar CST mercadoria
                
                *> Buscar CFOP mercadoria

                initialize                         ws-produto
                move nfe-cd-mercadoria             to ws-codigo-produto
                move nfe-quantidade-mercadoria     to ws-qtde-produto
                
                perform 9000-saida-estoque
                
                move nfe-cd-unidade-medida         to wf05100-cd-unidade-medida
                move nfe-quantidade-mercadoria     to wf05100-quantidade-mercadoria
                move nfe-valor-unitario            to wf05100-valor-unitario
                move nfe-valor-total               to wf05100-valor-total
                
                *> Acumular Total NF-e
                add  wf05100-valor-total           to wf05000-valor-total
                
                *> Calcular Base de ICMS
                
                *> Calcular Valor de ICMS 
                
                perform 9000-item-nota-fiscal
                
                write f05100-item-nota-fiscal
                if   not ws-operacao-ok
                     string "Erro ao gravar f05002-item-nota-fiscal - " ws-resultado-acesso into ws-mensagem
                     perform 9000-mensagem
                     perform 9000-abortar
                end-if
            
                read arq-nfe next 
            end-perform     
       
       exit.                                                       
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame

      *>=================================================================================
       8000-tela-cliente section.

            move 01                                to ws-nr-coluna
            
            if   lnk-permite-inclusao
                 move "01 - Emissao"               to ws-ds-funcao
                 string ws-ds-funcao               into lnk-ds-funcao with pointer ws-nr-coluna 
            end-if              

            move "99 - Retornar"                   to ws-ds-funcao
            string ws-ds-funcao                    into lnk-ds-funcao with pointer ws-nr-coluna

                  
            perform 9000-frame-padrao

            if   f-pessoa-fisica
                 display ws-mascara-cpf at line 19 col 34 
                      
                 display f-cpf(01:03) at line 19 col 34
                
                 display f-cpf(04:03) at line 19 col 38
                 
                 display f-cpf(07:03) at line 19 col 42
                 
                 display f-cpf(10:02) at line 19 col 46 
            else
                 display ws-mascara-cnpj at line 19 col 34
                 
                 display f-cnpj(01:02) at line 19 col 34 
                                        
                 display f-cnpj(03:03) at line 19 col 37 
                                            
                 display f-cnpj(06:03) at line 19 col 41 
                                         
                 display f-cnpj(09:04) at line 19 col 45 
                                     
                 display f-cnpj(13:02) at line 19 col 50 

            end-if

            display frm-cliente
       
       exit.          

      *>=================================================================================
       8000-limpa-tela-cliente section.
       
            initialize                             f-cliente
            
            move 01                                to ws-nr-coluna
            
            if   lnk-permite-inclusao
                 move "01 - Emissao"               to ws-ds-funcao
                 string ws-ds-funcao               into lnk-ds-funcao with pointer ws-nr-coluna 
            end-if              

            move "99 - Retornar"                   to ws-ds-funcao
            string ws-ds-funcao                    into lnk-ds-funcao with pointer ws-nr-coluna
            
            perform 9000-frame-padrao

            if   f-pessoa-fisica
                 display ws-mascara-cpf at line 19 col 34 
                      
                 display f-cpf(01:03) at line 19 col 34
                
                 display f-cpf(04:03) at line 19 col 38
                 
                 display f-cpf(07:03) at line 19 col 42
                 
                 display f-cpf(10:02) at line 19 col 46 
            else
                 display ws-mascara-cnpj at line 19 col 34
                 
                 display f-cnpj(01:02) at line 19 col 34 
                                        
                 display f-cnpj(03:03) at line 19 col 37 
                                            
                 display f-cnpj(06:03) at line 19 col 41 
                                         
                 display f-cnpj(09:04) at line 19 col 45 
                                     
                 display f-cnpj(13:02) at line 19 col 50 

            end-if

            display frm-cliente
       
       exit.


      *>=================================================================================
       8000-tela-produto section.
            
            move 01                                to ws-nr-coluna
            
            if   lnk-permite-inclusao
                 move "02 - Confirmar"               to ws-ds-funcao
                 string ws-ds-funcao               into lnk-ds-funcao with pointer ws-nr-coluna 
            end-if              

            move "03 - Cancelar"                   to ws-ds-funcao
            string ws-ds-funcao                    into lnk-ds-funcao with pointer ws-nr-coluna

            perform 9000-frame-padrao

            display frm-quadro-produto
    
            display frm-produto

            perform 8000-lista-produtos

       exit.

      *>=================================================================================
       8000-lista-produtos section.

            move 21                                to ws-nr-linha

            initialize                             nfe
            move 999999999                         to nfe-sequencia
            start arq-nfe key is not greater nfe-sequencia
            read arq-nfe previous
            perform until not ws-operacao-ok

                 initialize                        ws-linha-nfe-itens
                 move nfe-cd-mercadoria              to ws-ln-cd-produto

                 initialize                        f01800-produto
                 move lnk-cd-empresa               to f01800-cd-empresa
                 move lnk-cd-filial                to f01800-cd-filial
                 move nfe-cd-mercadoria            to f01800-cd-produto
                 perform 9000-ler-pd01800-ran
                 if   not ws-operacao-ok
                      move "PRODUTO NAO CADASTRADO" to ws-ln-ds-produto 
                 end-if
                 
                 move f01800-descricao-produto      to ws-ln-ds-produto
                 move nfe-quantidade-mercadoria     to ws-ln-qtde-produto
                 move nfe-valor-unitario            to ws-ln-vl-unitario-produto
                 move nfe-valor-total               to ws-ln-vl-total-produto
                          
                 move spaces                        to ws-linha-display
                
                 string ws-linha-nfe-itens          into ws-linha-display

                 display ws-linha-display at line ws-nr-linha col 06  
                
                 add 01                             to ws-nr-linha

                 if   ws-nr-linha > 46
                      exit perform
                 end-if
             
                 read arq-nfe previous   
            end-perform

       exit.
                                 
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão
       copy CSP05000.cpy.
       copy CSP05100.cpy.

      *>=================================================================================
       9000-monta-descricao-tipo-pessoa section.
       
            move function upper-case(f-tipo-pessoa) to f-tipo-pessoa
            
            evaluate true
                when f-pessoa-fisica
                    move "FISICA"                  to f-ds-tipo-pessoa
                    perform 8000-tela-cliente
                when f-pessoa-juridica
                    move "JURIDICA"                to f-ds-tipo-pessoa
                    perform 8000-tela-cliente
                when other
                    move "INVALIDO"                to f-ds-tipo-pessoa
                    perform 8000-tela-cliente
            end-evaluate
        
       exit.

      *>=================================================================================
       9000-monta-descricao-status section.
        
            move function upper-case(f-id-status)  to f-id-status

            evaluate true
                 when f-cliente-ativo
                      move "ATIVO"                 to f-ds-status
                      perform 8000-tela-cliente
                 when f-cliente-inativo
                      move "INATIVO"               to f-ds-status
                      perform 8000-tela-cliente
                 when f-cliente-bloqueado
                      move "BLOQUEADO"             to f-ds-status
                      perform 8000-tela-cliente
                 when other
                      move "INVALIDO"              to f-ds-status
                      perform 8000-tela-cliente
            end-evaluate       
       
       exit.
      *>=================================================================================
       9000-move-registros-frame section.

            initialize                             f-cliente
            move f01400-cd-cliente                 to f-cd-cliente                                    
            move f01400-razao-social               to f-razao-social               
            move f01400-nome-fantasia              to f-nome-fantasia              
            move f01400-tipo-pessoa                to f-tipo-pessoa
            if   f-pessoa-fisica
                 move f01400-cgc                   to f-cpf 
            else
                 move f01400-cgc                   to f-cnpj
            end-if
            move f01400-ie                         to f-ie                         
            move f01400-id-logradouro              to f-id-logradouro

            initialize                             lk-logradouro
            move f-id-logradouro                   to lk-id-logradouro
            call c-pesquisar-cep using lnk-par lk-logradouro
            cancel c-pesquisar-cep
            move lk-endereco                       to f-endereco
            move lk-bairro                         to f-bairro
            move lk-municipio                      to f-municipio
            move lk-uf                             to f-uf
            move lk-pais                           to f-nome-pais
            move f01400-nr-endereco                to f-nr-endereco                                
            move f01400-nr-telefone-1              to f-nr-telefone-1              
            move f01400-nr-telefone-2              to f-nr-telefone-2              
            move f01400-nr-telefone-3              to f-nr-telefone-3              
            move f01400-email                      to f-email                      
            move f01400-id-status                  to f-id-status                  
            perform 9000-monta-descricao-status

            perform 8000-tela-cliente                                          
    
       exit.
      *>=================================================================================
       9000-verifica-estoque section.

            move zeros                         to ws-qtde-disponivel

            set ws-produto-indisponivel-estoque to true

            initialize                          f06000-estoque
            move lnk-cd-empresa                 to f06000-cd-empresa
            move lnk-cd-filial                  to f06000-cd-filial
            move ws-codigo-produto              to f06000-cd-produto
            perform 9000-ler-pd06000-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro de leitura f01800-produto - " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if

            compute ws-qtde-disponivel = f06000-qtde-disponivel - ws-qtde-produto

            if   ws-qtde-disponivel >= zeros

                 set ws-produto-disponivel-estoque to true

            else
                string "Produto [" ws-codigo-produto "] com saldo insuficiente!" into ws-mensagem
                perform 9000-mensagem
            end-if 

       exit.

      *>=================================================================================
       9000-saida-estoque section.

            move zeros                         to ws-qtde-disponivel

            initialize                          f06000-estoque
            move lnk-cd-empresa                 to f06000-cd-empresa
            move lnk-cd-filial                  to f06000-cd-filial
            move ws-codigo-produto              to f06000-cd-produto
            perform 9000-ler-pd06000-ran
            if   not ws-operacao-ok
            and  not ws-registro-inexistente
                 string "Erro de leitura f01800-produto - " ws-resultado-acesso into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if

            compute ws-qtde-disponivel = f06000-qtde-disponivel - ws-qtde-produto  

            move ws-qtde-disponivel              to f06000-qtde-disponivel
            
            perform 9000-regravar-pd06000

       exit.

      *>=================================================================================
      *> Leituras

       copy CSR01400.cpy. 
       copy CSR01800.cpy.
       copy CSR02100.cpy.
       copy CSR05000.cpy.
       copy CSR05100.cpy.
       copy CSR06000.cpy.  