*** Settings ***
Documentation    Consultas no site da Petz

Library    SeleniumLibrary
Library    OperatingSystem
Library    String

Test Teardown    close browser

*** Variables ***
${browser}    Chrome
${url}    https://www.petz.com.br

*** Test Cases ***
Consulta Produto com click
    [Tags]    rapido
    Dado que acesso o site como cliente
    Quando escrevo "Ração" na barra de pesquisa
    E clico no botao da lupa
    Entao exibe um grid e a frase do resultado esperado

Consulta Produto com enter
    [Tags]    rapido
    Dado que acesso o site como cliente
    Quando escrevo "Ração" na barra de pesquisa
    E aperto a tecla enter
    Entao exibe um grid e a frase do resultado esperado

*** Keywords ***
Dado que acesso o site como cliente
    open browser    ${url}  ${browser}

Quando escrevo "${pesquisa}" na barra de pesquisa
    set test variable    ${pesquisa}
    input text  id = search    ${pesquisa}

E clico no botao da lupa
    click button    class = button-search

Entao exibe um grid e a frase do resultado esperado
    element should contain    class = col-md-12>.title    Resultados para "${pesquisa}"

E aperto a tecla enter
    press keys    id =search    ENTER
