package com.smallemperor.db;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import com.google.gson.Gson;

public class LostDAO {
	

	public List<Lost> getLostPeople(String id) {
		List<Lost> Losts = null;
		EntityManagerFactory e = Persistence
				.createEntityManagerFactory("BloodHoundDB");
		EntityManager em = e.createEntityManager();
		try {
			EntityTransaction entr = em.getTransaction();
			entr.begin();
			TypedQuery<Lost> query = em.createQuery(
					"SELECT a FROM Lost a where a.id > " + id, Lost.class);
			Losts = query.getResultList();

			entr.commit();
		} finally {
			em.close();
		}
		return Losts;
	}

	public Lost getLostDetails(String beaconId) {

		EntityManagerFactory e = Persistence
				.createEntityManagerFactory("BloodHoundDB");
		Lost Lost = new Lost();
		EntityManager em = e.createEntityManager();
		try {

			EntityTransaction entr = em.getTransaction();
			Lost.setBeaconId(beaconId);

			entr.begin();
			Lost = em.find(Lost.class, beaconId); // find lost details
			entr.commit();
		} catch (Exception e1) {
			System.out.println(e1);
		} finally {
			em.close();

		}
		return Lost;
	}
	
	public void insertToDB(Lost lostObject) {

		EntityManagerFactory e = Persistence
				.createEntityManagerFactory("BloodHoundDB");
		EntityManager em = e.createEntityManager();
		try {
			EntityTransaction entr = em.getTransaction();
			entr.begin();
			em.merge(lostObject); // works as save or update
			entr.commit();
		} catch (Exception e1) {
			System.out.println(e1);
		} finally {
			em.close();
		}

	}
	
	public void updateReportedBeacon(Lost lostObject) { //lost will only contain beconid and reported flag

		EntityManagerFactory e = Persistence
				.createEntityManagerFactory("BloodHoundDB");
		EntityManager em = e.createEntityManager();
		try {
			EntityTransaction entr = em.getTransaction();
			entr.begin();
			Lost lost = this.getLostDetails(lostObject.getBeaconId());
			lost.setCol7(lostObject.getCol7());
			em.merge(lost); // works as save or update
			entr.commit();
		} catch (Exception e1) {
			System.out.println(e1);
		} finally {
			em.close();
		}

	}
	
	
	
	public static void main(String[] args) {
		 Lost lost = new Lost();
		 lost.setBeaconId("A");
		 lost.setAddress("Address");
		 lost.setCol0("Col0");
		 LostDAO lostDAO = new LostDAO();
		 lostDAO.insertToDB(lost);
		 

			Gson gson = new Gson();
		 
		Lost lostObject = lostDAO.getLostDetails("William's Phone");
		System.out.println(lostObject.getAddress());
		
		System.out.println(gson.toJson(lostObject));
	}
	
}
