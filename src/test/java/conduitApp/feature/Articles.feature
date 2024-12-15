@ignore
Feature: Articles

Background: Define URL
    Given url apiUrl

Scenario: Create a new article
    Given path 'articles'
    And request {"article":{"title":"test2","description":"article ","body":"description","tagList":["rag 1"]}}
    When method Post
    Then status 201
    And match response.article.title == 'test2'
    * def articleId = response.article.slug
    
    Given params {limit: 10,offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200
    And match response.articles[0].title == 'test2'

    Given path 'articles' ,articleId
    When method Delete
    Then status 204

    Given params {limit: 10,offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200
    And match response.articles[0].title != 'test2'