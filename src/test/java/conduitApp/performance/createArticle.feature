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

    Given path 'articles' ,articleId
    When method Delete
    Then status 204