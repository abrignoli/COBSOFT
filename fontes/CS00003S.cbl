      $set sourceformat"free"
       program-id. CS00003S.
      *>=================================================================================
      *>    
      *>           Tratamento de Mensagens - Execução Foreground e Background
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
       78   c-este-programa                         value "CS00003S".

       78   c-caracteres-invalidos                 value "ÇÁÃÀÂÕÓÒÔÊÉÚÜÙÍÌÎçáãàâõóòôêéúüùíìî".
       78   c-caracteres-invalidos-conv            value "CAAAAOOOOEEUUUIIIcaaaaooooeeuuuiii".
              
       01   ws-campos-trabalho.
            03 ws-mensagem                         pic x(560).
            03 filler redefines ws-mensagem.
               05 ws-mensagem-01                   pic x(056).
               05 ws-mensagem-02                   pic x(056).
               05 ws-mensagem-03                   pic x(056).
               05 ws-mensagem-04                   pic x(056).
               05 ws-mensagem-05                   pic x(056).
               05 ws-mensagem-06                   pic x(056).
               05 ws-mensagem-07                   pic x(056).
               05 ws-mensagem-08                   pic x(056).
               05 ws-mensagem-09                   pic x(056).
               05 ws-mensagem-10                   pic x(056).
               
       01  ws-campos-frame.
           03  ws-posicao-frame.
               05  ws-linha-frame                  pic x(01)    comp-x value zeros.
               05  ws-coluna-frame                 pic x(01)    comp-x value zeros.
           03  ws-informacoes-frame.
               05  ws-caracteres-frame occurs 6.
                   07  ws-caracter-frame           pic x(6954).
                   07  filler redefines ws-caracter-frame.
                       09  ws-caracter-linha       pic x(122)   occurs 57 times. 
                   07  filler redefines ws-caracter-frame.
                       09  ws-caracter-byte        pic x(01)    occurs 6100 times.
                   07  ws-atributo-frame           pic x(6954).
                   07  filler redefines ws-atributo-frame.
                       09  ws-atributo-linha       pic x(122)   occurs 57 times.
                   07  filler redefines ws-atributo-frame.
                       09  ws-atributo-byte        pic x(01)    occurs 6954.
           03  ws-tamanho-frame                    pic x(02)    comp-x value 6954.
           03  ws-index-frame                      pic 9(02).               
               
      *>=================================================================================
       linkage section.
       
       copy CSL00900.cpy.
       
       01   lw-mensagem-parametros.
            03 lw-mensagem                         pic x(560).
            03 lw-mensagem-opcao                   pic x(002).
       
      *>=================================================================================
       screen section.
       
       01   frm-mensagem.
            03 blank screen.          
            03 line 04 col 31   value "ÚÄÄ MENSAGEM ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿".
            03 line 05 col 31   value "³                                                          ³".       
            03 line 06 col 31   value "³                                                          ³".
            03 line 07 col 31   value "³                                                          ³".
            03 line 08 col 31   value "³                                                          ³".
            03 line 09 col 31   value "³                                                          ³".
            03 line 10 col 31   value "³                                                          ³".
            03 line 11 col 31   value "³                                                          ³".
            03 line 12 col 31   value "³                                                          ³".
            03 line 13 col 31   value "³                                                          ³".
            03 line 14 col 31   value "³                                                          ³".
            03 line 15 col 31   value "³                                                          ³".
            03 line 16 col 31   value "³                                                          ³".            
            03 line 17 col 31   value "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ".
                                                                                       
      *>=================================================================================
       procedure division using lnk-par lw-mensagem-parametros.
       
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
       
            if   lnk-execucao-foreground
                 move lw-mensagem                  to ws-mensagem        
                 inspect ws-mensagem converting c-caracteres-invalidos to all c-caracteres-invalidos-conv 
                 
                 move spaces                       to lw-mensagem-opcao
                 
                 move 01                           to ws-index-frame
                 perform 9000-salvar-frame
                 
                 display frm-mensagem
                 
                 display ws-mensagem-01 at line 06 col 33
                 display ws-mensagem-02 at line 07 col 33
                 display ws-mensagem-03 at line 08 col 33
                 display ws-mensagem-04 at line 09 col 33
                 display ws-mensagem-05 at line 10 col 33
                 display ws-mensagem-06 at line 11 col 33
                 display ws-mensagem-07 at line 12 col 33
                 display ws-mensagem-08 at line 13 col 33
                 display ws-mensagem-09 at line 14 col 33
                 display ws-mensagem-10 at line 15 col 33
                 
                 accept lw-mensagem-opcao at line 16 col 87
                 
                 move function upper-case(lw-mensagem-opcao)    to lw-mensagem-opcao
                 
                 perform 9000-retorna-frame          
            
            else
            
            end-if    
       
       exit.

      *>=================================================================================
       3000-finalizacao section.
       
       
       exit.                                                   

      *>================================================================
       9000-salvar-frame section.
       
           call "CBL_READ_SCR_CHATTRS" using ws-posicao-frame  
                                             ws-caracter-frame(ws-index-frame)
                                             ws-atributo-frame(ws-index-frame)
                                             ws-tamanho-frame
       exit. 
       
      *>================================================================
       9000-retorna-frame section.
       
           call "CBL_WRITE_SCR_ATTRS" using ws-posicao-frame
                                            ws-atributo-frame(ws-index-frame)
                                            ws-tamanho-frame
           
           call "CBL_WRITE_SCR_CHARS" using ws-posicao-frame
                                            ws-caracter-frame(ws-index-frame)
                                            ws-tamanho-frame
       exit.