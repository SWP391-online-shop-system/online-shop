package view;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author admin
 */
public class FeedBack {

    private int FeedBackID;
    private int ProductID;
    private int UserID;
    private String FeedBackImage;
    private String FeedBackContent;
    private int FeedBackRate;
    private String FeedBackDate;
    private boolean FeedBackStatus;

    public FeedBack(int FeedBackID, int ProductID, int UserID, String FeedBackImage, String FeedBackContent, int FeedBackRate, String FeedBackDate, boolean FeedBackStatus) {
        this.FeedBackID = FeedBackID;
        this.ProductID = ProductID;
        this.UserID = UserID;
        this.FeedBackImage = FeedBackImage;
        this.FeedBackContent = FeedBackContent;
        this.FeedBackRate = FeedBackRate;
        this.FeedBackDate = FeedBackDate;
        this.FeedBackStatus = FeedBackStatus;
    }

    public FeedBack() {
    }

    @Override
    public String toString() {
        return "FeedBack{" + "FeedBackID=" + FeedBackID + ", ProductID=" + ProductID + ", UserID=" + UserID + ", FeedBackImage=" + FeedBackImage + ", FeedBackContent=" + FeedBackContent + ", FeedBackRate=" + FeedBackRate + ", FeedBackDate=" + FeedBackDate + ", FeedBackStatus=" + FeedBackStatus + '}';
    }

    public int getFeedBackID() {
        return FeedBackID;
    }

    public void setFeedBackID(int FeedBackID) {
        this.FeedBackID = FeedBackID;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getFeedBackImage() {
        return FeedBackImage;
    }

    public void setFeedBackImage(String FeedBackImage) {
        this.FeedBackImage = FeedBackImage;
    }

    public String getFeedBackContent() {
        return FeedBackContent;
    }

    public void setFeedBackContent(String FeedBackContent) {
        this.FeedBackContent = FeedBackContent;
    }

    public int getFeedBackRate() {
        return FeedBackRate;
    }

    public void setFeedBackRate(int FeedBackRate) {
        this.FeedBackRate = FeedBackRate;
    }

    public String getFeedBackDate() {
        return FeedBackDate;
    }

    public void setFeedBackDate(String FeedBackDate) {
        this.FeedBackDate = FeedBackDate;
    }

    public boolean isFeedBackStatus() {
        return FeedBackStatus;
    }

    public void setFeedBackStatus(boolean FeedBackStatus) {
        this.FeedBackStatus = FeedBackStatus;
    }

}
