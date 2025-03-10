*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/variables.robot
Resource  ../Resources/keywords.robot
Test Teardown    Run Keywords    Send Remove From Cart Test Result with Status    AND    Close Browser

*** Test Cases ***
Remove Item from Cart
    Open Test Store Homepage
    Search for a product    Deodorant
    Add Product to Cart
    Remove Product from Cart