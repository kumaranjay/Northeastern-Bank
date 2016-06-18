package com.kumaran.finalProj.dao;

import java.util.Date;
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
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.kumaran.finalProj.model.ChequeImage;
import com.kumaran.finalProj.model.MoneyTransaction;
import com.kumaran.finalProj.model.User;

public class TellerDao extends DAO {

	public int getChequesToTeller() {

		Session s = getSession();
		Criteria cr = s.createCriteria(ChequeImage.class);
		cr.add(Restrictions.eq("approved", 0));
		List<ChequeImage> cheques = cr.list();
		s.close();

		int count = cheques.size();

		return count;

	}

	public List<ChequeImage> getPendingChequeList() {
		Session s = getSession();
		Criteria cr = s.createCriteria(ChequeImage.class);
		cr.add(Restrictions.eq("approved", 0));
		List<ChequeImage> cheques = cr.list();
		s.close();
		return cheques;

	}

	public ChequeImage queryChequeWithImageID(int imageID) {

		Session s = getSession();
		Criteria cr = s.createCriteria(ChequeImage.class);
		cr.add(Restrictions.eq("imageID", imageID));
		ChequeImage cheque = (ChequeImage) cr.uniqueResult();
		s.close();
		return cheque;
	}

	public void approveCheque(int imageID) {
		Session s = getSession();
		Criteria cr = s.createCriteria(ChequeImage.class);
		cr.add(Restrictions.eq("imageID", imageID));
		ChequeImage cheque = (ChequeImage) cr.uniqueResult();
		Date uploadDate = cheque.getUploadDate();
		s.close();

		cheque.setApproved(1);
		cheque.setApproveDate(new Date());

		Session s2 = getSession();
		s2.beginTransaction();
		s2.update(cheque);
		s2.getTransaction().commit();
		s2.close();
		
		Session s3 = getSession();
		Criteria cr2 = s3.createCriteria(User.class);
		cr2.add(Restrictions.eq("userName", cheque.getUserName()));
		User user = (User) cr2.uniqueResult();
		s3.close();
		
		/*Saving transaction*/
		MoneyTransaction tx = new MoneyTransaction();
		tx.setAmount(1000);
		tx.setBalance(user.getBalance()+1000);
		tx.setDate(new Date());
		tx.setStatus("Check deposit");
		tx.setUser(user);
		tx.setType("Credit");
		
		Float balance = user.getBalance();
		user.setBalance(balance - 1000);
		
		Session s4 = getSession();
		s4.beginTransaction();
		s4.save(tx);
		s4.update(user);
		s4.getTransaction().commit();
		s4.close();
		
//		Session s5 = getSession();
//		Float balance = user.getBalance();
//		user.setBalance(balance - 1000);
//		s5.save(user);
//		s5.getTransaction().commit();
//		s5.close();
		
		
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
			message.setSubject("Check approved");
			message.setText("Hi "
					+ user.getFirstName()
					+ " "
					+ user.getLastName()
					+ ", Your check uploaded on "+uploadDate+" has been approved and the money has been credited to your account");

			Transport.send(message);
			

		} catch (MessagingException e) {
			// throw new RuntimeException(e);
			JOptionPane.showMessageDialog(null, "cant process the request");
		}
	}

	public void rejectCheque(int imageID) {
		Session s = getSession();
		Criteria cr = s.createCriteria(ChequeImage.class);
		cr.add(Restrictions.eq("imageID", imageID));
		ChequeImage cheque = (ChequeImage) cr.uniqueResult();
		Date uploadDate = cheque.getUploadDate();
		s.close();

		Session s3 = getSession();
		Criteria cr2 = s3.createCriteria(User.class);
		cr2.add(Restrictions.eq("userName", cheque.getUserName()));
		User user = (User) cr2.uniqueResult();
		s3.close();

		Session s2 = getSession();
		s2.beginTransaction();
		s2.delete(cheque);
		s2.getTransaction().commit();
		s2.close();

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
			message.setSubject("Check not approved");
			message.setText("Hi "
					+ user.getFirstName()
					+ " "
					+ user.getLastName()
					+ ", Your check uploaded on "+uploadDate+"is not approved. Please deposit the check again or contact the nearest Bank");

			Transport.send(message);

		} catch (MessagingException e) {
			// throw new RuntimeException(e);
			JOptionPane.showMessageDialog(null, "cant process the request");
		}

	}

}
