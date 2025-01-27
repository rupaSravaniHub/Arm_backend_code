package com.route;

import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;

@Component
public class ReplayRoute extends RouteBuilder {

	@Override
	public void configure() throws Exception {
		from("direct:Replay")		
				.setHeader("originalMessageId", jsonpath("$.messageId"))
				.setHeader("scenarioId", jsonpath("$.flowId")).setHeader("scenarioName", jsonpath("$.flowName"))
				.setHeader("countryCode", jsonpath("$.region")).setHeader("hops", jsonpath("$.stages"))
				.setHeader("inboundQueue", jsonpath("$.inboundQueue"))
				.setHeader("outboundQueue", jsonpath("$.outboundQueue")).setHeader("brokerurl", jsonpath("$.brokerurl"))
				.setHeader("transdata", simple("jsonpath($.transdata) == null ? null : jsonpath($.transdata) "))
				.setHeader("exceptionRoute", jsonpath("$.exceptionRoute")).setBody(jsonpath("$.payload"))
				.log("MQ camel ${body} ---> ${header.exceptionRoute.toUpperCase()}")
				.toD("activemq:queue:${header.exceptionRoute.toUpperCase()}?replyTo=direct:replayStatus");

		from("direct:replayStatus").setBody().constant("Replay Queue Processed");
	}

}