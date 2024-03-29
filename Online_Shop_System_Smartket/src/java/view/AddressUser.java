/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author trant
 */
public class AddressUser {
    private int addId;
    private int userId;
    private String name;
    private String cityDistrictWard;
    private String addressDetail;
    private String phone;
    private String email;
    private boolean gender;
    private boolean status;

    public AddressUser(int userId, String name, String cityDistrictWard, String addressDetail, String phone, String email, boolean gender) {
        this.userId = userId;
        this.name = name;
        this.cityDistrictWard = cityDistrictWard;
        this.addressDetail = addressDetail;
        this.phone = phone;
        this.email = email;
        this.gender = gender;
    }

    public AddressUser(int addId, int userId, String name, String cityDistrictWard, String addressDetail, String phone, String email, boolean gender) {
        this.addId = addId;
        this.userId = userId;
        this.name = name;
        this.cityDistrictWard = cityDistrictWard;
        this.addressDetail = addressDetail;
        this.phone = phone;
        this.email = email;
        this.gender = gender;
    }



    public int getAddId() {
        return addId;
    }

    public void setAddId(int addId) {
        this.addId = addId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCityDistrictWard() {
        return cityDistrictWard;
    }

    public void setCityDistrictWard(String cityDistrictWard) {
        this.cityDistrictWard = cityDistrictWard;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}
