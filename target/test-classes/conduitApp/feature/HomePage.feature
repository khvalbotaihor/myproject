@debug
Feature: Tests for the home page

Background: Define URL
    Given url apiUrl
    * def newArticleJson = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.dataGenerator')   
    * set newArticleJson.article.title = dataGenerator.getRandomArticleValues().title;
    * set newArticleJson.article.description = dataGenerator.getRandomArticleValues().description;
    * set newArticleJson.article.body = dataGenerator.getRandomArticleValues().body;
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }


Scenario: @getTags Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['Test', 'Coding']
    And match response.tags !contains ['test']
    And match response.tags contains any ['Zoom', 'Git', 'YouTube']
    And match response.tags == "#array"
    And match each response.tags == '#string'

Scenario: Get 10 articles
    * def timeValidator = read('classpath:helpers/validator.js')

    Given params {limit: 10,offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    # And match response.articlesCount == 12
    And match response.articlesCount != 11
    # And match response == {"articles": "#array",articlesCount: 13}
    And match response.articles[0].createdAt contains '2024'
    And match response.articles[*].favoritesCount contains 10
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



    Scenario: Conditional logic
        Given path 'articles'
        And request newArticleJson
        When method Post
        Then status 201
        * def newArticleResponse = response
        * def newArticleResponseSlugId = newArticleResponse.article.slug
        * def count = newArticleResponse.article.favoritesCount
        # * print 'newArticleResponse'+newArticleResponse
        # * print 'newArticleResponseSlugId'+newArticleResponseSlugId
        # * print 'favoritesCount'+count

        * def favoritesCount = newArticleResponse.favoritesCount

        * if(favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', newArticleResponse)
        # * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', newArticleResponse).likesCount : favoritesCount
        # * if(favoritesCount == 0) karate.call('classpath:helper/DeleteLikes.feature', newArticleResponse)
        Given path 'articles/', newArticleResponseSlugId
        When method Get
        * eval sleep(5000)
        Then status 200
        * print 'ffff', response
        And match response.article.favoritesCount == 0

        Given path 'articles/',newArticleResponseSlugId
        When method Delete
        Then status 204

    Scenario: Retry call
        * configure retry = {count:10, interval: 5000}

        Given params {limit: 10,offset: 0}
        Given path 'articles'  
        And retry until response.articles[0].favoritesCount ==0
        When method Get
        Then status 200

    Scenario: sleep call
        Given params {limit: 10,offset: 0}
        Given path 'articles'  
        When method Get
        Then status 200
