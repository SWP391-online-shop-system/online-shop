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
    private double totalPrice;

    public Order() {
    }

    public Order(int userID, int saleID, String orderDate, String shippedDate, int statusID) {
        this.userID = userID;
        this.saleID = saleID;
        this.orderDate = orderDate;
        this.shippedDate = shippedDate;
        this.statusID = statusID;
    }

    public Order(int userID, int saleID, int statusID, double totalPrice) {
        this.userID = userID;
        this.saleID = saleID;
        this.statusID = statusID;
        this.totalPrice = totalPrice;
    }


    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
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

    public String getQrImage() {
        return QrImage;
    }

    public void setQrImage(String QrImage) {
        this.QrImage = QrImage;
    }

    @Override
    public String toString() {
        return "Order{" + "orderID=" + orderID + ", userID=" + userID + ", saleID=" + saleID + ", orderDate=" + orderDate + ", shippedDate=" + shippedDate + ", statusID=" + statusID + ", QrImage=" + QrImage + '}';
    }

}
