      $set sourceformat"free"
       program-id. CS10001P.
      *>=================================================================================
      *>    
      *>                                Pesquisa CEP
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.      

       copy CSS00200.cpy.
       copy CSS00300.cpy.
       copy CSS00400.cpy.
       copy CSS00500.cpy.
       copy CSS00600.cpy.
       
            select arq-logradouro assign to disk wid-arq-logradouro
                organization             is indexed
                access mode              is dynamic
                record key               is rs-seq-item                                                               
                lock mode                is manual
                file status              is ws-resultado-acesso.             

      *>=================================================================================
       data division. 
       
       copy CSF00200.cpy.
       copy CSF00300.cpy.
       copy CSF00400.cpy.
       copy CSF00500.cpy.
       copy CSF00600.cpy.
       
       fd   arq-logradouro.
       01   rs-logradouro.
            03 rs-seq-item                         pic 9(06). 
            03 rs-id-logradouro                    pic 9(09).
            03 rs-cep                              pic 9(08).
            03 rs-endereco                         pic x(55).
            03 rs-bairro                           pic x(55).
            03 rs-municipio                        pic x(55).
            03 rs-uf                               pic x(02).
            03 rs-pais                             pic x(55).     
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS10015C".
       78   c-descricao-programa                   value "CATEGORIA MATERIAIS".
       
       78   c-cadastro-logradouros                 value "CS10006C".
       
       78   c-cep-nao-cadastrado                   value 999999.
       78   c-cep-unico                            value 000001. 
              
       copy CSC00900.cpy.
       copy CSW00900.cpy.

       01   ws-campos-trabalho.
            03 ws-seq-item                         pic 9(006).       
            03 ws-nr-linha                         pic 9(018).
            03 ws-nr-coluna                        pic 9(018).
            03 ws-linha-display                    pic x(100).
                   
       01   f-logradouro.
            03 f-cep                               pic 9(008).
            03 f-sequencia                         pic z(006).

      *>=================================================================================
       linkage section.
                 
       copy CSL00900.cpy.
       
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
      
      *>=================================================================================
       screen section.
       
       01   frm-logradouro.
            03 line 11 col 19   pic x(14) value "Pesquisar CEP:".
            03 line 11 col 34   pic x(09) from ws-mascara-cep.
            03 line 11 col 34   pic 9(05) from f-cep(01:05).
            03 line 11 col 40   pic 9(03) from f-cep(06:03).


      *>=================================================================================
       procedure division using lnk-par lk-logradouro.
       
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
       
            perform 9000-abrir-i-pd00200
            perform 9000-abrir-i-pd00300
            perform 9000-abrir-i-pd00400
            perform 9000-abrir-i-pd00500
            perform 9000-abrir-i-pd00600          
       
       exit.
        
      *>=================================================================================
       2000-processamento section.
       
            set lk-nao-encontrou-cep               to true
            
            if   lk-id-logradouro greater zeros
                 perform 2200-buscar-logradouro-id
            else
                 perform 2200-buscar-logradouro-cep
            end-if
            
       exit.
       
      *>=================================================================================
       2200-buscar-logradouro-id section.
       
            initialize                             f00600-logradouro
            move lnk-cd-empresa                    to f00600-cd-empresa
            move lnk-cd-filial                     to f00600-cd-filial
            move lk-id-logradouro                  to f00600-id-logradouro
            perform 9000-ler-pd00600-ran
            if   not ws-operacao-ok
                 string "Erro de leitura f00600-logradouro - Status [" ws-resultado-acesso "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if  
                        
            initialize                             f00500-bairro
            move lnk-cd-empresa                    to f00500-cd-empresa
            move lnk-cd-filial                     to f00500-cd-filial
            move f00600-id-bairro                  to f00500-id-bairro
            perform 9000-ler-pd00500-ran                                   
            if   not ws-operacao-ok
                 string "Erro de leitura f00500-bairro - Status [" ws-resultado-acesso "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if                         

            initialize                             f00400-municipio
            move lnk-cd-empresa                    to f00400-cd-empresa
            move lnk-cd-filial                     to f00400-cd-filial
            move f00500-id-municipio               to f00400-id-municipio
            perform 9000-ler-pd00400-ran                                   
            if   not ws-operacao-ok
                 string "Erro de leitura f00400-municipio - Status [" ws-resultado-acesso "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if           

            initialize                             f00300-estado
            move lnk-cd-empresa                    to f00300-cd-empresa
            move lnk-cd-filial                     to f00300-cd-filial
            move f00400-id-estado                  to f00300-id-estado
            perform 9000-ler-pd00300-ran                                   
            if   not ws-operacao-ok
                 string "Erro de leitura f00300-estado - Status [" ws-resultado-acesso "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if            

            initialize                             f00200-pais
            move lnk-cd-empresa                    to f00200-cd-empresa
            move lnk-cd-filial                     to f00200-cd-filial
            move f00300-id-pais                    to f00200-id-pais
            perform 9000-ler-pd00200-ran                                   
            if   not ws-operacao-ok
                 string "Erro de leitura f00200-pais - Status [" ws-resultado-acesso "]" into ws-mensagem
                 perform 9000-mensagem
                 perform 9000-abortar
            end-if
            
            initialize                             lk-logradouro
            
            set lk-encontrou-cep                   to true
            
            move f00600-id-logradouro              to lk-id-logradouro
            move f00600-cep                        to lk-cep
            move f00600-nome-logradouro            to lk-endereco
            move f00500-nome-bairro                to lk-bairro
            move f00400-nome-municipio             to lk-municipio
            move f00300-sigla-estado               to lk-uf
            move f00200-nome-pais                  to lk-pais            
       
       exit.

      *>=================================================================================
       2200-buscar-logradouro-cep section.
       
            accept ws-horas                        from time
            accept ws-data-inv                     from date yyyymmdd
            
            string lnk-tmp-path "\" c-este-programa "_" lnk-id-usuario "_" ws-data-inv "_" ws-horas ".WRK" delimited by "  " into wid-arq-logradouro
            open output arq-logradouro
            close arq-logradouro
            open i-o arq-logradouro
            
            initialize                             f00600-logradouro
            move lnk-cd-empresa                    to f00600-cd-empresa
            move lnk-cd-filial                     to f00600-cd-filial
            move lk-cep                            to f00600-cep
            perform 9000-str-pd00600-grt-2
            perform 9000-ler-pd00600-nex
            perform until not ws-operacao-ok
                 or f00600-cd-empresa <> lnk-cd-empresa
                 or f00600-cd-filial  <> lnk-cd-filial
                 or f00600-cep        <> lk-cep
                 
                 initialize                        f00500-bairro
                 move lnk-cd-empresa               to f00500-cd-empresa
                 move lnk-cd-filial                to f00500-cd-filial
                 move f00600-id-bairro             to f00500-id-bairro
                 perform 9000-ler-pd00500-ran                                   
                 if   not ws-operacao-ok
                      string "Erro de leitura f00500-bairro - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if          

                 initialize                        f00400-municipio
                 move lnk-cd-empresa               to f00400-cd-empresa
                 move lnk-cd-filial                to f00400-cd-filial
                 move f00500-id-municipio          to f00400-id-municipio
                 perform 9000-ler-pd00400-ran                                   
                 if   not ws-operacao-ok
                      string "Erro de leitura f00400-municipio - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if           

                 initialize                        f00300-estado
                 move lnk-cd-empresa               to f00300-cd-empresa
                 move lnk-cd-filial                to f00300-cd-filial
                 move f00400-id-estado             to f00300-id-estado
                 perform 9000-ler-pd00300-ran                                   
                 if   not ws-operacao-ok
                      string "Erro de leitura f00300-estado - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if            

                 initialize                        f00200-pais
                 move lnk-cd-empresa               to f00200-cd-empresa
                 move lnk-cd-filial                to f00200-cd-filial
                 move f00300-id-pais               to f00200-id-pais
                 perform 9000-ler-pd00200-ran                                   
                 if   not ws-operacao-ok
                      string "Erro de leitura f00200-pais - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if
                 
                 initialize                        rs-logradouro
                 move 999999                       to rs-seq-item
                 start arq-logradouro key is not greater rs-seq-item
                 read arq-logradouro previous
                 if   ws-operacao-ok
                      add 1                        to rs-seq-item
                      move rs-seq-item             to ws-seq-item 
                 else
                      move 1                       to ws-seq-item 
                 end-if
                        
                 initialize                        rs-logradouro
                 move ws-seq-item                  to rs-seq-item
                 move f00600-id-logradouro         to rs-id-logradouro
                 move f00600-cep                   to rs-cep
                 move f00600-nome-logradouro       to rs-endereco
                 move f00500-nome-bairro           to rs-bairro
                 move f00400-nome-municipio        to rs-municipio
                 move f00300-sigla-estado          to rs-uf
                 move f00200-nome-pais             to rs-pais
                 write rs-logradouro
                 if   not ws-operacao-ok
                      rewrite rs-logradouro
                      if   not ws-operacao-ok
                           exit perform cycle
                      end-if
                 end-if     
                        
                 perform 9000-ler-pd00600-nex    
            end-perform

            initialize                             rs-logradouro
            move 999999                            to rs-seq-item
            start arq-logradouro key is not greater rs-seq-item
            read arq-logradouro previous
            
            if   rs-seq-item equal c-cep-nao-cadastrado
                 string "O CEP [" lk-cep "] não existe! Efetuar cadastro? [S/N]" into ws-mensagem 
                 perform 9000-mensagem
                      
                 if   ws-mensagem-opcao-sim
                      call c-cadastro-logradouros using lnk-par
                      cancel c-cadastro-logradouros
                 end-if             
            else
                 if   rs-seq-item equal c-cep-unico
                      initialize                   lk-logradouro
                      
                      set lk-encontrou-cep         to true
                      
                      move rs-id-logradouro        to lk-id-logradouro
                      move rs-cep                  to lk-cep
                      move rs-endereco             to lk-endereco
                      move rs-bairro               to lk-bairro
                      move rs-municipio            to lk-municipio
                      move rs-uf                   to lk-uf
                      move rs-pais                 to lk-pais
                 else
                      perform 9000-monta-screen-cep
                 end-if        
            end-if
   
            close arq-logradouro  

       exit.

      *>=================================================================================       
       9000-monta-screen-cep section.      
       
            perform 8000-limpa-tela    
            
            perform 8000-tela
            
            move 13                                to ws-nr-linha
            move 10                                to ws-nr-coluna
            
            initialize                             rs-logradouro
            start arq-logradouro key is greater rs-seq-item
            read arq-logradouro next
            perform until not ws-operacao-ok
            
                 move spaces                       to ws-linha-display
                 
                 string rs-seq-item " - "
                        rs-cep(01:05) "-"
                        rs-cep(06:03) " - "
                        rs-endereco " - "
                        rs-bairro " - "
                        rs-municipio " - "
                        rs-uf " - "
                        rs-pais " - " delimited by "  " into ws-linha-display
                 
                 display ws-linha-display at line ws-nr-linha col ws-nr-coluna
                 
                 add 02                            to ws-nr-linha         
            
                 read arq-logradouro next
            end-perform

            display "Informe a Sequencia:" at line 11 col 70
            
            perform until exit
                 
                 accept f-sequencia at line 11 col 91
                      
                 initialize                        rs-logradouro
                 move f-sequencia                  to rs-seq-item
                 read arq-logradouro
                 if   ws-operacao-ok
                      initialize                   lk-logradouro
                      
                      set lk-encontrou-cep         to true
                      
                      move rs-id-logradouro        to lk-id-logradouro
                      move rs-cep                  to lk-cep
                      move rs-endereco             to lk-endereco
                      move rs-bairro               to lk-bairro
                      move rs-municipio            to lk-municipio
                      move rs-uf                   to lk-uf
                      move rs-pais                 to lk-pais
                      exit perform   
                 end-if  
                       
            end-perform       
       exit.
              
      *>=================================================================================
       3000-finalizacao section.

            close pd00200
            close pd00300
            close pd00400
            close pd00500
            close pd00600      
       
       exit.                                                   
      *>=================================================================================
      *> Rotinas Genérias - Frame
 
       copy CSC00903.cpy. *> Frame


      *>=================================================================================
       8000-tela section.
            
            perform 9000-frame-padrao
            display frm-logradouro  
       
       exit. 
       
      *>=================================================================================
       8000-limpa-tela section.
       
            initialize                             f-logradouro
            
            perform 9000-frame-padrao
            display frm-logradouro
       
       exit.                               
      *>=================================================================================
      *> Rotinas Genérias
      

       copy CSP00900.cpy. *> Padrão
       
      *>=================================================================================
      *> Leituras
      
      *>=================================================================================
      *> Leituras
      
       copy CSR00200.cpy.
       copy CSR00300.cpy.
       copy CSR00400.cpy.
       copy CSR00500.cpy.
       copy CSR00600.cpy.         