*** Settings ***
Documentation       Test Case for Checking Out Items in the Cart
Library             SeleniumLibrary
Resource           ../Resources/keywords.robot
Resource           ../Resources/variables.robot
Test Teardown    Run Keywords    Send Checkout Test Result with Status    AND    Close Browser


*** Test Cases ***
Checkout Process
    Open Test Store Homepage
    Login User    ${USERNAME}    ${PASSWORD}
    Search for a product    Conditioner
    Verify Search Results
    Add Product to Cart2
    Proceed to Checkout
    Confirm Order
    Capture Page Screenshot

