*** Settings ***
Documentation    Testes de consulta no buscador Google.
...              Abre o navergador Chrome
...              e realiza a consulta.

Library  SeleniumLibrary


*** Test Cases ***
Consulta Google
    [Tags]     rapido
    Acessar o Chrome na pagina <https://www.google.com.br>
    Digitar "Ovos de Páscoa" na pesquisa
    Validar se aparece no título da guia o resultado esperado
    Fechar o browser

*** Keywords ***


Acessar o ${browser} na pagina <${url}>
    open browser  ${url}        ${browser}

Digitar ${palavra_chave} na pesquisa
    Set Test Variable  ${palavra_chave}
    input text      name = q        ${palavra_chave}
    press keys      name = q        ENTER

Validar se aparece no título da guia o resultado esperado
    ${titulo}=  Get Title
    should contain  ${titulo}        ${palavra_chave}

    
Fechar o browser
    close browser

