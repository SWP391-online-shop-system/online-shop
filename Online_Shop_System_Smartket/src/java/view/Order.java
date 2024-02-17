/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author trant
 */
public class Order {
    private int orderID;
    private int userID;
    private int saleID;
    private String orderDate;
    private String shippedDate;
    private int statusID;

    public Order() {
    }

    public Order(int orderID, int userID, int saleID, String orderDate, String shippedDate, int statusID) {
        this.orderID = orderID;
        this.userID = userID;
        this.saleID = saleID;
        this.orderDate = orderDate;
        this.shippedDate = shippedDate;
        this.statusID = statusID;
    }
    public Order(int userID, int saleID, String orderDate, int statusID) {
        this.userID = userID;
        this.saleID = saleID;
        this.orderDate = orderDate;
        this.statusID = statusID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getSaleID() {
        return saleID;
    }

    public void setSaleID(int saleID) {
        this.saleID = saleID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getShippedDate() {
        return shippedDate;
    }

    public void setShippedDate(String shippedDate) {
        this.shippedDate = shippedDate;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }
    
}
