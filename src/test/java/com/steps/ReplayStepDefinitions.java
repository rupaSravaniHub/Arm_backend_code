package com.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.time.Duration;

import org.junit.Assert;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.Repo.ExceptionRepo;
import com.pojo.Exception;

import io.cucumber.java.After;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.github.bonigarcia.wdm.WebDriverManager;
import io.restassured.RestAssured;
import io.restassured.response.Response;

public class ReplayStepDefinitions {

	@Mock
	private ExceptionRepo exceptionrepo;

	public ReplayStepDefinitions() {
		MockitoAnnotations.openMocks(this);
	}

	private WebDriver driver;
	private Response response;

	@Given("I open replay slide {string}")
	public void iOpenReplaySlide(String url) {
		WebDriverManager.edgedriver().setup();
		driver = new EdgeDriver();
		driver.get(url);
	}

	@Given("this URL will be triggered {string}")
	public void thisUrlWillBeTriggered(String apiUrl) {
		System.out.println("API triggered: " + apiUrl);
	}

	@When("I click on the {string} button")
	public void iClickOnTheButton(String buttonName) {
		System.out.println("buttonName" + buttonName);
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
		WebElement button = wait.until(
				ExpectedConditions.visibilityOfElementLocated(By.xpath("//button[text()='" + buttonName + "']")));
		button.click();
	}

	@Then("hit this URL {string} with {string} and {string} parameters")
	public void hitThisUrl(String apiUrl, String flowId, String exceptionRoute) {
		response = RestAssured.given().queryParam("flowId", flowId).queryParam("exceptionRoute", exceptionRoute).when()
				.get(apiUrl);
		Exception exception = new Exception("ID:023b99fd3d67-46063-1737969109007-6:4:1:1:7", "FLOW1047",
				"PURCHASEORDERRPA108", "MS", null, "Activemq.PurchaseOrderrpa108.MS.IN", "INGATE.OUTGATE",
				"tcp://localhost:61616", "Activemq.PurchaseOrder109.MS.OUT", "2025-01-27 15:09:07:221", "INGATE",
				"true", "512", "com.example.demo.exception.CustomException: Failed to connect to ActiveMQ broker",
				"{\n" + "\"order_id\": \"order01\",\n" + "\"customer_id\": \"67890\",\n"
						+ "\"address\": \"123 Main St, CapitalState\",\n" + "\"region\":\"ME\",\n" + "\"items\": [\n"
						+ "{\n" + "\"name\": \"Widget\",\n" + "\"quantity\": \"2\"\n" + "},\n" + "{\n"
						+ "\"name\": \"Gadget\",\n" + "\"quantity\": \"1\"\n" + "}\n" + "]\n" + "}");

		when(exceptionrepo.findByFlowIdAndExceptionRoute(flowId, exceptionRoute)).thenReturn(exception);
		when(exceptionrepo.deleteByFlowIdAndExceptionRoute(flowId, exceptionRoute)).thenReturn("1");
		// Assert
		assertEquals("1", exceptionrepo.deleteByFlowIdAndExceptionRoute(flowId, exceptionRoute));
		verify(exceptionrepo, times(1)).deleteByFlowIdAndExceptionRoute(flowId, exceptionRoute);
	}

	@Then("status from the reply API should be {int}")
	public void statusFromTheBackendAPIShouldBe(int expectedStatusCode) {
		if (response != null) {
			int actualStatusCode = response.getStatusCode();
			Assert.assertEquals("The response status code is not as expected.", expectedStatusCode,
					actualStatusCode);
		} else {
			Assert.fail("API response is null, cannot verify status code.");
		}
	}

	@After
	public void closeBrowser() {
		if (driver != null) {
			driver.quit();
		}
	}
}