package DAO;

import static org.junit.jupiter.api.Assertions.*;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import Entity.Bill;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class BillDAOTest {

    private BillDAO billDAO;

    private static Integer createdBillId;

    @BeforeEach
    void setUp() {
        billDAO = new BillDAO();
    }

    @AfterEach
    void tearDown() {
        billDAO.close();
    }

    // Remove the test bill from the database after ALL tests finish
    @AfterAll
    static void cleanUp() {
        if (createdBillId == null) return;

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyCoffee");
        EntityManager em = emf.createEntityManager();
        try {
            Bill bill = em.find(Bill.class, createdBillId);
            if (bill != null) {
                em.getTransaction().begin();
                em.remove(bill);
                em.getTransaction().commit();
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }

    // ================= CREATE / FIND (order matters) =================

    @Test
    @Order(1)
    @DisplayName("createBill() saves a new bill")
    void testCreateBill() {
        Bill newBill = new Bill();
        newBill.setTableNumber("TEST-01");
        newBill.setTotal(BigDecimal.ZERO);
        newBill.setStatus("PENDING");
        newBill.setCreatedDate(new Date());
        newBill.setNote("JUnit test bill");

        boolean created = billDAO.createBill(newBill);

        assertTrue(created, "Bill should be created");
        assertNotNull(newBill.getBillId(), "Generated bill ID should not be null");

        createdBillId = newBill.getBillId();

        Bill savedBill = billDAO.findByBillId(createdBillId);
        assertNotNull(savedBill, "Created bill should be retrievable");
        assertEquals("TEST-01", savedBill.getTableNumber());
        assertEquals("PENDING", savedBill.getStatus());
        assertEquals(0, BigDecimal.ZERO.compareTo(savedBill.getTotal()));
    }

    @Test
    @Order(2)
    @DisplayName("findByBillId() finds the bill created earlier")
    void testFindByBillId() {
        assertNotNull(createdBillId, "testCreateBill must run first");

        Bill testBill = billDAO.findByBillId(createdBillId);

        assertNotNull(testBill, "Bill should be found");
        assertEquals(createdBillId, testBill.getBillId());
        assertEquals("TEST-01", testBill.getTableNumber());
        assertEquals("JUnit test bill", testBill.getNote());
    }

    @Test
    @Order(3)
    @DisplayName("findByBillId() returns null for nonexistent ID")
    void testFindByBillIdNotFound() {
        assertNull(billDAO.findByBillId(-999));
    }

    @Test
    @Order(4)
    @DisplayName("getOrderById() finds the created bill")
    void testGetOrderByIdFound() {
        assertNotNull(createdBillId, "testCreateBill must run first");

        Bill bill = billDAO.getOrderById(createdBillId);

        assertNotNull(bill);
        assertEquals(createdBillId, bill.getBillId());
    }

    // ================= UPDATE STATUS =================

    @Test
    @Order(5)
    @DisplayName("updateOrderStatus() changes status and note")
    void testUpdateOrderStatus() {
        assertNotNull(createdBillId, "testCreateBill must run first");

        boolean updated = billDAO.updateOrderStatus(createdBillId, "making", "Updated by JUnit");

        assertTrue(updated, "Update should succeed");

        // findByBillId uses a fresh EntityManager, so this reads from the DB
        Bill bill = billDAO.findByBillId(createdBillId);
        assertEquals("MAKING", bill.getStatus(), "Status should be saved in uppercase");
        assertEquals("Updated by JUnit", bill.getNote());
    }

    @Test
    @Order(6)
    @DisplayName("updateOrderStatus() with null note sets empty note")
    void testUpdateOrderStatusNullNote() {
        assertNotNull(createdBillId, "testCreateBill must run first");

        assertTrue(billDAO.updateOrderStatus(createdBillId, "COMPLETED", null));

        Bill bill = billDAO.findByBillId(createdBillId);
        assertEquals("COMPLETED", bill.getStatus());
        assertEquals("", bill.getNote());
    }

    @Test
    @Order(7)
    @DisplayName("updateOrderStatus() returns false for nonexistent bill")
    void testUpdateOrderStatusNotFound() {
        assertFalse(billDAO.updateOrderStatus(-999, "MAKING", "note"));
    }

    // ================= QUERIES =================

    @Test
    @Order(8)
    @DisplayName("getOrderById() returns null for nonexistent ID")
    void testGetOrderByIdNotFound() {
        assertNull(billDAO.getOrderById(-999),
                "Bill should be null when the ID does not exist");
    }

    @Test
    @Order(9)
    @DisplayName("getStatusCounts() returns expected statuses")
    void testGetStatusCounts() {
        Map<String, Integer> counts = billDAO.getStatusCounts();

        assertNotNull(counts);
        assertTrue(counts.containsKey("PENDING"));
        assertTrue(counts.containsKey("MAKING"));
        assertTrue(counts.containsKey("COMPLETED"));
        assertTrue(counts.containsKey("CANCELLED"));

        for (Integer count : counts.values()) {
            assertTrue(count >= 0, "Status counts should not be negative");
        }
    }

    @Test
    @Order(10)
    @DisplayName("getStatusCounts() counts the completed test bill")
    void testGetStatusCountsIncludesTestBill() {
        // after testUpdateOrderStatusNullNote the test bill is COMPLETED
        assertTrue(billDAO.getStatusCounts().get("COMPLETED") >= 1);
    }

    @Test
    @Order(11)
    @DisplayName("getOrdersByStatus() filters by status (case-insensitive)")
    void testGetOrdersByStatusFilter() {
        List<Bill> bills = billDAO.getOrdersByStatus("completed");

        assertNotNull(bills);
        assertFalse(bills.isEmpty(), "Test bill should be COMPLETED");
        for (Bill bill : bills) {
            assertEquals("COMPLETED", bill.getStatus().toUpperCase());
        }
    }

    @Test
    @Order(12)
    @DisplayName("getOrdersByStatus() returns all orders for ALL, null and blank")
    void testGetOrdersByStatusAll() {
        List<Bill> all = billDAO.getOrdersByStatus("ALL");

        assertNotNull(all);
        assertFalse(all.isEmpty());
        for (Bill bill : all) {
            assertNotNull(bill.getBillId());
        }

        assertEquals(all.size(), billDAO.getOrdersByStatus(null).size());
        assertEquals(all.size(), billDAO.getOrdersByStatus("   ").size());
    }

    @Test
    @Order(13)
    @DisplayName("getOrdersByStatus() is sorted by createdDate descending")
    void testGetOrdersByStatusSorted() {
        List<Bill> bills = billDAO.getOrdersByStatus("ALL");

        for (int i = 0; i < bills.size() - 1; i++) {
            assertFalse(
                bills.get(i).getCreatedDate().before(bills.get(i + 1).getCreatedDate()),
                "Bills should be newest first");
        }
    }

    @Test
    @Order(14)
    @DisplayName("FindByIdUser() returns null for nonexistent user")
    void testFindByIdUserNotFound() {
        // documents current behavior (arguably should be an empty list)
        assertNull(billDAO.FindByIdUser(-999));
    }
}