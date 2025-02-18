Feature: Replay Route Testing
  As a developer
  I want to ensure that the Replay route processes and routes messages correctly
  So that messages are routed based on the exceptionRoute and reply statuses are accurate

  Scenario: Process a message through the Replay route and validate headers and response
    Given the message is sent to the "direct:Replay" route
      """
      {
        "messageId": "ID:023b99fd3d67-46063-1737969109007-6:4:1:1:7",
        "flowId": "FLOW1004",
        "flowName": "PURCHASEORDERRPA108",
        "region": "MS",
        "transdata":null,
        "brokerurl": "tcp://localhost:61616",
        "inboundQueue": "Activemq.PurchaseOrderrpa108.MS.IN",
        "stages": "INGATE.OUTGATE",
        "outboundQueue": "Activemq.PurchaseOrder109.MS.OUT",
        "exceptionTimeStamp": "2025-01-27 15:09:07:221",
        "exceptionRoute": "test",
        "errorMessage": "com.example.demo.exception.CustomException: Failed to connect to ActiveMQ broker\r\n\tat com.example.demo.service.ActivemqQueue.amqConnectionCheck(ActivemqQueue.java:73)\r\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\r\n\tat java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n\tat java.base/java.lang.reflect.Method.invoke(Method.java:568)\r\n\tat org.apache.camel.support.ObjectHelper.invokeMethodSafe(ObjectHelper.java:469)\r\n\tat org.apache.camel.component.bean.MethodInfo.invoke(MethodInfo.java:493)\r\n\tat org.apache.camel.component.bean.MethodInfo$1.doProceed(MethodInfo.java:315)\r\n\tat org.apache.camel.component.bean.MethodInfo$1.proceed(MethodInfo.java:285)\r\n\tat org.apache.camel.component.bean.AbstractBeanProcessor.useMethodInvocation(AbstractBeanProcessor.java:122)\r\n\tat org.apache.camel.component.bean.AbstractBeanProcessor.process(AbstractBeanProcessor.java:88)\r\n\tat org.apache.camel.component.bean.BeanProcessor.process(BeanProcessor.java:81)\r\n\tat org.apache.camel.processor.errorhandler.RedeliveryErrorHandler$RedeliveryTask.doRun(RedeliveryErrorHandler.java:834)\r\n\tat org.apache.camel.processor.errorhandler.RedeliveryErrorHandler$RedeliveryTask.run(RedeliveryErrorHandler.java:740)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.doRun(DefaultReactiveExecutor.java:199)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.executeReactiveWork(DefaultReactiveExecutor.java:189)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.tryExecuteReactiveWork(DefaultReactiveExecutor.java:166)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor$Worker.schedule(DefaultReactiveExecutor.java:148)\r\n\tat org.apache.camel.impl.engine.DefaultReactiveExecutor.scheduleMain(DefaultReactiveExecutor.java:59)\r\n\tat org.apache.camel.processor.Pipeline.process(Pipeline.java:163)\r\n\tat org.apache.camel.impl.engine.CamelInternalProcessor.processNonTransacted(CamelInternalProcessor.java:355)\r\n\tat org.apache.camel.impl.engine.CamelInternalProcessor.process(CamelInternalProcessor.java:331)\r\n\tat org.apache.camel.impl.engine.DefaultAsyncProcessorAwaitManager.process(DefaultAsyncProcessorAwaitManager.java:82)\r\n\tat org.apache.camel.support.AsyncProcessorSupport.process(AsyncProcessorSupport.java:32)\r\n\tat org.apache.camel.component.jms.EndpointMessageListener.onMessage(EndpointMessageListener.java:132)\r\n\tat org.springframework.jms.listener.AbstractMessageListenerContainer.doInvokeListener(AbstractMessageListenerContainer.java:787)\r\n\tat org.springframework.jms.listener.AbstractMessageListenerContainer.invokeListener(AbstractMessageListenerContainer.java:742)\r\n\tat org.springframework.jms.listener.AbstractMessageListenerContainer.doExecuteListener(AbstractMessageListenerContainer.java:720)\r\n\tat org.springframework.jms.listener.AbstractPollingMessageListenerContainer.doReceiveAndExecute(AbstractPollingMessageListenerContainer.java:333)\r\n\tat org.springframework.jms.listener.AbstractPollingMessageListenerContainer.receiveAndExecute(AbstractPollingMessageListenerContainer.java:270)\r\n\tat org.springframework.jms.listener.DefaultMessageListenerContainer$AsyncMessageListenerInvoker.invokeListener(DefaultMessageListenerContainer.java:1257)\r\n\tat org.springframework.jms.listener.DefaultMessageListenerContainer$AsyncMessageListenerInvoker.executeOngoingLoop(DefaultMessageListenerContainer.java:1247)\r\n\tat org.springframework.jms.listener.DefaultMessageListenerContainer$AsyncMessageListenerInvoker.run(DefaultMessageListenerContainer.java:1140)\r\n\tat java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)\r\n\tat java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635)\r\n\tat java.base/java.lang.Thread.run(Thread.java:833)\r\n",
        "payload": "{\"order_id\":\"order101\",\"items\":[]}"
      }
      """
    Then consume the message from "direct:Replay"
    And the payload and set headers should be routed to the queue
    Then the body should be set to "Replay Queue Processed"