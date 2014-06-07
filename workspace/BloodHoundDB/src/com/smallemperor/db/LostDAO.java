package com.smallemperor.db;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

public class LostDAO {

	public List<Lost> getLostPeople(String id) {
		List<Lost> Losts = null;
		EntityManagerFactory e = Persistence
				.createEntityManagerFactory("GODJPADB");
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
				.createEntityManagerFactory("GODJPADB");
		Lost Lost = new Lost();
		EntityManager em = e.createEntityManager();
		try {

			EntityTransaction entr = em.getTransaction();
			Lost.setBeaconId(beaconId);

			entr.begin();
			Lost = em.find(Lost.class, beaconId); // works as save or update
			entr.commit();
		} catch (Exception e1) {
			System.out.println(e1);
		} finally {
			em.close();

		}
		return Lost;
	}
}
