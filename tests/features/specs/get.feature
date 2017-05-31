#language: pt

Funcionalidade: Consulta de usuários

Cenario: Obter lista de usuários

    Quando faço uma consulta
    Então o código de resposta deve ser "200" 
        E o sistema retorna uma lista de usuarios cadastrados


Cenario: Obter um unico usuario

    Dado que eu tenho um usuário cadastrado
    Então faço a consulta desse usuário 
    Então o código de resposta deve ser "200" 
        E o sistema retorna os dados desse usuario


Cenario: Usuário não cadastrado

    Dado que o usuário não está cadastrado
    Quando faço a consulta desse usuário
    Então o código de resposta deve ser "404"
        E vejo a mensagem "Usuário não encontrado!"


Cenario: Consulta por email do usuário
    Dado que eu tenho um usuário cadastrado
    Então faço a consulta desse usuário por email
    Então o código de resposta deve ser "200" 
        E o sistema retorna os dados desse usuario
