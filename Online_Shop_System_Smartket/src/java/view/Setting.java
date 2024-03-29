/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author admin
 */
public class Setting {

    private int SettingID;
    private String SettingName;
    private int SettingOrder;
    private String SettingValue;
    private String SettingDescription;
    private int SettingStatus;
    private String CreateDate;

    public Setting() {
    }

    public Setting(int SettingID, String SettingName, int SettingOrder, String SettingValue, String SettingDescription, int SettingStatus, String CreateDate) {
        this.SettingID = SettingID;
        this.SettingName = SettingName;
        this.SettingOrder = SettingOrder;
        this.SettingValue = SettingValue;
        this.SettingDescription = SettingDescription;
        this.SettingStatus = SettingStatus;
        this.CreateDate = CreateDate;
    }
     public Setting( String SettingName, int SettingOrder, String SettingValue, String SettingDescription, int SettingStatus) {
        this.SettingName = SettingName;
        this.SettingOrder = SettingOrder;
        this.SettingValue = SettingValue;
        this.SettingDescription = SettingDescription;
        this.SettingStatus = SettingStatus;
    }

    public int getSettingID() {
        return SettingID;
    }

    public void setSettingID(int SettingID) {
        this.SettingID = SettingID;
    }

    public String getSettingName() {
        return SettingName;
    }

    public void setSettingName(String SettingName) {
        this.SettingName = SettingName;
    }

    public int getSettingOrder() {
        return SettingOrder;
    }

    public void setSettingOrder(int SettingOrder) {
        this.SettingOrder = SettingOrder;
    }

    public String getSettingValue() {
        return SettingValue;
    }

    public void setSettingValue(String SettingValue) {
        this.SettingValue = SettingValue;
    }

    public String getSettingDescription() {
        return SettingDescription;
    }

    public void setSettingDescription(String SettingDescription) {
        this.SettingDescription = SettingDescription;
    }

    public int getSettingStatus() {
        return SettingStatus;
    }

    public void setSettingStatus(int SettingStatus) {
        this.SettingStatus = SettingStatus;
    }

    public String getCreateDate() {
        return CreateDate;
    }

    public void setCreateDate(String CreateDate) {
        this.CreateDate = CreateDate;
    }

    @Override
    public String toString() {
        return "Setting{" + "SettingID=" + SettingID + ", SettingName=" + SettingName + ", SettingOrder=" + SettingOrder + ", SettingValue=" + SettingValue + ", SettingDescription=" + SettingDescription + ", SettingStatus=" + SettingStatus + ", CreateDate=" + CreateDate + '}';
    }

}
