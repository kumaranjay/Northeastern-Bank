package com.kumaran.finalProj.model;

import java.io.Serializable;
import java.util.Date;

import javax.annotation.Generated;
import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Cacheable
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE, region="ehcacheUser")
@Entity
@Table(name = "TRANSACTION")
public class MoneyTransaction implements Serializable{
	
	@Id @GeneratedValue
	@Column(name = "TRANSACTIONID")
	private int transactionID;
	
	@Column(name = "TYPE")
	private String type;
	
	@Column(name = "AMOUNT")
	private float amount;
	
	@Column(name = "DATE")
	private Date date; 
	
	@Column(name = "BALANCE")
	private float balance;
	
	@Column(name="STATUS")
	private String status;
	
	@Column(name="PIN")
	private int pin;
	
	@Column(name="NOTE")
	private String note;
	
	@ManyToOne 
	@JoinColumn(name="USERNAME")
	private User user;

	public int getTransactionID() {
		return transactionID;
	}

	public void setTransactionID(int transactionID) {
		this.transactionID = transactionID;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}


	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public float getBalance() {
		return balance;
	}

	public void setBalance(float balance) {
		this.balance = balance;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getPin() {
		return pin;
	}

	public void setPin(int pin) {
		this.pin = pin;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	
	

}
