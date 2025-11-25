package com.finance.model;
import java.util.Date;

public class Transaction {
    private int id, userId, categoryId;
    private double amount;
    private String type, description;
    private Date date;

    // Getter and Setter for 'id'
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    // Getter and Setter for 'userId'
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    // Getter and Setter for 'categoryId'
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    // Getter and Setter for 'amount'
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    // Getter and Setter for 'type'
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    // Getter and Setter for 'description'
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    // Getter and Setter for 'date'
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
}
