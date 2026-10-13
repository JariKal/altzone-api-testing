*** Settings ***
Documentation    API-testaus AltZonen dev-rajapinnalla.
Library    RequestsLibrary
Library    Collections
Suite Setup    Kirjaudu Ja Tallenna Token

*** Variables ***
${API_URL}    https://devapi.altzone.fi
${USERNAME}      %{ALTZONE_USERNAME}
${PASSWORD}      %{ALTZONE_PASSWORD}
${AUTH_TOKEN}    ${EMPTY}
${AUTH_HEADER}    ${EMPTY}
${PROFILE_ID}    ${EMPTY}
${PLAYER_ID}    ${EMPTY}
${CLAN_ID}    ${EMPTY}

*** Test Cases ***
Tarkista että token on käytettävissä
    [Documentation]    Tarkistaa, että Setupissa saatu token on tallennettu.
    Should Not Be Empty    ${AUTH_TOKEN}
    Log To Console    \nToken on tallennettu ja käytettävissä.
    
Hae oma profiili
    [Documentation]    Hakee kirjautuneen käyttäjän profiilitiedot dynaamisella ID:llä.
    ${response}=    GET On Session    
    ...    altzone_api    
    ...    profile/${PROFILE_ID}    
    ...    headers=${AUTH_HEADER}    
    ...    expected_status=200

    Log To Console    \n--- OMAN PROFIILIN VASTAUS ---
    Log To Console    Koodi: ${response.status_code}

Tarkista pelaajan ID
    [Documentation]    Tarkistaa, että pelaajan API palauttaa oikean pelaajan tiedot.

    ${response}=    GET On Session    
    ...    altzone_api    
    ...    player/${PLAYER_ID}    
    ...    headers=${AUTH_HEADER}    
    ...    expected_status=200

    ${player_data}=    Evaluate    $response.json()
    ${data}=    Get From Dictionary    ${player_data}    data
    ${player}=    Get From Dictionary    ${data}    Player
    
    ${id_matches}=    Evaluate    str($player["_id"]) == str($PLAYER_ID)
    Should Be True    ${id_matches}

Hae oma pelaaja
    [Documentation]    Hakee kirjautuneen käyttäjän pelaajatiedot dynaamisella ID:llä
    ${response}=    GET On Session    
    ...    altzone_api    
    ...    player/${PLAYER_ID}    
    ...    headers=${AUTH_HEADER}    
    ...    expected_status=200

    Log To Console    \n--- OMAN PELAAJAN VASTAUS
    Log To Console    Koodi: ${response.status_code}

Hae oma klaani
    [Documentation]    Hakee oman klaanin tiedot dynaamisella ID:llä
    ${response}=    GET On Session    
    ...    altzone_api    
    ...    clan/${CLAN_ID}    
    ...    headers=${AUTH_HEADER}    
    ...    expected_status=200

    Log To Console    \n--- OMAN KLAANIN VASTAUS
    Log To Console    Koodi: ${response.status_code}

Hae kaikki huoneet
    [Documentation]    Tarkistaa, että huoneiden API palauttaa HTTP 200 -vastauksen.
    ${response}=    GET On Session    
    ...    altzone_api    
    ...    room/
    ...    headers=${AUTH_HEADER}    
    ...    expected_status=200

    Log To Console    koodi: ${response.status_code}

*** Keywords ***
Kirjaudu Ja Tallenna Token
    [Documentation]    Kirjautuu sisään ja tallentaa tarvittavat ID:t.
    ${old_level}=    Set Log Level    NONE

    TRY
        Create Session    altzone_api    ${API_URL}    verify=${True}

        &{data}=    Create Dictionary
        ...    username=${USERNAME}
        ...    password=${PASSWORD}

        ${response}=    POST On Session
        ...    altzone_api
        ...    auth/signin
        ...    json=${data}
        ...    expected_status=201

        ${json_data}=    Set Variable    ${response.json()}

        ${token}=    Set Variable    ${json_data}[accessToken]
        Set Suite Variable    \${AUTH_TOKEN}    ${token}

        &{headers}=    Create Dictionary    Authorization=Bearer ${token}
        Set Suite Variable    \${AUTH_HEADER}    ${headers}

        ${oma_id}=    Set Variable    ${json_data}[id]
        Set Suite Variable    \${PROFILE_ID}    ${oma_id}

        ${player_info}=    Evaluate    $json_data["Player"]
        ${pelaaja_id}=    Evaluate    $player_info["_id"]
        Set Suite Variable    \${PLAYER_ID}    ${pelaaja_id}

        ${klaani_id}=    Set Variable    ${json_data}[Player][clan_id]
        Set Suite Variable    \${CLAN_ID}    ${klaani_id}

    FINALLY
        Set Log Level    ${old_level}
    END


