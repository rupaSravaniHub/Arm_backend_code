package com.steps;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.github.bonigarcia.wdm.WebDriverManager;
import io.restassured.response.Response;

public class ReplayStepDefinitions {
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
		System.out.println("buttonName"+buttonName);
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
		WebElement button = wait.until(
				ExpectedConditions.visibilityOfElementLocated(By.xpath("//button[text()='" + buttonName + "']")));
		button.click();
	}

	@Then("hit this URL {string}")
	public void hitThisUrl(String apiUrl) {
		String expectedUrl = apiUrl;
		System.out.println("Expected API hit: " + expectedUrl);
	}
}
