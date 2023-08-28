*** Settings ***
Library     AppiumLibrary
Resource    C:/Users/kuecuekkaya/PycharmProjects/robotautomation/resources/android-res.robot
*** Variables ***


*** Test Cases ***
Login&Logout
    Open Chat21 Application
    Login With User     ${USER1-DETAILS}[email]     ${USER1-DETAILS}[password]
    Go To Profile Page
    Click The Logout Button
    Logout With User
    Verify Login Email Field Is Displayed

Login&SearchGroup
    Open Chat21 Application
    Login With User     ${USER1-DETAILS}[email]     ${USER1-DETAILS}[password]
    Go To Chat Button
    Create A New Conversation
    Search For A Conversation    ${USER1-DETAILS}[name]
    Verify Group Is Displayed





