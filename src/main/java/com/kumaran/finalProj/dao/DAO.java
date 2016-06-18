package com.kumaran.finalProj.dao;

import java.util.logging.Level;
import java.util.logging.Logger;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;


public abstract class DAO {


	protected DAO() {
	}

	public Session getSession() {
		return HibernateUtil.getSessionFactory().openSession();
	}

	protected void begin() {
		getSession().beginTransaction();
	}

	protected void commit() {
		getSession().getTransaction().commit();
	}

	protected void rollback() {
		try {
			getSession().getTransaction().rollback();
		} catch (HibernateException e) {

		}
		try {
			getSession().close();
		} catch (HibernateException e) {

		}

	}

	public void close() {
		getSession().close();
	}

}
