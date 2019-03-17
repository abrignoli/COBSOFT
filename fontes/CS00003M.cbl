      $set sourceformat"free"
       program-id. CS00003M.
      *>=================================================================================
      *>    
      *>                           Menu Principal - ESTOQUE
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.
            
       copy CSS00100.cpy. *> Módulos
       copy CSS01300.cpy. *> Usuário x Módulos           

      *>=================================================================================
       data division.
       
       copy CSF00100.cpy. *> Módulos
       copy CSF01300.cpy. *> Usuário x Módulos       
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                                value "a".
       78   c-este-programa                         value "CS00003M". 
       78   c-descricao-programa                    value "FATURAMENTO".        
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       01   ws-campos-trabalho.
            03 ws-nr-linha                         pic 9(02).
            03 ws-nr-coluna                        pic 9(02).
            03 ws-cd-programa                      pic x(08).
            03 ws-id-acesso                        pic x(01).
               88 ws-usuario-acesso                     value "S".
               88 ws-usuario-sem-acesso                 value "N".
            03 ws-linha-modulo                     pic x(58).
       
      *>=================================================================================
       linkage section.
       
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
                                                    
                                                                           
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
                           move "Frame inválido!"  to ws-mensagem
                           perform 9000-mensagem
                           perform 9000-abortar
                 end-evaluate
                           
            end-perform
       
       exit.
           
      *>=================================================================================
       2999-controle-frame section.     
            
            perform 8000-accept-opcao
                 
            if   not wf-opcao-retornar   
                 
                 perform 9000-abrir-io-pd00100
                 perform 9000-abrir-io-pd01300
                 
                 initialize                   f00100-modulos
                 move lnk-cd-empresa          to f00100-cd-empresa
                 move lnk-cd-filial           to f00100-cd-filial
                 move c-este-programa         to f00100-programa-principal
                 move wf-opcao                to f00100-operacao-programa
                 perform 9000-ler-pd00100-ran-1
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro de leitura f00100-modulos - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if
                      
                 move f00100-cd-programa           to ws-cd-programa
                      
                 if   not lnk-login-master
                      initialize                   f01300-usuario-modulo
                      move lnk-cd-empresa          to f01300-cd-empresa
                      move lnk-cd-filial           to f01300-cd-filial
                      move lnk-id-usuario          to f01300-id-usuario
                      move ws-cd-programa          to f01300-cd-programa
                      perform 9000-ler-pd01300-ran
                      if   not ws-operacao-ok
                      and  not ws-registro-inexistente
                           string "Erro de leitura f00100-modulos - Status [" ws-resultado-acesso "]" into ws-mensagem
                           perform 9000-mensagem
                           perform 9000-abortar
                      end-if  
                      
                      move f01300-id-consulta      to lnk-id-consulta
                      move f00130-id-inclusao      to lnk-id-inclusao
                      move f01300-id-manutencao    to lnk-id-manutencao
                      move f00130-id-exclusao      to lnk-id-exclusao
                 else
                      set lnk-permite-consulta     to true
                      set lnk-permite-inclusao     to true
                      set lnk-permite-manutencao   to true
                      set lnk-permite-exclusao     to true
                 end-if                         
                 
                 close pd00100
                 close pd01300
                 
                 if   (lnk-permite-consulta or lnk-permite-inclusao or lnk-permite-manutencao or lnk-permite-exclusao)    
                 and  ws-cd-programa not equal spaces   
                      call ws-cd-programa using lnk-par
                      cancel ws-cd-programa 
                 end-if
                      
                 set lnk-nao-permite-consulta      to true
                 set lnk-nao-permite-inclusao      to true
                 set lnk-nao-permite-manutencao    to true
                 set lnk-nao-permite-exclusao      to true
                 
                 perform 8000-inicia-frame   
                 
            end-if     

            if   wf-opcao-retornar
                 set wf-frame-retornar             to true
            end-if
                   
       exit.
      
      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.  
                                                        
      *>=================================================================================
       8000-tela section.
       
            perform 9000-frame-padrao
            
            perform 9000-abrir-io-pd00100
            perform 9000-abrir-io-pd01300

            move 11                                to ws-nr-linha
            move 04                                to ws-nr-coluna
            
            initialize                             f00100-modulos
            move lnk-cd-empresa                    to f00100-cd-empresa
            move lnk-cd-filial                     to f00100-cd-filial
            move c-este-programa                   to f00100-programa-principal
            perform 9000-str-pd00100-grt
            perform 9000-ler-pd00100-nex
            perform until not ws-operacao-ok
                 or f00100-cd-empresa   <>  lnk-cd-empresa
                 or f00100-cd-filial    <>  lnk-cd-filial
                 
                 if   f00100-programa-principal equal c-este-programa
                 
                       if   not lnk-login-master
                            move f00100-cd-programa     to ws-cd-programa
                            perform 9000-verifica-acesso
                       end-if
                       
                       if   ws-usuario-acesso
                       or   lnk-login-master                      
                 
                            string f00100-operacao-programa " - " f00100-descricao-programa into ws-linha-modulo
                 
                            display ws-linha-modulo at line ws-nr-linha col ws-nr-coluna
                 
                            add 02                       to ws-nr-linha
                            
                       end-if     
                 
                 end-if
                   
                 perform 9000-ler-pd00100-nex
            end-perform
       
            perform 8000-controle-frame
            
            close pd00100
            close pd01300
            
       exit.
      
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame
                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão
       
      *>=================================================================================
       9000-verifica-acesso section.

            set ws-usuario-sem-acesso              to true
            
            initialize                             f01300-usuario-modulo
            move lnk-cd-empresa                    to f01300-cd-empresa
            move lnk-cd-filial                     to f01300-cd-filial
            move lnk-id-usuario                    to f01300-id-usuario
            move ws-cd-programa                    to f01300-cd-programa
            perform 9000-ler-pd01300-ran
            if   ws-operacao-ok
                 set ws-usuario-acesso             to true
            end-if
       
       exit.
             
      *>=================================================================================
      *> Leituras
      
       copy CSR00100.cpy. *> Módulos
       copy CSR01300.cpy. *> Usuário x Módulos        