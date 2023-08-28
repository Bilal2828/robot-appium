*** Settings ***
Library      AppiumLibrary
Library    SeleniumLibrary
Resource     credentials.resource

*** Variables ***
#*** Test-Data ***
&{Credentials}        email=benimtest@gmail.com     passwort=${PASSWORD}

#*** Android-Settings ***
${ANDROID-CONTINUE-BUTTON}      id=com.android.permissioncontroller:id/continue_button
${ANDROID-OK-BUTTON}            id=android:id/button1

#*** Login-Page ***
${Login-Email}      id=chat21.android.demo:id/email
${Login-Passwort}   id=chat21.android.demo:id/password
${Login-Button}     chat21.android.demo:id/login

#*** Profile-Page ***
${Profil-Button}    //android.widget.TextView[@text="PROFILE"]

#*** Chat-Page***
${Chat-Button}      //android.widget.TextView[@text="CHAT"]
${Chat-New-Conversation-Button}     id=chat21.android.demo:id/button_new_conversation
${Chat-Contacts-Header}             id=chat21.android.demo:id/toolbar
${Chat-Contacts-Header-Search}      id=chat21.android.demo:id/action_search
${Chat-Contacts-Header-Search-Field}    id=chat21.android.demo:id/search_src_text
${Group-Selected}           ////android.widget.TextView[contains(@resource-id,'recipient_display_name') and @text="Meine Gruppe"]

#*** Logout-Profile ***
${Logout-Button}    id=chat21.android.demo:id/logout

*** Keywords ***
Open Chat21 Application
    Open Application     http://localhost:4723/wd/hub    platformName=Android    deviceName=emulator-5554    appPackage=chat21.android.demo      appActivity=chat21.android.demo.SplashActivity    automationName=Uiautomator2
    ${ALERT}        Run Keyword And Return Status    Page Should Not Contain Element    ${ANDROID-CONTINUE-BUTTON}
    Run Keyword If    '${ALERT}' == 'False'     Bypass Andorid-10 Allerts

Bypass Andorid-10 Allerts
    Wait Until Page Contains Element    ${ANDROID-CONTINUE-BUTTON}
    Click Element    ${ANDROID-CONTINUE-BUTTON}
    Wait Until Page Contains Element    ${ANDROID-OK-BUTTON}
    Click Element    ${ANDROID-OK-BUTTON}

Login With User
    [Arguments]   ${EMAIL}    ${USERPASSWORD}
    Input User Email       ${EMAIL}
    Input User Password    ${USERPASSWORD}
    Submit Login
    Verify Login Is Successful
    Sleep    1

Input User Email
    [Arguments]     ${EMAIL}
    Wait Until Page Contains Element    ${Login-Button}
    Input text      ${Login-Email}      ${EMAIL}

Input User Password
    [Arguments]     ${USERPASSWORD}
    Input Text      ${Login-Passwort}   ${USERPASSWORD}

Submit Login
    Click Element   ${Login-Button}

Verify Login Is Successful
    Wait Until Page Contains Element    id=chat21.android.demo:id/direct_message

Logout With User
    Go To Profile Page
    Click The Logout Button
    Verify Login Email Field Is Displayed

Go To Profile Page
    Wait Until Page Contains Element    ${Profil-Button}
    Click Element    ${Profil-Button}
    Wait Until Page Contains Element    ${Logout-Button}

Click The Logout Button
    Click Element    ${Logout-Button}

Verify Login Email Field Is Displayed
    Wait Until Page Contains Element    ${Login-Email}

Go To Chat Button
    Click Element    ${Chat-Button} 
    Wait Until Page Contains Element    ${Chat-New-Conversation-Button}

Create A New Conversation

    Click Element    ${Chat-New-Conversation-Button}
    Wait Until Page Contains Element    ${Chat-Contacts-Header}
    Sleep    5
Search For A Conversation
    [Arguments]      ${NAME}
    Click Element    ${Chat-Contacts-Header-Search}
    #Sleep    5
    Wait Until Page Contains Element    //android.widget.TextView[contains(@resource-id,'fullname') and @text="${NAME}"]
    Click Element     //android.widget.TextView[contains(@resource-id,'fullname') and @text="${NAME}"]


Verify Group Is Displayed
    Wait Until Page Contains Element    //android.widget.TextView[contains(@resource-id,'toolbar_title') and @text="null null"]