#language: pt
# utf-8


Funcionalidade: Acessar a area logada
Eu como quero acessar a area logada com meu login previamente cadastrado

Contexto: 
Dado que o usuário esteja na pagina de Login


@login_invalido
Esquema do Cenário: Logar com credenciais invalidas
Quando fornecer "<email>" ou "<senha>" inválidos
Então ele visualiza a mensagem de alerta "<msg_alerta>"

Exemplos:
|          email            |    senha    |     msg_alerta    |
|   silvio.tester@p4f.com   |    1234     |  There is 1 error |
|   tester                  |             |  There is 1 error |
|   silvio.testep4f.com     |  123456     |  There is 1 error |
|                           |             |  There is 1 error |


@user_inexistente
Cenário: Usuario não cadastrado
Quando fornecer login inexistente
Então seu acesso não é liberado



@user_existente
Cenario: Logar com usuário válido
Quando as informacoes validas forem fornecidas
Então o usuario pode ver que esta logado