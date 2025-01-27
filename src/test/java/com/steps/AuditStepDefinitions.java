package com.steps;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import io.cucumber.java.After;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.github.bonigarcia.wdm.WebDriverManager;
import io.restassured.response.Response;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


public class AuditStepDefinitions {
	
	private WebDriver driver;
    private Response response;

    @Given("I open audit UI URL {string}")
    public void iOpenAuditUIURL(String url) {
        WebDriverManager.edgedriver().setup();
        driver = new EdgeDriver();
        driver.get(url);
    }

    @When("I enter {string} into the {string} label")
    public void iEnterIntoTheLabel(String value, String fieldLabel) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        WebElement textField = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//label[text()='" + fieldLabel + "']/following-sibling::div/input")
        ));

        textField.clear();
        textField.sendKeys(value);
    }

    @When("I click {string} button")
    public void iClickButton(String buttonText) {
    	 System.out.println("buttonText "+buttonText);
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement button = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//button[text()='" + buttonText + "']")
        ));
        button.click();
    }

    @Then("I open audit UI URL after form submission {string}")
    public void iOpenAuditUIURLAfterSubmission(String url) {
        driver.get(url);
    }


    @When("I hit the audit API {string}")
    public void I_hit_the_audit_API(String endpoint) {
    	System.out.println("url "+endpoint);
        response = given()
                    .get(endpoint);
        System.out.println("url "+response);
    }

    @Then("the response status should be 200")
    public void the_response_status_should_be_200() {
    	 System.out.println("Response audit Body: " + response.asString());
         System.out.println("Response Code: " + response.statusCode());
         assertEquals(200, response.statusCode());  
    }
    
    @Then("I want the following audit details in the JSON format:{string}")
    public void i_want_the_following_audit_details_in_the_json_format(String expectedJson) throws JsonMappingException, JsonProcessingException{
    	 System.out.println("expectedJson "+expectedJson);
    	ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(expectedJson);
        JsonNode actualNode = mapper.readTree(response.getBody().asString());
        JsonNode actualElement = actualNode.isArray() ? actualNode.get(0) : actualNode;
        System.out.println("Audit ID: " + actualElement.get("messageId").asText());
        System.out.println("flowId: " + actualElement.get("flowId").asText());
        System.out.println("region: " + actualElement.get("region").asText());

        System.out.println("expectedNode "+expectedNode);
        System.out.println("actualElement " +actualElement);
        assertEquals(expectedNode, actualElement, "Response JSON does not match the expected JSON.");
    }
    
    @After
    public void closeBrowser() {
        if (driver != null) {
            driver.quit();
        }
    }

}

