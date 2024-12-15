@ignore
Feature: Sign up new user

    Background: Preconditions
     Given url apiUrl

    @debug
    Scenario: Sign up a new user
        Given def userData = {"email":"dddfyd@ff.fddd", "username": "fcfdd7cfece5fcef"}

        Given path 'users'
        And request  {"user":{"email":#(userData.email),"password":"3345375333", "username": #(userData.username)}}
        And request
        When method Post
        Then status 201  
        * def resp = response.user
        * print 'user response' + resp  

