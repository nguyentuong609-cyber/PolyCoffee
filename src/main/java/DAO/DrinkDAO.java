package DAO;

import java.util.List;

import Entity.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class DrinkDAO {


	EntityManagerFactory factory = Persistence.createEntityManagerFactory("PolyCoffee");
	
	public List<Product> findAll() {
	EntityManager em = factory.createEntityManager();
		
		String sql = "select o from Product o";
		TypedQuery<Product> query = em.createQuery(sql,Product.class);
		List<Product> list = query.getResultList();
		return list;
	}
	
	public List<Product> findByCate(String cate){
		EntityManager em = factory.createEntityManager();
		String sql = "Select u from Product u where u.category like :cate";
		TypedQuery<Product> query = em.createQuery(sql, Product.class);
		System.out.println(cate);
		Object x;
		switch (cate) {
		case "caphe": {
			 x = "Cà Phê";
			 break;
		}
		case "tra":{
			 x = "Trà";
			 break;
		}
		case"freeze":{
			 x = "Freeze";
			 break;
		}
		
		default:
			 x = "Bánh";
		}
		
		
		query.setParameter("cate", x);
		return query.getResultList();
	}
	
	public Product FindByID(int id) {
		EntityManager em = factory.createEntityManager();
		return em.find(Product.class, id);
	}
	
	public void CreateProduct(Product u) {
		EntityManager em = factory.createEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(u);
			em.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			em.getTransaction().rollback();
		}
	}
	
	public void UpdateProduct(Product u) {
		EntityManager em = factory.createEntityManager();
		Product exit = em.find(Product.class, u.getProductId());
		
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
	
	public void DeleteProduct(int id) {
		EntityManager em = factory.createEntityManager();
		Product exit = em.find(Product.class, id);
		String sql = "delete from Bill o where o.users.iduser like :id";
		if (exit != null) {

            try {

                em.getTransaction().begin();

                em.remove(exit);

                em.getTransaction().commit();

            } catch (Exception e) {

                if (em.getTransaction().isActive()) {
                    em.getTransaction().rollback();
                }

                e.printStackTrace();
            }
        }
    }
	

}
