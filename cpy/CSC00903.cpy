       8000-inicia-frame section.
       
            move 00                                 to wf-frame
            move 00                                 to wf-opcao
            
       exit. 
        
      *>=================================================================================
       8000-controle-frame section.
           
           move 09                                 to wf-frame
       
       exit.
      
      *>=================================================================================
       8000-accept-opcao section.

            move zeros                             to wf-opcao
            
            perform until wf-opcao <> zeros
                 accept wf-opcao at line 08 col 29 with update auto-skip 
            end-perform
       
       exit.
       

