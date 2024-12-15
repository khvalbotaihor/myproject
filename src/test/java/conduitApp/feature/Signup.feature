Feature: Sign up new user

    Background: Preconditions
     * def dataGenerator = Java.type('helpers.dataGenerator')   
     * def randomEmail = dataGenerator.getRandomEmail()    
     * def randomUsername = dataGenerator.getRandomUsername()
     Given url apiUrl

    Scenario: Sign up a new user
        * def jsFunction =
        """
            function () {
              var dataGenerator = Java.type('helpers.dataGenerator') 
              var generator = new dataGenerator()  
              return generator.getRandomUsername2()
            }
        """
        * def randomUsername2 = call jsFunction

        Given path 'users'
        And request 
        """
            {"user":
                {
                    "email": #(randomEmail),
                    "password":"3345375333",
                    "username": #(randomUsername2)
                }
            }
        """
        When method Post
        Then status 201  
        And match response.user == 
        """
            {
                "id": "#number",
                "email": #(randomEmail),
                "username": #(randomUsername2),
                "bio": "#null",
                "image": "#string",
                "token": "#string"
            }
        """
        * def resp = response.user
        * print 'user response' + resp  




    Scenario Outline: Validate sign up error message
        Given path 'users'
        And request 
        """
            {"user":
                {
                    "email": <email>,
                    "password":<password>,
                    "username": <username>
                }
            }
        """
        When method Post
        Then status 422 
        And match response == <errorResponse>

        Examples:
            | email                 | password   | username          | errorResponse                                      |
            | #(randomEmail)        | karate1234 | ihor              | {"errors":{"username":["has already been taken"]}} |
            | #(randomEmail)        | karate1231 |  ""                 | {"errors":{"username":["can't be blank"]}}         |
            | upqode.igor@gmail.com | karate1234 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
            | upqode.igor@gmail.com | karate1234 | ihor              | {"errors":{"email":["has already been taken"],"username":["has already been taken"]}} | 
            |                       | karate1234 | #(randomUsername) | {"errors":{"email":["can't be blank"]}}            |
            | #(randomEmail)        |            | #(randomUsername) | {"errors":{"password":["can't be blank"]}}         |
