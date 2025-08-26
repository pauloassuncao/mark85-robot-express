*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

#Library        FakerLibrary

Resource       ../resources/base.resource

#Suite Setup        Log    Tudo aqui ocorre antes da Suite (antes de todos os testes)
#Suite Teardown     Log    Tudo aqui ocorre depois da Suite (depois de todos os testes)

Test Setup        Start Sessions
Test Teardown     Take Screenshot

*** Variables ***
${name}            Paulo Assunção
${email}           pauloserial@hotmail.com
${password}        pwd123

*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}        Create Dictionary
    ...    name=Paulo Assunção
    ...    email=pauloserial@hotmail.com
    ...    password=pwd123

    #${name}            FakerLibrary.Name
   # ${email}           FakerLibrary.Free Email
    #${name}            Set Variable        Paulo Assunção
    #${email}           Set Variable        pauloserial@hotmail.com
    #${password}        Set Variable        pwd123

    remove user from database    ${user}[email]

    Go to signup page
    Submit signup form        ${user}
    Notice should be          Boas vindas ao Mark85, o seu gerenciador de tarefas.




Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}        Create Dictionary
    ...    name=Assunção Paulo
    ...    email=paulo@hotmail.com
    ...    password=pwd123


    remove user from database    ${user}[email]
    insert user from database    ${user}


    Go to signup page
    Submit signup form      ${user}
    Notice should be        Oops! Já existe uma conta com o e-mail informado.


Campos obrigatórios
    [Tags]    required

    ${user}        Create Dictionary
    ...            name=${EMPTY}
    ...            email=${EMPTY}
    ...            password=${EMPTY}

    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos


Não deve cadastrar com emal ncorreto
    [Tags]    inv_email

    ${user}        Create Dictionary
    ...            name=Chales Xaver
    ...            email=xavier.com.br
    ...            password=123456

    Go to signup page
    Submit signup form    ${user}
    Alert should be       Digite um e-mail válido


Não deve cadastrar com senha muito curta
    [Tags]    temp

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
    ${user}        Create Dictionary
    ...            name=Paulo Assunção
    ...            email=paulo@msn.com
    ...            password=${password}

    Go to signup page
    Submit signup form        ${user}
    Alert should be           Informe uma senha com pelo menos 6 digitos
        
    END
    


Não deve cadastrar com senha de 1 digito
    [Tags]    short_pass
    [Template]
    Short Password    1

Não deve cadastrar com senha de 2 digito
    [Tags]    short_pass
    [Template]
    Short Password    12

Não deve cadastrar com senha de 3 digito
    [Tags]    short_pass
    [Template]
    Short Password    123

Não deve cadastrar com senha de 4 digito
    [Tags]    short_pass
    [Template]
    Short Password    1234

Não deve cadastrar com senha de 5 digito
    [Tags]    short_pass
    [Template]
    Short Password    12345

*** Keywords ***

Short Password
    [Arguments]        ${short_pass}

    ${user}        Create Dictionary
    ...            name=Paulo Assunção
    ...            email=paulo@msn.com
    ...            password=${short_pass}

    Go to signup page
    Submit signup form        ${user}
    Alert should be           Informe uma senha com pelo menos 6 digitos