#language: pt

Funcionalidade: Cadastro de usuários

@post
Cenário: Cadastro de novo usuário
    Dado que eu tenho um novo usuário
    Quando faco o cadastro
    Então o código de resposta deve ser "200"
        E vejo este usuário cadastrado no sistema
