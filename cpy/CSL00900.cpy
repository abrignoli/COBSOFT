      *>=================================================================================
      *>    
      *>                          Linkage Padrão - Sistema
      *>
      *>=================================================================================
      
       01   lnk-par.
            03 lnk-opcao                           pic 9(002).
               88 lnk-carregar-diretorios              value 01.
               88 lnk-carregar-prametros               value 02.
               88 lnk-carregar-completa                value 03.
            03 lnk-status                          pic 9(002).
               88 lnk-sem-erros                        value 00.
               88 lnk-com-warning                      value 01.
               88 lnk-com-erros                        value 02.
            03 lnk-path.
               05 lnk-cgi-path                     pic x(200).
               05 lnk-dat-path                     pic x(200).
               05 lnk-tmp-path                     pic x(200).
               05 lnk-int-path                     pic x(200).
               05 lnk-dvs-path                     pic x(200).
               05 lnk-log-path                     pic x(200).
               05 lnk-nfe-path                     pic x(200).
            03 lnk-empresa.
               05 lnk-cd-empresa                   pic 9(003).
               05 lnk-cd-filial                    pic 9(004).
               05 lnk-cnpj                         pic 9(014).
               05 lnk-razao-social                 pic x(060).
               05 lnk-nome-fantasia                pic x(060).
            03 lnk-usuario.
               05 lnk-id-usuario                   pic x(011).
               05 lnk-pw-usuario                   pic x(015).
               05 lnk-nome-usuario                 pic x(060).
               05 lnk-status-usuario               pic x(001).
                  88 lnk-usuario-ativo                  value "A".
                  88 lnk-usuario-bloqueado              value "B".
                  88 lnk-usuario-inativo                value "I".
               05 lnk-id-login-master              pic x(001).
                  88 lnk-login-master                   value "M".    
            03 lnk-informacoes-programa.
               05 lnk-cd-programa                  pic x(008).
               05 lnk-vs-programa                  pic x(001).
               05 lnk-ds-programa                  pic x(116).
               05 lnk-ds-funcao                    pic x(116). 
               05 lnk-id-consulta                  pic x(01).
                  88 lnk-permite-consulta               value "S".
                  88 lnk-nao-permite-consulta           value "N".
               05 lnk-id-inclusao                  pic x(01).
                  88 lnk-permite-inclusao               value "S".
                  88 lnk-nao-permite-inclusao           value "N".
               05 lnk-id-manutencao                pic x(01).
                  88 lnk-permite-manutencao             value "S".
                  88 lnk-nao-permite-manutencao         value "N".
               05 lnk-id-exclusao                  pic x(01).
                  88 lnk-permite-exclusao               value "S".
                  88 lnk-nao-permite-exclusao           value "N".                
            03 lnk-sistema-operacional.
               05 lnk-data-so                      pic 9(008).
               05 filler redefines lnk-data-so.
                  07 lnk-dia-os                    pic 9(002).
                  07 lnk-mes-os                    pic 9(002).
                  07 lnk-ano-os                    pic 9(004).
               05 lnk-nome-computador              pic x(060).
               05 lnk-ambiente                     pic x(003).
                  88 lnk-desenvolvimento               value "DSV".
                  88 lnk-homologacao                   value "HML".
                  88 lnk-producao                      value "PRD".
            03 lnk-ctrl-execucao                   pic x(001).
               88 lnk-execucao-foreground              value " ".
               88 lnk-execucao-background              value "B".
            03 lnk-linha-comando                   pic x(500).
            03 lnk-parametros-emissao.
               05 lnk-numero-documento             pic 9(09).
               05 lnk-serie-documento              pic 9(03).

