*** Settings ***
Documentation        Cenários de tentativa de cadastro com senha muito curta

Resource            ../resources/base.resource
Test Template       Short Password

Test Setup        Start Sessions
Test Teardown     Take Screenshot

*** Test Cases ***
#Cenários variantes utilizando Page Object para simplificar a escrita e otimizar o código com Keyword personalizada
Não deve logar com senha de 1 digito    1

Não deve logar com senha de 2 digitos    12

Não deve logar com senha de 3 digitos    123

Não deve logar com senha de 4 digitos    1234

Não deve logar com senha de 5 digitos    12345








*** Keywords ***
#Palavra chave que utilizo para referenciar os cenarios variantes acima

Short Password
    [Arguments]        ${short_pass}
    #Argument é usado para definir uma variavel que vou utilizar de argumento foa deste escopo (Ex. a short_pass são as senhas variaveis dos cenarios acma)

    ${user}        Create Dictionary
    ...            name=Paulo Assunção
    ...            email=paulo@msn.com
    ...            password=${short_pass}

    Go to signup page
    Submit signup form        ${user}
    Alert should be           Informe uma senha com pelo menos 6 digitos