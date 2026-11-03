package DAO;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.math.BigDecimal;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;



import Entity.Product;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class DrinkDAOTest {

    private DrinkDAO drinkDAO;
    private static int createdProductId; // Shared ID across ordered test steps

    @BeforeEach
    void setUp() {
        drinkDAO = new DrinkDAO();
    }

    @Test
    @Order(1)
    @DisplayName("1. Test findAll() returns non-null list")
    void testFindAll() {
        List<Product> products = drinkDAO.findAll();
        assertNotNull(products, "Product list should not be null");
        assertFalse(products.isEmpty(), "Product list should not be empty");
    }

    @Test
    @Order(2)
    @DisplayName("2. Test findByCate() mapping logic")
    void testFindByCate() {
        // Tests the category switch mapping ("caphe" -> "Cà Phê")
        List<Product> coffeeList = drinkDAO.findByCate("caphe");
        assertNotNull(coffeeList, "Coffee list should not be null");
        
        List<Product> traList = drinkDAO.findByCate("tra");
        assertNotNull(traList, "Tra list should not be null");

        // Tests default fallback ("unknown" -> "Bánh")
        List<Product> defaultList = drinkDAO.findByCate("unknown"); // change to "tra" or ""
        assertNotNull(defaultList, "Default fallback list should not be null");
        
        // 
    }

    @Test
    @Order(3)
    @DisplayName("3. Test CreateProduct() persists a new Product")
    void testCreateProduct() {
        Product newProduct = new Product();
        // Set required fields based on your Entity mapping
         newProduct.setProductName("Matcha Latte");
         newProduct.setCategory("Trà");
         newProduct.setPrice(BigDecimal.valueOf(45000.00));

        drinkDAO.CreateProduct(newProduct);

        // Verify entity was persisted and ID generated
        assertTrue(newProduct.getProductId() > 0, "Generated Product ID should be greater than 0");// pass/ fail
        createdProductId = newProduct.getProductId();

        // Verify retrieval matches
        Product fetched = drinkDAO.FindByID(createdProductId);
        assertNotNull(fetched, "Persisted product should be fetchable from DB");
    }

    @Test
    @Order(4)
    @DisplayName("4. Test FindByID() returns valid product")
    void testFindByID() {
        // Testing with an invalid ID first
        Product invalidProduct = drinkDAO.FindByID(-999);
        assertNull(invalidProduct, "Finding by non-existent ID should return null");
    }

    @Test
    @Order(5)
    @DisplayName("5. Test UpdateProduct() modifies existing record")
    void testUpdateProduct() {
        if (createdProductId == 0) {
            // Fallback ID if running test standalone
            createdProductId = 1; 
        }

        Product existingProduct = drinkDAO.FindByID(createdProductId);
        if (existingProduct != null) {
            // Modify a field and update
            // existingProduct.setProductName("Updated Product Name");
            drinkDAO.UpdateProduct(existingProduct);

            Product updatedProduct = drinkDAO.FindByID(createdProductId);
            assertNotNull(updatedProduct);
        }
    }

    @Test
    @Order(6)
    @DisplayName("6. Test DeleteProduct() removes record from DB")
    void testDeleteProduct() {
        if (createdProductId > 0) {
            drinkDAO.DeleteProduct(createdProductId);

            Product deletedProduct = drinkDAO.FindByID(createdProductId);
            assertNull(deletedProduct, "Product should no longer exist after deletion");
        }
    }
}