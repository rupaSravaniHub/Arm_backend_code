Feature: flowShowAll

  Scenario: Retrieve all flow details successfully via UI
    Given I open view all UI URL "http://localhost:3000/viewDetails"
    And I click the viewAll "viewAll" button
    And hit the URL "http://localhost:9090/showAll"
    Then data should be like this:
     """
     {"flowId":"FLOW1034","flowName":"SALES","stages":"INGATE.CONVERT.ROUTEFLIP.OUTGATE","region":"EA","transdata":"Json-Xml","inbound":{"topic":"","queue":"Activemq.sales.ea.in","brokerurl":"tcp://172.17.2.77:61616","username":"","password":""},"outbound":[[{"topic":"KAFKA.WAREHOUSE.SS.OUT","brokerurl":"172.17.1.72:9092"}],[{"queuemanger":"","queuename":"IBMMQ.DISPATCH.ME.OUT","channel":"","connectionName":"172.17.1.80(1414)","username":"","password":""}],[{"url":"http://172.17.1.31:8089/outbound/REST.DELIVERY.SA.OUT"}]],"nodes":[{"id":"dndnode_0","type":"Amq","position":{"x":-183.015625,"y":226},"data":{"label":"Amq"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-183.015625,"y":226},"dragging":false},{"id":"dndnode_1","type":"Ingate","position":{"x":-106.0234375,"y":225.75},"data":{"label":"Ingate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-106.0234375,"y":225.75},"dragging":false},{"id":"dndnode_2","type":"Convert","position":{"x":-33.5234375,"y":225.75},"data":{"label":"Convert"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-33.5234375,"y":225.75},"dragging":false},{"id":"dndnode_3","type":"RouteFlip","position":{"x":37.4765625,"y":227.75},"data":{"label":"RouteFlip"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":37.4765625,"y":227.75},"dragging":false},{"id":"dndnode_4","type":"Outgate","position":{"x":103.9765625,"y":227.25},"data":{"label":"Outgate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":103.9765625,"y":227.25},"dragging":false},{"id":"dndnode_5","type":"kafkaout","position":{"x":204.4765625,"y":170.75},"data":{"label":"kafkaout"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":204.4765625,"y":170.75},"dragging":false},{"id":"dndnode_7","type":"ibmMQout","position":{"x":210.9765625,"y":250.25},"data":{"label":"ibmMQout"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":210.9765625,"y":250.25},"dragging":false},{"id":"dndnode_8","type":"restout","position":{"x":216.9765625,"y":330.25},"data":{"label":"restout"},"width":40,"height":40,"selected":true,"positionAbsolute":{"x":216.9765625,"y":330.25},"dragging":false}],"edges":[{"source":"dndnode_0","sourceHandle":null,"target":"dndnode_1","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_0-dndnode_1"},{"source":"dndnode_1","sourceHandle":null,"target":"dndnode_2","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_1-dndnode_2"},{"source":"dndnode_2","sourceHandle":null,"target":"dndnode_3","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_2-dndnode_3"},{"source":"dndnode_3","sourceHandle":null,"target":"dndnode_4","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_3-dndnode_4"},{"source":"dndnode_4","sourceHandle":null,"target":"dndnode_5","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_4-dndnode_5"},{"source":"dndnode_4","sourceHandle":null,"target":"dndnode_7","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_4-dndnode_7"},{"source":"dndnode_4","sourceHandle":null,"target":"dndnode_8","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_4-dndnode_8"}]},{"flowId":"FLOW1036","flowName":"ORDER","stages":"INGATE.ROUTEFLIP.OUTGATE","region":"LA","transdata":null,"inbound":{"queuemanger":"QM1","queuename":"IBMMQ.ORDER.LA.OUT","channel":"DEV.ADMIN.SVRCONN","connectionName":"172.17.1.80(1414)","username":"admin","password":"passw0rd"},"outbound":[[{"url":"http://172.17.1.31:8089/outbound/rest.dispatch.SS.out"}],[{"topic":"","queue":"Activemq.sales.me.OUT","brokerurl":"tcp://172.17.1.31:61616","username":"admin","password":"password"}]],"nodes":[{"id":"dndnode_0","type":"ibmMQ","position":{"x":-213.515625,"y":207},"data":{"label":"ibmMQ"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-213.515625,"y":207},"dragging":false},{"id":"dndnode_1","type":"Ingate","position":{"x":-122.0234375,"y":205.25},"data":{"label":"Ingate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-122.0234375,"y":205.25},"dragging":false},{"id":"dndnode_2","type":"Outgate","position":{"x":28.4765625,"y":207.25},"data":{"label":"Outgate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":28.4765625,"y":207.25},"dragging":false},{"id":"dndnode_3","type":"RouteFlip","position":{"x":-43.0234375,"y":208.25},"data":{"label":"RouteFlip"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-43.0234375,"y":208.25},"dragging":false},{"id":"dndnode_4","type":"restout","position":{"x":118.4765625,"y":158.75},"data":{"label":"restout"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":118.4765625,"y":158.75},"dragging":false},{"id":"dndnode_5","type":"Amqout","position":{"x":126.9765625,"y":262.25},"data":{"label":"Amqout"},"width":40,"height":40,"selected":true,"positionAbsolute":{"x":126.9765625,"y":262.25},"dragging":false}],"edges":[{"source":"dndnode_0","sourceHandle":null,"target":"dndnode_1","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_0-dndnode_1"},{"source":"dndnode_1","sourceHandle":null,"target":"dndnode_3","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_1-dndnode_3"},{"source":"dndnode_3","sourceHandle":null,"target":"dndnode_2","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_3-dndnode_2"},{"source":"dndnode_2","sourceHandle":null,"target":"dndnode_4","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_2-dndnode_4"},{"source":"dndnode_2","sourceHandle":null,"target":"dndnode_5","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_2-dndnode_5"}]},{"flowId":"FLOW1037","flowName":"MARKETING","stages":"INGATE.OUTGATE","region":"EA","transdata":null,"inbound":{"topic":"KAFKA.MARKETING.EA.IN","brokerurl":"172.17.1.72:9092"},"outbound":[[{"topic":"","queue":"Activemq.MANUFACTURING.US.OUT","brokerurl":"tcp://172.17.2.77:61616","username":"admin","password":"passw0rd"}],[{"queuemanger":"QM1","queuename":"IBMMQ.PURCHASE.LA.OUT","channel":"DEV.ADMIN.SVRCONN","connectionName":"172.17.1.80(1414)","username":"admin","password":"passw0rd"},{"queuemanger":"QM1","queuename":"IBMMQ.MAKING.SS.OUT","channel":"DEV.ADMIN.SVRCONN","connectionName":"172.17.1.80(1414)","username":"","password":""}]],"nodes":[{"id":"dndnode_0","type":"kafka","position":{"x":-190.515625,"y":206},"data":{"label":"kafka"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-190.515625,"y":206},"dragging":false},{"id":"dndnode_1","type":"Ingate","position":{"x":-93.0234375,"y":204.75},"data":{"label":"Ingate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-93.0234375,"y":204.75},"dragging":false},{"id":"dndnode_2","type":"Outgate","position":{"x":5.9765625,"y":209.25},"data":{"label":"Outgate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":5.9765625,"y":209.25},"dragging":false},{"id":"dndnode_3","type":"Amqout","position":{"x":112.9765625,"y":149.25},"data":{"label":"Amqout"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":112.9765625,"y":149.25},"dragging":false},{"id":"dndnode_4","type":"ibmMQout","position":{"x":114.4765625,"y":216.75},"data":{"label":"ibmMQout"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":114.4765625,"y":216.75},"dragging":false},{"id":"dndnode_5","type":"ibmMQout","position":{"x":118.4765625,"y":301.25},"data":{"label":"ibmMQout"},"width":40,"height":40,"selected":true,"positionAbsolute":{"x":118.4765625,"y":301.25},"dragging":false}],"edges":[{"source":"dndnode_0","sourceHandle":null,"target":"dndnode_1","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_0-dndnode_1"},{"source":"dndnode_1","sourceHandle":null,"target":"dndnode_2","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_1-dndnode_2"},{"source":"dndnode_2","sourceHandle":null,"target":"dndnode_3","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_2-dndnode_3"},{"source":"dndnode_2","sourceHandle":null,"target":"dndnode_4","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_2-dndnode_4"},{"source":"dndnode_2","sourceHandle":null,"target":"dndnode_5","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_2-dndnode_5"}]},{"flowId":"FLOW1047","flowName":"PURCHASEORDERRPA108","stages":"INGATE.OUTGATE","region":"MS","transdata":null,"inbound":{"topic":"","queue":"Activemq.PurchaseOrderrpa108.MS.IN","brokerurl":"tcp://localhost:61616","username":"","password":""},"outbound":[[{"topic":"","queue":"Activemq.PurchaseOrder109.MS.OUT","brokerurl":"tcp://localhost:61616","username":"","password":""}]],"nodes":[{"id":"dndnode_0","type":"Amq","position":{"x":-81.21875,"y":152.5},"data":{"label":"Amq"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":-81.21875,"y":152.5},"dragging":false},{"id":"dndnode_1","type":"Ingate","position":{"x":28.421875,"y":148.75},"data":{"label":"Ingate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":28.421875,"y":148.75},"dragging":false},{"id":"dndnode_2","type":"Outgate","position":{"x":132.921875,"y":147.25},"data":{"label":"Outgate"},"width":40,"height":40,"selected":false,"positionAbsolute":{"x":132.921875,"y":147.25},"dragging":false},{"id":"dndnode_3","type":"Amqout","position":{"x":288.921875,"y":145.75},"data":{"label":"Amqout"},"width":40,"height":40,"selected":true,"dragging":false}],"edges":[{"source":"dndnode_0","sourceHandle":null,"target":"dndnode_1","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_0-dndnode_1"},{"source":"dndnode_1","sourceHandle":null,"target":"dndnode_2","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_1-dndnode_2"},{"source":"dndnode_2","sourceHandle":null,"target":"dndnode_3","targetHandle":null,"type":"straight","id":"reactflow__edge-dndnode_2-dndnode_3"}]}
     """