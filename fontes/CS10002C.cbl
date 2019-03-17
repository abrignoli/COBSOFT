      $set sourceformat"free"
       program-id. CS10002C.
      *>=================================================================================
      *>    
      *>                                Cadastro de Paises
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.
            
       copy CSS00200.cpy. 
       copy CSS00300.cpy.          

      *>=================================================================================
       data division.
       
       copy CSF00200.cpy. 
       copy CSF00300.cpy.       
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10002C".
       78   c-descricao-programa                   value "PAISES".
       78   c-relatorio-paises                     value "CS10002R".
              
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       
       01   ws-campos-trabalho.
            03 ws-status-pais                      pic x(01).
               88 ws-pais-existente                     value "S".
            03 ws-id-pais                          pic 9(09).    
            03 ws-id-validacao                     pic x(01).
               88 ws-validacao-ok                       value "S".
               88 ws-validacao-nok                      value "N".   
            
       01   f-pais.
            03 f-cd-pais                           pic 9(04).
            03 f-nome-pais                         pic x(55).

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-pais.
            03 line 11 col 21   pic x(12) value "Codigo Pais:".
            03 line 11 col 34   pic 9(04) from f-cd-pais.
            03 line 13 col 23   pic x(10) value "Nome Pais:". 
            03 line 13 col 34   pic x(55) from f-nome-pais.                                       
      
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
            
            perform 9000-abrir-io-pd00200
            perform 9000-abrir-i-pd00300
            
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
            
            perform until f-cd-pais <> zeros
                 accept f-cd-pais at line 11 col 34 with update auto-skip 
            end-perform
            
            initialize                             f00200-pais
            move lnk-cd-empresa                    to f00200-cd-empresa
            move lnk-cd-filial                     to f00200-cd-filial
            move f-cd-pais                         to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   ws-operacao-ok
                 string "Código de país já utilizado! [" f-cd-pais "]" into ws-mensagem
                 perform 9000-mensagem
                 
                 set ws-pais-existente             to true
                 
                 perform 9000-move-registros-frame
            end-if
                        
            perform until f-nome-pais <> spaces
                 accept f-nome-pais at line 13 col 34 with update auto-skip 
            end-perform              

            if   not ws-pais-existente
                 move "Confirma inclusão do registro? [S/N]"    to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim
                      
                      initialize                        f00200-pais
                      move lnk-cd-empresa               to f00200-cd-empresa
                      move lnk-cd-filial                to f00200-cd-filial
                      move 999999999                    to f00200-id-pais
                      perform 9000-str-pd00200-ngrt
                      perform 9000-ler-pd00200-pre
                      if   ws-operacao-ok
                      and  f00200-cd-empresa equal lnk-cd-empresa
                      and  f00200-cd-filial  equal lnk-cd-filial
                           add 1                        to f00200-id-pais
                           move f00200-id-pais          to ws-id-pais
                      else
                           move 1                       to ws-id-pais                                            
                      end-if                 
            
                      initialize                        f00200-pais
                      move lnk-cd-empresa               to f00200-cd-empresa
                      move lnk-cd-filial                to f00200-cd-filial
                      move ws-id-pais                   to f00200-id-pais
                      move f-cd-pais                    to f00200-cd-pais
                      move f-nome-pais                  to f00200-nome-pais   
                      
                      perform 9000-gravar-pd00200
                      
                      if   not ws-operacao-ok
                           string "Erro de gravação PD00200 - f00200-chave [" f00200-pais "]" into ws-mensagem
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
            
            perform until f-cd-pais <> zeros
                 accept f-cd-pais at line 11 col 34 with update auto-skip 
            end-perform
            
            initialize                             f00200-pais
            move lnk-cd-empresa                    to f00200-cd-empresa
            move lnk-cd-filial                     to f00200-cd-filial
            move f-cd-pais                         to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   not ws-operacao-ok
                 string "Código de país não encontrado! - [" f-cd-pais "]" into ws-mensagem
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
            
            perform until f-cd-pais <> zeros
                 accept f-cd-pais at line 11 col 34 with update auto-skip 
            end-perform
                        
            initialize                             f00200-pais
            move lnk-cd-empresa                    to f00200-cd-empresa
            move lnk-cd-filial                     to f00200-cd-filial
            move f-cd-pais                         to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   not ws-operacao-ok
                 string "Código de país não encontrado! - [" f-cd-pais "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section 
            else
                 perform 9000-move-registros-frame
            end-if
            
            perform until exit 
                 accept f-nome-pais at line 13 col 34 with update auto-skip
                 
                 if   f-nome-pais <> spaces
                      exit perform
                 end-if
            
            end-perform             

            move "Confirma alteração do registro? [S/N]"    to ws-mensagem
            perform 9000-mensagem

            if   ws-mensagem-opcao-sim

                 initialize                        f00200-pais
                 move lnk-cd-empresa               to f00200-cd-empresa
                 move lnk-cd-filial                to f00200-cd-filial
                 move f-cd-pais                    to f00200-cd-pais
                 perform 9000-ler-pd00200-ran-1
                 if   not ws-operacao-ok
                      string "Código de país não encontrado! - [" f-cd-pais "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 end-if
                      
                 move f00200-id-pais               to ws-id-pais               
            
                 initialize                        f00200-pais
                 move lnk-cd-empresa               to f00200-cd-empresa
                 move lnk-cd-filial                to f00200-cd-filial
                 move ws-id-pais                   to f00200-id-pais
                 move f-cd-pais                    to f00200-cd-pais
                 move f-nome-pais                  to f00200-nome-pais                 

                 perform 9000-regravar-pd00200

                 if   not ws-operacao-ok
                      string "Erro de regravação PD00200 - f00200-chave [" f00200-pais "]" into ws-mensagem
                      perform 9000-mensagem
                 end-if

            end-if
            
            perform 8000-controle-frame            
                  
       exit.

      *>=================================================================================
       2100-exclusao section.

            if   not lnk-permite-exclusao
                 exit section
            end-if

            perform 8000-limpa-tela

            perform until f-cd-pais <> zeros
                 accept f-cd-pais at line 11 col 34 with update auto-skip 
            end-perform
                        
            initialize                             f00200-pais
            move lnk-cd-empresa                    to f00200-cd-empresa
            move lnk-cd-filial                     to f00200-cd-filial
            move f-cd-pais                         to f00200-cd-pais
            perform 9000-ler-pd00200-ran
            if   not ws-operacao-ok
                 string "Código de país não encontrado! - [" f-cd-pais "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section 
            else
                 perform 9000-move-registros-frame
                 
                 perform 9000-validacao
                 
                 if   ws-validacao-ok
                      perform 9000-sleep-3s
                 
                      move "Confirma exclusão de registro? [S/N]"   to ws-mensagem
                      perform 9000-mensagem 
                 
                      if   ws-mensagem-opcao-sim
                           delete pd00200
                      end-if
                 end-if
                 
                 perform 8000-controle-frame                 
                 
            end-if       
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.

            if   not lnk-permite-consulta
                 exit section
            end-if
            
            call c-relatorio-paises using lnk-par
            cancel c-relatorio-paises
            
            perform 8000-controle-frame       
       
       exit.       
             
      *>=================================================================================
       3000-finalizacao section.
       
            close pd00200
            close pd00300
       
       exit.
                                                          
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame

      *>================================================================================= 
       8000-tela section.
       
            initialize                             f-pais
            
            perform 9000-frame-padrao
            display frm-pais
            
            perform 8000-controle-frame
       
       exit. 

      *>================================================================================= 
       8000-limpa-tela section.
       
            initialize                             f-pais
            
            perform 9000-frame-padrao
            display frm-pais
       
       exit. 
                                      
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão
                          
      *>=================================================================================       
       9000-move-registros-frame section.
       
            initialize                             f-pais
            move f00200-cd-pais                    to f-cd-pais
            move f00200-nome-pais                  to f-nome-pais
       
            perform 9000-frame-padrao
            display frm-pais
                   
       exit.

      *>=================================================================================       
       9000-move-registros-arquivo section.
          
                   
       exit.
       
      *>=================================================================================
       9000-validacao section.
       
            set ws-validacao-ok                    to true

            initialize                             f00200-pais
            move lnk-cd-empresa                    to f00200-cd-empresa
            move lnk-cd-filial                     to f00200-cd-filial
            move f-cd-pais                         to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            
                        
            initialize                             f00300-estado
            move lnk-cd-empresa                    to f00300-cd-empresa
            move lnk-cd-filial                     to f00300-cd-filial
            move f00200-id-pais                    to f00300-id-pais
            perform 9000-str-pd00300-grt-1
            perform 9000-ler-pd00300-nex
            perform until not ws-operacao-ok
                 or f00300-cd-empresa <> lnk-cd-empresa
                 or f00300-cd-filial  <> lnk-cd-filial
                 or f00300-id-pais    <> f00200-cd-pais
                    
                    set ws-validacao-nok           to true
                    
                    move "Existem estados atrelados ao país - Exclusão não permitida!"  to ws-mensagem
                    perform 9000-mensagem
                    
                    exit perform              
                 
            end-perform
       
       exit. 
                    
      *>=================================================================================
      *> Leituras
      
       copy CSR00200.cpy.
       copy CSR00300.cpy.         