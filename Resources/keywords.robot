*** Settings ***
Resource  ../Resources/variables.robot
Library     RequestsLibrary

*** Keywords ***
Open Test Store Homepage
    Open Browser    ${TEST_STORE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@id='filter_keyword']    5s

Login User
    [Arguments]    ${username}    ${password}
    Click Element    xpath=/html/body/div/header/div[1]/div/div[2]/div/div[2]/div/ul/li/a
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[1]/div    5s
    Sleep    2s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[1]/div/input   ${username}
    Sleep    1s
    Input Text    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/div[2]/div/input    ${password}
    Sleep    1s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/div/div[2]/div/form/fieldset/button
    Wait Until Page Contains    My Account    5s

Verify Login Success
    [Documentation]    Verifies that the login was successful.
    Wait Until Page Contains    My Account    5s

Verify Registration Success
    [Documentation]    Verifies that the registration was successful.
    Wait Until Page Contains    Your Account Has Been Created!    10s


Search for a product
    [Arguments]    ${product_name}
    Input Text    xpath=//input[@id='filter_keyword']    ${product_name}
    Press Keys    xpath=//input[@id='filter_keyword']    ENTER
    Wait Until Page Contains    ${product_name}    5s

Verify Search Results
    Page Should Contain Element    xpath=//*[@id="maincontainer"]/div/div/div/div/div[3]/div[1]

Add Product to Cart
    Click Element    xpath=(//a[@class='prdocutname'])[1]   # Click the first product
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div/div[2]/form/fieldset/div[4]/ul/li/a   10s  # Wait for Add to Cart button
    Sleep    2s
    Click Element    xpath=/html/body/div/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div/div[2]/form/fieldset/div[4]/ul/li/a    # Click 'Add to Cart' button
    Wait Until Page Contains    Shopping Cart    10s

Add Product to Cart2
    Click Element    xpath=(//a[@class='prdocutname'])[1]   # Click the first product
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div/div[2]/form/fieldset/div[5]/ul/li/a   10s  # Wait for Add to Cart button
    Sleep    2s
    Click Element    xpath=/html/body/div/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div/div[2]/form/fieldset/div[5]/ul/li/a    # Click 'Add to Cart' button
    Wait Until Page Contains    Shopping Cart    10s

Remove Product from Cart
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/table/tbody/tr[2]/td[7]/a    5s
    Sleep    2s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/table/tbody/tr[2]/td[7]/a    # Click 'Remove' button
    Wait Until Page Does Not Contain    Deodorant    10s

Verify Cart Is Empty
    [Documentation]    Verifies that the cart is empty after removing the product.
    Wait Until Page Contains    Your shopping cart is empty!    10s

Proceed to Checkout
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/div/a    5s
    Click Element    xpath=/html/body/div/div[2]/div/div/div/form/div/div[1]/div/a
    Sleep    2s

Confirm Order
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div/button    5s
    Click Element    xpath=/html/body/div/div[2]/div/div[1]/div/div[2]/div/div[2]/div/div/div/button
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div/div/h1/span[1]    10s
    ${confirmation_text}    Get Text    xpath=/html/body/div/div[2]/div/div/div/h1/span[1]
    Log    Found confirmation text: ${confirmation_text}
    Should Contain Any    ${confirmation_text}    CHECKOUT CONFIRMATION    Your order has been processed

Verify Checkout Success
    [Documentation]    Verifies that the checkout process was successful.
    Page Should Contain Element    xpath=/html/body/div/div[2]/div/div/div/h1/span[1]
    ${confirmation_text}    Get Text    xpath=/html/body/div/div[2]/div/div/div/h1/span[1]
    Should Contain Any    ${confirmation_text}    CHECKOUT CONFIRMATION    Your order has been processed

Check Order History
    Mouse Over    xpath=/html/body/div/header/div[1]/div/div[2]/div/div[2]/div/ul/li/a
    Wait Until Element Is Visible    xpath=/html/body/div/header/div[1]/div/div[2]/div/div[2]/div/ul/li/ul/li[6]/a    5s
    Click Element    xpath=/html/body/div/header/div[1]/div/div[2]/div/div[2]/div/ul/li/ul/li[6]/a
    Wait Until Element Is Visible    xpath=/html/body/div/div[2]/div/div[1]/div/div/div[1]/div[3]/div/table/tbody/tr[1]/td[3]/button    5s
    Click Element    xpath=/html/body/div/div[2]/div/div[1]/div/div/div[1]/div[3]/div/table/tbody/tr[1]/td[3]/button
    Wait Until Page Contains    Order History    10s

Verify Order History Page
    [Documentation]    Verifies that the order history page is displayed successfully.
    Wait Until Page Contains    Order History    10s


Send Test Result
    [Arguments]    ${test_name}    ${status}    ${message}
    ${data}=    Create Dictionary    test_name=${test_name}    status=${status}    message=${message}
    ${response}=    POST    http://kthcreation.com/robot_framework_automation/php/save_test_result.php    json=${data}
    Log    Response: ${response.content}

Send Search Test Result with Status
    [Documentation]    Sends test result as Passed or Failed depending on the test outcome.
    ${status}    Run Keyword And Return Status    Verify Search Results
    ${message}    Set Variable If    ${status}    Item searching completed successfully    Test failed unexpectedly
    ${final_status}    Set Variable If    ${status}    Passed    Failed
    Send Test Result    Searching process    ${final_status}    ${message}

Send Add To Cart Test Result with Status
    [Documentation]    Sends the test result for "Add to Cart" test case.
    ${test_name}    Set Variable    Add to Cart Test
    ${test_status}    Run Keyword And Return Status    Add Product to Cart
    ${test_status}    Set Variable If    '${test_status}' == 'True'    Passed    Failed
    ${test_message}    Set Variable If    '${test_status}' == 'Passed'    Product successfully added to cart    Failed to add product to cart
    Send Test Result    ${test_name}    ${test_status}    ${test_message}

Send Checkout Test Result with Status
    [Documentation]    Sends the test result for the Checkout test case.
    ${test_name}    Set Variable    Checkout Process

    TRY
        Verify Checkout Success
        ${test_status}    Set Variable    Passed
        ${test_message}    Set Variable    Checkout process completed successfully
    EXCEPT
        ${test_status}    Set Variable    Failed
        ${test_message}    Set Variable    Checkout process failed
    END

    Send Test Result    ${test_name}    ${test_status}    ${test_message}

Send Login Test Result with Status
    [Documentation]    Sends the test result for the Login test case.
    ${test_name}    Set Variable    User Login Test

    TRY
        Verify Login Success
        ${test_status}    Set Variable    Passed
        ${test_message}    Set Variable    User login successful
    EXCEPT
        ${test_status}    Set Variable    Failed
        ${test_message}    Set Variable    User login failed
    END

    Send Test Result    ${test_name}    ${test_status}    ${test_message}

Send Register Test Result with Status
    [Documentation]    Sends the test result for the Register New User test case.
    ${test_name}    Set Variable    Register New User

    TRY
        Verify Registration Success
        ${test_status}    Set Variable    Passed
        ${test_message}    Set Variable    User registration successful
    EXCEPT
        ${test_status}    Set Variable    Failed
        ${test_message}    Set Variable    User registration failed
    END

    Send Test Result    ${test_name}    ${test_status}    ${test_message}

Send Check Order History Test Result with Status
    [Documentation]    Sends the test result for the Order History Test case.
    ${test_name}    Set Variable    Order History Test

    TRY
        Verify Order History Page
        ${test_status}    Set Variable    Passed
        ${test_message}    Set Variable    Order history displayed successfully
    EXCEPT
        ${test_status}    Set Variable    Failed
        ${test_message}    Set Variable    Order history verification failed
    END

    Send Test Result    ${test_name}    ${test_status}    ${test_message}

Send Remove From Cart Test Result with Status
    [Documentation]    Sends the test result for the Remove From Cart Test case.
    ${test_name}    Set Variable    Remove Item from Cart

    TRY
        Verify Cart Is Empty
        ${test_status}    Set Variable    Passed
        ${test_message}    Set Variable    Item successfully removed from cart
    EXCEPT
        ${test_status}    Set Variable    Failed
        ${test_message}    Set Variable    Failed to remove item from cart
    END

    Send Test Result    ${test_name}    ${test_status}    ${test_message}

