package com.pojo;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import com.mongodb.lang.Nullable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Document(collection ="Exception")
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Exception {

	@Id
	String 	messageId;
	@Nullable
	@Field("transdata")
	String transdata;
	
	String 	flowId;
	String  flowName;
	String 	region;
	String  inboundQueue,
			brokerurl,
			stages,
			outboundQueue,
			exceptionTimeStamp,
			exceptionRoute,
			replayableStatus,
			errorCode,
//			exitStatus,
			errorMessage;
	
	
//	byte[]	payload ;
	String	payload ;
}
