package com.controllerTest;


import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
    features = "src/test/resources/features/exceptions.feature", 
    glue = "com.steps", // Path to the package containing your step definitions
    plugin = {"pretty", "html:target/cucumber-reports.html"} // Cucumber plugins for pretty output and HTML report generation
)
public class ExceptionTest {

}
