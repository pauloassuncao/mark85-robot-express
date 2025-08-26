*** Settings ***
Documentation        Ações e elementos da página de cadastro de tarefas

Library        Browser

*** Keywords ***
Submit task form
    [Arguments]        ${task} 

    Fill Text        css=input[placeholder$=tarefa]        ${task}[name]

#Criando uma variavel tags com o locator de tags para reutilizar o código
    ${tags_element}        Set Variable        css=input[name=tags]

#Sleep de Thinking Time para simular o tempo de digitação do usuário
#For para percorrer um array de fixtures para preencher o campo de tags
    FOR    ${tag}    IN    @{task}[tags]
         Fill Text        ${tags_element}        ${tag}
         Sleep            1
         Press Keys       ${tags_element}        Enter

    END
    


    Click    css=button >> text=Cadastrar