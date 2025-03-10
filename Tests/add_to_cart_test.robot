*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/variables.robot
Resource  ../Resources/keywords.robot
Test Teardown    Run Keywords    Send Add To Cart Test Result with Status    AND    Close Browser

*** Test Cases ***
Search and Add Deodorant to Cart
    Open Test Store Homepage
    Search for a product  Deodorant
    Verify Search Results
    
