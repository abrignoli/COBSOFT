      $set sourceformat"free"
       program-id. CS00100S.
      *>=================================================================================
      *>    
      *>                            Tela Login - Empresa
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

       copy CSS00800.cpy. *> Usuários

      *>=================================================================================
       data division.      
       
       copy CSF00800.cpy. *> Usuários
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS00100S".
       78   c-descricao-programa                   value "MENU PRINCIPAL".        
       
       copy CSW00900.cpy.
       
       78   c-usuario-implantacao                  value "IMPLANTACAO". 

       01   ws-campos-trabalho.
            03 ws-computer-name                    pic x(55).       
      *>=================================================================================
       linkage section. 
 
       copy CSL00900.cpy.
              
       01   lw-login.
            03 lw-nr-tentativas                    pic 9(02).
            03 lw-id-retorno-usuario               pic x(01).
               88 lw-login-invalido                     value "I".
               88 lw-login-valido                       value "V".                        
                                                                          
      *>=================================================================================
       procedure division using lnk-par lw-login.
       
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
       
            perform 9000-abrir-io-pd00800                
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
            accept ws-data-inv                     from date yyyymmdd
            move ws-dia-inv                        to ws-dia
            move ws-mes-inv                        to ws-mes
            move ws-ano-inv                        to ws-ano
            
            add 01                                 to lw-nr-tentativas
            
            set lw-login-invalido                  to true
            
            if   function upper-case(lnk-id-usuario) equal c-usuario-implantacao
            and  lnk-pw-usuario                      equal ws-data
                 set lw-login-valido               to true
                 set lnk-login-master              to true            
            else
                 initialize                             f00800-usuario
                 move function numval(lnk-id-usuario)   to f00800-id-usuario
                 perform 9000-ler-pd00800-ran
                 if   not ws-operacao-ok
                 and  not ws-registro-inexistente
                      string "Erro de leitura f00800-usuario - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      set lnk-com-erros            to true  
                 end-if
                 
                 if   f00800-id-usuario equal function numval(lnk-id-usuario)
                 and  f00800-pw-usuario equal lnk-pw-usuario
                 and  f00800-ativo
                      if   f00800-desenvolvimento
                           set lnk-login-master    to true 
                      end-if
                      move f00800-id-usuario       to lnk-id-usuario
                      move f00800-nome-usuario     to lnk-nome-usuario 
                      perform 2100-atualizar-login
                      set lw-login-valido          to true
                 end-if   
            
            end-if 
       
       exit.

      *>=================================================================================
       2100-atualizar-login section.
       
            accept ws-data-inv                     from date yyyymmdd
            accept ws-horas                        from time
            
            move ws-data-inv                       to f00800-data-ultimo-login
            move ws-horas                          to f00800-hora-ultimo-login

            display "COMPUTERNAME"                 upon environment-name
            accept ws-computer-name                from environment-value
            
            move ws-computer-name                  to f00800-maquina-login                         
       
       exit.
       
      *>=================================================================================
       3000-finalizacao section.
       
            close pd00800
       
       exit. 
                                                         
      *>=================================================================================
      *> Rotinas Genérias
      
       copy CSP00900.cpy.
        
      *>=================================================================================
      *> Leituras

       copy CSR00800.cpy. *> Tabelas          
