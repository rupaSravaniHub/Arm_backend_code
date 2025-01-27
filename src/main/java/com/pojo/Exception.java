package com.pojo;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import com.mongodb.lang.Nullable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Document(collection ="Exception")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Exception {

	@Id
	String 	messageId;
	
	String 	flowId;
	String  flowName;
	String 	region;
	@Nullable
	@Field("transdata")
	String transdata;
	String  inboundQueue,
			stages,
			brokerurl,
			outboundQueue,
			exceptionTimeStamp,
			exceptionRoute,
			replayableStatus,
			errorCode,
			errorMessage;
	
	Object	payload ;
}


