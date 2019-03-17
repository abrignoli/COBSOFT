      $set sourceformat"free"
       program-id. CS10012C.
      *>=================================================================================
      *>    
      *>                        Gerenciador de Chamadas Assincronas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.

       copy CSS01400.cpy.     

      *>=================================================================================
       data division.

       copy CSF01400.cpy.      
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10012C".
       78   c-descricao-programa                   value "CLIENTES".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-status-cliente                   pic x(01).
               88 ws-cliente-existente                  value "S".            
            03 ws-cd-cliente                       pic 9(09).

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

            perform 9000-abrir-io-pd01400
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
             perform until wf-frame-retornar
                      
                 evaluate wf-frame
                      when 0
                           perform 8000-tela
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
     
       
       exit. 

      *>=================================================================================
       2999-controle-frame section.
        
            perform 8000-accept-opcao
            
            evaluate wf-opcao
                when 01
                     perform 2100-incluir
                when 02
                     perform 2100-consulta
                when 03
                     perform 2100-manutencao
                when 04
                     perform 2100-exclusao
                when 05
                     perform 2100-relatorio
                when 99
                     set wf-frame-retornar         to true                       
                when other    
                     move "Opcao invalida!"   to ws-mensagem
                     perform 9000-mensagem            
            end-evaluate
       
       exit.
      *>=================================================================================
       2100-incluir section.

            if   not lnk-permite-inclusao
                 exit section
            end-if       

            perform 8000-limpa-tela

            initialize                             f01400-cliente
            move lnk-cd-empresa                    to f01400-cd-empresa
            move lnk-cd-filial                     to f01400-cd-filial
            move 999999999                         to f01400-cd-cliente
            perform 9000-str-pd01400-ngrt
            perform 9000-ler-pd01400-pre
            if   ws-operacao-ok
            and  f01400-cd-empresa equal lnk-cd-empresa
            and  f01400-cd-filial  equal lnk-cd-filial
                 add 1                             to f01400-cd-cliente
                 move f01400-cd-cliente            to ws-cd-cliente
            else
                 move 1                            to ws-cd-cliente                                            
            end-if

            move ws-cd-cliente                     to f-cd-cliente

            perform 8000-tela              

            perform until f-razao-social <> spaces
                 accept f-razao-social at line 13 col 34 with update auto-skip 
            end-perform
            
            perform until f-nome-fantasia <> spaces
                 accept f-nome-fantasia at line 15 col 34 with update auto-skip 
            end-perform

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
                 
                      accept f-cnpj(01:02) at line 19 col 34 with auto-skip
                                             
                      accept f-cnpj(03:03) at line 19 col 37 with auto-skip
                                                 
                      accept f-cnpj(06:03) at line 19 col 41 with auto-skip
                                              
                      accept f-cnpj(09:04) at line 19 col 45 with auto-skip
                                          
                      accept f-cnpj(13:02) at line 19 col 50 with auto-skip    
                 
                 end-perform
            end-if

            initialize                             f01400-cliente
            if   f-pessoa-fisica
                 move f-cpf                        to f01400-cgc
            else
                 move f-cnpj                       to f01400-cgc
            end-if
            perform 9000-ler-pd01400-ran-1
            if   ws-operacao-ok
                 move "Cliente já cadastrado na base de dados!" to ws-mensagem
                 perform 9000-mensagem

                 perform 9000-move-registros-frame

                 exit section   
            end-if  

            if   f-pessoa-fisica
                 move "ISENTO"                     to f-ie
                 perform 8000-tela
            else
                 perform until f-ie <> spaces
                      accept f-ie at line 19 col 63   
                 end-perform
            end-if

            set lk-nao-encontrou-cep               to true
            
            perform until lk-encontrou-cep    

                 accept f-cep(01:05) at line 21 col 34 with auto-skip

                 accept f-cep(06:03) at line 21 col 40 with auto-skip
  
                 if   f-cep greater zeros
                 and  not lk-encontrou-cep    
                      
                      initialize                   lk-logradouro
                      move f-cep                   to lk-cep
                      call c-pesquisar-cep using lnk-par lk-logradouro
                      cancel c-pesquisar-cep
                       
                      move lk-id-logradouro        to f-id-logradouro 
                      move lk-endereco             to f-endereco
                      move lk-bairro               to f-bairro
                      move lk-municipio            to f-municipio
                      move lk-uf                   to f-uf
                      move lk-pais                 to f-nome-pais

                      if   not lk-encontrou-cep
                           move zeros              to f-cep
                      end-if 
                       
                      perform 8000-tela                     
                      
                 end-if     
                 
            end-perform
            perform until f-nr-endereco <> spaces
                 accept f-nr-endereco at line 25 col 34 with auto-skip
            end-perform

            perform until exit
            
                 if   f-nr-telefone-1 greater zeros
                      exit perform
                 end-if
                 
                 accept f-nr-telefone-1(01:02) at line 31 col 35 with auto-skip
                 
                 accept f-nr-telefone-1(03:03) at line 31 col 39 with auto-skip
                 
                 accept f-nr-telefone-1(06:05) at line 31 col 44 with auto-skip
                 
                 accept f-nr-telefone-1(11:04) at line 31 col 50 with auto-skip
            
            end-perform

            perform until exit
            
                 if   f-nr-telefone-2 greater zeros
                      exit perform
                 end-if
                 
                 accept f-nr-telefone-2(01:02) at line 33 col 35 with auto-skip
                 
                 accept f-nr-telefone-2(03:03) at line 33 col 39 with auto-skip
                
                 accept f-nr-telefone-2(06:05) at line 33 col 44 with auto-skip
                 
                 accept f-nr-telefone-2(11:04) at line 33 col 50 with auto-skip
            
            end-perform

            perform until exit
            
                 if   f-nr-telefone-3 greater zeros
                      exit perform
                 end-if
                 
                 accept f-nr-telefone-3(01:02) at line 35 col 35 with auto-skip
                 
                 accept f-nr-telefone-3(03:03) at line 35 col 39 with auto-skip
                 
                 accept f-nr-telefone-3(06:05) at line 35 col 44 with auto-skip
                 
                 accept f-nr-telefone-3(11:04) at line 35 col 50 with auto-skip
            
            end-perform 
            
            perform until f-email <> spaces
                 accept f-email at line 37 col 34 with auto-skip 
            end-perform
            
            perform until exit
            
                 if   f-cliente-ativo
                 or   f-cliente-inativo
                 or   f-cliente-bloqueado
                      exit perform
                 end-if 
                 
                 accept f-id-status at line 39 col 34 with auto-skip
                 
                 move function upper-case(f-id-status)  to f-id-status
                 
                 perform 9000-monta-descricao-status
                  
            end-perform

            if   not ws-cliente-existente
                 move "Confirma inclusão do registro? [S/N]"    to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim
                      perform 9000-move-registros-arquivo
                      perform 9000-gravar-pd01400
                      
                      if   not ws-operacao-ok
                           string "Erro de gravação - f01400-cliente [" f01400-cliente "]" into ws-mensagem
                           perform 9000-mensagem
                      end-if
                 
                 end-if
                 
            end-if

       exit.

      *>=================================================================================
       2100-consulta section.
       
            if   not lnk-permite-consulta
                 exit section
            end-if       

            perform 8000-limpa-tela

       exit.

      *>=================================================================================
       2100-manutencao section.
       
            if   not lnk-permite-manutencao
                 exit section
            end-if       

            perform 8000-limpa-tela       
       
       exit. 

      *>=================================================================================
       2100-exclusao section.

            if   not lnk-permite-consulta
                 exit section
            end-if       

            perform 8000-limpa-tela

       exit.

      *>=================================================================================
       2100-relatorio section.
       
       
       exit.        
                                                                 
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame

      *>=================================================================================
       8000-tela section.
                  
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
       8000-limpa-tela section.
       
            initialize                             f-cliente
            
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
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================
       9000-monta-descricao-tipo-pessoa section.
       
            move function upper-case(f-tipo-pessoa) to f-tipo-pessoa
            
            evaluate true
                when f-pessoa-fisica
                    move "FISICA"                  to f-ds-tipo-pessoa
                    perform 8000-tela
                when f-pessoa-juridica
                    move "JURIDICA"                to f-ds-tipo-pessoa
                    perform 8000-tela
                when other
                    move "INVALIDO"                to f-ds-tipo-pessoa
                    perform 8000-tela
            end-evaluate
        
       exit.

      *>=================================================================================
       9000-monta-descricao-status section.
        
            move function upper-case(f-id-status)  to f-id-status

            evaluate true
                 when f-cliente-ativo
                      move "ATIVO"                 to f-ds-status
                      perform 8000-tela
                 when f-cliente-inativo
                      move "INATIVO"               to f-ds-status
                      perform 8000-tela
                 when f-cliente-bloqueado
                      move "BLOQUEADO"             to f-ds-status
                      perform 8000-tela
                 when other
                      move "INVALIDO"              to f-ds-status
                      perform 8000-tela
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
             
            move lk-endereco                      to f-endereco
            move lk-bairro                        to f-bairro
            move lk-municipio                     to f-municipio
            move lk-uf                            to f-uf
            move lk-pais                          to f-nome-pais
                               
            move f01400-nr-endereco                to f-nr-endereco                                
            move f01400-nr-telefone-1              to f-nr-telefone-1              
            move f01400-nr-telefone-2              to f-nr-telefone-2              
            move f01400-nr-telefone-3              to f-nr-telefone-3              
            move f01400-email                      to f-email                      
            move f01400-id-status                  to f-id-status                  
            perform 9000-monta-descricao-status

            perform 8000-tela                                          

       exit.

      *>=================================================================================       
       9000-move-registros-arquivo section.

            initialize                             f01400-cliente
            move lnk-cd-empresa                    to f01400-cd-empresa
            move lnk-cd-filial                     to f01400-cd-filial
            move f-cd-cliente                      to f01400-cd-cliente                               
            move f-razao-social                    to f01400-razao-social               
            move f-nome-fantasia                   to f01400-nome-fantasia              
            move f-tipo-pessoa                     to f01400-tipo-pessoa
            if   f-pessoa-fisica
                 move f-cpf                        to f01400-cgc
            else
                 move f-cnpj                       to f01400-cgc
            end-if                
            move f-ie                              to f01400-ie                         
            move f-id-logradouro                   to f01400-id-logradouro                                                  
            move f-nr-endereco                     to f01400-nr-endereco                                
            move f-nr-telefone-1                   to f01400-nr-telefone-1              
            move f-nr-telefone-2                   to f01400-nr-telefone-2              
            move f-nr-telefone-3                   to f01400-nr-telefone-3              
            move f-email                           to f01400-email                      
            move f-id-status                       to f01400-id-status
                  
       exit.

      *>=================================================================================
      *> Leituras

       copy CSR01400.cpy. 