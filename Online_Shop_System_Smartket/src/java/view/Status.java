/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author admin
 */
public class Status {

    private int StatusID;
    private String StatusName;

    public Status() {
    }

    public Status(int StatusID, String StatusName) {
        this.StatusID = StatusID;
        this.StatusName = StatusName;
    }

    public int getStatusID() {
        return StatusID;
    }

    public void setStatusID(int StatusID) {
        this.StatusID = StatusID;
    }

    public String getStatusName() {
        return StatusName;
    }

    public void setStatusName(String StatusName) {
        this.StatusName = StatusName;
    }

    @Override
    public String toString() {
        return "Status{" + "StatusID=" + StatusID + ", StatusName=" + StatusName + '}';
    }

}
