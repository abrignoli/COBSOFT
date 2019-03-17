      $set sourceformat"free"
       program-id. CS00105S.
      *>=================================================================================
      *>    
      *>                          Busca Próximo Documento NF-e
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      
        
       copy CSS02200.cpy.

      *>=================================================================================
       data division.      

       copy CSF02200.cpy.
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS00105S".
       78   c-descricao-programa                   value "PROXIMO DOCUMENTO NFE".

       01   ws-campos-trabalho.
            03 ws-numero-documento                 pic 9(09).
            03 ws-serie-documento                  pic 9(03).
       
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

            perform 9000-abrir-io-pd02200
       
       exit.
        
      *>=================================================================================
       2000-processamento section.

            initialize                             f02200-parametros-nfe
            move lnk-cd-empresa                    to f02200-cd-empresa
            move lnk-cd-filial                     to f02200-cd-filial
            perform 9000-ler-pd02200-ran
            if   ws-operacao-ok
            and  f02200-cd-empresa equal lnk-cd-empresa
            and  f02200-cd-filial  equal lnk-cd-filial
                 add 1                             to f02200-numero-documento
                 move f02200-numero-documento      to ws-numero-documento
                 move f02200-serie-documento       to ws-serie-documento
                 if   ws-numero-documento equal zeros
                      move 1                       to ws-numero-documento
                      
                      add 1                        to f02200-serie-documento
                      move f02200-serie-documento  to ws-serie-documento                              
                 end-if
            else
                 move 1                            to ws-numero-documento
                 move 1                            to ws-serie-documento                                            
            end-if 

            initialize                             f02200-parametros-nfe
            move lnk-cd-empresa                    to f02200-cd-empresa
            move lnk-cd-filial                     to f02200-cd-filial
            move ws-numero-documento               to f02200-numero-documento
            move ws-serie-documento                to f02200-serie-documento
            perform 9000-gravar-pd02200
            if   not ws-operacao-ok
                 perform 9000-regravar-pd02200
                 if   not ws-operacao-ok
                      string "Erro de gravacao f02200-parametros-nfe - " ws-resultado-acesso into ws-mensagem
                      perform 9000-mensagem
                 end-if
            end-if

            move ws-numero-documento               to lnk-numero-documento
            move ws-serie-documento                to lnk-serie-documento
       
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
            close pd02200
       
       exit.  
                                                
      *>=================================================================================
      *> Rotinas Genérias

       copy CSP00900.cpy. *> Padrão
       copy CSR02200.cpy.