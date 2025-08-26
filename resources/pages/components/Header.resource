*** Settings ***
Documentation        Ações e elementos do cabeçalho do Mark85

Library        Browser
Library        String

*** Keywords ***

User should be logged in
    [Arguments]        ${name}

    #Transformando o nome em strng, splitando ele e guardando numa variavel para reutilizar
    @{splited_name}   Split String        ${name}

    Log    ${splited_name}
    
    #Transformando o elemento em variavel para economizar codigo chamando o elemento
    ${element}        Set Variable        css=header .right small

    #Garante que o elemento esteja visível
    Wait For Elements State        css=header .right small
    ...    visible    5

                                                 #Splita o nome e pega o nome da primeira posição
    Get Text        ${element}        equal        Olá, ${splited_name}[0]


Go to task form
    
    Click    css=.button-add