package com.kumaran.finalProj.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.swing.JOptionPane;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.kumaran.finalProj.model.ChequeImage;
import com.kumaran.finalProj.model.Contacts;
import com.kumaran.finalProj.model.MoneyTransaction;
import com.kumaran.finalProj.model.User;

public class UserDao extends DAO {
	static int count = 1;

	public User queryUserByNameAndPassword(String userName, String password)
			throws Exception {
		try {
			// begin();
			User users = null;
			Session session = getSession();
			Query q1 = session
					.createQuery("from User where userName = :userName");
			q1.setString("userName", userName);
			User user1 = (User) q1.uniqueResult();

			if (user1 != null) {

				Query q = session
						.createQuery("from User where userName = :userName and password = :password");
				q.setString("userName", userName);
				q.setString("password", password);
				users = (User) q.uniqueResult();
				session.close();
				// commit();

				if (users == null) {
					count++;
					if (count > 3) {
						user1.setActive(0);
						Session session2 = HibernateUtil.getSessionFactory()
								.openSession();
						session2.beginTransaction();
						session2.update(user1);
						session2.getTransaction().commit();
						return user1;

					}
				} else {
					count = 1;
				}

			}
			return users;

		} catch (HibernateException e) {
			// rollback();
			throw new Exception("Could not get user " + userName, e);
		}
	}

	public int registerUser(User user) throws Exception {
		
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			session.save(user);
			session.getTransaction().commit();
			session.close();
		} catch (HibernateException e) {
			// rollback();
			return -1;
		}
		return 1;
	}

	public int sendOTP(MoneyTransaction moneyTransaction) {

		final String gmailu = "northeastern.bank@gmail.com";
		final String gmailp = "nbank123$";

		User user = moneyTransaction.getUser();

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		javax.mail.Session session = javax.mail.Session.getDefaultInstance(
				props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(gmailu, gmailp);
					}
				});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("northeastern.bank@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(user.getEmail()));
			message.setSubject("One Time Password - Northeastern Bank");
			message.setText("Hi " + user.getFirstName() + " "
					+ user.getLastName() + ", Your OTP is: "
					+ moneyTransaction.getPin());

			Transport.send(message);
			return 1;

		} catch (MessagingException e) {
			// throw new RuntimeException(e);
			JOptionPane.showMessageDialog(null, "cant process the request");
			return -1;
		}
	}

	public int sendMoney(MoneyTransaction t) {

		int pin = (int) (Math.random() * 9999) + 1000;
		t.setPin(pin);

		return sendOTP(t);

	}

	public void saveTransaction(MoneyTransaction t, User senderUser,
			String receiverEmail) throws Exception {

		Session session = HibernateUtil.getSessionFactory().openSession();

		Criteria cr = session.createCriteria(User.class);
		cr.add(Restrictions.eq("email", receiverEmail));
		User receiverUser = (User) cr.uniqueResult();

		// User senderUser = (User)session.get(User.class, u.getUserName());
		MoneyTransaction senderTx = new MoneyTransaction();
		senderTx = t;
		senderTx.setUser(senderUser);
		senderTx.setStatus("To: " + receiverUser.getFirstName() + " "
				+ receiverUser.getLastName());
		senderTx.setBalance(senderUser.getBalance() - senderTx.getAmount());
		senderUser.setBalance(senderUser.getBalance() - senderTx.getAmount());

		session.beginTransaction();
		session.save(senderTx);
		session.update(senderUser);
		session.getTransaction().commit();
		session.close();

		MoneyTransaction receiverTx = new MoneyTransaction();
		receiverTx = t;
		receiverTx.setType("Credit");
		receiverTx.setUser(receiverUser);
		receiverTx.setStatus("From: " + senderUser.getFirstName() + " "
				+ senderUser.getLastName());
		receiverTx.setBalance(receiverUser.getBalance()
				+ receiverTx.getAmount());
		receiverUser.setBalance(receiverUser.getBalance()
				+ receiverTx.getAmount());

		Session session2 = getSession();
		session2.beginTransaction();
		session2.update(receiverUser);
		session2.save(receiverTx);
		session2.getTransaction().commit();
		session2.close();

	}

	public int addContact(User user, Contacts contacts) {

		// Opening New Session
		Session session = getSession();
		Query q = session
				.createQuery("from User where accountNumber = :an and firstName = :fn and lastName = :ln and email = :email");
		q.setString("an", String.valueOf(contacts.getAccountNumber()));
		q.setString("fn", contacts.getFirstName());
		q.setString("ln", contacts.getLastName());
		q.setString("email", contacts.getEmail());
		User u = (User) q.uniqueResult();

		if (u == null) {
			return 0;
		}
		session.close();

		// Opening New Session
		Session s = getSession();
		Criteria cr = s.createCriteria(Contacts.class);
		cr.add(Restrictions.eq("accountNumber", contacts.getAccountNumber()));
		cr.add(Restrictions.eq("email", contacts.getEmail()));
		cr.add(Restrictions.eq("firstName", contacts.getFirstName()));
		cr.add(Restrictions.eq("lastName", contacts.getLastName()));
		Contacts contacts2 = (Contacts) cr.uniqueResult();
		s.close();

		// Opening New Session

		if (contacts2 == null) {
			Session session2 = HibernateUtil.getSessionFactory().openSession();
			session2.beginTransaction();
			session2.save(contacts);
			session2.getTransaction().commit();
			session2.close();
		}

		// Opening New Session
		Session session3 = HibernateUtil.getSessionFactory().openSession();

		User user2 = (User) session3.get(User.class, user.getUserName());

		Criteria cr2 = session3.createCriteria(Contacts.class);
		cr2.add(Restrictions.eq("accountNumber", contacts.getAccountNumber()));
		Contacts contacts3 = (Contacts) cr2.uniqueResult();

		Contacts c = (Contacts) session3.get(Contacts.class,
				contacts3.getContactsID());

		user2.getContacts().add(c);
		session3.beginTransaction();
		session3.update(user2);
		session3.getTransaction().commit();
		session3.close();

		return 1;

		// Contacts contacts3 = (Contacts) session3.get(Contacts.class,
		// contacts.getContactsID());

		// Criteria cr2 = session3.createCriteria(User.class);
		// cr2.add(Restrictions.eq("userName", user.getUserName()));
		// User user2 = (User)cr2.uniqueResult();
		//
		// Criteria cr3 = session.createCriteria(Contacts.class);
		// cr3.add(Restrictions.eq("accountNumber",
		// contacts.getAccountNumber()));
		// cr3.add(Restrictions.eq("email", contacts.getEmail()));
		// cr3.add(Restrictions.eq("firstName", contacts.getFirstName()));
		// cr3.add(Restrictions.eq("lastName", contacts.getLastName()));
		//
		// Contacts contacts3 = (Contacts)cr.uniqueResult();

		// Session session2 = HibernateUtil.getSessionFactory().openSession();
		// session2.beginTransaction();
		// User user2 = (User) session2.get(User.class, user.getUserName());
		// Contacts contacts3 = (Contacts) session2.get(Contacts.class,
		// contacts.getContactsID());
		//
		// user2.getContacts().add(contacts3);
		// session2.save(user2);
		// session2.getTransaction().commit();
		// session2.close();
		//
		// return 1;

		// Query q = session
		// .createQuery("from User where accountNumber = :an and firstName = :fn and lastName = :ln and email = :email");
		// q.setString("an", String.valueOf(contacts.getAccountNumber()));
		// q.setString("fn", contacts.getFirstName());
		// q.setString("ln", contacts.getLastName());
		// q.setString("email", contacts.getEmail());
		//
		// User u = (User) q.uniqueResult();
		//
		// session.close();
		// if (u != null) {
		//
		// Session session2 = HibernateUtil.getSessionFactory().openSession();
		// session2.beginTransaction();
		// session2.update(user);
		// session2.getTransaction().commit();
		// session2.close();
		// return 1;
		// } else if (u == null) {
		// return 0;
		// }

		// return 0;
	}

	public int deleteContact(int id, User u) throws Exception {
		try {
			int update = 0;

			Session session = getSession();
			session.beginTransaction();

			User user = (User) session.get(User.class, u.getUserName());
			Contacts contacts = (Contacts) session.get(Contacts.class, id);

			user.getContacts().remove(contacts);
			session.save(user);

			// Query q = session.createQuery(
			// "delete from Contacts where accountNumber = :an");
			// q.setInteger("an", an);
			// update = q.executeUpdate();
			session.getTransaction().commit();
			session.close();
			return update;

		} catch (HibernateException e) {
			throw new Exception("Could not delete messages" + id, e);
		}
	}

	public void addChequeToDB(ChequeImage cm) {
		Session session = getSession();
		session.beginTransaction();
		session.save(cm);
		session.getTransaction().commit();
		session.close();
	}

	public String checkExistingEmail(String email) {

		Query q1 = getSession().createQuery("from User where email = :email");
		q1.setString("email", email);
		User user = (User) q1.uniqueResult();

		if (user != null) {
			return "available";
		} else {
			return "no";
		}
	}

	public String checkExistingUserName(String userName) {

		Query q1 = getSession().createQuery(
				"from User where userName = :userName");
		q1.setString("userName", userName);
		User user = (User) q1.uniqueResult();

		if (user != null) {
			return "available";
		} else {
			return "no";
		}
	}
	
	public User queryUserByUserName(String userName){
		Session s = getSession();
		Criteria cr = s.createCriteria(User.class);
		cr.add(Restrictions.eq("userName", userName));
		User user = (User)cr.uniqueResult();
		s.close();
		return user;
	}
	
	public void sendPasswordMail(User user) {

		final String gmailu = "northeastern.bank@gmail.com";
		final String gmailp = "nbank123$";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		javax.mail.Session session = javax.mail.Session.getDefaultInstance(
				props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(gmailu, gmailp);
					}
				});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("northeastern.bank@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(user.getEmail()));
			message.setSubject("Password Retrieval - Northeastern Bank");
			message.setText("Hi " + user.getFirstName() + " "
					+ user.getLastName() + ", Your password is: "
					+ user.getPassword());

			Transport.send(message);

		} catch (MessagingException e) {
			// throw new RuntimeException(e);
			JOptionPane.showMessageDialog(null, "cant process the request");
		}
	}
	
	public void updateUser(User user){
		
		
//		Session s = getSession();
//		Criteria cr = s.createCriteria(User.class);
//		cr.add(Restrictions.eq("userName", user.getUserName()));
//		User u = (User)cr.uniqueResult();
//		s.close();
//		
//		u = user;
//		JOptionPane.showMessageDialog(null, "am here");
		Session session = getSession();
		session.beginTransaction();
		session.update(user);
		session.getTransaction().commit();
		session.close();
	}
	
}
