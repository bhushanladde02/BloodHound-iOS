package com.smallemperor.factory;

import java.util.Date;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class EntityManagerProvider {
	
	 private static final String databaseName = "BloodHoundDB";

	    public static final boolean DEBUG = true;

	    private static final EntityManagerProvider singleton = new EntityManagerProvider();

	    private EntityManagerFactory emf;

	    private EntityManagerProvider() {}

	    public static EntityManagerProvider getInstance() {
	        return singleton;
	    }


	    public EntityManagerFactory getEntityManagerFactory() {
	        if(emf == null) {
	            emf = Persistence.createEntityManagerFactory(databaseName);
	        }
	        if(DEBUG) {
	            System.out.println("factory created on: " + new Date());
	        }
	        return emf;
	    }

	    public void closeEmf() {
	        if(emf.isOpen() || emf != null) {
	            emf.close();
	        }
	        emf = null;
	        if(DEBUG) {
	            System.out.println("EMF closed at: " + new Date());
	        }
	    }


}
