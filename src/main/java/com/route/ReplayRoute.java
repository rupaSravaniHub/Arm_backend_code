package com.route;

import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;

@Component
public class ReplayRoute extends RouteBuilder{

	@Override
	public void configure() throws Exception {
		from("direct:Replay")
//		from("activemq:queue:reply")
		.routeId("ReplyRoute")
		.marshal().json()
		 .log("reply ${body}")
		 	
			.setHeader("messageId", jsonpath("$.messageId"))
			.setHeader("scenarioId", jsonpath("$.flowId"))
			.setHeader("scenarioName", jsonpath("$.flowName"))
			.setHeader("countryCode", jsonpath("$.region"))
		    .setHeader("hops", jsonpath("$.stages"))
		    .setHeader("transdata", jsonpath("$.transdata"))
		    .log("transdata ${header.transdata}")
			.setHeader("inboundQueue", jsonpath("$.inboundQueue"))
			.setHeader("outboundQueue", jsonpath("$.outboundQueue"))
			.setHeader("brokerurl", jsonpath("$.brokerurl"))
			.setHeader("exceptionRoute", jsonpath("$.exceptionRoute"))
//			.setHeader("exitStatus", jsonpath("$.exitStatus"))
			.setBody(jsonpath("$.payload"))
			.validate(header("exceptionRoute").isNotNull())
		.log("MQ  camel ${body} ---> ${header.exceptionRoute.toUpperCase()}")
//		.to("activemq:queue:ttt")
	        .toD("activemq:queue:${header.exceptionRoute.toUpperCase()}?replyTo=direct:replayStatus")
	        .log("test ${body} ---> ${headers}")
	     ;
		
		from("direct:replayStatus")
        .setBody().constant("Replay Queue Processed");
	}

}
