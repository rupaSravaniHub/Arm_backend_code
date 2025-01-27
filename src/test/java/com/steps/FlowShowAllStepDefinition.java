package com.steps;

import static io.restassured.RestAssured.given;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

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

public class FlowShowAllStepDefinition {

    private WebDriver driver;
    private Response response;

    @Given("I open view all UI URL {string}")
    public void iOpenViewAllUIURL(String url) {
        WebDriverManager.edgedriver().setup();
        driver = new EdgeDriver();
        driver.get(url);
    }

    @When("I click the viewAll {string} button")
    public void iClickTheViewAllButton(String buttonText) {
    	System.out.println("buttonText"+buttonText);
         WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
         WebElement button = wait.until(ExpectedConditions.visibilityOfElementLocated(
                 By.xpath("//button[text()='" + buttonText + "']")
         ));
         button.click();
    }

    @When("hit the URL {string}")
    public void hitTheURL(String url) {
        response = given()
                .when()
                .get(url);
    }

    @Then("data should be like this:")
    public void dataShouldBeLikeThis(String expectedJson) throws JsonProcessingException {
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
