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
    And match response.tags == "#array"
    And match each response.tags == '#string'
    * print 'test 3'

Scenario: Get 10 articles
    Given params {limit: 10,offset: 0}
    Given path 'articles'  
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 10
    * print 'test 4'
    # And match each response.articles == '#{}'



   