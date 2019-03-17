      $set sourceformat"free"
       program-id. CS10001C.
      *>=================================================================================
      *>    
      *>                                Cadastro de Empresas
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.
            
       copy CSS00700.cpy.           

      *>=================================================================================
       data division.      

       copy CSF00700.cpy. 
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10001C".
       78   c-descricao-programa                   value "EMPRESAS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-id-empresa                       pic x(01).
               88 ws-empresa-existente                  value "S".
            03 ws-id-cnpj                          pic x(01).
               88 ws-cnpj-existente                     value "S".
            03 ws-cep-anterior                     pic 9(08).    
               
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

       01   f-empresa.
            03 f-cd-empresa                        pic 9(03).
            03 f-cd-filial                         pic 9(04).
            03 f-razao-social                      pic x(55).
            03 f-nome-fantasia                     pic x(55).
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
               88 f-empresa-ativa                       value "A".
               88 f-empresa-inativa                     value "I".
               88 f-empresa-bloqueada                   value "B".
            03 f-ds-status                         pic x(30).   

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-empresa.
            03 line 11 col 18   pic x(15) value "Codigo Empresa:".
            03 line 11 col 34   pic 9(03) from f-cd-empresa.
            03 line 11 col 48   pic x(14) value "Codigo Filial:".
            03 line 11 col 63   pic 9(04) from f-cd-filial.
            03 line 13 col 20   pic x(13) value "Razao Social:".
            03 line 13 col 34   pic x(55) from f-razao-social.
            03 line 15 col 19   pic x(14) value "Nome Fantasia:".
            03 line 15 col 34   pic x(55) from f-nome-fantasia.
            03 line 17 col 28   pic x(05) value "CNPJ:".
            03 line 17 col 34   pic x(18) from ws-mascara-cnpj.
            03 line 17 col 34   pic 9(02) from f-cnpj(01:02).
            03 line 17 col 37   pic 9(03) from f-cnpj(03:03).
            03 line 17 col 41   pic 9(03) from f-cnpj(06:03).
            03 line 17 col 45   pic 9(04) from f-cnpj(09:04).
            03 line 17 col 50   pic 9(02) from f-cnpj(13:02).   
            03 line 17 col 59   pic x(03) value "IE:".
            03 line 17 col 63   pic x(11) from f-ie.
            03 line 19 col 29   pic x(04) value "CEP:".
            03 line 19 col 34   pic x(09) from ws-mascara-cep.
            03 line 19 col 34   pic 9(05) from f-cep(01:05).
            03 line 19 col 40   pic 9(03) from f-cep(06:03).
            03 line 21 col 24   pic x(09) value "Endereco:".
            03 line 21 col 34   pic x(55) from f-endereco.
            03 line 23 col 17   pic x(16) value "Numero Endereco:".
            03 line 23 col 34   pic x(10) from f-nr-endereco.
            03 line 23 col 55   pic x(07) value "Bairro:".
            03 line 23 col 63   pic x(55) from f-bairro.
            03 line 25 col 23   pic x(10) value "Municipio:".
            03 line 25 col 34   pic x(55) from f-municipio.
            03 line 27 col 30   pic x(03) value "UF:".
            03 line 27 col 34   pic x(02) from f-uf.
            03 line 27 col 57   pic x(05) value "Pais:".
            03 line 27 col 63   pic x(55) from f-nome-pais.
            03 line 29 col 24   pic x(09) value "Telefone:".
            03 line 29 col 34   pic x(20) from ws-mascara-telefone.
            03 line 29 col 35   pic 9(02) from f-nr-telefone-1(01:02).
            03 line 29 col 39   pic 9(03) from f-nr-telefone-1(03:03).
            03 line 29 col 44   pic 9(05) from f-nr-telefone-1(06:05).
            03 line 29 col 50   pic 9(04) from f-nr-telefone-1(11:04).
            03 line 31 col 24   pic x(09) value "Telefone:".
            03 line 31 col 34   pic x(20) from ws-mascara-telefone.
            03 line 31 col 35   pic 9(02) from f-nr-telefone-2(01:02).
            03 line 31 col 39   pic 9(03) from f-nr-telefone-2(03:03).
            03 line 31 col 44   pic 9(05) from f-nr-telefone-2(06:05).
            03 line 31 col 50   pic 9(04) from f-nr-telefone-2(11:04).            
            03 line 33 col 24   pic x(09) value "Telefone:".
            03 line 33 col 34   pic x(20) from ws-mascara-telefone.
            03 line 33 col 35   pic 9(02) from f-nr-telefone-3(01:02).
            03 line 33 col 39   pic 9(03) from f-nr-telefone-3(03:03).
            03 line 33 col 44   pic 9(05) from f-nr-telefone-3(06:05).
            03 line 33 col 50   pic 9(04) from f-nr-telefone-3(11:04).            
            03 line 35 col 26   pic x(07) value "E-mail:".
            03 line 35 col 34   pic x(55) from f-email.
            03 line 37 col 18   pic x(15) value "Status Empresa:".
            03 line 37 col 34   pic x(01) from f-id-status.
            03 line 37 col 36   pic x(01) value "-".
            03 line 37 col 38   pic x(30) from f-ds-status.                                                            
      
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
                        
            perform 9000-abrir-io-pd00700
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
            perform until wf-frame-retornar
                      
                 evaluate wf-frame
                      when 0
                           perform 8000-tela
                      when 9
                           perform 2999-controle-frame
                      when other   
                           move "Frame invalido!"   to ws-mensagem
                           perform 9000-mensagem
                 end-evaluate
                           
            end-perform
       
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
            
            perform until f-cd-empresa <> zeros
                 accept f-cd-empresa at line 11 col 34 with update auto-skip 
            end-perform
            
            perform until f-cd-filial <> zeros
                 accept f-cd-filial at line 11 col 63 with update auto-skip 
            end-perform
            
            initialize                             f00700-empresa
            move f-cd-empresa                      to f00700-cd-empresa
            move f-cd-filial                       to f00700-cd-filial
            perform 9000-ler-pd00700-ran
            if   ws-operacao-ok
                 string "Código de empresa\filial já utilizado! - [" f-cd-empresa "." f-cd-filial "]" into ws-mensagem
                 perform 9000-mensagem
                 
                 set ws-empresa-existente          to true
                 
                 perform 9000-move-registros-frame             
            end-if

            perform until f-razao-social <> spaces
                 accept f-razao-social at line 13 col 34 with update auto-skip 
            end-perform
            
            perform until f-nome-fantasia <> spaces
                 accept f-nome-fantasia at line 15 col 34 with auto-skip
            end-perform
            
            perform until exit
                 
                 if   f-cnpj greater zeros
                      exit perform
                 end-if
            
                 accept f-cnpj(01:02) at line 17 col 34 with auto-skip
                 
                 accept f-cnpj(03:03) at line 17 col 37 with auto-skip
                 
                 accept f-cnpj(06:03) at line 17 col 41 with auto-skip
                 
                 accept f-cnpj(09:04) at line 17 col 45 with auto-skip
                 
                 accept f-cnpj(13:02) at line 17 col 50 with auto-skip    
            
            end-perform
            
            perform until f-ie <> spaces
                 accept f-ie at line 17 col 63 with auto-skip 
            end-perform

            set lk-nao-encontrou-cep               to true
            
            perform until lk-encontrou-cep     
  
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
                                            
                      perform 9000-frame-padrao
                      display frm-empresa
                 
                 else     

                      accept f-cep(01:05) at line 19 col 34 with auto-skip

                      accept f-cep(06:03) at line 19 col 40 with auto-skip
                 
                 end-if
                 
            end-perform
            
            perform until f-nr-endereco <> spaces
                 accept f-nr-endereco at line 23 col 34 with auto-skip
            end-perform

            perform until exit
            
                 if   f-nr-telefone-1 greater zeros
                      exit perform
                 end-if
                 
                 accept f-nr-telefone-1(01:02) at line 29 col 35 with auto-skip
                 
                 accept f-nr-telefone-1(03:03) at line 29 col 39 with auto-skip
                 
                 accept f-nr-telefone-1(06:05) at line 29 col 44 with auto-skip
                 
                 accept f-nr-telefone-1(11:04) at line 29 col 50 with auto-skip
            
            end-perform

            perform until exit
            
                 if   f-nr-telefone-2 greater zeros
                      exit perform
                 end-if
                 
                 accept f-nr-telefone-2(01:02) at line 31 col 35 with auto-skip
                 
                 accept f-nr-telefone-2(03:03) at line 31 col 39 with auto-skip
                 
                 accept f-nr-telefone-2(06:05) at line 31 col 44 with auto-skip
                 
                 accept f-nr-telefone-2(11:04) at line 31 col 50 with auto-skip
            
            end-perform

            perform until exit
            
                 if   f-nr-telefone-3 greater zeros
                      exit perform
                 end-if
                 
                 accept f-nr-telefone-3(01:02) at line 33 col 35 with auto-skip
                 
                 accept f-nr-telefone-3(03:03) at line 33 col 39 with auto-skip
                 
                 accept f-nr-telefone-3(06:05) at line 33 col 44 with auto-skip
                 
                 accept f-nr-telefone-3(11:04) at line 33 col 50 with auto-skip
            
            end-perform 
            
            perform until f-email <> spaces
                 accept f-email at line 35 col 34 with auto-skip 
            end-perform
            
            perform until exit
            
                 if   f-empresa-ativa
                 or   f-empresa-inativa
                 or   f-empresa-bloqueada
                      exit perform
                 end-if 
                 
                 accept f-id-status at line 37 col 34 with auto-skip
                 
                 move function upper-case(f-id-status)  to f-id-status
                 
                 perform 9000-monta-descricao-status
                  
            end-perform
            
            if   not ws-empresa-existente
                 move "Confirma inclusão do registro? [S/N]"    to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim
                      perform 9000-move-registros-arquivo
                      perform 9000-gravar-pd00700
                      
                      if   not ws-operacao-ok
                           string "Erro de gravação PD00700 - f00700-chave [" f00700-empresa "]" into ws-mensagem
                           perform 9000-mensagem
                      end-if
                 
                 end-if
                 
            end-if
            
            perform 8000-controle-frame 
                             
       exit.
 
       *>=================================================================================
       2100-consulta section.

            if   not lnk-permite-consulta
                 exit section
            end-if
                        
            perform 8000-limpa-tela
            
            perform until f-cd-empresa <> zeros
                 accept f-cd-empresa at line 11 col 34 with update auto-skip 
            end-perform
            
            perform until f-cd-filial <> zeros
                 accept f-cd-filial at line 11 col 63 with update auto-skip 
            end-perform
            
            initialize                             f00700-empresa
            move f-cd-empresa                      to f00700-cd-empresa
            move f-cd-filial                       to f00700-cd-filial
            perform 9000-ler-pd00700-ran
            if   not ws-operacao-ok
                 string "Código de empresa\filial não encontrado! - [" f-cd-empresa "." f-cd-filial "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame 
            else
                 perform 9000-move-registros-frame
                 perform 8000-controle-frame
            end-if       
       
       exit.

      *>=================================================================================
       2100-manutencao section.

            if   not lnk-permite-manutencao
                 exit section
            end-if
            
            perform 8000-limpa-tela
            
            perform until f-cd-empresa <> zeros
                 accept f-cd-empresa at line 11 col 34 with update auto-skip 
            end-perform
            
            perform until f-cd-filial <> zeros
                 accept f-cd-filial at line 11 col 63 with update auto-skip 
            end-perform
            
            initialize                             f00700-empresa
            move f-cd-empresa                      to f00700-cd-empresa
            move f-cd-filial                       to f00700-cd-filial
            perform 9000-ler-pd00700-ran
            if   not ws-operacao-ok
                 string "Código de empresa\filial não encontrado! - [" f-cd-empresa "." f-cd-filial "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section 
            else
                 perform 9000-move-registros-frame
            end-if
            
            perform until exit 
                 accept f-razao-social at line 13 col 34 with update auto-skip
                 
                 if   f-razao-social <> spaces
                      exit perform
                 end-if
                    
            end-perform       

            perform until exit
                 accept f-nome-fantasia at line 15 col 34 with auto-skip
                 
                 if   f-nome-fantasia <> spaces
                      exit perform
                 end-if
                 
            end-perform

            perform until exit

                 accept f-cnpj(01:02) at line 17 col 34 with auto-skip

                 accept f-cnpj(03:03) at line 17 col 37 with auto-skip

                 accept f-cnpj(06:03) at line 17 col 41 with auto-skip

                 accept f-cnpj(09:04) at line 17 col 45 with auto-skip

                 accept f-cnpj(13:02) at line 17 col 50 with auto-skip
                 
                 initialize                        f00700-empresa
                 move f-cnpj                       to f00700-cnpj
                 perform 9000-ler-pd00700-ran-1
                 if   ws-operacao-ok
                      if   f00700-cd-empresa <> f-cd-empresa
                      and  f00700-cd-filial  <> f-cd-filial   

                           string "CNPJ já utilizado! Empresa - [" f00700-cd-empresa "." f00700-cd-filial "]" into ws-mensagem
                           perform 9000-mensagem
                                            
                           set ws-cnpj-existente        to true
                      
                           move zeros                   to f-cnpj
                      
                      end-if     

                 end-if                 

                 if   f-cnpj greater zeros
                 and  not ws-cnpj-existente
                      exit perform
                 end-if                 

            end-perform

            perform until exit
                 accept f-ie at line 17 col 63 with auto-skip

                 if    f-ie <> spaces
                       exit perform
                 end-if

            end-perform

            set lk-nao-encontrou-cep               to true
            
            perform until lk-encontrou-cep     

                 accept f-cep(01:05) at line 19 col 34 with auto-skip

                 accept f-cep(06:03) at line 19 col 40 with auto-skip
  
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
                                            
                      perform 9000-frame-padrao
                      display frm-empresa
                      
                 end-if     
                 
            end-perform

            perform until exit
                 accept f-nr-endereco at line 23 col 34 with auto-skip

                 if   f-nr-endereco <> spaces
                      exit perform
                 end-if

            end-perform

            perform until exit

                 accept f-nr-telefone-1(01:02) at line 29 col 35 with auto-skip

                 accept f-nr-telefone-1(03:03) at line 29 col 39 with auto-skip

                 accept f-nr-telefone-1(06:05) at line 29 col 44 with auto-skip

                 accept f-nr-telefone-1(11:04) at line 29 col 50 with auto-skip

                 if   f-nr-telefone-1 greater zeros
                      exit perform
                 end-if

            end-perform
            
            perform until exit

                 accept f-nr-telefone-2(01:02) at line 31 col 35 with auto-skip

                 accept f-nr-telefone-2(03:03) at line 31 col 39 with auto-skip

                 accept f-nr-telefone-2(06:05) at line 31 col 44 with auto-skip

                 accept f-nr-telefone-2(11:04) at line 31 col 50 with auto-skip

                 if   f-nr-telefone-2 greater zeros
                      exit perform
                 end-if

            end-perform

            perform until exit

                 accept f-nr-telefone-3(01:02) at line 33 col 35 with auto-skip

                 accept f-nr-telefone-3(03:03) at line 33 col 39 with auto-skip

                 accept f-nr-telefone-3(06:05) at line 33 col 44 with auto-skip

                 accept f-nr-telefone-3(11:04) at line 33 col 50 with auto-skip

                 if   f-nr-telefone-3 greater zeros
                      exit perform
                 end-if

            end-perform

            perform until exit
                 accept f-email at line 35 col 34 with auto-skip

                 if   f-email <> spaces
                      exit perform
                 end-if

            end-perform
            
            perform until exit

                 accept f-id-status at line 37 col 34 with auto-skip

                 perform 9000-monta-descricao-status

                 if   f-empresa-ativa
                 or   f-empresa-inativa
                 or   f-empresa-bloqueada
                      exit perform
                 end-if

            end-perform
            
            perform 8000-controle-frame

            move "Confirma alteração do registro? [S/N]"    to ws-mensagem
            perform 9000-mensagem

            if   ws-mensagem-opcao-sim
                 perform 9000-move-registros-arquivo
                 perform 9000-regravar-pd00700

                 if   not ws-operacao-ok
                      string "Erro de regravação PD00700 - f00700-chave [" f00700-empresa "]" into ws-mensagem
                      perform 9000-mensagem
                 end-if

            end-if       
       
       exit.

      *>=================================================================================
       2100-exclusao section.

            if   not lnk-permite-exclusao
                 exit section
            end-if
            
            perform 8000-limpa-tela
            
            perform until f-cd-empresa <> zeros
                 accept f-cd-empresa at line 11 col 34 with update auto-skip 
            end-perform
            
            perform until f-cd-filial <> zeros
                 accept f-cd-filial at line 11 col 63 with update auto-skip 
            end-perform
            
            initialize                             f00700-empresa
            move f-cd-empresa                      to f00700-cd-empresa
            move f-cd-filial                       to f00700-cd-filial
            perform 9000-ler-pd00700-ran
            if   not ws-operacao-ok
                 string "Código de empresa\filial não encontrado! - [" f-cd-empresa "." f-cd-filial "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section 
            else
                 perform 9000-move-registros-frame
                 
                 perform 9000-sleep-3s
                 
                 move "Confirma exclusão de registro? [S/N]"   to ws-mensagem
                 perform 9000-mensagem 
                 
                 if   ws-mensagem-opcao-sim
                      delete pd00700
                 end-if
                 
                 perform 8000-controle-frame
            end-if        
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.
       
       
       exit.       
             
      *>=================================================================================
       3000-finalizacao section.
       
            close pd00700
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
       
      *>=================================================================================
       8000-tela section.
       
            initialize                             f-empresa
            
            perform 9000-frame-padrao
            display frm-empresa
            
            perform 8000-controle-frame
       
       exit. 
       
      *>=================================================================================
       8000-limpa-tela section.
       
            initialize                             f-empresa
            
            perform 9000-frame-padrao
            display frm-empresa
       
       exit.
                                       
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão
       
      *>=================================================================================
       9000-move-registros-frame section.
       
            initialize                             f-empresa
            move f00700-cd-empresa                 to f-cd-empresa
            move f00700-cd-filial                  to f-cd-filial
            move f00700-razao-social               to f-razao-social
            move f00700-nome-fantasia              to f-nome-fantasia
            move f00700-cnpj                       to f-cnpj
            move f00700-ie                         to f-ie
            
            initialize                             lk-logradouro
            move f00700-id-logradouro              to lk-id-logradouro
            call c-pesquisar-cep using lnk-par lk-logradouro
            cancel c-pesquisar-cep
                       
            move lk-id-logradouro                  to f-id-logradouro 
            move lk-endereco                       to f-endereco
            move lk-bairro                         to f-bairro
            move lk-municipio                      to f-municipio
            move lk-uf                             to f-uf
            move lk-pais                           to f-nome-pais
            
            move lk-cep                            to f-cep
            move f00700-nr-endereco                to f-nr-endereco
            
            move f00700-nr-telefone-1              to f-nr-telefone-1
            move f00700-nr-telefone-2              to f-nr-telefone-2
            move f00700-nr-telefone-3              to f-nr-telefone-3
            move f00700-email                      to f-email
            move f00700-id-status                  to f-id-status
            
            perform 9000-monta-descricao-status
            
            perform 9000-frame-padrao
            display frm-empresa
       
       exit.

      *>=================================================================================
       9000-move-registros-arquivo section.

            initialize                             f00700-empresa
            move f-cd-empresa                      to f00700-cd-empresa
            move f-cd-filial                       to f00700-cd-filial
            move f-razao-social                    to f00700-razao-social
            move f-nome-fantasia                   to f00700-nome-fantasia
            move f-cnpj                            to f00700-cnpj
            move f-ie                              to f00700-ie
            move f-id-logradouro                   to f00700-id-logradouro
            move f-nr-endereco                     to f00700-nr-endereco
            move f-nr-telefone-1                   to f00700-nr-telefone-1
            move f-nr-telefone-2                   to f00700-nr-telefone-2
            move f-nr-telefone-3                   to f00700-nr-telefone-3
            move f-email                           to f00700-email
            move f-id-status                       to f00700-id-status
       
       exit.
                           
      *>=================================================================================
       9000-monta-descricao-status section.
        
            move function upper-case(f-id-status)  to f-id-status

            evaluate true
                 when f-empresa-ativa
                      move "ATIVA"                 to f-ds-status
                      perform 9000-frame-padrao
                      display frm-empresa
                 when f-empresa-inativa
                      move "INATIVA"               to f-ds-status
                      perform 9000-frame-padrao
                      display frm-empresa
                 when f-empresa-bloqueada
                      move "BLOQUEADA"             to f-ds-status
                      perform 9000-frame-padrao
                      display frm-empresa
                 when other
                      move "INVALIDO"              to f-ds-status
                      perform 9000-frame-padrao
                      display frm-empresa
            end-evaluate       
       
       exit. 
       
      *>=================================================================================
      *> Leituras
      
       copy CSR00700.cpy.        