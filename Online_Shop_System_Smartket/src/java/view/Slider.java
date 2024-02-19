/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author admin
 */
public class Slider {

    private int SliderID;
    private int UserID;
    private String SliderImage;
    private String SliderLink;
    private boolean SliderStatus;

    public Slider() {
    }

    public Slider(int SliderID, int UserID, String SliderImage, String SliderLink, boolean SliderStatus) {
        this.SliderID = SliderID;
        this.UserID = UserID;
        this.SliderImage = SliderImage;
        this.SliderLink = SliderLink;
        this.SliderStatus = SliderStatus;
    }

    public int getSliderID() {
        return SliderID;
    }

    public void setSliderID(int SliderID) {
        this.SliderID = SliderID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getSliderImage() {
        return SliderImage;
    }

    public void setSliderImage(String SliderImage) {
        this.SliderImage = SliderImage;
    }

    public String getSliderLink() {
        return SliderLink;
    }

    public void setSliderLink(String SliderLink) {
        this.SliderLink = SliderLink;
    }

    public boolean isSliderStatus() {
        return SliderStatus;
    }

    public void setSliderStatus(boolean SliderStatus) {
        this.SliderStatus = SliderStatus;
    }

    @Override
    public String toString() {
        return "Slider{" + "SliderID=" + SliderID + ", UserID=" + UserID + ", SliderImage=" + SliderImage + ", SliderLink=" + SliderLink + ", SliderStatus=" + SliderStatus + '}';
    }

}
