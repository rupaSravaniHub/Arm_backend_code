package com.steps;

import io.cucumber.core.internal.com.fasterxml.jackson.core.JsonProcessingException;
import io.cucumber.core.internal.com.fasterxml.jackson.databind.JsonMappingException;
import io.cucumber.core.internal.com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.CamelContext;
import org.apache.camel.component.mock.MockEndpoint;
import org.junit.jupiter.api.Assertions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Map;

@SpringBootTest
public class ReplayRouteStepDefinitions {

	@Autowired
	private ProducerTemplate producerTemplate;

	@Autowired
	private CamelContext camelContext;

	private Map<String, Object> messageBody;
	private MockEndpoint testDirectMock;


	@Given("the message is sent to the \"direct:Replay\" route")
	public void sendMessageToReplayRoute(String message) throws JsonMappingException, JsonProcessingException {

		ObjectMapper objectMapper = new ObjectMapper();
		messageBody = objectMapper.readValue(message, Map.class);
		producerTemplate.sendBody("direct:Replay", messageBody);
	}

	@Then("consume the message from {string}")
	public void ConsumeMessage(String route1) throws Exception {
		MockEndpoint mockEndpoint = camelContext.getEndpoint("mock:route1", MockEndpoint.class);
		MockEndpoint.assertIsSatisfied(camelContext);
	}

	@And("the payload and set headers should be routed to the queue")
	public void routeMessageToTestQueue() throws Exception {


		String response = (String) producerTemplate.requestBody("direct:Replay");
		ObjectMapper objectMapper = new ObjectMapper();
		messageBody = objectMapper.readValue(response, Map.class);

		String queueName = ((String) messageBody.get("exceptionRoute")).toUpperCase();
		String MOCK_ENDPOINT_URI = "mock:activemq:queue:" + queueName;
		System.out.println("MOCK_ENDPOINT_URI --- " + MOCK_ENDPOINT_URI);
		MockEndpoint testQueueMock = camelContext.getEndpoint(MOCK_ENDPOINT_URI, MockEndpoint.class);
		producerTemplate.sendBody("direct:replayStatus", messageBody);
		System.err.println("transdata  "+messageBody.get("transdata") == null ? null : messageBody.get("transdata"));
		testQueueMock.expectedMessageCount(1);
		testQueueMock.setAssertPeriod(50000);
		testQueueMock.expectedHeaderReceived("originalMessageId", messageBody.get("messageId"));
		testQueueMock.expectedHeaderReceived("scenarioId", messageBody.get("flowId"));
		testQueueMock.expectedHeaderReceived("scenarioName", messageBody.get("flowName"));
		testQueueMock.expectedHeaderReceived("countryCode", messageBody.get("region"));
		testQueueMock.expectedHeaderReceived("hops", messageBody.get("stages"));
		testQueueMock.expectedHeaderReceived("transdata",
				messageBody.get("transdata") == null ? null : messageBody.get("transdata"));
		testQueueMock.expectedHeaderReceived("inboundQueue", messageBody.get("inboundQueue"));
		testQueueMock.expectedHeaderReceived("outboundQueue", messageBody.get("outboundQueue"));
		testQueueMock.expectedHeaderReceived("brokerurl", messageBody.get("brokerurl"));
		testQueueMock.expectedHeaderReceived("exceptionRoute", messageBody.get("exceptionRoute"));
		testQueueMock.expectedBodiesReceived(messageBody.get("payload"));
	}

	@Then("the body should be set to {string}")
	public void validateReplayStatusBody(String body) throws InterruptedException {
		testDirectMock = camelContext.getEndpoint("mock:direct:replayStatus", MockEndpoint.class);
		testDirectMock.expectedBodiesReceived("Replay Queue Processed");
		
		String response = producerTemplate.requestBody("mock:direct:replayStatus", body, String.class);
		Assertions.assertEquals("Replay Queue Processed", response);
		System.err.println("direct:replayStatus "+response);
	}


}

