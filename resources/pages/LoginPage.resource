*** Settings ***
Documentation        Ações e elementos da página de login

Library        Browser
Library        String

*** Keywords ***
Submit login form
    [Arguments]        ${user}

# o $ é uma expressão regular que busca um elemento input curo placeholder TERMINA COM Mail
    Fill Text        css=input[placeholder$=mail]    ${user}[email]
    Fill Text        css=input[placeholder=Senha]         ${user}[password]

#Busca pelo elemento sendo feita pelo Xpath que procura o button e o texto
    #Click        xpath=//button[text()="Entrar"]

#Combinação de seletor CSS com texto do elemento
    Click        css=button >> text=Entrar



