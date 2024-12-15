@debug
Feature: Tests for the home page

Background: Define URL
    Given url apiUrl

Scenario: @getTags Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['Test', 'Coding']
    And match response.tags !contains ['test']
    And match response.tags contains any ['Zoom', 'Git', 'YouTube']
    And match response.tags == "#array"
    And match each response.tags == '#string'
    * print 'test 3'

Scenario: Get 10 articles
    * def timeValidator = read('classpath:helpers/validator.js')

    Given params {limit: 10,offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 10
    And match response.articlesCount != 11
    And match response == {"articles": "#array",articlesCount: 10}
    And match response.articles[0].createdAt contains '2024'
    And match response.articles[*].favoritesCount contains 427
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    And match each response..bio == '#null' //## it's a null  or optional or string
    And match each response.articles ==
   """
    {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": '#? timeValidator(_)',
            "updatedAt": '#? timeValidator(_)',
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "#null",
                "image": "#string",
                "following": "#boolean"
            }
        } 
   """