package com.securepay.model;

import java.sql.Timestamp;

public class Recharge {

    private int id;
    private int userId;
    private String serviceType;
    private String provider;
    private String customerNumber;
    private double amount;
    private String transactionId;
    private String status;
    private Timestamp rechargeDate;

    // Default Constructor
    public Recharge() {
    }

    // Parameterized Constructor
    public Recharge(int userId, String serviceType, String provider,
                    String customerNumber, double amount,
                    String transactionId, String status) {

        this.userId = userId;
        this.serviceType = serviceType;
        this.provider = provider;
        this.customerNumber = customerNumber;
        this.amount = amount;
        this.transactionId = transactionId;
        this.status = status;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public String getCustomerNumber() {
        return customerNumber;
    }

    public void setCustomerNumber(String customerNumber) {
        this.customerNumber = customerNumber;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getRechargeDate() {
        return rechargeDate;
    }

    public void setRechargeDate(Timestamp rechargeDate) {
        this.rechargeDate = rechargeDate;
    }

    @Override
    public String toString() {
        return "Recharge{" +
                "id=" + id +
                ", userId=" + userId +
                ", serviceType='" + serviceType + '\'' +
                ", provider='" + provider + '\'' +
                ", customerNumber='" + customerNumber + '\'' +
                ", amount=" + amount +
                ", transactionId='" + transactionId + '\'' +
                ", status='" + status + '\'' +
                ", rechargeDate=" + rechargeDate +
                '}';
    }

	
}