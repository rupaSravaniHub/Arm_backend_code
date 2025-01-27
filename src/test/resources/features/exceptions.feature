Feature: Retrieve Exception Details

  Scenario: Retrieve valid exception details successfully via UI
    Given I open the initial UI URL "http://localhost:3000/exceptionFilter"
    When I enter "FLOW1001" into the "Flow Id" field
    And I enter "SALES" into the "Flow Name" field
    And I enter "US" into the "Region" field
    And I click the "Faults" button
    Then I open the UI URL after form submission "http://localhost:3000/exceptionDetails"
    When I hit the backend API "http://localhost:9090/exception?flowId=FLOW1001&flowName=SALES&region=US"
    Then I should see the following exception details displayed on the UI:
      """
      {
      "messageId": "ID:e141f12ad4ct-38445-1737541886095-4:1:1:1:1",
      "flowId": "FLOW1001",
      "flowName": "SALES",
      "region": "US",
      "brokerurl": "172.17.1.165:9092,tcp://172.17.1.72:61616",
      "inboundQueue": "Activemq.Sales.MS.IN",
      "stages": "INGATE.CONVERT.OUTGATE",
      "outboundQueue": "kafka.PurchaseOrders.US.OUT,Activemq.Sales.NS.OUT",
      "exceptionTimeStamp": "2025-01-22 10:48:03:277",
      "exceptionRoute": "CONVERT",
      "replayableStatus": "true",
      "errorCode": "509",
      "errorMessage": "java.security.InvalidKeyException: No installed provider supports this key: (null)\r\n\tat java.base/javax.crypto.Cipher.chooseProvider(Cipher.java:958)\r\n\tat java.base/javax.crypto.Cipher.init(Cipher.java:1299)\r\n\tat java.base/javax.crypto.Cipher.init(Cipher.java:1236)\r\n\tat com.Encrypt.MessageEncryption.encryptMessage(MessageEncryption.java:47)\r\n\tat com.Encrypt.MessageEncryption.MessageEncrypt(MessageEncryption.java:35)\r\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n\tat java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n\tat org.apache.camel.support.ObjectHelper.invokeMethodSafe(ObjectHelper.java:469)\r\n\tat org.apache.camel.component.bean.MethodInfo.invoke(MethodInfo.java:493)\r\n\tat org.apache.camel.component.bean.MethodInfo$1.doProceed(MethodInfo.java:315)\r\n\tat org.apache.camel.component.bean.MethodInfo$1.proceed(MethodInfo.java:285)\r\n\tat org.apache.camel.component.bean.AbstractBeanProcessor.useMethodInvocation(AbstractBeanProcessor.java:122)\r\n\tat org.apache.camel.component.bean.AbstractBeanProcessor.process(AbstractBeanProcessor.java:88)\r\n\tat org.apache.camel.component.bean.BeanProcessor.process(BeanProcessor.java:81)\r\n\tat org.apache.camel.processor.errorhandler.RedeliveryErrorHandler$RedeliveryTask.doRun(RedeliveryErrorHandler.java:834)\r\n\tat org.apache.camel.processor.errorhandler.RedeliveryErrorHandler$RedeliveryTask.run(RedeliveryErrorHandler.java:740)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.doRun(DefaultReactiveExecutor.java:199)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.executeReactiveWork(DefaultReactiveExecutor.java:189)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.tryExecuteReactiveWork(DefaultReactiveExecutor.java:166)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.schedule(DefaultReactiveExecutor.java:148)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor.scheduleMain(DefaultReactiveExecutor.java:59)\r\n\tat org.apache.camel.processor.Pipeline.process(Pipeline.java:163)\r\n\tat org.apache.camel.impl.engine.CamelInternalProcessor.processNonTransacted(CamelInternalProcessor.java:355)\r\n\tat org.apache.camel.impl.engine.CamelInternalProcessor.process(CamelInternalProcessor.java:331)\r\n\tat org.apache.camel.impl.engine.DefaultAsyncProcessorAwaitManager.process(DefaultAsyncProcessorAwaitManager.java:82)\r\n\tat org.apache.camel.support.AsyncProcessorSupport.process(AsyncProcessorSupport.java:32)\r\n\tat org.apache.camel.component.jms.EndpointMessageListener.onMessage(EndpointMessageListener.java:132)\r\n\tat org.springframework.jms.listener.AbstractMessageListenerContainer.doInvokeListener(AbstractMessageListenerContainer.java:787)\r\n\tat org.springframework.jms.listener.AbstractMessageListenerContainer.invokeListener(AbstractMessageListenerContainer.java:742)\r\n\tat org.springframework.jms.listener.AbstractMessageListenerContainer.doExecuteListener(AbstractMessageListenerContainer.java:720)\r\n\tat org.springframework.jms.listener.AbstractPollingMessageListenerContainer.doReceiveAndExecute(AbstractPollingMessageListenerContainer.java:333)\r\n\tat org.springframework.jms.listener.AbstractPollingMessageListenerContainer.receiveAndExecute(AbstractPollingMessageListenerContainer.java:270)\r\n\tat org.springframework.jms.listener.DefaultMessageListenerContainer$AsyncMessageListenerInvoker.invokeListener(DefaultMessageListenerContainer.java:1257)\r\n\tat org.springframework.jms.listener.DefaultMessageListenerContainer$AsyncMessageListenerInvoker.executeOngoingLoop(DefaultMessageListenerContainer.java:1247)\r\n\tat org.springframework.jms.listener.DefaultMessageListenerContainer$AsyncMessageListenerInvoker.run(DefaultMessageListenerContainer.java:1140)\r\n\tat java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)\r\n\tat java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635)\r\n\tat java.base/java.lang.Thread.run(Thread.java:833)\r\n",
      "payload": "10"
      }
      """
    And the response status from the backend API should be 200
    When I hit the flows backend API "http://localhost:9090/search" with the provided parameters
    Then I should see the following flow details displayed on the UI:
      """
       {
      "flowId": "FLOW1001",
      "flowName": "SALES",
      "stages": "INGATE.CONVERT.OUTGATE",
      "region": "US",
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
      }
      """
    And the response status from the flows backend API should be 200
