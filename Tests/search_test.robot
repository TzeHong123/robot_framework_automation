*** Settings *** 
Library  SeleniumLibrary
Resource  ../Resources/variables.robot
Resource  ../Resources/keywords.robot
Test Teardown    Run Keywords    Send Search Test Result with Status    AND    Close Browser

*** Test Cases ***
Search Product on Automation Test Store
    Open Test Store Homepage
    Search for a product    shirt
    Verify Search Results

