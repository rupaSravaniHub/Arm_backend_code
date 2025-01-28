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

public class FlowSearchStepDefiniton {

    private WebDriver driver;
    private Response response;

    @Given("I open flow search UI URL {string}")
    public void iOpenFlowSearchUIURL(String url) {
        WebDriverManager.edgedriver().setup();
        driver = new EdgeDriver();
        driver.get(url);
    }

    @When("I enter {string} into the {string} search label")
    public void iEnterIntoTheSearchLabel(String value, String fieldLabel) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        WebElement textField = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//label[text()='" + fieldLabel + "']/following-sibling::div/input")
        ));

        textField.clear();
        textField.sendKeys(value);
    }

    @When("Click flow search {string} button")
    public void clickFlowSearchButton(String buttonText) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement button = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//button[text()='" + buttonText + "']")
        ));
        button.click();
    }

    @Then("Hit flow search API {string}")
    public void hitFlowSearchAPI(String endpoint) {
        response = given()
                    .get(endpoint);
    }

    @Then("the response should be 200")
    public void the_response_should_be_200() {
        System.out.println("Response Body: " + response.asString());
        System.out.println("Response Code: " + response.statusCode());
        assertEquals(200, response.statusCode());  
    }

    @Then("I want the following valid flow search in the JSON format:")
    public void iWantTheFollowingValidFlowSearchInTheJSONFormat(String expectedJson) throws JsonMappingException, JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode expectedNode = mapper.readTree(expectedJson);
        JsonNode actualNode = mapper.readTree(response.getBody().asString());
        JsonNode actualElement = actualNode.isArray() ? actualNode.get(0) : actualNode;

        assertEquals(expectedNode, actualElement, "Response JSON does not match the expected JSON.");
    }

//    @After
//    public void closeBrowser() {
//        if (driver != null) {
//            driver.quit();
//        }
//    }
}
