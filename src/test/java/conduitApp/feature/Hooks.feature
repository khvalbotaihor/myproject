Feature: Hooks

Background: Background
    # * def result = callonce read('classpath:helpers/Dummy.feature')
    # * def username = result.username

    # after hook
    * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature')}
    * configure afterFeature = 
    """
    function(){
        karate.log('after Feature console log');
        
    }
    """

Scenario: First scenario
    # * print 'username: '+ username
    # * print 'This is first scenario'

Scenario: Second scenario
    # * print 'username: '+ username
    # * print 'This is second scenario'