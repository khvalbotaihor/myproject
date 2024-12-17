Feature: Hooks

Background: Background
    * def result = callonce read('classpath:helpers/Dummy.feature')
    * def username = result.username

Scenario: First scenario
    * print 'username: '+ username
    * print 'This is first scenario'

Scenario: Second scenario
    * print 'username: '+ username
    * print 'This is second scenario'