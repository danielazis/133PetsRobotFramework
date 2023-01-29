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
    Quando escrevo "Coleira" na barra de pesquisa
    E aperto a tecla enter
    Entao exibe um grid e a frase do resultado esperado

Compra Produto
    [Tags]    rapido
    Dado que acesso o site como cliente
    E concordo com a Politica de Privacidade
    Quando escrevo "Pote" na barra de pesquisa
    E aperto a tecla enter
    Entao exibe um grid e a frase do resultado esperado
    Quando seleciono o produto "Porta Ração Petz Rosa 1kg"
    Entao exibe a pagina do produto com o preco de "R$ 59,99"
    Quando mudamos a quantidade do produto para "2"
    E clico no botao Adicionar no Carrinho
    Entao exibe a pagina do carrinho com o total de "R$ 119,98"

*** Keywords ***
Dado que acesso o site como cliente
    open browser    ${url}  ${browser}

E concordo com a Politica de Privacidade
    wait until element is visible    id= onetrust-accept-btn-handler
    click button    id= onetrust-accept-btn-handler

Quando escrevo "${pesquisa}" na barra de pesquisa
    set test variable    ${pesquisa}
    wait until element is enabled  id = search    30000ms
    input text  id = search    ${pesquisa}

E clico no botao da lupa
    click button    class = button-search

Entao exibe um grid e a frase do resultado esperado
    wait until element is visible    class = col-md-12>.title
    element should contain    class = col-md-12>.title    Resultados para "${pesquisa}"

E aperto a tecla enter
    press keys    id =search    ENTER

Quando seleciono o produto "${produto}"
    set test variable    ${produto}
    wait until element is enabled   xpath = //a[@data-nomeproduto="${produto}"]    30000ms
    click element    xpath = //a[@data-nomeproduto="${produto}"]
    #cart-item-147547 > div.cart-item-detail.flex.col.cont-center.align-itstart > div:nth-child(2)

Entao exibe a pagina do produto com o preco de "${preco}"
    wait until element is visible    xpath = //h1
    element should contain    xpath = //h1    ${produto}
    element should contain    class= current-price-left    ${preco}

Quando mudamos a quantidade do produto para "2"
    click button    xpath = //button[@onclick ="changeQuantity('plus')"]

E clico no botao Adicionar no Carrinho
    click button    id = adicionarAoCarrinho

Entao exibe a pagina do carrinho com o total de "${preco_total}"
#    wait until page contains element    xpath = //div[@id="cart-item-147547"]  60000ms
#    element should contain    xpath = //div[@id="cart-item-147547"]    ${produto}
#    element should contain    class = tx-blue.money    ${preco_total}
    wait until element is visible    xpath = //div[@id="cart-item-147547"]/div[@class="cart-item-detail flex col cont-center align-itstart"]/div[2]  60000ms
    element should contain    xpath = //div[@id="cart-item-147547"]/div[@class="cart-item-detail flex col cont-center align-itstart"]/div[2]    ${produto}
    element should contain    class = tx-blue.money    ${preco_total}
    //div[@id="cart-item-147547"]/div[@class="cart-item-detail flex col cont-center align-itstart"]