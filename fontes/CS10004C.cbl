      $set sourceformat"free"
       program-id. CS10004C.
      *>=================================================================================
      *>    
      *>                             Cadastro de Municipio
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

       copy CSS00200.cpy. 
       copy CSS00300.cpy.
       copy CSS00400.cpy.

      *>=================================================================================
       data division.      
 
       copy CSF00200.cpy. 
       copy CSF00300.cpy.
       copy CSF00400.cpy. 
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "b".
       78   c-este-programa                        value "CS10004C".
       78   c-descricao-programa                   value "MUNICIPIOS".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       01   ws-campos-trabalho.
            03 ws-status-muncipio                  pic x(01).
               88 ws-muncipio-existente                 value "S".
            03 ws-id-muncipio                      pic 9(09).
            03 ws-id-validacao                     pic x(01).
               88 ws-validacao-ok                       value "S".
               88 ws-validacao-nok                      value "N".
                           
       01   f-municipio.
            03 f-cd-pais                           pic 9(04).
            03 f-nome-pais                         pic x(55).
            03 f-cd-estado                         pic 9(02).
            03 f-nome-estado                       pic x(55).       
            03 f-cd-municipio                      pic 9(07).
            03 f-nome-municipio                    pic x(55).

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       
       01   frm-municipio.
            03 line 11 col 21   pic x(12) value "Codigo Pais:".
            03 line 11 col 34   pic 9(04) from f-cd-pais.
            03 line 13 col 23   pic x(10) value "Nome Pais:".  
            03 line 13 col 34   pic x(55) from f-nome-pais.        
            03 line 15 col 19   pic x(14) value "Codigo Estado:".
            03 line 15 col 34   pic 9(02) from f-cd-estado.
            03 line 17 col 21   pic x(12) value "Nome Estado:".    
            03 line 17 col 34   pic x(55) from f-nome-estado.         
            03 line 19 col 16   pic x(17) value "Codigo Municipio:".
            03 line 19 col 34   pic 9(07) from f-cd-municipio.
            03 line 21 col 18   pic x(15) value "Nome Municipio:".
            03 line 21 col 34   pic x(55) from f-nome-municipio.                                   
      
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

            perform 9000-abrir-i-pd00200
            perform 9000-abrir-i-pd00300
            perform 9000-abrir-io-pd00400
       
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
            
            perform until exit
            
                 accept f-cd-pais at line 11 col 34 with update auto-skip
                 
                 initialize                        f00200-pais
                 move lnk-cd-empresa               to f00200-cd-empresa
                 move lnk-cd-filial                to f00200-cd-filial
                 move f-cd-pais                    to f00200-cd-pais
                 perform 9000-ler-pd00200-ran-1
                 if   ws-operacao-ok
                      move f00200-nome-pais        to f-nome-pais
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if           
                  
            end-perform
            
            perform until exit
            
                accept f-cd-estado at line 15 col 34 with update auto-skip
            
                 initialize                        f00300-estado
                 move lnk-cd-empresa               to f00300-cd-empresa
                 move lnk-cd-filial                to f00300-cd-filial
                 move f00200-id-pais               to f00300-id-pais
                 move f-cd-estado                  to f00300-cd-estado
                 perform 9000-ler-pd00300-ran-1
                 if   ws-operacao-ok
                      move f00300-nome-estado      to f-nome-estado
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if

            
            end-perform 
             
            
            perform until f-cd-municipio <> zeros
                 accept f-cd-municipio at line 19 col 34 with update auto-skip 
            end-perform
            
            initialize                             f00400-municipio
            move lnk-cd-empresa                    to f00400-cd-empresa
            move lnk-cd-filial                     to f00400-cd-filial
            move f00300-id-estado                  to f00400-id-estado
            move f-cd-municipio                    to f00400-cd-municipio
            perform 9000-ler-pd00400-ran-1
            if   ws-operacao-ok
                 string "Código de municipio já utilizado! [" f-cd-municipio "]" into ws-mensagem
                 perform 9000-mensagem
                 
                 set ws-muncipio-existente         to true
                 
                 perform 9000-move-registros-frame
            end-if             
            
            perform until f-nome-municipio <> spaces
                 accept f-nome-municipio at line 21 col 34 with update auto-skip 
            end-perform
            
            if   not ws-muncipio-existente
                 move "Confirma inclusão do registro? [S/N]"    to ws-mensagem
                 perform 9000-mensagem
                 
                 if   ws-mensagem-opcao-sim
                      
                      initialize                   f00400-municipio
                      move lnk-cd-empresa          to f00400-cd-empresa
                      move lnk-cd-filial           to f00400-cd-filial
                      move 999999999               to f00400-id-municipio
                      perform 9000-str-pd00400-ngrt
                      perform 9000-ler-pd00400-pre
                      if   ws-operacao-ok
                      and  f00400-cd-empresa equal lnk-cd-empresa
                      and  f00400-cd-filial  equal lnk-cd-filial
                           add 1                      to f00400-id-municipio
                           move f00400-id-municipio   to ws-id-muncipio
                      else
                           move 1                     to ws-id-muncipio                                            
                      end-if                     
                      
                      initialize                   f00400-municipio
                      move lnk-cd-empresa          to f00400-cd-empresa
                      move lnk-cd-filial           to f00400-cd-filial
                      move ws-id-muncipio          to f00400-id-municipio
                      move f-cd-municipio          to f00400-cd-municipio
                      move f-nome-municipio        to f00400-nome-municipio
                      move f00300-id-estado        to f00400-id-estado           
                      
                      perform 9000-gravar-pd00400
                      
                      if   not ws-operacao-ok
                           string "Erro de gravação - f00400-municipio [" f00400-municipio "]" into ws-mensagem
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
            
            perform until exit
            
                 accept f-cd-pais at line 11 col 34 with update auto-skip
                 
                 initialize                        f00200-pais
                 move lnk-cd-empresa               to f00200-cd-empresa
                 move lnk-cd-filial                to f00200-cd-filial
                 move f-cd-pais                    to f00200-cd-pais
                 perform 9000-ler-pd00200-ran-1
                 if   ws-operacao-ok
                      move f00200-nome-pais        to f-nome-pais
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if           
                  
            end-perform
            
            perform until exit
            
                accept f-cd-estado at line 15 col 34 with update auto-skip
            
                 initialize                        f00300-estado
                 move lnk-cd-empresa               to f00300-cd-empresa
                 move lnk-cd-filial                to f00300-cd-filial
                 move f00200-id-pais               to f00300-id-pais
                 move f-cd-estado                  to f00300-cd-estado
                 perform 9000-ler-pd00300-ran-1
                 if   ws-operacao-ok
                      move f00300-nome-estado      to f-nome-estado
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if
            
            end-perform 
            
            perform until f-cd-municipio <> zeros
                 accept f-cd-municipio at line 19 col 34 with update auto-skip 
            end-perform
            
            initialize                             f00400-municipio
            move lnk-cd-empresa                    to f00400-cd-empresa
            move lnk-cd-filial                     to f00400-cd-filial
            move f00300-id-estado                  to f00400-id-estado
            move f-cd-municipio                    to f00400-cd-municipio
            perform 9000-ler-pd00400-ran-1
            if   not ws-operacao-ok
                 string "Código de municipio não encontrado! - [" f00400-cd-municipio "]" into ws-mensagem
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
            
            perform until exit
            
                 accept f-cd-pais at line 11 col 34 with update auto-skip
                 
                 initialize                        f00200-pais
                 move lnk-cd-empresa               to f00200-cd-empresa
                 move lnk-cd-filial                to f00200-cd-filial
                 move f-cd-pais                    to f00200-cd-pais
                 perform 9000-ler-pd00200-ran-1
                 if   ws-operacao-ok
                      move f00200-nome-pais        to f-nome-pais
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if           
                  
            end-perform
            
            perform until exit
            
                accept f-cd-estado at line 15 col 34 with update auto-skip
            
                 initialize                        f00300-estado
                 move lnk-cd-empresa               to f00300-cd-empresa
                 move lnk-cd-filial                to f00300-cd-filial
                 move f00200-id-pais               to f00300-id-pais
                 move f-cd-estado                  to f00300-cd-estado
                 perform 9000-ler-pd00300-ran-1
                 if   ws-operacao-ok
                      move f00300-nome-estado      to f-nome-estado
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if
            
            end-perform

            perform until f-cd-municipio <> zeros
                 accept f-cd-municipio at line 19 col 34 with update auto-skip 
            end-perform
            
            initialize                             f00400-municipio
            move lnk-cd-empresa                    to f00400-cd-empresa
            move lnk-cd-filial                     to f00400-cd-filial
            move f00300-id-estado                  to f00400-id-estado
            move f-cd-municipio                    to f00400-cd-municipio
            perform 9000-ler-pd00400-ran-1            
            if   not ws-operacao-ok
                 string "Código de municipio não encontrado! - [" f-cd-municipio "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 8000-controle-frame
                 exit section 
            else
                 perform 9000-move-registros-frame
            end-if
            
            perform until exit
            
                accept f-nome-municipio at line 21 col 34 with update auto-skip
                
                if   f-nome-municipio <> spaces
                     exit perform
                end-if       
            
            end-perform
            
            move "Confirma alteração do registro? [S/N]"    to ws-mensagem
            perform 9000-mensagem
                 
            if   ws-mensagem-opcao-sim
            
                 initialize                        f00400-municipio
                 move lnk-cd-empresa               to f00400-cd-empresa
                 move lnk-cd-filial                to f00400-cd-filial
                 move f00300-id-estado             to f00400-id-estado
                 move f-cd-municipio               to f00400-cd-municipio              
                 perform 9000-ler-pd00400-ran-1
                 if   not ws-operacao-ok
                      string "Código de estado não encontrado! - [" f-cd-estado "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 8000-controle-frame
                      exit section
                 end-if
                             
                 move f00400-id-municipio          to ws-id-muncipio 
                 
                 initialize                        f00400-municipio
                 move lnk-cd-empresa               to f00400-cd-empresa
                 move lnk-cd-filial                to f00400-cd-filial
                 move ws-id-muncipio               to f00400-id-municipio
                 move f-cd-municipio               to f00400-cd-municipio
                 move f-nome-municipio             to f00400-nome-municipio 
                 move f00300-id-estado             to f00400-id-estado
                 
                 perform 9000-regravar-pd00400
                      
                 if   not ws-operacao-ok
                      string "Erro de gravação - f00400-municipio [" f00400-municipio "]" into ws-mensagem
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
            
            perform until exit
            
                 accept f-cd-pais at line 11 col 34 with update auto-skip
                 
                 initialize                        f00200-pais
                 move lnk-cd-empresa               to f00200-cd-empresa
                 move lnk-cd-filial                to f00200-cd-filial
                 move f-cd-pais                    to f00200-cd-pais
                 perform 9000-ler-pd00200-ran-1
                 if   ws-operacao-ok
                      move f00200-nome-pais        to f-nome-pais
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if           
                  
            end-perform
            
            perform until exit
            
                accept f-cd-estado at line 15 col 34 with update auto-skip
            
                 initialize                        f00300-estado
                 move lnk-cd-empresa               to f00300-cd-empresa
                 move lnk-cd-filial                to f00300-cd-filial
                 move f00200-id-pais               to f00300-id-pais
                 move f-cd-estado                  to f00300-cd-estado
                 perform 9000-ler-pd00300-ran-1
                 if   ws-operacao-ok
                      move f00300-nome-estado      to f-nome-estado
                      
                      perform 8000-tela
                      
                      exit perform
                    
                 end-if
            
            end-perform

            perform until f-cd-municipio <> zeros
                 accept f-cd-municipio at line 19 col 34 with update auto-skip 
            end-perform
            
            initialize                             f00400-municipio
            move lnk-cd-empresa                    to f00400-cd-empresa
            move lnk-cd-filial                     to f00400-cd-filial
            move f00300-id-estado                  to f00400-id-estado
            move f-cd-municipio                    to f00400-cd-municipio
            perform 9000-ler-pd00400-ran-1            
            if   not ws-operacao-ok
                 string "Código de municipio não encontrado! - [" f-cd-municipio "]" into ws-mensagem
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
                           delete pd00400
                      end-if
                 end-if
                 
                 perform 8000-controle-frame  
                                  
            end-if
       
       
       exit.       
       
      *>=================================================================================
       2100-relatorio section.
       
       
       exit.        

      *>=================================================================================
       3000-finalizacao section.
       
            close pd00200
            close pd00300
            close pd00400
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
       
      *>=================================================================================
       8000-tela section.

            perform 9000-frame-padrao
            display frm-municipio
            
       exit. 

      *>=================================================================================
       8000-limpa-tela section.
       
            initialize                             f-municipio
            
            perform 9000-frame-padrao
            display frm-municipio  
       
       exit.                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão

      *>=================================================================================       
       9000-move-registros-frame section.
       
            initialize                             f-municipio
            move f00200-cd-pais                    to f-cd-pais
            move f00200-nome-pais                  to f-nome-pais
            move f00300-cd-estado                  to f-cd-estado
            move f00300-nome-estado                to f-nome-estado
            move f00400-cd-municipio               to f-cd-municipio
            move f00400-nome-municipio             to f-nome-municipio
       
            perform 9000-frame-padrao
            display frm-municipio
                   
       exit.

      *>=================================================================================       
       9000-move-registros-arquivo section.
          
                   
       exit.
       
      *>=================================================================================
       9000-validacao section.
       
            set ws-validacao-ok                    to true
            
       
       exit.           
              
      *>=================================================================================
      *> Leituras
      
       copy CSR00200.cpy. 
       copy CSR00300.cpy.
       copy CSR00400.cpy.        