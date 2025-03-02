*** Keywords ***
Open Test Store Homepage
    Open Browser    ${TEST_STORE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@id='filter_keyword']    5s

Login User
    [Arguments]    ${username}    ${password}
    Click Element    xpath=/html/body/div/header/div[1]/div/div[2]/div/div[2]/div/ul/li/a
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[1]/div    5s
    Sleep    2s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[1]/div/input   ${username}
    Sleep    1s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[2]/div/input    ${password}
    Sleep    1s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/button
    Wait Until Page Contains    My Account    5s

Search for a product
    [Arguments]    ${product_name}
    Input Text    xpath=//input[@id='filter_keyword']    ${product_name}
    Press Keys    xpath=//input[@id='filter_keyword']    ENTER
    Wait Until Page Contains    ${product_name}    5s

Verify Search Results
    Page Should Contain Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[3]/div[1]

Add Product to Cart
    Click Element    xpath=(//a[@class='prdocutname'])[1]   # Click the first product
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div/div[2]/form/fieldset/div[5]/ul/li/a   10s  # Wait for Add to Cart button
    Sleep    2s
    Click Element    xpath=/html/body/div/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div/div[2]/form/fieldset/div[5]/ul/li/a    # Click 'Add to Cart' button
    Wait Until Page Contains    Shopping Cart    10s

Remove Product from Cart
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/table/tbody/tr[2]/td[7]/a    5s
    Sleep    2s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/table/tbody/tr[2]/td[7]/a    # Click 'Remove' button
    Wait Until Page Does Not Contain    Deodorant    10s

Proceed to Checkout
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/div/a    5s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/div/a
    Sleep    2s

Confirm Order
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div/button    5s
    Click Element    xpath=/html/body/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div/button
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/h1/span[1]    10s
    ${confirmation_text}    Get Text    xpath=/html/body/div/div[2]/div/div/div/h1/span[1]
    Log    Found confirmation text: ${confirmation_text}
    Should Contain Any    ${confirmation_text}    CHECKOUT CONFIRMATION    Your order has been processed

Close Browser
    Close Browser

