Feature: Home Work

    Background: Preconditions
        * url apiUrl
        Given params {limit: 10,offset: 0}
        Given path 'articles'  
        When method Get
        Then status 200
        And def firstArticleWithFavorite = response.articles[0]
        And def firstArticleSlug = firstArticleWithFavorite.slug
        And def firstArticleFavorited = firstArticleWithFavorite.favorited
        And def firstArticlefavoritesCount = firstArticleWithFavorite.favoritesCount

    Scenario: Favorite articles
        * def timeValidator = read('classpath:helpers/validator.js')

        #step 1: get articles of the global feed
        
        And match firstArticleFavorited == false
        And match firstArticlefavoritesCount == 0
        #step 2: get the favorites count and slug id for the first article, save to variable
        #step 3: make post request to increase favorites count for the first article
        Given path 'articles/'+firstArticleSlug+'/favorite' 
        And request {}
        When method Post
        Then status 200
        And match response ==
        """
            {
                "article": {
                    "id": "#number",
                    "slug": "#string",
                    "title": "#string",
                    "description": "#string",
                    "body": "#string",
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "authorId": "#number",
                    "tagList": [],
                    "author": {
                        "username": "#string",
                        "bio": "#null",
                        "image": "#string",
                        "following": "#boolean"
                    },
                    "favoritedBy": [
                        {
                            "id": "#number",
                            "email": "#string",
                            "username": "#string",
                            "password": "#string",
                            "image": "#string",
                            "bio": "#null",
                            "demo": "#boolean"
                        }
                    ],
                    "favorited": "#boolean",
                    "favoritesCount": "#number"
                }
            }
        """


        Given path 'articles/'+ firstArticleSlug 
        When method Get
        Then status 200
        And match response.article.favorited == true
        And match response.article.favoritesCount == 1
    
        #step 4: verify response schema
        #step 5: verify that favorites article increment by 1

       

            #example
            # * def initialCount = 0
            # * def response = {"favoritesCount": 1}
            # * match response.favoriteCount == initialCount + 1

        #step 6: get all favorite articles

        Given params {limit: 10,offset: 0}
        Given path 'articles'  
        When method Get
        Then status 200
        When def favoritedArticles = $response.articles[?(@.favoritesCount > 0)]
        And def favoritedArticlesCount = favoritedArticles.length
        And match favoritedArticlesCount == 8
        When def filteredArticles = favoritedArticles.filter(x => x.slug == firstArticleSlug)
        And def filteredArticlesLength = filteredArticles.length
        And match filteredArticlesLength == 1
        And match filteredArticles[0].slug == firstArticleSlug
 

        Given path 'articles/'+firstArticleSlug+'/favorite' 
        And request {}
        When method Delete
        Then status 200


        Given path 'articles/'+ firstArticleSlug 
        When method Get
        Then status 200
        And match response.article.favorited == false
        And match response.article.favoritesCount == 0

        #step 7: verify response schema
        #step 8: verify that slug ID from step 2 exists in one of the favorite articles
   
        
    Scenario: comment article
        #step 1: get articles of the global feed
        #step 2: get the slug id for the first article, save it to variable
        #step 3: make get call to "comments" endpoint to get a;; comments

        Given path 'articles/'+firstArticleSlug+'/comments' 
        When method Get
        Then status 200
        And match response.comments == []
        And match response ==
        """
            {"comments":[]}
        """
        And def commentsNumber = response.comments.length    


        #step 4: verify response schema
        #step 5: get the count of the articles array length and save to variable
        #example
        * def resposeWithcomments = [{"article": "first"},{article: "second"}]
        # * def articlesCount = response With comment.length
        #step 6: make post request to publish a new comment

        Given path 'articles/'+firstArticleSlug+'/comments' 
        And request {"comment":{"body":"new comment"}}
        When method Post
        Then status 200
        And match response.comment.body == "new comment"


        Given path 'articles/'+firstArticleSlug+'/comments' 
        When method Get
        Then status 200
        And def commentId = response.comments[0].id
        And def commentsCount = response.comments.length
        And match commentsCount == (commentsNumber + 1)
        #step 7: verify response schema that should contain posted comment text
        #test 8: get the list of all the comments for this article one more time
        #test 9: verify number of comments increased by 1
        #step 10: make a delete request to delete comment
        #articles/Jon-Hollard-14338/comments/86616
        Given path 'articles/'+firstArticleSlug+'/comments/'+commentId
        When method Delete
        Then status 200
        And match response == {}
        #step 11: get all comments again and verify number of comments decreased by 1
        Given path 'articles/'+firstArticleSlug+'/comments' 
        When method Get
        Then status 200
        And match response.comments == []
  
        
        