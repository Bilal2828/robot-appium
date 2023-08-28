*** Settings ***
Library    SeleniumLibrary
Library    AppiumLibrary


*** Variables ***
${URL}      https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${Browser}   chrome
@{Credentials}  Admin   admin123
&{LoginData}    username=Admin  password=admin123


*** Test Cases ***
Opening browser
    Open Browser    ${URL}   headlesschrome
    set browser implicit wait    3
    LoginKeyword
    log    das pw ist @{Credentials}    console=true
    click button  xpath=//*[@id="app"]/div[1]/div/div[1]/div/div[2]/div[2]/form/div[3]/button
    click element   class=oxd-userdropdown-name
    click element   link=Logout
    sleep    3
    close browser
*** Keywords ***
LoginKeyword
    input text    name=username    @{Credentials}
    sleep    3
    input password    name=password    admin123
