Feature: flowShowAll

  Scenario: Retrieve all flow details successfully via UI
    Given I open view all UI URL "http://localhost:3000/viewDetails"
    And I click the viewAll "viewAll" button
    And hit the URL "http://localhost:9090/showAll"
    Then data should be like this:
     """
     [
    {
        "flowId": "FLOW1001",
        "flowName": "SALES",
        "stages": "INGATE.CONVERT.OUTGATE",
        "region": "US",
        "transdata": "Json-to-Xml",
        "inbound": {
            "topic": "",
            "queue": "Activemq.sales.US.IN",
            "brokerurl": "tcp://172.17.1.31:61616",
            "username": "admin",
            "password": "admin"
        },
        "outbound": [
            [
                {
                    "topic": "",
                    "queue": "Activemq.sales1.US.OUT",
                    "brokerurl": "tcp://172.17.1.165:61616",
                    "username": "admin",
                    "password": "admin"
                },
                {
                    "topic": "",
                    "queue": "Activemq.sales2.US.OUT",
                    "brokerurl": "tcp://172.17.2.77:61616",
                    "username": "admin",
                    "password": "admin"
                }
            ]
        ],
        "nodes": [
            {
                "id": "dndnode_0",
                "type": "Amq",
                "position": {
                    "x": -127.5,
                    "y": 264.5
                },
                "data": {
                    "label": "Amq"
                },
                "width": 40,
                "height": 40,
                "selected": false,
                "positionAbsolute": {
                    "x": -127.5,
                    "y": 264.5
                },
                "dragging": false
            },
            {
                "id": "dndnode_1",
                "type": "Ingate",
                "position": {
                    "x": -44,
                    "y": 268.75
                },
                "data": {
                    "label": "Ingate"
                },
                "width": 40,
                "height": 40,
                "selected": false,
                "positionAbsolute": {
                    "x": -44,
                    "y": 268.75
                },
                "dragging": false
            },
            {
                "id": "dndnode_2",
                "type": "Convert",
                "position": {
                    "x": 34.5,
                    "y": 270.75
                },
                "data": {
                    "label": "Convert"
                },
                "width": 40,
                "height": 40,
                "selected": false,
                "positionAbsolute": {
                    "x": 34.5,
                    "y": 270.75
                },
                "dragging": false
            },
            {
                "id": "dndnode_3",
                "type": "Outgate",
                "position": {
                    "x": 146.5,
                    "y": 272.25
                },
                "data": {
                    "label": "Outgate"
                },
                "width": 40,
                "height": 40,
                "selected": false,
                "positionAbsolute": {
                    "x": 146.5,
                    "y": 272.25
                },
                "dragging": false
            },
            {
                "id": "dndnode_4",
                "type": "Amqout",
                "position": {
                    "x": 245.5,
                    "y": 271.75
                },
                "data": {
                    "label": "Amqout"
                },
                "width": 40,
                "height": 40,
                "selected": false,
                "positionAbsolute": {
                    "x": 245.5,
                    "y": 271.75
                },
                "dragging": false
            },
            {
                "id": "dndnode_5",
                "type": "Amqout",
                "position": {
                    "x": 252,
                    "y": 334.75
                },
                "data": {
                    "label": "Amqout"
                },
                "width": 40,
                "height": 40,
                "selected": true,
                "positionAbsolute": {
                    "x": 252,
                    "y": 334.75
                },
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
            },
            {
                "source": "dndnode_3",
                "sourceHandle": null,
                "target": "dndnode_4",
                "targetHandle": null,
                "type": "straight",
                "id": "reactflow__edge-dndnode_3-dndnode_4"
            },
            {
                "source": "dndnode_3",
                "sourceHandle": null,
                "target": "dndnode_5",
                "targetHandle": null,
                "type": "straight",
                "id": "reactflow__edge-dndnode_3-dndnode_5"
            }
        ]
    },
    {
        "flowId": "FLOW1002",
        "flowName": "SAMPLE",
        "stages": "INGATE.OUTGATE",
        "region": "MU",
        "transdata": null,
        "inbound": {
            "topic": "",
            "queue": "ACTIVEMQ.SAMPLE.MU.IN",
            "brokerurl": "tcp://172.17.1.25:61616",
            "username": "admin",
            "password": "admin"
        },
        "outbound": {
            "topic": "",
            "queue": "ACTIVEMQ.SAMPLE.MU.OUT",
            "brokerurl": "tcp://172.17.1.25:61616",
            "username": "admin",
            "password": "admin"
        },
        "nodes": [
            {
                "id": "dndnode_0",
                "type": "Amq",
                "position": {
                    "x": -128.203125,
                    "y": 157
                },
                "data": {
                    "label": "Amq"
                }
            },
            {
                "id": "dndnode_1",
                "type": "Ingate",
                "position": {
                    "x": -34.8046875,
                    "y": 156.75
                },
                "data": {
                    "label": "Ingate"
                }
            },
            {
                "id": "dndnode_2",
                "type": "Outgate",
                "position": {
                    "x": 52.1953125,
                    "y": 157.25
                },
                "data": {
                    "label": "Outgate"
                }
            },
            {
                "id": "dndnode_3",
                "type": "Amqout",
                "position": {
                    "x": 190,
                    "y": 158.25
                },
                "data": {
                    "label": "Amqout"
                }
            }
        ],
        "edges": [
            {
                "source": "dndnode_0",
                "target": "dndnode_1",
                "type": "straight"
            },
            {
                "source": "dndnode_1",
                "target": "dndnode_2",
                "type": "straight"
            },
            {
                "source": "dndnode_2",
                "target": "dndnode_3",
                "type": "straight"
            }
        ]
    }
]
     """