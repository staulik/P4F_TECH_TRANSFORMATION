#language: pt
# utf-8


Funcionalidade: Cadastro de Usuarios
Eu como usuário quero me cadastrar no site para ter acesso as funcionalidades

Contexto: 
Dado que o usuário esteja na pagina de cadastro

@cad_user
Cenario: Cadastrar usuário
Quando ele executar o fluxo de cadastro
Então ele é direcionado para a area logada

