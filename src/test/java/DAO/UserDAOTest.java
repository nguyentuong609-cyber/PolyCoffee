package DAO;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import Entity.Users;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class UserDAOTest {
	private UserDAO UserDAO;
	
	private static int createdUserId;
	
	@BeforeEach
	void setUp() {
		UserDAO = new UserDAO();
	}
	
	@Test
	@Order(1)
	@DisplayName("1. Test findAll() returns non null list")
	void testFindAll() {
		List<Users> users = UserDAO.findAll();
		assertNotNull(users, "User List should not be null");
	}
	
	@Test
	@Order(2)
	@DisplayName("2. Test findById() returns null for nonexistent ID")
	void testFindByIdNotFound() {
		Users user = UserDAO.findById(-999);
		assertNull(user, "User should not exist");
	}
	
	@Test
	@Order(3)
	@DisplayName("3. Test findByEmail() returns null when email is not found")
	void testFindByEmailNotFound() {
		Users user = UserDAO.findByEmail(
				"nonexistence-user-987654@example.com"
				);
		
		assertNull(user, "No user should not match this email");
	}
	
	@Test
	@Order(4)
	@DisplayName("4. Test FindByID() returns null for unknown username")
	void testFindByUsernameNotFound() {
		Users user = UserDAO.FindByID(
				"nonexistent-user-987654"
				);
		assertNull(user, "No user should not match by this ");
	}
	
	@Test
	@Order(5)
	@DisplayName("5. Test CreateUser() saves a new user")
	void testCreateUser() {

	    Users newUser = new Users();

	    newUser.setUserName("test_user_987654");
	    newUser.setPassword("test_password");
	    newUser.setUserPhone("0900000000");
	    newUser.setRole("USER");
	    newUser.setEmail("test_user_987654@example.com");

	    UserDAO.CreateUser(newUser);

	    assertNotNull(
	        newUser.getUserId(),
	        "User ID should be generated"
	    );

	    createdUserId = newUser.getUserId();

	    Users fetchedUser = UserDAO.findById(createdUserId);

	    assertNotNull(
	        fetchedUser,
	        "Created user should be retrievable"
	    );

	    assertEquals(
	        "test_user_987654",
	        fetchedUser.getUserName(),
	        "Username should match"
	    );
	}
	
	@Test
	@Order(6)
	@DisplayName("6. Test findById() finds an existing user")
	void testFindByIdFound() {
	    assertTrue(createdUserId > 0,
	            "A test user must be created first");

	    Users user = UserDAO.findById(createdUserId);

	    assertNotNull(user, "User should be found");
	    assertEquals("test_user_987654", user.getUserName());
	}
	
	@Test
	@Order(7)
	@DisplayName("7. Test findByEmail() finds an existing user via email")
	void testFindByEmail() {
		assertTrue(createdUserId > 0,
				"A test user must be created first");
		
		Users user = UserDAO.findByEmail("test_user_987654@example.com");
		
		assertNotNull(user, "User should be found");
		assertEquals("test_user_987654@example.com", user.getEmail());
		
	}
	
	@Test
	@Order(8)
	@DisplayName("8. Test UpdateUser() modifies a user")
	void testUpdateUser() {

	    assertTrue(
	        createdUserId > 0,
	        "A test user must be created first"
	    );

	    Users existingUser = UserDAO.findById(createdUserId);

	    assertNotNull(existingUser, "Test user should exist");

	    existingUser.setUserPhone("0911111111");

	    UserDAO.UpdateUser(existingUser);

	    Users updatedUser = UserDAO.findById(createdUserId);

	    assertNotNull(updatedUser, "User should still exist");

	    assertEquals(
	        "0911111111",
	        updatedUser.getUserPhone(),
	        "Phone number should be updated"
	    );
	}
	
	@Test
	@Order(9)
	@DisplayName("9. Test DeleteUser() removes a user")
	void testDeleteUser() {

	    assertTrue(
	        createdUserId > 0,
	        "A test user must be created first"
	    );

	    Users existingUser = UserDAO.findById(createdUserId);

	    assertNotNull(existingUser, "Test user should exist before deletion");

	    UserDAO.DeleteUser(createdUserId);

	    Users deletedUser = UserDAO.findById(createdUserId);

	    assertNull(
	        deletedUser,
	        "Deleted user should no longer exist"
	    );
	}
	
	
	@Test
	@Order(10)
	@DisplayName("10. Test DeleteUser() handles nonexistent ID")
	void testDeleteUserNotFound() {
	    assertDoesNotThrow(
	        () -> UserDAO.DeleteUser(-999)
	    );

	    assertNull(UserDAO.findById(-999));
	}
}