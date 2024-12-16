Feature: Articles

Background: Define URL
    Given url apiUrl
    * def newArticleJson = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.dataGenerator')   
    * set newArticleJson.article.title = dataGenerator.getRandomArticleValues().title;
    * set newArticleJson.article.description = dataGenerator.getRandomArticleValues().description;
    * set newArticleJson.article.body = dataGenerator.getRandomArticleValues().body;

Scenario: Create a new article
    Given path 'articles'
    And request newArticleJson
    When method Post
    Then status 201
    And match response.article.title == newArticleJson.article.title
    * def articleId = response.article.slug
    
    Given params {limit: 10,offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200
    And match response.articles[0].title == newArticleJson.article.title

    Given path 'articles' ,articleId
    When method Delete
    Then status 204

    Given params {limit: 10,offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200
    And match response.articles[0].title != 'test2'