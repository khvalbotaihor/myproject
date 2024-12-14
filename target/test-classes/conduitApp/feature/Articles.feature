Feature: Articles

Background: Define URL
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    And request {"user":{"email":"ihorkhvalbota@gmail.com","password":"sabato2024"}}
    When method Post
    Then status 200
    And match response.user.token != null
* def token = response.user.token

Scenario: Create a new article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article":{"title":"test","description":"article ","body":"description","tagList":["rag 1"]}}
    When method Post
    Then status 201
    And match response.article.title == 'test'
    * def articleId = response.article.slug


    Given header Authorization = 'Token ' + token
    Given path 'articles' ,articleId
    When method Delete
    Then status 204