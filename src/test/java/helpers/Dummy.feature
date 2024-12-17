Feature: Dummy


Scenario: Dummy scenario
    * def dataGenerator = Java.type('helpers.dataGenerator')
    * def username = dataGenerator.getRandomUsername()
