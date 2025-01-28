package com.controllerTest;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
    features = "src/test/resources/features/replay.feature", 
    glue = "com.steps", // Path to the package containing your step definitions
    plugin = {"pretty", "html:target/cucumber-reports.html"} // Cucumber plugins for pretty output and HTML report generation
)
public class ReplayTesting {

}
