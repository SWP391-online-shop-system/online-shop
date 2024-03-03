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

    private int OrderID;
    private String ReceiverName;
    private int ReceiverGender;
    private String ReceiverPhoneNumber;
    private String ReceiverEmail;
    private String RceiverAddress;
    private String note;

    @Override
    public String toString() {
        return "Receiver{" + "OrderID=" + OrderID + ", ReceiverName=" + ReceiverName + ", ReceiverGender=" + ReceiverGender + ", ReceiverPhoneNumber=" + ReceiverPhoneNumber + ", ReceiverEmail=" + ReceiverEmail + ", RceiverAddress=" + RceiverAddress + ", note=" + note + '}';
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public String getReceiverName() {
        return ReceiverName;
    }

    public void setReceiverName(String ReceiverName) {
        this.ReceiverName = ReceiverName;
    }

    public int getReceiverGender() {
        return ReceiverGender;
    }

    public void setReceiverGender(int ReceiverGender) {
        this.ReceiverGender = ReceiverGender;
    }

    public String getReceiverPhoneNumber() {
        return ReceiverPhoneNumber;
    }

    public void setReceiverPhoneNumber(String ReceiverPhoneNumber) {
        this.ReceiverPhoneNumber = ReceiverPhoneNumber;
    }

    public String getReceiverEmail() {
        return ReceiverEmail;
    }

    public void setReceiverEmail(String ReceiverEmail) {
        this.ReceiverEmail = ReceiverEmail;
    }

    public String getRceiverAddress() {
        return RceiverAddress;
    }

    public void setRceiverAddress(String RceiverAddress) {
        this.RceiverAddress = RceiverAddress;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
