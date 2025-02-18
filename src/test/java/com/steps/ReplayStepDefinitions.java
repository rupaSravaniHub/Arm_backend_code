package com.steps;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.time.Duration;

import org.apache.camel.CamelContext;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.component.mock.MockEndpoint;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;

import com.Repo.ExceptionRepo;
import com.controller.ReplayContoller;
import com.pojo.Exception;

import io.cucumber.core.internal.com.fasterxml.jackson.core.JsonProcessingException;
import io.cucumber.core.internal.com.fasterxml.jackson.databind.JsonMappingException;
import io.cucumber.core.internal.com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.After;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.github.bonigarcia.wdm.WebDriverManager;
import io.restassured.RestAssured;
import io.restassured.response.Response;

public class ReplayStepDefinitions {
	@Mock
	private ExceptionRepo exceptionRepo;

	@Mock
	private ProducerTemplate producerTemplate;

	@InjectMocks
	private ReplayContoller replayController;

	private MockMvc mockMvc;

	private WebDriver driver;
	private Response response;
	@Autowired
	ExceptionRepo exceptionrepo;
	@Autowired
	private CamelContext camelContext;

	@Given("I open replay slide {string}")
	public void iOpenReplaySlide(String url) {
		WebDriverManager.edgedriver().setup();
		driver = new EdgeDriver();
		driver.get(url);
	}

	@Given("this URL will be triggered {string}")
	public void thisUrlWillBeTriggered(String apiUrl) {
		System.out.println("API triggered: " + apiUrl);
//		RestAssured.given().get(apiUrl).then().statusCode(200);
	}

	@When("I click on the {string} button")
	public void iClickOnTheButton(String buttonName) {
		System.out.println("buttonName" + buttonName);
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));
		WebElement button = wait.until(
				ExpectedConditions.visibilityOfElementLocated(By.xpath("//button[text()='" + buttonName + "']")));
		button.click();
	}
	
	@Then("hit this URL {string} with the provided parameters {string}, and {string}")
	public void hitThisUrlWithParams(String apiUrl, String flowId, String exceptionRoute) {
	    // Construct the full API request URL
	    String fullUrl = apiUrl + "?flowId=" + flowId + "&exceptionRoute=" + exceptionRoute;

	    // Hit the API using RestAssured
	    response = RestAssured.given()
	                .when()
	                .get(fullUrl)
	                .then()
	                .statusCode(200) // Ensure the response is 200 OK
	                .extract()
	                .response();

	    // Print response for debugging
	    System.out.println("Response: " + response.asString());

	    // Validate response content (optional)
	    Assertions.assertNotNull(response.asString(), "Response should not be null");
	}

	@After
    public void closeBrowser() {
        if (driver != null) {
            driver.quit();
        }
    }
//	@Then("hit this URL {string} with the provided parameters {string}, and {string}")
//	public void hitThisUrlWithParams(String apiUrl, String flowId, String exceptionRoute, String replayException)
//			throws JsonMappingException, JsonProcessingException {
//
//		RestAssured.given().param("flowId", flowId).param("exceptionRoute", exceptionRoute).when().get(apiUrl).then()
//				.statusCode(200).body(equalTo("0"));
//
//		ObjectMapper objectMapper = new ObjectMapper();
//		Exception mockException = objectMapper.readValue(replayException, Exception.class);
//		System.err.println("mockException " + mockException);
//		when(exceptionRepo.findByFlowIdAndExceptionRoute(flowId, exceptionRoute)).thenReturn(mockException);
//		when(producerTemplate.requestBody(anyString(), eq(mockException))).thenReturn("Replay Queue Processed");
//
//		verify(producerTemplate, times(1)).sendBody(eq("direct:Replay"), eq(mockException));
//		verify(exceptionRepo, times(1)).deleteByFlowIdAndExceptionRoute(flowId, exceptionRoute);
//
//		String replayResponse = (String) producerTemplate.requestBody("direct:replayStatus");
//		Assertions.assertEquals("Replay Queue Processed", replayResponse);
//	}
}