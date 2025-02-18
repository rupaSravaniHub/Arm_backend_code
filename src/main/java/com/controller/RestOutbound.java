package com.controller;

import java.util.Map;
import java.util.TreeMap;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/outbound")
//http://localhost:8089/outbound/rest.orderDetails.us.out
public class RestOutbound {

Map<String, Object> value = new TreeMap<>();

@PostMapping(value = "/rest...out", consumes = "application/json")
public ResponseEntity<Object> forwardRequest(@RequestBody Object requestBody,
@RequestHeader Map<String, Object> header) {
// System.out.println("request url "+requestURL);
System.out.println("Received request at REST API: " + header);
header.put("currentqueue", "rest.Data1.us.out");
value.put((String) header.get("currentqueue"), requestBody);
System.err.println(" ----" + value);
return ResponseEntity.ok(requestBody);
}

@GetMapping(value = "/rest...out")
public Object receiveRequest(HttpServletRequest request) {
String requestURL = request.getRequestURI();
System.out.println("request url "+requestURL);
System.out.println("Matched URL: " + requestURL.split("/")[2] + " body" + value.get(requestURL.split("/")[2]));
return value.get(requestURL.split("/")[2]);
}
}
