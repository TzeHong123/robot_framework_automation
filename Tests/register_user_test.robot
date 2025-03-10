*** Settings ***
Library    SeleniumLibrary
Resource           ../Resources/keywords.robot
Test Teardown    Run Keywords    Send Register Test Result with Status    AND    Close Browser

*** Variables ***
${BROWSER}      chrome
${URL}          https://automationteststore.com/
${FIRST_NAME}   Ali
${LAST_NAME}    Hamdan
${EMAIL}        ali.hamdan1@example.com
${TELEPHONE}    0123456789
${ADDRESS}      123 Example Street
${CITY}         Seremban
${ZIP}          70000
${COUNTRY}      Malaysia
${REGION}       Negeri Sembilan
${USERNAME}     ali_hamdan1
${PASSWORD}     P@ssw0rd

*** Test Cases ***
Register New User
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Click Element    xpath=/html/body/div/header/div[1]/div/div[2]/div/div[2]/div/ul/li
    Wait Until Page Contains    Register Account    10s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/div/div[1]/div/form/fieldset/button
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[1]/fieldset/div[1]/div/input    10s
    Sleep    2s
    
    # Fill Personal Details
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[1]/fieldset/div[1]/div/input    ${FIRST_NAME}
    Sleep    1s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[1]/fieldset/div[2]/div/input    ${LAST_NAME}
    Sleep    1s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[1]/fieldset/div[3]/div/input    ${EMAIL}
    Sleep    1s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[1]/fieldset/div[4]/div/input    ${TELEPHONE}
    Sleep    1s
    
    # Select Country & Region
    Select From List By Label    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[2]/fieldset/div[7]/div/select    ${COUNTRY}
    Sleep    1s
    Select From List By Label    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[2]/fieldset/div[5]/div/select    ${REGION}
    Sleep    1s
    
    # Enter Address
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[2]/fieldset/div[2]/div/input    ${ADDRESS}
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[2]/fieldset/div[4]/div/input    ${CITY}
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[2]/fieldset/div[6]/div/input    ${ZIP}
    Sleep    1s
    
    # Login Credentials
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[3]/fieldset/div[1]/div/input    ${USERNAME}
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[3]/fieldset/div[2]/div/input    ${PASSWORD}
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[3]/fieldset/div[3]/div/input    ${PASSWORD}
    Sleep    1s
    
    # Subscribe to Newsletter (No)
    Click Element    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[4]/fieldset/div/div/label[2]
    Sleep    1s
    
    # Agree to Terms
    Click Element    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[5]/div/label/input
    Sleep    1s
    
    # Submit Form
    Click Element    xpath=/html/body/div/div[2]/div/div/div/div[1]/form/div[5]/div/div/button
    Wait Until Page Contains    Your Account Has Been Created!    10s
