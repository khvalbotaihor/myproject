Feature: Create Token

Scenario: Create Token
    Given url apiUrl
    Given path 'users/login'
    And request {"user":{"email":"#(userEmail)","password":"#(userPassword)"}}
    When method Post
    Then status 200
    And match response.user.token != null
    * def authToken = response.user.token