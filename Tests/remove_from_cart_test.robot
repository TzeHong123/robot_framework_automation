*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/variables.robot
Resource  ../Resources/keywords.robot
Test Teardown    Close Browser

*** Test Cases ***
Remove Item from Cart
    Open Test Store Homepage
    Search for a product    Deodorant
    Add Product to Cart
    Remove Product from Cart