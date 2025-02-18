package com.steps;

import io.cucumber.java.After;
import io.cucumber.java.en.*;
import io.github.bonigarcia.wdm.WebDriverManager;
import io.restassured.response.Response;
import io.restassured.RestAssured;

import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.time.Duration;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ExceptionStepDefiniton {

    private WebDriver driver;
    private String flowId;
    private String flowName;
    private String region;
    private Response apiResponse;

    @Given("I open the initial UI URL {string}")
    public void iOpenTheInitialUIURL(String url) {
        WebDriverManager.edgedriver().setup();
        driver = new EdgeDriver();
        driver.get(url);
    }

    @When("I enter {string} into the {string} field")
    public void iEnterIntoTheField(String value, String fieldLabel) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        WebElement textField = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//label[text()='" + fieldLabel + "']/following-sibling::div/input")
        ));

        textField.clear();
        textField.sendKeys(value);
    }

    @When("I click the {string} button")
    public void iClickTheButton(String buttonText) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement button = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//button[text()='" + buttonText + "']")
        ));
        button.click();
    }

    @Then("I open the UI URL after form submission {string}")
    public void iOpenTheUIURLAfterSubmission(String url) {
        driver.get(url);
    }

    @When("I hit the backend API {string}")
    public void iHitTheBackendAPIWithTheProvidedParameters(String apiUrl) {
        apiResponse = RestAssured.given()
                .get(apiUrl);
//        System.out.println("Response Body: " + apiResponse.asString());
//        System.out.println("Response Code: " + apiResponse.statusCode());
    }

    @Then("I should see the following exception details displayed on the UI:")
    public void iShouldSeeTheFollowingExceptionDetailsDisplayedOnTheUI(String expectedResponse) throws Exception {
        ObjectMapper mapper = new ObjectMapper();

        // Deserialize expectedResponse to JsonNode
        JsonNode expectedNode = mapper.readTree(expectedResponse);

        // Deserialize the actual response from the API
        JsonNode actualNode = mapper.readTree(apiResponse.asString());

        // If the actual response is an array, get the first element, otherwise use the root
        JsonNode actualElement = actualNode.isArray() ? actualNode.get(0) : actualNode;

        // Now, compare the expected and actual JSON objects
        assertEquals(expectedNode, actualElement, "Response JSON does not match the expected JSON.");
    }


    @And("the response status from the backend API should be {int}")
    public void theResponseStatusFromTheBackendAPIShouldBe(int expectedStatusCode) {
        System.out.println("Response Body: " + apiResponse.getBody().asString());
        System.out.println("Response Code: " + apiResponse.statusCode());
        assertEquals(expectedStatusCode, apiResponse.statusCode());
    }

    @When("I hit the exceptions backend API {string} with the provided parameters {string}, {string}, and {string}")
    public void iHitTheExceptionsBackendAPIWithTheProvidedParameters(String apiUrl, String flowId, String flowName, String region) {
        // Log query parameters for debugging
        System.out.println("Query Parameters: flowId=" + flowId + ", flowName=" + flowName + ", region=" + region);

        // Make the API call
        apiResponse = RestAssured.given()
            .queryParam("flowId", flowId)
            .queryParam("flowName", flowName)
            .queryParam("region", region)
            .when()
            .get(apiUrl);

        // Log the API URL and response details for debugging
        System.out.println("API URL: " + apiUrl);
        if (apiResponse != null) {
            System.out.println("Response Status: " + apiResponse.statusCode());
            System.out.println("Response Body: " + apiResponse.getBody().asString());
        } else {
            System.out.println("API response is null.");
        }
    }



    @Then("I should see the following flow details displayed on the UI:")
    public void iShouldSeeTheFollowingFlowDetailsDisplayedOnTheUI(String expectedResponse) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(expectedResponse);
        JsonNode actualNode = mapper.readTree(apiResponse.getBody().asString());
        System.out.println("actualNode"+actualNode);
        JsonNode actualElement = actualNode.isArray() ? actualNode.get(0) : actualNode;
        assertEquals(expectedNode, actualElement, "Response JSON does not match the expected JSON.");
    }
    
    @Then("status from the backend API should be {int}")
    public void statusFromTheBackendAPIShouldBe(int expectedStatusCode) {
        if (apiResponse != null) {
            int actualStatusCode = apiResponse.getStatusCode();
            org.junit.Assert.assertEquals("The response status code is not as expected.", expectedStatusCode, actualStatusCode);
        } else {
            org.junit.Assert.fail("API response is null, cannot verify status code.");
        }
    }


    @After
    public void closeBrowser() {
        if (driver != null) {
            driver.quit();
        }
    }
}
