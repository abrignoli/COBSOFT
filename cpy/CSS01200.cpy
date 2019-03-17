           select pd01200 assign to disk wid-pd01200
                organization        is indexed
                access mode         is dynamic
                record key          is f01200-chave = 
                                       f01200-cd-empresa                
                                       f01200-cd-filial
                                       f01200-id-usuario
                                       f01200-cd-perfil
                lock mode           is manual
                file status         is ws-resultado-acesso.
   
      


