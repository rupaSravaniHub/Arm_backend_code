package com.controllerTest;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
    features = "src/test/resources/features/view.feature", 
    glue = "com.steps", // Path to the package containing your step definitions
    plugin = {"pretty", "html:target/cucumber-reports.html"} // Cucumber plugins for pretty output and HTML report generation
//    tags = "@Audit" // Optional: If you use tags, you can filter by tags here
)
public class ViewTest {

}
