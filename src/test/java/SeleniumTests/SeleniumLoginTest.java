package SeleniumTests;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class SeleniumLoginTest {
	@Test
	public void testLoginPage() {
		WebDriver driver = new FirefoxDriver();
		
		try {
			driver.get("http://localhost:8080/PolyCoffee/dang_nhap");
			
			driver.findElement(By.id("username"))
				.sendKeys("test123");
			
			driver.findElement(By.id("password"))
				.sendKeys("test123");
			
			driver.findElement(By.cssSelector("button[type='submit']"))
            .click();
			
			Thread.sleep(5000);
			
			
			// Check the result
	        System.out.println("Current URL: " + driver.getCurrentUrl());
	        
	        assertTrue(driver.getCurrentUrl().contains("dang_nhap"));
		} catch (InterruptedException  e) {
			Thread.currentThread().interrupt();
		} finally {
			driver.quit();
		}
	}
}
