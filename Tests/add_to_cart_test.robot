*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/variables.robot
Resource  ../Resources/keywords.robot
Test Teardown    Close Browser

*** Test Cases ***
Search and Add Deodorant to Cart
    Open Test Store Homepage
    Search for a product  Deodorant
    Verify Search Results
    Add Product to Cart
