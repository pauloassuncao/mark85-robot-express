*** Settings ***
Documentation        Cenários de autenticação de usuários

Resource        ../resources/base.resource
Library         Collections

Test Setup        Start Sessions
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder logar com um usuario pré-cadastado

    ${user}        Create Dictionary
    ...            name=Paulo Assunção
    ...            email=paulo@hotmail.com
    ...            password=pwd123

    remove user from database        ${user}[email]
    insert user from database        ${user}

    Submit login form            ${user}
    User should be logged in     ${user}[name]

Não deve logar com senha inválida

    ${user}        Create Dictionary
    ...            name=Paulin Silva
    ...            email=paulin@msn.com
    ...            password=pwd123

    remove user from database        ${user}[email]
    insert user from database        ${user}

    Set To Dictionary        ${user}        password=123456

    Submit login form            ${user}
    Notice should be            Ocorreu um erro ao fazer login, verifique suas credenciais.