/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author trant
 */
public class User {
    private int userID;
    private String fullname;
    private String address;
    private String phone;
    private String username;
    private String password;
    private int roleid;
    

    public User() {
    }

    public User(int userID, String fullname, String address, String phone, String username, String password, int roleid) {
        this.userID = userID;
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.username = username;
        this.password = password;
        this.roleid = roleid;
    }

    public User(String fullname, String address, String phone, String username, String password, int roleid) {
        this.fullname = fullname;
        this.address = address;
        this.phone = phone;
        this.username = username;
        this.password = password;
        this.roleid = roleid;
    }

    

    

    public int getUserID() {
        return userID;
    }

    public void setUserID(int UserID) {
        this.userID = UserID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    @Override
    public String toString() {
        return "User{" + "UserID=" + userID + ", fullname=" + fullname + ", address=" + address + ", phone=" + phone + ", username=" + username + ", password=" + password + ", roleid=" + roleid + '}';
    }

    
    
    
}
