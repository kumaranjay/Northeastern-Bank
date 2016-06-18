package com.kumaran.finalProj.dao;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.AnnotationConfiguration;

import com.kumaran.finalProj.model.User;


public class HibernateUtil {
	 private static final SessionFactory sessionFactory;
	 
	    static {
	        try {
	            // Create the SessionFactory from hibernate.cfg.xml
//	            Configuration configuration = new Configuration().configure();
//	            StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties());
//	            sessionFactory = configuration.buildSessionFactory(builder.build());
	        	
	        	sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
	        } catch (Throwable ex) {
	            // Make sure you log the exception, as it might be swallowed
	            System.err.println("Initial SessionFactory creation failed." + ex);
	            throw new ExceptionInInitializerError(ex);
	        }
	    }
	 
	    public static SessionFactory getSessionFactory() {
	        return sessionFactory;
	    }
}
