/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author trant
 */
public class Receiver {
    private int orderID;
    private String receName;
    private String recePhone;
    private String receAdress;
    private String receEmail;
    private String note;

    public Receiver() {
    }

    public Receiver(int orderID, String receName, String recePhone, String receAdress, String receEmail) {
        this.orderID = orderID;
        this.receName = receName;
        this.recePhone = recePhone;
        this.receAdress = receAdress;
        this.receEmail = receEmail;
    }

    public Receiver(int orderID, String receName, String recePhone, String receAdress, String receEmail, String note) {
        this.orderID = orderID;
        this.receName = receName;
        this.recePhone = recePhone;
        this.receAdress = receAdress;
        this.receEmail = receEmail;
        this.note = note;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getReceName() {
        return receName;
    }

    public void setReceName(String receName) {
        this.receName = receName;
    }

    public String getRecePhone() {
        return recePhone;
    }

    public void setRecePhone(String recePhone) {
        this.recePhone = recePhone;
    }

    public String getReceAdress() {
        return receAdress;
    }

    public void setReceAdress(String receAdress) {
        this.receAdress = receAdress;
    }

    public String getReceEmail() {
        return receEmail;
    }

    public void setReceEmail(String receEmail) {
        this.receEmail = receEmail;
    }
    
}
