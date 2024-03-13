/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

import model.DAOOrder;

/**
 *
 * @author trant
 */
public class Order {

    private int orderID;
    private int userID;
    private int saleID;
    private int Quantity;
    private double totalPrice;
    private String orderDate;
    private String shippedDate;
    private int statusID;
    private boolean OrderStatus;
    private String QrImage;

    public Order() {
    }
//int, int, int, int, double, String, String, int, boolean, String
    public Order(int orderID, int userID, int saleID, int Quantity, 
            double totalPrice, String orderDate, String shippedDate, 
            int statusID, boolean OrderStatus, String QrImage) {
        this.orderID = orderID;
        this.userID = userID;
        this.saleID = saleID;
        this.Quantity = Quantity;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.shippedDate = shippedDate;
        this.statusID = statusID;
        this.OrderStatus = OrderStatus;
        this.QrImage = QrImage;
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

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
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

    public boolean isOrderStatus() {
        return OrderStatus;
    }

    public void setOrderStatus(boolean OrderStatus) {
        this.OrderStatus = OrderStatus;
    }

    public String getQrImage() {
        return QrImage;
    }

    public void setQrImage(String QrImage) {
        this.QrImage = QrImage;
    }

    @Override
    public String toString() {
        return "Order{" + "orderID=" + orderID + ", userID=" + userID + ", saleID=" + saleID + ", Quantity=" + Quantity + ", totalPrice=" + totalPrice + ", orderDate=" + orderDate + ", shippedDate=" + shippedDate + ", statusID=" + statusID + ", OrderStatus=" + OrderStatus + ", QrImage=" + QrImage + '}';
    }
    public static void main(String[] args) {
        DAOOrder dao = new DAOOrder();
        Order order = new Order();
        order = dao.getOrderById(1);
    }
}
