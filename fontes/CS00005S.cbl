      $set sourceformat"free"
       program-id. CS00005S.
      *>=================================================================================
      *>    
      *>                         Importação de Configurações
      *>
      *>=================================================================================
       environment division.
       configuration section.
            special-names. decimal-point is comma.
            
       copy CSS00000.cpy. *> Tabelas
       copy CSS00100.cpy. *> Módulos
       copy CSS00200.cpy. *> País
       copy CSS00300.cpy. *> Estados
       copy CSS00400.cpy. *> Cidades     
       copy CSS00500.cpy. *> Bairros
       copy CSS00600.cpy. *> Logradouros
       copy CSS00700.cpy. *> Empresas                     
       copy CSS00800.cpy. *> Usuários
       copy CSS00900.cpy. *> Usuários x Empresas
       copy CSS01000.cpy. *> Perfil
       copy CSS01100.cpy. *> Perfil x Módulo
       copy CSS01200.cpy. *> Perfil x Usuário
       copy CSS01300.cpy. *> Usuário x Módulos 
                                              
                                                                      
            select cobsoft-cfg assign to disk wid-cobsoftcfg
                 organization         is line sequential
                 access mode          is sequential
                 file status          is ws-resultado-acesso. 

      *>=================================================================================
       data division.

       copy CSF00000.cpy. *> Tabelas
       copy CSF00100.cpy. *> Módulos
       copy CSF00200.cpy. *> País
       copy CSF00300.cpy. *> Estados
       copy CSF00400.cpy. *> Cidades
       copy CSF00500.cpy. *> Bairros                           
       copy CSF00600.cpy. *> Logradouros
       copy CSF00700.cpy. *> Empresas                    
       copy CSF00800.cpy. *> Usuários
       copy CSF00900.cpy. *> Usuários x Empresas
       copy CSF01000.cpy. *> Perfil                       
       copy CSF01100.cpy. *> Perfil x Módulo
       copy CSF01200.cpy. *> Perfil x Usuário
       copy CSF01300.cpy. *> Usuário x Módulos
                                           
       fd   cobsoft-cfg.
       01   rs-cobsoft-cfg                         pic x(1000).        
      
      *>=================================================================================      
       working-storage section.
       
       78   c-versao                               value "a".
       78   c-este-programa                        value "CS00005S". 
       78   c-descricao-programa                   value "MENU PRINCIPAL".            

       copy CSW00900.cpy.
              
       01   ws-campos-trabalho.
            03 ws-alias-registro                   pic 9(03).
            03 ws-alias-registro-x                 pic x(03).
            03 ws-conte-registro                   pic x(997).
            03 ws-id-pais                          pic 9(09).
            03 ws-id-estado                        pic 9(09).
            03 ws-id-municipio                     pic 9(09).
            03 ws-id-bairro                        pic 9(09).
            03 ws-id-logradouro                    pic 9(09).     

       01   r01.
            03 r01-cd-programa-x                   pic x(08).
            03 r01-descricao-programa-x            pic x(55).

       01   r02.
            03 r02-programa-principal-x            pic x(08).
            03 r02-cd-programa-x                   pic x(08).
            03 r02-tipo-programa-x                 pic x(01).
            03 r02-operacao-programa-x             pic x(02).
            03 r02-descricao-programa-x            pic x(55).
            
       01   r03.
            03 r03-cd-pais-x                       pic x(04).
            03 r03-nome-pais-x                     pic x(55).  
                                  
       01   r04.
            03 r04-cd-estado-x                     pic x(02).
            03 r04-nome-estado-x                   pic x(55).
            03 r04-sigla-estado-x                  pic x(02).
            03 r04-cd-pais-x                       pic x(04).
            
       01   r05.            
            03 r05-cd-municipio-x                  pic x(07).
            03 r05-nome-municipio-x                pic x(55).
            03 r05-cd-estado-x                     pic x(02).
            03 r05-cd-pais-x                       pic x(04).
       
       01   r06.
            03 r06-cd-bairro-x                     pic x(10).
            03 r06-nome-bairro-x                   pic x(55).
            03 r06-cd-municipio-x                  pic x(07).
            03 r06-cd-estado-x                     pic x(02).
            03 r06-cd-pais-x                       pic x(04).

       01   r07.
            03 r07-cep-x                           pic x(08).
            03 r07-nome-logradouro-x               pic x(55).
            03 r07-cd-bairro-x                     pic x(10).
            03 r07-cd-municipio-x                  pic x(07).
            03 r07-cd-estado-x                     pic x(02).
            03 r07-cd-pais-x                       pic x(04).                        

       01   r08.
            03 r08-cd-empresa-x                    pic x(03).
            03 r08-cd-filial-x                     pic x(04).
            03 r08-razao-social-x                  pic x(55).
            03 r08-nome-fantasia-x                 pic x(55).
            03 r08-cnpj-x                          pic x(14).
            03 r08-ie-x                            pic x(11).
            03 r08-cep-x                           pic x(08).
            03 r08-cd-bairro-x                     pic x(10).
            03 r08-cd-municipio-x                  pic x(07).
            03 r08-cd-estado-x                     pic x(02).
            03 r08-cd-pais-x                       pic x(04).
            03 r08-nr-endereco-x                   pic x(10).
            03 r08-nr-telefone-1-x                 pic x(14).
            03 r08-nr-telefone-2-x                 pic x(14).
            03 r08-nr-telefone-3-x                 pic x(14).
            03 r08-email-x                         pic x(55).
            03 r08-id-status-x                     pic x(01). 

       01   r09.
            03 r09-id-usuario-x                    pic x(11).
            03 r09-pw-usuario-x                    pic x(15).
            03 r09-nome-usuario-x                  pic x(55).
            03 r09-data-nascimento-x               pic x(08).
            03 r09-sexo-x                          pic x(01).
            03 r09-email-x                         pic x(55).
            03 r09-id-perfil-especial              pic x(01).

       01   r10.
            03 r10-id-usuario-x                    pic x(11).
            03 r10-cd-empresa-x                    pic x(03).
            03 r10-cd-filial-x                     pic x(04).
            
       01   r11.
            03 r11-cd-perfil-x                     pic x(03).
            03 r11-descricao-perfil-x              pic x(55).            

       01   r12.
            03 r12-cd-perfil-x                     pic x(03).
            03 r12-cd-programa-x                   pic x(08).
            03 r12-id-consulta-x                   pic x(01).
            03 r12-id-inclusao-x                   pic x(01).
            03 r12-id-manutencao-x                 pic x(01).
            03 r12-id-exclusao-x                   pic x(01).

       01   r13.
            03 r13-cd-perfil-x                     pic x(03).
            03 r13-id-usuario-x                    pic x(11).
                         
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
             
            string lnk-dat-path delimited   by "  " "\EFD000.DAT" into wid-pd00000
            open i-o pd00000
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if

            string lnk-dat-path delimited   by "  " "\EFD001.DAT" into wid-pd00100
            open i-o pd00100
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if            
            
            string lnk-dat-path delimited   by "  " "\EFD002.DAT" into wid-pd00200
            open i-o pd00200
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if            

            string lnk-dat-path delimited   by "  " "\EFD003.DAT" into wid-pd00300
            open i-o pd00300
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if             
            
            string lnk-dat-path delimited   by "  " "\EFD004.DAT" into wid-pd00400
            open i-o pd00400
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if               

            string lnk-dat-path delimited   by "  " "\EFD005.DAT" into wid-pd00500
            open i-o pd00500
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if             

            string lnk-dat-path delimited   by "  " "\EFD006.DAT" into wid-pd00600
            open i-o pd00600
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if              

            string lnk-dat-path delimited   by "  " "\EFD007.DAT" into wid-pd00700
            open i-o pd00700
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if  

            string lnk-dat-path delimited   by "  " "\EFD008.DAT" into wid-pd00800
            open i-o pd00800
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if

            string lnk-dat-path delimited   by "  " "\EFD009.DAT" into wid-pd00900
            open i-o pd00900
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if

            string lnk-dat-path delimited   by "  " "\EFD010.DAT" into wid-pd01000
            open i-o pd01000
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if

            string lnk-dat-path delimited   by "  " "\EFD011.DAT" into wid-pd01100
            open i-o pd01100
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if 

            string lnk-dat-path delimited   by "  " "\EFD012.DAT" into wid-pd01200
            open i-o pd01200
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if             

            string lnk-dat-path delimited   by "  " "\EFD013.DAT" into wid-pd01300
            open i-o pd01300
            if   not ws-operacao-ok
            and  ws-resultado-acesso <> "05"
                 perform 9000-abortar
            end-if 
                                                                   
       exit.
        
      *>=================================================================================
       2000-processamento section.
            
            display "Inicializando base de dados. Aguarde..."
            
            *> A primeira importação irá impotar apenas o registgro 
            *> Contendo as empresas
            display "Importando empresas. Aguarde..."
            perform 2100-importar-registros

            
            *> Após importação das empresas, irá impotar os registros comuns
            *> entre elas
            initialize                             f00700-empresa
            perform 9000-str-pd00700-gtr
            perform 9000-ler-pd00700-nex
            perform until not ws-operacao-ok
                 move f00700-cd-empresa            to lnk-cd-empresa
                 move f00700-cd-filial             to lnk-cd-filial
                 
                 move spaces                       to ws-mensagem
                 string "Importando registros para empresa [" lnk-cd-empresa "." lnk-cd-filial "]" into ws-mensagem
                 display ws-mensagem
                  
                 perform 2100-importar-registros
            
                 perform 9000-ler-pd00700-nex
            end-perform                      
                  
       exit.
      *>=================================================================================
       2100-importar-registros section.
       
            move "..\configuracao\COBSOFT.CSV"     to wid-cobsoftcfg
            open input cobsoft-cfg
            read cobsoft-cfg next
            perform until not ws-operacao-ok
            
                 unstring rs-cobsoft-cfg delimited by "|"   into ws-alias-registro-x
                                                                 ws-conte-registro
                 
                 move function numval(ws-alias-registro-x)  to ws-alias-registro
                 
                 evaluate ws-alias-registro
                      when 1
                           perform 9000-registro-arquivos 
                      when 2
                           perform 9000-registro-modulos
                      when 3
                           perform 9000-registro-paises 
                      when 4
                           perform 9000-registro-estados
                      when 5
                           perform 9000-registro-municipios
                      when 6
                           perform 9000-registro-bairros
                      when 7
                           perform 9000-registro-logradouros
                      when 8
                           perform 9000-registro-empresas
                      when 9     
                           perform 9000-registro-usuarios
                      when 10
                           perform 9000-usuario-empresas     
                      when 11
                           perform 9000-registro-perfil
                      when 12
                           perform 9000-registro-perfil-modulo
                      when 13
                           perform 9000-registro-perfil-usuario                                                                  
                 end-evaluate                                                     
            
                 read cobsoft-cfg next
            end-perform
            close cobsoft-cfg 
       
       exit.
       
      *>=================================================================================
       3000-finalizacao section.
       
            close pd00000
            close pd00100
            close pd00200
            close pd00300
            close pd00400
            close pd00500
            close pd00600
            close pd00700
            close pd00800
            close pd00900
            close pd01000
            close pd01100
            close pd01200
       
       exit.
       
      *>=================================================================================
      *> Rotinas Genérias
      
       copy CSP00900.cpy. 
             
      *>=================================================================================
       9000-registro-arquivos section.
            
            initialize                                       r01
            
            unstring ws-conte-registro delimited by ";" into r01-cd-programa-x
                                                             r01-descricao-programa-x
                                                             
            initialize                                       f00000-programas
            move r01-cd-programa-x                           to f00000-cd-programa
            move r01-descricao-programa-x                    to f00000-descricao-programa
            perform 9000-gravar-pd00000
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00000
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00000-programas - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if
            
       exit.
         
      *>=================================================================================
       9000-registro-modulos section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if
                   
            initialize                                       r02
            
            unstring ws-conte-registro delimited by ";" into r02-programa-principal-x
                                                             r02-cd-programa-x
                                                             r02-tipo-programa-x
                                                             r02-operacao-programa-x
                                                             r02-descricao-programa-x
            
            initialize                                       f00100-modulos
            move lnk-cd-empresa                              to f00100-cd-empresa
            move lnk-cd-filial                               to f00100-cd-filial
            move r02-programa-principal-x                    to f00100-programa-principal
            move r02-cd-programa-x                           to f00100-cd-programa
            move r02-tipo-programa-x                         to f00100-tipo-programa
            move function numval(r02-operacao-programa-x)    to f00100-operacao-programa
            move r02-descricao-programa-x                    to f00100-descricao-programa
            perform 9000-gravar-pd00100
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00100
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00100-modulos - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if
            
       exit.
       
      *>=================================================================================
       9000-registro-paises section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if
            
            initialize                                       r03

            unstring ws-conte-registro delimited by ";" into r03-cd-pais-x
                                                             r03-nome-pais-x
                                                             
            initialize                                       f00200-pais
            move lnk-cd-empresa                              to f00200-cd-empresa
            move lnk-cd-filial                               to f00200-cd-filial
            move 999999999                                   to f00200-id-pais
            perform 9000-str-pd00200-ngrt
            perform 9000-ler-pd00200-pre
            if   ws-operacao-ok
            and  f00200-cd-empresa equal lnk-cd-empresa
            and  f00200-cd-filial  equal lnk-cd-filial
                 add 1                                       to f00200-id-pais
                 move f00200-id-pais                         to ws-id-pais
            else
                 move 1                                      to ws-id-pais                                            
            end-if                                                       
            
            initialize                                       f00200-pais
            move lnk-cd-empresa                              to f00200-cd-empresa
            move lnk-cd-filial                               to f00200-cd-filial
            move ws-id-pais                                  to f00200-id-pais
            move function numval(r03-cd-pais-x)              to f00200-cd-pais
            move r03-nome-pais-x                             to f00200-nome-pais           
            perform 9000-gravar-pd00200
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00200
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00200-pais [" f00200-pais "] - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if       
       exit.
       
      *>=================================================================================
       9000-registro-estados section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if
       
            initialize                                       r04
            
            unstring ws-conte-registro delimited by ";" into r04-cd-estado-x
                                                             r04-nome-estado-x
                                                             r04-sigla-estado-x
                                                             r04-cd-pais-x                                                                           

            initialize                                       f00200-pais
            move lnk-cd-empresa                              to f00200-cd-empresa
            move lnk-cd-filial                               to f00200-cd-filial
            move function numval(r04-cd-pais-x)              to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if

            initialize                                       f00300-estado
            move lnk-cd-empresa                              to f00300-cd-empresa
            move lnk-cd-filial                               to f00300-cd-filial
            move 999999999                                   to f00300-id-estado
            perform 9000-str-pd00300-ngrt
            perform 9000-ler-pd00300-pre
            if   ws-operacao-ok
            and  f00300-cd-empresa equal lnk-cd-empresa
            and  f00300-cd-filial  equal lnk-cd-filial
                 add 1                                       to f00300-id-estado
                 move f00300-id-estado                       to ws-id-estado
            else
                 move 1                                      to ws-id-estado                                            
            end-if
                                                                         
            initialize                                       f00300-estado
            move lnk-cd-empresa                              to f00300-cd-empresa
            move lnk-cd-filial                               to f00300-cd-filial
            move ws-id-estado                                to f00300-id-estado
            move function numval(r04-cd-estado-x)            to f00300-cd-estado
            move r04-nome-estado-x                           to f00300-nome-estado
            move r04-sigla-estado-x                          to f00300-sigla-estado
            move f00200-id-pais                              to f00300-id-pais          
            perform 9000-gravar-pd00300
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00300
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00300-estado - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if                                                                            
       
       exit.
       
      *>=================================================================================
       9000-registro-municipios section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if
       
            initialize                                       r05

            unstring ws-conte-registro delimited by ";" into r05-cd-municipio-x
                                                             r05-nome-municipio-x
                                                             r05-cd-estado-x
                                                             r05-cd-pais-x
            
            initialize                                       f00200-pais
            move lnk-cd-empresa                              to f00200-cd-empresa
            move lnk-cd-filial                               to f00200-cd-filial
            move function numval(r05-cd-pais-x)              to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if

            initialize                                       f00300-estado
            move lnk-cd-empresa                              to f00300-cd-empresa
            move lnk-cd-filial                               to f00300-cd-filial
            move f00200-id-pais                              to f00300-id-pais
            move function numval(r05-cd-estado-x)            to f00300-cd-estado
            perform 9000-ler-pd00300-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if                                          

            initialize                                       f00400-municipio
            move lnk-cd-empresa                              to f00400-cd-empresa
            move lnk-cd-filial                               to f00400-cd-filial
            move 999999999                                   to f00400-id-municipio
            perform 9000-str-pd00400-ngrt
            perform 9000-ler-pd00400-pre
            if   ws-operacao-ok
            and  f00400-cd-empresa equal lnk-cd-empresa
            and  f00400-cd-filial  equal lnk-cd-filial
                 add 1                                       to f00400-id-municipio
                 move f00400-id-municipio                    to ws-id-municipio
            else
                 move 1                                      to ws-id-municipio                                            
            end-if
                                                             
            initialize                                       f00400-municipio
            move lnk-cd-empresa                              to f00400-cd-empresa
            move lnk-cd-filial                               to f00400-cd-filial
            move ws-id-municipio                             to f00400-id-municipio
            move function numval(r05-cd-municipio-x)         to f00400-cd-municipio
            move r05-nome-municipio-x                        to f00400-nome-municipio
            move f00300-id-estado                            to f00400-id-estado
            perform 9000-gravar-pd00400
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00400
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00400-municipio - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if 
                                                                      
       exit.
             
      *>=================================================================================
       9000-registro-bairros section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if

            initialize                                       r06

            unstring ws-conte-registro delimited by ";" into r06-cd-bairro-x
                                                             r06-nome-bairro-x
                                                             r06-cd-municipio-x 
                                                             r06-cd-estado-x
                                                             r06-cd-pais-x      

            initialize                                       f00200-pais
            move lnk-cd-empresa                              to f00200-cd-empresa
            move lnk-cd-filial                               to f00200-cd-filial
            move function numval(r06-cd-pais-x)              to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if

            initialize                                       f00300-estado
            move lnk-cd-empresa                              to f00300-cd-empresa
            move lnk-cd-filial                               to f00300-cd-filial
            move f00200-id-pais                              to f00300-id-pais
            move function numval(r06-cd-estado-x)            to f00300-cd-estado
            perform 9000-ler-pd00300-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if                                          

            initialize                                       f00400-municipio
            move lnk-cd-empresa                              to f00400-cd-empresa
            move lnk-cd-filial                               to f00400-cd-filial
            move f00300-id-estado                            to f00400-id-estado
            move function numval(r06-cd-municipio-x)         to f00400-cd-municipio
            perform 9000-ler-pd00400-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if 

            initialize                                       f00500-bairro
            move lnk-cd-empresa                              to f00500-cd-empresa
            move lnk-cd-filial                               to f00500-cd-filial
            move 999999999                                   to f00500-id-bairro
            perform 9000-str-pd00500-ngrt
            perform 9000-ler-pd00500-pre
            if   ws-operacao-ok
            and  f00500-cd-empresa equal lnk-cd-empresa
            and  f00500-cd-filial  equal lnk-cd-filial
                 add 1                                       to f00500-id-bairro
                 move f00500-id-bairro                       to ws-id-bairro
            else
                 move 1                                      to ws-id-bairro                                            
            end-if

            initialize                                       f00500-bairro
            move lnk-cd-empresa                              to f00500-cd-empresa
            move lnk-cd-filial                               to f00500-cd-filial
            move ws-id-bairro                                to f00500-id-bairro
            move function numval(r06-cd-bairro-x)            to f00500-cd-bairro
            move r06-nome-bairro-x                           to f00500-nome-bairro
            move f00400-id-municipio                         to f00500-id-municipio
            perform 9000-gravar-pd00500
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00500
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00500-bairro - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if
                    
       exit.
      
      *>=================================================================================
       9000-registro-logradouros section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if

            initialize                                       r07
            
            unstring ws-conte-registro delimited by ";" into r07-cep-x
                                                             r07-nome-logradouro-x
                                                             r07-cd-bairro-x
                                                             r07-cd-municipio-x
                                                             r07-cd-estado-x
                                                             r07-cd-pais-x

            initialize                                       f00200-pais
            move lnk-cd-empresa                              to f00200-cd-empresa
            move lnk-cd-filial                               to f00200-cd-filial
            move function numval(r07-cd-pais-x)              to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if

            initialize                                       f00300-estado
            move lnk-cd-empresa                              to f00300-cd-empresa
            move lnk-cd-filial                               to f00300-cd-filial
            move f00200-id-pais                              to f00300-id-pais
            move function numval(r07-cd-estado-x)            to f00300-cd-estado
            perform 9000-ler-pd00300-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if                                          

            initialize                                       f00400-municipio
            move lnk-cd-empresa                              to f00400-cd-empresa
            move lnk-cd-filial                               to f00400-cd-filial
            move f00300-id-estado                            to f00400-id-estado
            move function numval(r07-cd-municipio-x)         to f00400-cd-municipio
            perform 9000-ler-pd00400-ran-1
            if   not ws-operacao-ok
                 exit section
            end-if 

            initialize                                       f00500-bairro
            move lnk-cd-empresa                              to f00500-cd-empresa
            move lnk-cd-filial                               to f00500-cd-filial
            move f00400-id-municipio                         to f00500-id-municipio
            move function numval(r07-cd-bairro-x)            to f00500-cd-bairro
            perform 9000-ler-pd00500-ran-1                                    
            if   not ws-operacao-ok
                 exit section
            end-if                                                              

            initialize                                       f00600-logradouro
            move lnk-cd-empresa                              to f00600-cd-empresa
            move lnk-cd-filial                               to f00600-cd-filial
            move 999999999                                   to f00600-id-logradouro
            perform 9000-str-pd00600-ngrt
            perform 9000-ler-pd00600-pre
            if   ws-operacao-ok
            and  f00600-cd-empresa equal lnk-cd-empresa
            and  f00600-cd-filial  equal lnk-cd-filial
                 add 1                                       to f00600-id-logradouro
                 move f00600-id-logradouro                   to ws-id-logradouro
            else
                 move 1                                      to ws-id-logradouro                                            
            end-if
                                                              
            initialize                                       f00600-logradouro
            move lnk-cd-empresa                              to f00600-cd-empresa
            move lnk-cd-filial                               to f00600-cd-filial
            move ws-id-logradouro                            to f00600-id-logradouro
            move function numval(r07-cep-x)                  to f00600-cep
            move r07-nome-logradouro-x                       to f00600-nome-logradouro
            move f00500-id-bairro                            to f00600-id-bairro
            perform 9000-gravar-pd00600
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00600
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00600-logradouro - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if                                                                                
       exit.       

      *>=================================================================================
       9000-registro-empresas section. 

            initialize                                       r08
            
            unstring ws-conte-registro delimited by ";" into r08-cd-empresa-x
                                                             r08-cd-filial-x
                                                             r08-razao-social-x
                                                             r08-nome-fantasia-x
                                                             r08-cnpj-x
                                                             r08-ie-x
                                                             r08-cep-x
                                                             r08-cd-bairro-x
                                                             r08-cd-municipio-x
                                                             r08-cd-estado-x
                                                             r08-cd-pais-x
                                                             r08-nr-endereco-x
                                                             r08-nr-telefone-1-x
                                                             r08-nr-telefone-2-x
                                                             r08-nr-telefone-3-x
                                                             r08-email-x
                                                             r08-id-status-x
                                                             
            initialize                                       f00200-pais
            move function numval(r08-cd-empresa-x)           to f00200-cd-empresa
            move function numval(r08-cd-filial-x)            to f00200-cd-filial
            move function numval(r08-cd-pais-x)              to f00200-cd-pais
            perform 9000-ler-pd00200-ran-1
            if   not ws-operacao-ok
                 continue
            end-if

            initialize                                       f00300-estado
            move function numval(r08-cd-empresa-x)           to f00300-cd-empresa
            move function numval(r08-cd-filial-x)            to f00300-cd-filial
            move f00200-id-pais                              to f00300-id-pais
            move function numval(r08-cd-estado-x)            to f00300-cd-estado
            perform 9000-ler-pd00300-ran-1
            if   not ws-operacao-ok
                 continue
            end-if                                          

            initialize                                       f00400-municipio
            move function numval(r08-cd-empresa-x)           to f00400-cd-empresa
            move function numval(r08-cd-filial-x)            to f00400-cd-filial
            move f00300-id-estado                            to f00400-id-estado
            move function numval(r08-cd-municipio-x)         to f00400-cd-municipio
            perform 9000-ler-pd00400-ran-1
            if   not ws-operacao-ok
                 continue
            end-if 

            initialize                                       f00500-bairro
            move function numval(r08-cd-empresa-x)           to f00500-cd-empresa
            move function numval(r08-cd-filial-x)            to f00500-cd-filial
            move f00400-id-municipio                         to f00500-id-municipio
            move function numval(r08-cd-bairro-x)            to f00500-cd-bairro
            perform 9000-ler-pd00500-ran-1                                    
            if   not ws-operacao-ok
                 continue
            end-if
            
            initialize                                       f00600-logradouro
            move function numval(r08-cd-empresa-x)           to f00600-cd-empresa
            move function numval(r08-cd-filial-x)            to f00600-cd-filial
            move f00500-id-bairro                            to f00600-id-bairro
            move function numval(r08-cep-x)                  to f00600-cep
            perform 9000-ler-pd00600-ran-1                                    
            if   not ws-operacao-ok
                 continue
            end-if                                                                                                                                       
                                                             
            initialize                                       f00700-empresa
            move function numval(r08-cd-empresa-x)           to f00700-cd-empresa
            move function numval(r08-cd-filial-x)            to f00700-cd-filial
            move r08-razao-social-x                          to f00700-razao-social
            move r08-nome-fantasia-x                         to f00700-nome-fantasia
            move function numval(r08-cnpj-x)                 to f00700-cnpj
            move r08-ie-x                                    to f00700-ie
            move f00600-id-logradouro                        to f00700-id-logradouro
            move r08-nr-endereco-x                           to f00700-nr-endereco
            move function numval(r08-nr-telefone-1-x)        to f00700-nr-telefone-1
            move function numval(r08-nr-telefone-2-x)        to f00700-nr-telefone-2
            move function numval(r08-nr-telefone-3-x)        to f00700-nr-telefone-3
            move r08-email-x                                 to f00700-email
            move r08-id-status-x                             to f00700-id-status
            perform 9000-gravar-pd00700
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00700
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00700-empresa - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if                
       
       exit.     
      *>=================================================================================
       9000-registro-usuarios section.

            initialize                                       r09
            
            unstring ws-conte-registro delimited by ";" into r09-id-usuario-x
                                                             r09-pw-usuario-x
                                                             r09-nome-usuario-x
                                                             r09-data-nascimento-x
                                                             r09-sexo-x
                                                             r09-email-x
                                                             r09-id-perfil-especial
            
            initialize                                       f00800-usuario
            move function numval(r09-id-usuario-x)           to f00800-id-usuario
            move r09-pw-usuario-x                            to f00800-pw-usuario
            move r09-nome-usuario-x                          to f00800-nome-usuario
            move function numval(r09-data-nascimento-x)      to ws-data
            move ws-dia                                      to ws-dia-inv                                                                                           
            move ws-mes                                      to ws-mes-inv   
            move ws-ano                                      to ws-ano-inv
            move ws-data-inv                                 to f00800-data-nascimento
            move r09-sexo-x                                  to f00800-sexo
            move r09-email-x                                 to f00800-email
            set  f00800-permite-atribuir-acesso              to true
            set  f00800-ativo                                to true
            set  f00800-trocar-senha                         to true
            move r09-id-perfil-especial                      to f00800-id-perfil-especial
            accept ws-data-inv                               from date yyyymmdd
            move ws-data-inv                                 to f00800-data-criacao
            accept ws-horas                                  from time
            move ws-horas                                    to f00800-hora-criacao
            perform 9000-gravar-pd00800
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00800
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00800-usuario - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if             
                     
       exit.
       
      *>================================================================================= 
       9000-usuario-empresas section.
       
            initialize                                       r10
            
            unstring ws-conte-registro delimited by ";" into r10-id-usuario-x
                                                             r10-cd-empresa-x
                                                             r10-cd-filial-x
                                                             
            initialize                                       f00900-usuario-empresa
            move function numval(r10-id-usuario-x)           to f00900-id-usuario
            move function numval(r10-cd-empresa-x)           to f00900-cd-empresa
            move function numval(r10-cd-filial-x)            to f00900-cd-filial
            perform 9000-gravar-pd00900
            if   not ws-operacao-ok
                 perform 9000-regravar-pd00900
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f00900-usuario-empresa - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if     
       
       exit.

      *>=================================================================================
       9000-registro-perfil section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if
                   
            initialize                                       r11
            
            unstring ws-conte-registro delimited by ";" into r11-cd-perfil-x
                                                             r11-descricao-perfil-x
                                                             
            initialize                                       f01000-perfil
            move lnk-cd-empresa                              to f01000-cd-empresa
            move lnk-cd-filial                               to f01000-cd-filial
            move function numval(r11-cd-perfil-x)            to f01000-cd-perfil
            move r11-descricao-perfil-x                      to f01000-descricao-perfil
            perform 9000-gravar-pd01000
            if   not ws-operacao-ok
                 perform 9000-regravar-pd01000
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f01000-perfil - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if 
                  
       exit. 
       
      *>=================================================================================
       9000-registro-perfil-modulo section.
       
            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if
                   
            initialize                                       r12
            
            unstring ws-conte-registro delimited by ";" into r12-cd-perfil-x
                                                             r12-cd-programa-x
                                                             r12-id-consulta-x
                                                             r12-id-inclusao-x
                                                             r12-id-manutencao-x
                                                             r12-id-exclusao-x

            initialize                                       f01100-perfil-modulo
            move lnk-cd-empresa                              to f01100-cd-empresa
            move lnk-cd-filial                               to f01100-cd-filial
            move function numval(r12-cd-perfil-x)            to f01100-cd-perfil
            move r12-cd-programa-x                           to f01100-cd-programa
            move r12-id-consulta-x                           to f01100-id-consulta
            move r12-id-inclusao-x                           to f01100-id-inclusao
            move r12-id-manutencao-x                         to f01100-id-manutencao
            move r12-id-exclusao-x                           to f01100-id-exclusao
            perform 9000-gravar-pd01100
            if   not ws-operacao-ok
                 perform 9000-regravar-pd01100
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f01100-perfil-modulo - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if 
    
       
       exit.  
        
      *>=================================================================================
       9000-registro-perfil-usuario section.

            if   lnk-cd-empresa equal zeros
            or   lnk-cd-filial equal zeros
                 exit section
            end-if
                   
            initialize                                       r13
            
            unstring ws-conte-registro delimited by ";" into r13-cd-perfil-x
                                                             r13-id-usuario-x
                                                             
            initialize                                       f00900-usuario-empresa
            move lnk-cd-empresa                              to f00900-cd-empresa
            move lnk-cd-filial                               to f00900-cd-filial            
            move function numval(r13-id-usuario-x)           to f00900-id-usuario
            perform 9000-ler-pd00900-ran
            if   not ws-operacao-ok
                 exit section
            end-if           
            
            initialize                                       f01200-usuario-perfil
            move lnk-cd-empresa                              to f01200-cd-empresa
            move lnk-cd-filial                               to f01200-cd-filial
            move function numval(r13-cd-perfil-x)            to f01200-cd-perfil
            move function numval(r13-id-usuario-x)           to f01200-id-usuario
            perform 9000-gravar-pd01200
            if   not ws-operacao-ok
                 perform 9000-regravar-pd01200
                 if   not ws-operacao-ok
                      string "Erro ao gravar registro f01200-usuario-perfil - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem
                      perform 9000-abortar
                 end-if             
            end-if
            
            *> Víncula usuário ao módulo
            
            initialize                                       f01100-perfil-modulo
            move lnk-cd-empresa                              to f01100-cd-empresa
            move lnk-cd-filial                               to f01100-cd-filial
            move f01200-cd-perfil                            to f01100-cd-perfil
            perform 9000-str-pd01100-gtr
            perform 9000-ler-pd01100-nex
            perform until not ws-operacao-ok
                 or f01100-cd-empresa <> lnk-cd-empresa
                 or f01100-cd-filial  <> lnk-cd-filial
                 or f01100-cd-perfil  <> f01200-cd-perfil
                 
                 initialize                                  f01300-usuario-modulo
                 move lnk-cd-empresa                         to f01300-cd-empresa
                 move lnk-cd-filial                          to f01300-cd-filial
                 move f01200-id-usuario                      to f01300-id-usuario
                 move f01100-cd-programa                     to f01300-cd-programa
                 perform 9000-ler-pd01300-ran
                 if  not ws-operacao-ok
                 and not ws-registro-inexistente    
                      string "Erro de leitura f01300-usuario-modulo - Status [" ws-resultado-acesso "]" into ws-mensagem
                      perform 9000-mensagem 
                      perform 9000-abortar                
                 end-if
                 
                 if   f01100-permite-consulta
                      set f01300-permite-consulta            to true
                 end-if
                 
                 if   f01100-permite-inclusao                                     
                      set f01300-permite-inclusao            to true 
                 end-if
                 
                 if   f01100-permite-manutencao
                      set f01300-permite-manutencao          to true
                 end-if
                 
                 if   f01100-permite-exclusao
                      set f01300-permite-exclusao            to true
                 end-if
                 
                 perform 9000-regravar-pd01300
                 if   not ws-operacao-ok
                      perform 9000-gravar-pd01300
                      if   not ws-operacao-ok
                           string "Erro de gravação f01300-usuario-modulo - Status [" ws-resultado-acesso "]" into ws-mensagem
                           perform 9000-mensagem
                           perform 9000-abortar                             
                      end-if
                 end-if
                  
                 perform 9000-ler-pd01100-nex
            end-perform                                                                           
       
       exit.                                                                                          
      *>=================================================================================
      *> Leituras

       copy CSR00000.cpy. *> Tabelas       
       copy CSR00100.cpy. *> Módulos
       copy CSR00200.cpy. *> País
       copy CSR00300.cpy. *> Estados
       copy CSR00400.cpy. *> Cidades
       copy CSR00500.cpy. *> Bairros
       copy CSR00600.cpy. *> Logradouros
       copy CSR00700.cpy. *> Empresas
       copy CSR00800.cpy. *> Usuários
       copy CSR00900.cpy. *> Usuários x Empresas
       copy CSR01000.cpy. *> Perfil
       copy CSR01100.cpy. *> Perfil x Módulo
       copy CSR01200.cpy. *> Perfil x Usuário
       copy CSR01300.cpy. *> Usuário x Módulos                                                                            