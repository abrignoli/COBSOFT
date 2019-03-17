      $set sourceformat"free"
       program-id. CS00000F.
      *>=================================================================================
      *>    
      *>                                Frame Padrão
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.
            
      *>=================================================================================
       data division.       
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                                value "a".
       78   c-este-programa                         value "CS00000F".
       
       copy CSC00900.cpy.
       copy CSW00900.cpy.
       
       01   ws-campos-trabalho.
            03 ws-index-0                          pic 9(001).
            03 ws-nr-coluna                        pic 9(003).
            03 ws-ds-programa                      pic x(116).
            03 filler redefines ws-ds-programa occurs 116 times.
               05 ws-byte-ds-programa              pic x(001).
            03 ws-ds-funcao                        pic x(019).    
       
       01   f-menu.
            03 linha-topo.
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "Ú".
               05 filler                           pic x(118)    value all "Ä".
               05 filler                           pic x(001)    value all "¿".
               05 filler                           pic x(001)    value all " ".
            03 linha-programa.
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(001)    value all " ".
               05 linha-ds-programa                pic x(116)    value all " ".
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(001)    value all " ".
            03 linha-empresa.
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(001)    value all " ".
               05 linha-cd-empresa                 pic 9(003).
               05 filler                           pic x(001)    value all ".".
               05 linha-cd-filial                  pic 9(004).
               05 filler                           pic x(001)    value all " ". 
               05 filler                           pic x(001)    value all "-".
               05 filler                           pic x(001)    value all " ".
               05 linha-nome-empresa               pic x(079)    value all " ".
               05 filler                           pic x(001)    value all " ".
               05 linha-cd-programa                pic x(008)    value all " ".
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "-".
               05 filler                           pic x(001)    value all " ".
               05 linha-vs-programa                pic x(001)    value all " ".
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "-".
               05 filler                           pic x(001)    value all " ".
               05 linha-dt-sistema                 pic 99/99/9999.
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(001)    value all " ".   
            03 linha-divisao.    
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(118)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(001)    value all " ".
            03 linha-funcao.
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(001)    value all " ".
               05 linha-funcoes                    pic x(116)    value all " ".
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "³".
               05 filler                           pic x(001)    value all " ".
            03 linha-rodape.
               05 filler                           pic x(001)    value all " ".
               05 filler                           pic x(001)    value all "À".
               05 filler                           pic x(118)    value all "Ä".
               05 filler                           pic x(001)    value all "Ù".
               05 filler                           pic x(001)    value all " ".
          
                              
      *>=================================================================================
       linkage section.
       
       copy CSL00900.cpy.
      
      *>=================================================================================
       screen section.
       01   frm-menu-0.
            03 blank screen.
            03 line 02 col 01 pic x(122) from linha-topo.
            03 line 03 col 01 pic x(122) from linha-programa.
            03 line 04 col 01 pic x(122) from linha-divisao.
            03 line 05 col 01 pic x(122) from linha-empresa.
            03 line 06 col 01 pic x(122) from linha-rodape.
            
            03 line 09 col 01 pic x(122) from linha-topo.
            03 line 10 col 01 pic x(122) from linha-divisao.
            03 line 11 col 01 pic x(122) from linha-divisao.
            03 line 12 col 01 pic x(122) from linha-divisao.
            03 line 13 col 01 pic x(122) from linha-divisao.
            03 line 14 col 01 pic x(122) from linha-divisao.
            03 line 15 col 01 pic x(122) from linha-divisao.
            03 line 16 col 01 pic x(122) from linha-divisao.
            03 line 17 col 01 pic x(122) from linha-divisao.
            03 line 18 col 01 pic x(122) from linha-divisao.  
            03 line 19 col 01 pic x(122) from linha-divisao.  
            03 line 20 col 01 pic x(122) from linha-divisao.  
            03 line 21 col 01 pic x(122) from linha-divisao.  
            03 line 22 col 01 pic x(122) from linha-divisao.  
            03 line 23 col 01 pic x(122) from linha-divisao.
            03 line 24 col 01 pic x(122) from linha-divisao.
            03 line 25 col 01 pic x(122) from linha-divisao.
            03 line 26 col 01 pic x(122) from linha-divisao.
            03 line 27 col 01 pic x(122) from linha-divisao.
            03 line 28 col 01 pic x(122) from linha-divisao.
            03 line 29 col 01 pic x(122) from linha-divisao.
            03 line 30 col 01 pic x(122) from linha-divisao.
            03 line 31 col 01 pic x(122) from linha-divisao.
            03 line 32 col 01 pic x(122) from linha-divisao.
            03 line 33 col 01 pic x(122) from linha-divisao.
            03 line 34 col 01 pic x(122) from linha-divisao.
            03 line 35 col 01 pic x(122) from linha-divisao.
            03 line 36 col 01 pic x(122) from linha-divisao.
            03 line 37 col 01 pic x(122) from linha-divisao.
            03 line 38 col 01 pic x(122) from linha-divisao.
            03 line 39 col 01 pic x(122) from linha-divisao.
            03 line 40 col 01 pic x(122) from linha-divisao.
            03 line 41 col 01 pic x(122) from linha-divisao.
            03 line 42 col 01 pic x(122) from linha-divisao.
            03 line 43 col 01 pic x(122) from linha-divisao.
            03 line 44 col 01 pic x(122) from linha-divisao.
            03 line 45 col 01 pic x(122) from linha-divisao.
            03 line 46 col 01 pic x(122) from linha-divisao.
            03 line 47 col 01 pic x(122) from linha-divisao.
            03 line 48 col 01 pic x(122) from linha-divisao.
            03 line 49 col 01 pic x(122) from linha-divisao.
            03 line 45 col 01 pic x(122) from linha-divisao.
            03 line 46 col 01 pic x(122) from linha-divisao.
            03 line 47 col 01 pic x(122) from linha-divisao.
            03 line 48 col 01 pic x(122) from linha-divisao.
            03 line 49 col 01 pic x(122) from linha-divisao.
            03 line 50 col 01 pic x(122) from linha-divisao.
            03 line 51 col 01 pic x(122) from linha-divisao.
            03 line 52 col 01 pic x(122) from linha-divisao.
            03 line 53 col 01 pic x(122) from linha-divisao.
            03 line 54 col 01 pic x(122) from linha-divisao.
            03 line 55 col 01 pic x(122) from linha-divisao.                           
            03 line 56 col 01 pic x(122) from linha-rodape.     
                   
       01   frm-menu-1.
            03 blank screen.
            03 line 02 col 01 pic x(122) from linha-topo.
            03 line 03 col 01 pic x(122) from linha-programa.
            03 line 04 col 01 pic x(122) from linha-divisao.
            03 line 05 col 01 pic x(122) from linha-empresa.
            03 line 06 col 01 pic x(122) from linha-rodape.
            
            03 line 08 col 03 pic x(122) value "INFORME A OPCAO DESEJADA (  )".
            
            03 line 09 col 01 pic x(122) from linha-topo.
            03 line 10 col 01 pic x(122) from linha-divisao.
            03 line 11 col 01 pic x(122) from linha-divisao.
            03 line 12 col 01 pic x(122) from linha-divisao.
            03 line 13 col 01 pic x(122) from linha-divisao.
            03 line 14 col 01 pic x(122) from linha-divisao.
            03 line 15 col 01 pic x(122) from linha-divisao.
            03 line 16 col 01 pic x(122) from linha-divisao.
            03 line 17 col 01 pic x(122) from linha-divisao.
            03 line 18 col 01 pic x(122) from linha-divisao.  
            03 line 19 col 01 pic x(122) from linha-divisao.  
            03 line 20 col 01 pic x(122) from linha-divisao.  
            03 line 21 col 01 pic x(122) from linha-divisao.  
            03 line 22 col 01 pic x(122) from linha-divisao.  
            03 line 23 col 01 pic x(122) from linha-divisao.
            03 line 24 col 01 pic x(122) from linha-divisao.
            03 line 25 col 01 pic x(122) from linha-divisao.
            03 line 26 col 01 pic x(122) from linha-divisao.
            03 line 27 col 01 pic x(122) from linha-divisao.
            03 line 28 col 01 pic x(122) from linha-divisao.
            03 line 29 col 01 pic x(122) from linha-divisao.
            03 line 30 col 01 pic x(122) from linha-divisao.
            03 line 31 col 01 pic x(122) from linha-divisao.
            03 line 32 col 01 pic x(122) from linha-divisao.
            03 line 33 col 01 pic x(122) from linha-divisao.
            03 line 34 col 01 pic x(122) from linha-divisao.
            03 line 35 col 01 pic x(122) from linha-divisao.
            03 line 36 col 01 pic x(122) from linha-divisao.
            03 line 37 col 01 pic x(122) from linha-divisao.
            03 line 38 col 01 pic x(122) from linha-divisao.
            03 line 39 col 01 pic x(122) from linha-divisao.
            03 line 40 col 01 pic x(122) from linha-divisao.
            03 line 41 col 01 pic x(122) from linha-divisao.
            03 line 42 col 01 pic x(122) from linha-divisao.
            03 line 43 col 01 pic x(122) from linha-divisao.
            03 line 44 col 01 pic x(122) from linha-divisao.
            03 line 45 col 01 pic x(122) from linha-divisao.
            03 line 46 col 01 pic x(122) from linha-divisao.
            03 line 47 col 01 pic x(122) from linha-divisao.
            03 line 48 col 01 pic x(122) from linha-divisao.
            03 line 49 col 01 pic x(122) from linha-divisao.
            03 line 50 col 01 pic x(122) from linha-rodape.
            
            03 line 52 col 01 pic x(122) from linha-topo.
            03 line 53 col 01 pic x(122) from linha-divisao.
            03 line 54 col 01 pic x(122) from linha-funcao.
            03 line 55 col 01 pic x(122) from linha-divisao.
            03 line 56 col 01 pic x(122) from linha-rodape.                                                  
                                                                           
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
       
            *> Monta cabeçalho Padrão

            move lnk-cd-empresa                    to linha-cd-empresa
            move lnk-cd-filial                     to linha-cd-filial
            
            string lnk-razao-social " - " lnk-nome-fantasia delimited by "  " into linha-nome-empresa
            
            move lnk-cd-programa                   to linha-cd-programa
            move lnk-vs-programa                   to linha-vs-programa
            
            move lnk-ds-programa                   to ws-ds-programa
            
            perform varying ws-index-0 from 116 by -1 until ws-index-0 < 1
                 or ws-byte-ds-programa(ws-index-0) not equal spaces
                      continue   
            end-perform
            
            if   ws-index-0 > 0   
                 compute ws-nr-coluna = (116 - ws-index-0)/2
            end-if
            
            move lnk-ds-programa                   to linha-ds-programa(ws-nr-coluna:)     
            
            move lnk-data-so                       to linha-dt-sistema
            
           *> Monta Rodapé Padrão
           
            if   lnk-ds-funcao equal spaces    
                 
                 move 01                                to ws-nr-coluna
                 
                 if   lnk-permite-inclusao
                      move "01 - Inclusao"              to ws-ds-funcao
                      string ws-ds-funcao               into linha-funcoes with pointer ws-nr-coluna 
                 end-if
                 
                 if   lnk-permite-consulta
                      move "02 - Consulta"             to ws-ds-funcao 
                      string ws-ds-funcao              into linha-funcoes with pointer ws-nr-coluna  
                 end-if
                 
                 if   lnk-permite-manutencao
                      move "03 - Manutencao"            to ws-ds-funcao 
                      string ws-ds-funcao               into linha-funcoes with pointer ws-nr-coluna
                 end-if
                 
                 if   lnk-permite-exclusao
                      move "04 - Exclusao"              to ws-ds-funcao
                      string ws-ds-funcao               into linha-funcoes with pointer ws-nr-coluna        
                 end-if 
                 
                 if   lnk-permite-consulta
                      move "05 - Relatorio"             to ws-ds-funcao 
                      string ws-ds-funcao               into linha-funcoes with pointer ws-nr-coluna  
                 end-if
                 
                 move "99 - Retornar"                   to ws-ds-funcao
                 string ws-ds-funcao                    into linha-funcoes with pointer ws-nr-coluna
            
            else
                 move lnk-ds-funcao                     to linha-funcoes
            end-if
                        
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
            if   lnk-cd-programa(08:01) equal "M"
            or   lnk-cd-programa(08:01) equal "P"
            
                 display frm-menu-0
                 
                 if   lnk-cd-programa(08:01) equal "M"
                      display "INFORME A OPCAO DESEJADA (  )" at line 08 col 03
                 end-if   
                                   
            else   
                 display frm-menu-1
            end-if             
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.  
                                                       