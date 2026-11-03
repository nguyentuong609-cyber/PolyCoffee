package DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Entity.Bill;
import Entity.Users;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class BillDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyCoffee");;
    private EntityManager em = emf.createEntityManager();;

    public BillDAO() {

    }
    
    public Bill findByBillId(Object id) {
    	EntityManager em = emf.createEntityManager();
    	
    	try {
    		return em.find(Bill.class, id);
    	} finally {
    		em.close();
    	}
    }
    
    public boolean createBill(Bill bill) {
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            em.persist(bill);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
	
	public void UpdateBill(Bill u) {
		Bill exit = em.find(Bill.class, u.getBillId());
		if (exit!=null) {
			try {
				em.getTransaction().begin();
				em.merge(u);
				em.getTransaction().commit();
			} catch (Exception e) {
				// TODO: handle exception
				em.getTransaction().rollback();
			}
		}
	}
	
	public void DeleteBill(String id) {
		Bill exit = em.find(Bill.class, id);
		String sql = "delete from Bill o where o.user.userId = :id	";
		String sql2 = "delete from BillDetail o where o.Bill.users.iduser like :id";
		try {
			em.getTransaction().begin();
			em.createQuery(sql).setParameter("id", id).executeUpdate();
			em.createQuery(sql2).setParameter("id", id).executeUpdate();
			em.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			em.getTransaction().rollback();
		}
		
		if(exit!=null) {
			try {
				em.getTransaction().begin();
				em.remove(exit);
				em.getTransaction().commit();
			} catch (Exception e) {
				// TODO: handle exception
				em.getTransaction().rollback();
			}
		}
	}
	
	public List<Bill> FindByIdUser(int id) {
		UserDAO dao = new UserDAO();
		String sql = "select u from Bill u where u.user.userId = :id";
		var exit = dao.findById(id);
		if(exit!=null) {
				
				return em.createQuery(sql).setParameter("id", id).getResultList();
			
		}
		return null;
		
	}
	
	
    
    

    // ==========================================
    // 1. THỐNG KÊ SỐ LƯỢNG ĐƠN THEO STATUS
    // ==========================================

    public Map<String, Integer> getStatusCounts() {

        Map<String, Integer> counts = new HashMap<>();

        counts.put("PENDING", 0);
        counts.put("MAKING", 0);
        counts.put("COMPLETED", 0);
        counts.put("CANCELLED", 0);

        List<Object[]> result = em.createQuery(
                "SELECT b.status, COUNT(b) " +
                "FROM Bill b " +
                "GROUP BY b.status",
                Object[].class
        ).getResultList();

        for (Object[] row : result) {

            String status = (String) row[0];
            Long count = (Long) row[1];

            if (status != null) {

                counts.put(
                    status.toUpperCase(),
                    count.intValue()
                );
            }
        }

        return counts;
    }


    // ==========================================
    // 2. LẤY DANH SÁCH ĐƠN
    // ==========================================

    public List<Bill> getOrdersByStatus(String statusFilter) {
    	em.clear();
        if (statusFilter == null
                || statusFilter.trim().isEmpty()
                || "ALL".equalsIgnoreCase(statusFilter)) {

            return em.createQuery(
                    "SELECT b FROM Bill b " +
                    "ORDER BY b.createdDate DESC",
                    Bill.class
            ).getResultList();
        }

        return em.createQuery(
                "SELECT b FROM Bill b " +
                "WHERE UPPER(b.status) = :status " +
                "ORDER BY b.createdDate DESC",
                Bill.class
        )
        .setParameter("status", statusFilter.toUpperCase())
        .getResultList();
    }


    // ==========================================
    // 3. LẤY ĐƠN THEO ID
    // ==========================================

    public Bill getOrderById(int orderId) {

        return em.find(Bill.class, orderId);
    }


    // ==========================================
    // 4. UPDATE STATUS
    // ==========================================

    public boolean updateOrderStatus(
            int billId,
            String status,
            String note) {

        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            Bill bill = em.find(Bill.class, billId);

            if (bill == null) {

                transaction.rollback();

                return false;
            }

            bill.setStatus(status.toUpperCase());
            bill.setNote(note != null ? note : "");

            transaction.commit();

            return true;

        } catch (Exception e) {

            if (transaction.isActive()) {
                transaction.rollback();
            }

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 5. ĐÓNG ENTITY MANAGER
    // ==========================================

    public void close() {

        if (em != null && em.isOpen()) {
            em.close();
        }

        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
