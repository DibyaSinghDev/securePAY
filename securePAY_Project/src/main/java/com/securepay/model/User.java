package com.securepay.model;

public class User {

    private int id;
    private String name;
    private String email;
    private String password;
    private String accountNumber;
    private double balance;
    private String profileImage;

    public User() {
    }

    public User(
            int id,
            String name,
            String email,
            String password,
            String accountNumber,
            double balance) {

        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.accountNumber = accountNumber;
        this.balance = balance;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(
            String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(
            String password) {
        this.password = password;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(
            String accountNumber) {
        this.accountNumber =
                accountNumber;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(
            double balance) {
        this.balance = balance;
    }
    
}