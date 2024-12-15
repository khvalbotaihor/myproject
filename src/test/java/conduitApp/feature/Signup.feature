Feature: Sign up new user

    Background: Preconditions
     * def dataGenerator = Java.type('helpers.dataGenerator')   
     Given url apiUrl

    Scenario: Sign up a new user
        * def randomEmail = dataGenerator.getRandomEmail()    
        * def randomUsername = dataGenerator.getRandomUsername()

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




    Scenario: Validate sign up error message
        * def randomEmail = dataGenerator.getRandomEmail()    
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        And request 
        """
            {"user":
                {
                    "email": "upqode.igor@gmail.com",
                    "password":"3345375333",
                    "username": #(randomUsername)
                }
            }
        """
        When method Post
        Then status 422 


    Scenario: Validate sign up error message
        * def randomEmail = dataGenerator.getRandomEmail()    
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        And request 
        """
            {"user":
                {
                    "email": #(randomEmail),
                    "password":"3345375333",
                    "username": 'ihor'
                }
            }
        """
        When method Post
        Then status 422 