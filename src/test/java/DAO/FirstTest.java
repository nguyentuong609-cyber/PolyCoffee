//package DAO;
//
//import org.openqa.selenium.By;
//import org.openqa.selenium.WebDriver;
//import org.openqa.selenium.WebElement;
//import org.openqa.selenium.firefox.FirefoxDriver;
//
//public class FirstTest {
//	public static void main(String[] args) {
//		// 1. Initialize the Firefox Driver (Selenium Manager handles the path automatically)
//	    WebDriver driver = new FirefoxDriver();
//	    
//	    try {
//	    	// 2. Navigate to a website
//	    	driver.get("https://google.com");
//	    	// 3. Maximize the browser window
//	    	driver.manage().window().maximize();
//	    	// 4. Find the search box element by its name
//	        WebElement searchBox = driver.findElement(By.name("q"));
//	        // 5. Type a search query and submit
//	        searchBox.sendKeys("Selenium WebDriver");
//	        searchBox.submit();
//	        // Print the title of the new page
//	        System.out.println("Page title is: " + driver.getTitle());
//	    } catch (Exception e) {
//	    	e.printStackTrace();
//	    } finally {
//	    	// 6. close driver
//	    	driver.quit();
//	    }
//	}
//}
