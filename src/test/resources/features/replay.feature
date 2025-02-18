Feature: Replay

  Scenario: test case for replay slide
    Given I open replay slide "http://localhost:3000/replayDetails"
    And this URL will be triggered "http://localhost:9090/getAllReplays"
    When I click on the "Replay" button
    Then hit this URL "http://localhost:9090/getReplay" with "FLOW1047" and "INGATE" parameters
    And status from the reply API should be 200
