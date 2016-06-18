package com.kumaran.finalProj.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Cacheable
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE, region="ehcacheUser")
@Entity
@Table(name = "CONTACTS")
public class Contacts implements Serializable{
	
	@Id @GeneratedValue
	@Column(name = "CONTACTSID")
	private int contactsID;
	
	@Column(name="ACCOUNTNUMBER")
	private int accountNumber;
	
	@Column(name = "FIRSTNAME")
	private String firstName;
	
	@Column(name = "LASTNAME")
	private String lastName;
	
	@Column(name="EMAIL")
	private String email;
	
	@Column(name="IFSC")
	private int IFSC;	
	
	@ManyToMany(mappedBy="contacts")
	private Set<User> employees = new HashSet<User>();

	

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(int accountNumber) {
		this.accountNumber = accountNumber;
	}

	public int getIFSC() {
		return IFSC;
	}

	public void setIFSC(int iFSC) {
		IFSC = iFSC;
	}


	public Set<User> getEmployees() {
		return employees;
	}

	public void setEmployees(Set<User> employees) {
		this.employees = employees;
	}

	public int getContactsID() {
		return contactsID;
	}

	public void setContactsID(int contactsID) {
		this.contactsID = contactsID;
	}
	
	
	

}
