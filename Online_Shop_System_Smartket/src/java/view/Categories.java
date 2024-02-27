/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

import java.sql.Date;

/**
 *
 * @author admin
 */
public class Categories {

    private int CategoryID;
    private String CategoryName;
    private Date CreateDate;
    private boolean CategoryStatus;

    public Categories() {
    }

    
    public Categories(int CategoryID, String CategoryName, Date CreateDate, boolean CategoryStatus) {
        this.CategoryID = CategoryID;
        this.CategoryName = CategoryName;
        this.CreateDate = CreateDate;
        this.CategoryStatus = CategoryStatus;
    }

    public Categories(int CategoryID, String CategoryName, boolean CategoryStatus) {
        this.CategoryID = CategoryID;
        this.CategoryName = CategoryName;
        this.CategoryStatus = CategoryStatus;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public void setCategoryName(String CategoryName) {
        this.CategoryName = CategoryName;
    }

    public Date getCreateDate() {
        return CreateDate;
    }

    public void setCreateDate(Date CreateDate) {
        this.CreateDate = CreateDate;
    }

    public boolean isCategoryStatus() {
        return CategoryStatus;
    }

    public void setCategoryStatus(boolean CategoryStatus) {
        this.CategoryStatus = CategoryStatus;
    }

    @Override
    public String toString() {
        return "Categories{" + "CategoryID=" + CategoryID + ", CategoryName=" + CategoryName + ", CreateDate=" + CreateDate + ", CategoryStatus=" + CategoryStatus + '}';
    }

    

}
