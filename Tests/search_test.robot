*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/variables.robot
Resource  ../Resources/keywords.robot
Test Teardown    Close Browser

*** Test Cases ***
Search Product on Automation Test Store
    Open Test Store Homepage
    Search for a product  shirt
    Verify Search Results
