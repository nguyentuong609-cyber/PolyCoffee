package SeleniumTests;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class SeleniumTest {
	
	@Test
	public void testHomePage() {
		WebDriver driver = new FirefoxDriver();
		
		try {
			// Open PolyCoffee homepage
            driver.get("http://localhost:8080/PolyCoffee/Index");

            // Get and print the page title
            String actualTitle = driver.getTitle();
            System.out.println("Page Title: " + actualTitle);

            // Verify the page title
            assertEquals("PolyCoffee", actualTitle);
		} finally {
			driver.quit();
		}
		
	}
}
