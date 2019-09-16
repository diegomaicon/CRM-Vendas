# CRM-Vendas
 Protótipo mini sistema de CRM de Vendas.

Embarcadero® Delphi 10.2


1 - Configuração de Conexão do DB ConfigDB.ini, deve estar junto do executável.


Regras

* Scoring (mínimo de 150 pontos): Leads interessados e com perfil ideal devem ser encaminhados para a equipe de vendas.
* Scoring (mínimo de 100 pontos): Leads interessados, necessita mais interações.
* Scoring (mínimo de 50 pontos):  Leads desinteressados   


Cálculo Scoring.
        (Cargo * 10) * Tipo Atividade;
        
       ** Cargo
           * Proprietário/Socio = 3;
           * Gerente de Compra  = 2;
           * Secretário/Funcionário = 1;
           
        ** Tipo Atividade
            * Ligação = 2
            * Visita  = 4
            * Email   = 1
            * Outros  = 1
           
        
 
