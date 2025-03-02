*** Settings ***
Documentation       Test Case for User Login
Library             SeleniumLibrary
Resource  ../Resources/variables.robot
Test Teardown    Close Browser

*** Variables ***
${BROWSER}         chrome
${TEST_STORE_URL}  https://automationteststore.com/


*** Test Cases ***
User Login Test
    Open Browser    ${TEST_STORE_URL}    ${BROWSER}
    Maximize Browser Window
    Click Element    xpath=/html/body/div/header/div[1]/div/div[2]/div/div[2]/div/ul/li/a
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[1]/div    5s
    Sleep    2s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[1]/div/input   ${USERNAME}
    Sleep    1s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[2]/div/input    ${PASSWORD}
    Sleep    1s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/button
    Wait Until Page Contains    My Account    5s
    Capture Page Screenshot
    Close Browser
