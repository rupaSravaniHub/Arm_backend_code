Feature: Audits

  Scenario: Retrieve valid audit details successfully via UI
    Given I open audit UI URL "http://localhost:3000/auditFilter"
    When I enter "FLOW1047" into the "Flow Id" label 
    And I enter "PURCHASEORDERRPA108" into the "Flow Name" label
    And I enter "MS" into the "Region" label
    And I click "Logs" button
    Then I open audit UI URL after form submission "http://localhost:3000/auditDetails"
    When I hit the audit API "http://localhost:9090/audits?flowId=FLOW1047&flowName=PURCHASEORDERRPA108&region=MS"
    Then the response status should be 200
    And I want the following audit details in the JSON format:
  """
     {
  "messageId": "ID:MH50012341-64953-1737987778720-7:3:1:1:1",
  "flowId": "FLOW1047",
  "flowName": "PURCHASEORDERRPA108",
  "region": "MS",
  "inboundQueue": "Activemq.PurchaseOrderrpa108.MS.IN",
  "outboundQueue": "Activemq.PurchaseOrder109.MS.OUT",
  "sourceTimeStamp": "2025-01-27 14:38:37:599",
  "targetTimeStamp": "2025-01-27 14:38:37:908",
  "stages": "INGATE.OUTGATE",
  "inAuditStatus": "true",
  "outAuditStatus": "true",
  "payload": "{\r\n\"order_id\": \"orderrpa001\",\r\n\"customer_id\": \"67890\",\r\n\"address\": \"123 Main St, CapitalState\",\r\n\"region\":\"ME\",\r\n\"items\": [\r\n{\r\n\"name\": \"Widget\",\r\n\"quantity\": \"2\"\r\n},\r\n{\r\n\"name\": \"Gadget\",\r\n\"quantity\": \"1\"\r\n}\r\n]\r\n}"
}
      """
