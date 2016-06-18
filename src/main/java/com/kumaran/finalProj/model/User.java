package com.kumaran.finalProj.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Cacheable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Cacheable
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "ehcacheUser")
@Entity
@Table(name = "USERTABLE")
public class User implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = -4796493820642197049L;

    @Id
    @Column(name = "USERNAME")
    private String userName;

    @Column(name = "PASSWORD")
    private String password;

    @Column(name = "EMAIL")
    private String email;

    @Column(name = "ACTIVE")
    private int active;

    @Column(name = "FIRSTNAME")
    private String firstName;

    @Column(name = "LASTNAME")
    private String lastName;

    @GeneratedValue
    @Column(name = "ACCOUNTNUMBER")
    private int accountNumber;

    @Column(name = "PIN")
    private int pin;

    @Column(name = "PHONENUMBER")
    private long phoneNumber;

    @Column(name = "ADDRESS")
    private String address;

    @Column(name = "CITY")
    private String city;

    @Column(name = "STATE")
    private String state;

    @Column(name = "ZIP")
    private int zip;

    @Column(name = "USERTYPE")
    private String userType;

    @Column(name = "BALANCE")
    private float balance;

    @Column(name = "SECRETQUESTION")
    private String secretQuestion;

    @Column(name = "SECRETANSWER")
    private String secretAnswer;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<MoneyTransaction> moneyTransactions;

    @ManyToMany(cascade = {CascadeType.ALL}, fetch = FetchType.EAGER)
    @JoinTable(name = "USERTABLE_CONTACTS",
            joinColumns = {
                @JoinColumn(name = "USERNAME")},
            inverseJoinColumns = {
                @JoinColumn(name = "CONTACTSID")})
    private Set<Contacts> contacts = new HashSet<Contacts>();

//	@ManyToMany(cascade = {CascadeType.ALL}, fetch = FetchType.EAGER)
//    @JoinTable(name="USERTABLE_TRANSACTIONS", 
//                joinColumns={@JoinColumn(name="USERNAME")}, 
//                inverseJoinColumns={@JoinColumn(name="TRANSACTIONID")})
//    private Set<MoneyTransaction> moneyTransaction = new HashSet<MoneyTransaction>();
    //private ArrayList<ChequeFile> chequeFiles;
    public static int imageNumber = 0;

    public List<MoneyTransaction> getMoneyTransactions() {
        return moneyTransactions;
    }

    public void setMoneyTransactions(List<MoneyTransaction> transactions) {
        this.moneyTransactions = transactions;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public int getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }

    public long getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(long phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getZip() {
        return zip;
    }

    public void setZip(int zip) {
        this.zip = zip;
    }

    public String getSecretQuestion() {
        return secretQuestion;
    }

    public void setSecretQuestion(String secretQuestion) {
        this.secretQuestion = secretQuestion;
    }

    public String getSecretAnswer() {
        return secretAnswer;
    }

    public void setSecretAnswer(String secretAnswer) {
        this.secretAnswer = secretAnswer;
    }

    public static int getImageNumber() {
        return imageNumber;
    }

    public static void setImageNumber(int imageNumber) {
        User.imageNumber = imageNumber;
    }

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

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public int getPin() {
        return pin;
    }

    public void setPin(int pin) {
        this.pin = pin;
    }

    public Set<Contacts> getContacts() {
        return contacts;
    }

    public void setContacts(Set<Contacts> contacts) {
        this.contacts = contacts;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

}
