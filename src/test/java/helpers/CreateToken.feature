Feature: Create Token

Scenario: Create Token
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    And request {"user":{"email":"ihorkhvalbota@gmail.com","password":"sabato2024"}}
    When method Post
    Then status 200
    And match response.user.token != null
    * def authToken = response.user.token