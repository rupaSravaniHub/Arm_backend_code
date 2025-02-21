package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.camel.ProducerTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Repo.AuditRepo;
import com.Repo.ExceptionRepo;
import com.pojo.Audit;
import com.pojo.Exception;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class ReplayContoller {

	@Autowired
	ExceptionRepo exceptionrepo;
	
	@Autowired
	AuditRepo auditRepo;
	
	@Autowired
	ProducerTemplate producerTemplate;
	
//	http://localhost:9090/getAllReplays
	@CrossOrigin
	@GetMapping("/getAllReplays")
	public ResponseEntity<?> getAllReplays() {
		List<Exception> Allreplays = exceptionrepo.findAll();
//		System.err.println("exceptionDetails "+Allreplays);
		List<Exception> replayable = new ArrayList<Exception>() ;
		for(Exception replay : Allreplays) {
			System.err.println("replay.getReplayableStatus() "+replay.getReplayableStatus());
			if(replay.getReplayableStatus().equalsIgnoreCase("true") ) {
				replayable.add(replay);
			}
		}
		if(Allreplays != null)
			return new ResponseEntity<>(replayable, HttpStatus.OK);
		else
			return new ResponseEntity<>("Data is not Retrived from Exception for replay.", HttpStatus.BAD_REQUEST);
	}
	
//	http://localhost:9090/getReplay?flowId=FLOW1001&exceptionRoute=INGATE
//	Handling Replay
	@CrossOrigin
	@GetMapping("/getReplay")
	public String getReplayById(@RequestParam("flowId") String flowId, @RequestParam("exceptionRoute") String exceptionRoute) {
		Exception replay = exceptionrepo.findByFlowIdAndExceptionRoute(flowId,exceptionRoute);
		Audit auditsForExceptionTrack = getAudit(  replay.getMessageId()); //---
		Map<String, Object> headers = new HashMap<>();
	    headers.put("inAuditStatus", auditsForExceptionTrack.getInAuditStatus());
//	    headers.put("headerKey2", "headerValue2");
		System.err.println("exceptionDetails replay "+replay.getPayload());
		System.err.println("  "+replay.getPayload());
		producerTemplate.sendBodyAndHeaders("direct:Replay", replay, headers);
//	    producerTemplate.sendBody("direct:Replay",replay);
        String replayResponse = (String) producerTemplate.requestBodyAndHeader("direct:replayStatus", null, "CamelHttpResponse", String.class);
	    System.err.println("replayResponse  "+replayResponse);
	   if(replayResponse != null)
		   return exceptionrepo.deleteByFlowIdAndExceptionRoute(flowId,exceptionRoute);
		else
			return "Replay unsucccessful";
	}
	
	
//	@CrossOrigin
//	@GetMapping("/audits")
	public Audit getAudit( String messageId) {
		Audit retrivedAuditTransDetails = auditRepo.findByMessageId(messageId);
		System.out.println("Audits " + retrivedAuditTransDetails);
		if (retrivedAuditTransDetails != null)
			return retrivedAuditTransDetails;
		return null;
		
	}
}
