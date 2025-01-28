Feature: FlowSearch

  Scenario: Retrieve valid flow search details successfully via UI
    Given I open flow search UI URL "http://localhost:3000/viewDetails"
    When I enter "FLOW1047" into the "Id" search label
    And I enter "PURCHASEORDERRPA108" into the "Name" search label
    And I enter "MS" into the "region" search label
    And Click flow search "Search" button
    Then Hit flow search API "http://localhost:9090/search?flowId=FLOW1047&flowName=PURCHASEORDERRPA108&region=MS"
    Then the response should be 200
    And I want the following valid flow search in the JSON format:
      """
      {
  "flowId": "FLOW1047",
  "flowName": "PURCHASEORDERRPA108",
  "stages": "INGATE.OUTGATE",
  "region": "MS",
  "inbound": {
    "topic": "",
    "queue": "Activemq.PurchaseOrderrpa108.MS.IN",
    "brokerurl": "tcp://localhost:61616",
    "username": "",
    "password": ""
  },
  "outbound": [
    [
      {
        "topic": "",
        "queue": "Activemq.PurchaseOrder109.MS.OUT",
        "brokerurl": "tcp://localhost:61616",
        "username": "",
        "password": ""
      }
    ]
  ],
  "nodes": [
    {
      "id": "dndnode_0",
      "type": "Amq",
      "position": {
        "x": -81.21875,
        "y": 152.5
      },
      "data": {
        "label": "Amq"
      },
      "width": 40,
      "height": 40,
      "selected": false,
      "positionAbsolute": {
        "x": -81.21875,
        "y": 152.5
      },
      "dragging": false
    },
    {
      "id": "dndnode_1",
      "type": "Ingate",
      "position": {
        "x": 28.421875,
        "y": 148.75
      },
      "data": {
        "label": "Ingate"
      },
      "width": 40,
      "height": 40,
      "selected": false,
      "positionAbsolute": {
        "x": 28.421875,
        "y": 148.75
      },
      "dragging": false
    },
    {
      "id": "dndnode_2",
      "type": "Outgate",
      "position": {
        "x": 132.921875,
        "y": 147.25
      },
      "data": {
        "label": "Outgate"
      },
      "width": 40,
      "height": 40,
      "selected": false,
      "positionAbsolute": {
        "x": 132.921875,
        "y": 147.25
      },
      "dragging": false
    },
    {
      "id": "dndnode_3",
      "type": "Amqout",
      "position": {
        "x": 288.921875,
        "y": 145.75
      },
      "data": {
        "label": "Amqout"
      },
      "width": 40,
      "height": 40,
      "selected": true,
      "dragging": false
    }
  ],
  "edges": [
    {
      "source": "dndnode_0",
      "sourceHandle": null,
      "target": "dndnode_1",
      "targetHandle": null,
      "type": "straight",
      "id": "reactflow__edge-dndnode_0-dndnode_1"
    },
    {
      "source": "dndnode_1",
      "sourceHandle": null,
      "target": "dndnode_2",
      "targetHandle": null,
      "type": "straight",
      "id": "reactflow__edge-dndnode_1-dndnode_2"
    },
    {
      "source": "dndnode_2",
      "sourceHandle": null,
      "target": "dndnode_3",
      "targetHandle": null,
      "type": "straight",
      "id": "reactflow__edge-dndnode_2-dndnode_3"
    }
  ]
}
      """
