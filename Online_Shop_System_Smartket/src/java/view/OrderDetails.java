/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author trant
 */
public class OrderDetails {

    private int productID;
    private int orderID;
    private int quantity;
    private double unitPrice;
    private int discount;
    private boolean isFeedback;

    public OrderDetails() {
    }

    public OrderDetails(int productID, int orderID, int quantity, double unitPrice, int discount, boolean isFeedback) {
        this.productID = productID;
        this.orderID = orderID;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.discount = discount;
        this.isFeedback = isFeedback;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public boolean isIsFeedback() {
        return isFeedback;
    }

    public void setIsFeedback(boolean isFeedback) {
        this.isFeedback = isFeedback;
    }

    @Override
    public String toString() {
        return "OrderDetails{" + "productID=" + productID + ", orderID=" + orderID + ", quantity=" + quantity + ", unitPrice=" + unitPrice + ", discount=" + discount + ", isFeedback=" + isFeedback + '}';
    }
}
