      $set sourceformat"free"
       program-id. CS00002S.
      *>=================================================================================
      *>    
      *>                               Carregar Linkage
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

            select ambiente assign to disk wid-ambiente
                 organization      is line sequential
                 access mode       is sequential
                 file status       is ws-resultado-acesso.
                 

            select cobsoft-ini assign to disk wid-cobsoft-ini
                 organization         is line sequential
                 access mode          is sequential
                 file status          is ws-resultado-acesso.                 

      *>=================================================================================
       data division.
       
       fd   ambiente.
       01   rs-ambiente                            pic x(300).
       
       fd   cobsoft-ini.
       01   rs-cobsoft-ini                         pic x(300).
                   
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS00002S".
       78   c-computador-adrian                    value "DT-ADRIAN".
       78   c-omputador-hbsis                      value "DT-02403".
       
       01   ws-campos-trabalho.
            03 ws-computer-name                    pic x(55).
               88 ws-computador-adrian                  value c-computador-adrian.
               88 ws-computador-hbsis                   value c-omputador-hbsis.
            03 ws-alias-path                       pic x(55).
            03 ws-dir-path                         pic x(250).
               
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
       
       
       exit.
        
      *>=================================================================================
       2000-processamento section.     
            
            evaluate true
                 when lnk-carregar-diretorios
                      perform 2100-carregar-diretorios
                 when lnk-carregar-prametros
                      perform 2100-carregar-parametros             
                 when lnk-carregar-completa 
                      perform 2100-carregar-completa 
            end-evaluate
       
       exit.
       
      *>=================================================================================
       2100-carregar-diretorios section.     

            perform 9000-obter-computer-name
            
            if   ws-computador-adrian
            or   ws-computador-hbsis
                 set lnk-desenvolvimento           to true
                 move "C:\CobSoft\cgi"             to lnk-cgi-path
                 move "C:\CobSoft\dat"             to lnk-dat-path
                 move "C:\CobSoft\dvs"             to lnk-dvs-path
                 move "C:\CobSoft\int"             to lnk-int-path
                 move "C:\CobSoft\log"             to lnk-log-path
                 move "C:\CobSoft\tmp"             to lnk-tmp-path  
            else
                set lnk-producao                   to true
                move "..\configuracao\COBSOFT.INI" to wid-cobsoft-ini
                open input cobsoft-ini
                read cobsoft-ini next
                perform until not ws-operacao-ok
                 
                      move spaces                  to ws-alias-path
                                                      ws-dir-path
                      
                      unstring rs-cobsoft-ini delimited by "=" into ws-alias-path
                                                                    ws-dir-path
                                                                    
                      evaluate ws-alias-path
                           when "CGI"
                                move ws-dir-path   to lnk-cgi-path
                           when "DAT"
                                move ws-dir-path   to lnk-dat-path
                           when "TMP"
                                move ws-dir-path   to lnk-tmp-path                                      
                           when "INT"
                                move ws-dir-path   to lnk-int-path
                           when "DVS"
                                move ws-dir-path   to lnk-dvs-path
                           when "LOG"
                                move ws-dir-path   to lnk-log-path 
                           when "NFE"
                                move ws-dir-path   to lnk-nfe-path                                                                                        
                      end-evaluate                                                                                
                    
                      read cobsoft-ini next
                 end-perform
                 close cobsoft-ini            
            end-if           
                 
       exit.
         
      *>=================================================================================
       2100-carregar-parametros section.
       
            accept ws-data-inv                     from date yyyymmdd
            move ws-dia-inv                        to lnk-dia-os
            move ws-mes-inv                        to lnk-mes-os
            move ws-ano-inv                        to lnk-ano-os             
       
       exit.
        
      *>=================================================================================
       2100-carregar-completa section.
       
            perform 2100-carregar-diretorios
            perform 2100-carregar-parametros
       
       exit.
      
      *>=================================================================================
      
       3000-finalizacao section.
       
       
       exit.
                                                          
      *>=================================================================================
       9000-obter-computer-name section.

            display "COMPUTERNAME"                 upon environment-name
            accept ws-computer-name                from environment-value

       exit.
     