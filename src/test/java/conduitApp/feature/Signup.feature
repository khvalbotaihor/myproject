Feature: Sign up new user

    Background: Preconditions
     Given url apiUrl

    Scenario: Sign up a new user
        Given path 'users'
        And request  {"user":{"email":"ddsdffddddd@ff.fddd","password":"334334433355333", "username": "fcfffffecfece5fcef"}}
        When method Post
        Then status 201  
        * def resp = response.user
        * print 'user response' + resp  

