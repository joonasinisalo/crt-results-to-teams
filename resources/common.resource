*** Settings ***
Library                 QWeb
Library                 Collections
Library                 ../libraries/send_results.py


*** Variables ***
&{RESULTS}              
...                     suite_name=${SUITE NAME}
...                     suite_status=${EMPTY}
...                     tests_total=${0}
...                     tests_passed=${0}
...                     tests_failed=${0}


*** Keywords ***
Setup Browser
    Open Browser        about:blank    chrome
    SetConfig           DefaultTimeout    5s

End Suite
    Close All Browsers
    Set To Dictionary   ${RESULTS}    suite_status=${SUITE STATUS}
    Send Results        ${RESULTS}    ${CHANNEL_WEBHOOK}

Update Results
    Log                 \nTest Status: ${TEST STATUS}
    Log                 \nTest Message: ${TEST MESSAGE}

    ${total}=           Evaluate    ${RESULTS}[tests_total] + 1
    Set To Dictionary   ${RESULTS}    tests_total=${total}
    
    IF    "${TEST STATUS}" == "PASS"
        ${passed}=           Evaluate    ${RESULTS}[tests_passed] + 1
        Set To Dictionary   ${RESULTS}    tests_passed=${passed}
    ELSE IF    "${TEST STATUS}" == "FAIL"
        ${failed}=           Evaluate    ${RESULTS}[tests_failed] + 1
        Set To Dictionary   ${RESULTS}    tests_failed=${failed}
    ELSE
        Log                 Unknown status!
    END
