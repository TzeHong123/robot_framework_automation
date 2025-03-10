*** Settings ***
Documentation       Test Case for Checking Order History
Library             SeleniumLibrary
Resource           ../Resources/keywords.robot
Resource           ../Resources/variables.robot
Test Teardown    Run Keywords    Send Check Order History Test Result with Status    AND    Close Browser

*** Test Cases ***
Order History Test
    Open Test Store Homepage
    Login User    ${USERNAME}    ${PASSWORD}
    Check Order History
    Capture Page Screenshot

