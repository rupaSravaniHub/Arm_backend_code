Feature: Audits

  Scenario: Retrieve valid audit details successfully via UI
    Given I open audit UI URL "http://localhost:3000/auditFilter"
    When I enter "FLOW1001" into the "Flow Id" label 
    And I enter "ORDERDETAILS" into the "Flow Name" label
    And I enter "MU" into the "Region" label
    And I click "Logs" button
    Then I open audit UI URL after form submission "http://localhost:3000/auditDetails"
    When I hit the audit API "http://localhost:9090/audits?flowId=FLOW1001&flowName=ORDERDETAILS&region=MU"
    Then the response status should be 200
    And I want the following audit details in the JSON format:
      """
      {
      "messageId": "ID:MH50012324-54232-1732633370992-3:1:1:2:1",
      "flowId": "FLOW1001",
      "flowName": "ORDERDETAILS",
      "region": "MU",
      "inboundQueue": "ACTIVEMQ.ORDERDETAILS.MU.IN",
      "outboundQueue": "ACTIVEMQ.ORDERDETAILS.MU.OUT",
      "sourceTimeStamp": "2024-12-17T10:00:00.000Z",
      "targetTimeStamp": "2024-12-17T10:01:00.000Z",
      "stages": "INGATE.OUTGATE",
      "inAuditStatus": "true",
      "outAuditStatus": "true",
      "payload": "<order>\r\n<order_id>12345</order_id>\r\n<customer_id>67890</customer_id>\r\n<address>123 Main St, CapitalState</address>\r\n<items>\r\n<item>\r\n<name>Widget</name>\r\n<quantity>2</quantity>\r\n</item>\r\n<item>\r\n<name>Gadget</name>\r\n<quantity>1</quantity>\r\n</item>\r\n</items>\r\n</order>\r\n"
      }
      """
