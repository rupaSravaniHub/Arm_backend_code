Feature: Replay Route Testing
  As a developer
  I want to ensure that the Replay route processes and routes messages correctly
  So that messages are routed based on the exceptionRoute and reply statuses are accurate

  Scenario: Process a message through the Replay route and validate headers and response
    Given consume the message from "direct:Replay"
    And the payload and set headers should be routed to the queue
    Then the body should be set to "Replay Queue Processed"
