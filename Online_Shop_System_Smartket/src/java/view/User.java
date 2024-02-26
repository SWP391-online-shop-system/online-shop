/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author HP
 */
public class User {

    private int userID;
    private String firstName, lastName, address, phoneNumber, dateOfBirth;
    private Boolean gender;
    private String userImage, password, email, lastLogin;
    private int userStatus;
    private int reportTo, roleID;
    private String rePassword;
    private String createDate;

    public User() {
    }

    public User(int userID, String firstName, String lastName, String address, String phoneNumber, String dateOfBirth, Boolean gender, String userImage, String password, String email, String lastLogin, int userStatus, int reportTo, int roleID) {
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.userImage = userImage;
        this.password = password;
        this.email = email;
        this.lastLogin = lastLogin;
        this.userStatus = userStatus;
        this.reportTo = reportTo;
        this.roleID = roleID;
        this.createDate = createDate;
    }

    }

    public User(String firstName, String lastName, String address, String phoneNumber, String dateOfBirth, Boolean gender, String userImage, String password, String email, String lastLogin, int userStatus, int reportTo, int roleID) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.userImage = userImage;
        this.password = password;
        this.email = email;
        this.lastLogin = lastLogin;
        this.userStatus = userStatus;
        this.reportTo = reportTo;
        this.roleID = roleID;
    }

    public User(String firstName, String lastName, String email, String password, String rePassword) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.rePassword = rePassword;
        this.createDate = createDate;
    }

    public User(String firstName, String lastName, String address, String phoneNumber, Boolean gender, String password, String email) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.password = password;
        this.email = email;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getRePassword() {
        return rePassword;
    }

    public void setRePassword(String rePassword) {
        this.rePassword = rePassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Boolean isGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin;
    }

    public int isUserStatus() {
        return userStatus;
    }

    public void setUserStatus(int userStatus) {
        this.userStatus = userStatus;
    }

    public int getReportTo() {
        return reportTo;
    }

    public void setReportTo(int reportTo) {
        this.reportTo = reportTo;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public static String encryptEmail(String email) {
        StringBuilder encryptedEmail = new StringBuilder();
        int length = email.length();
        if (length > 4) {
            int atIndex = email.indexOf('@');
            if (atIndex > 2) {
                encryptedEmail.append(email.substring(0, 2)); // First two characters
                for (int i = 2; i < atIndex; i++) {
                    encryptedEmail.append("*");
                }
                encryptedEmail.append(email.substring(atIndex)); // Append the domain part as is
            } else {
                encryptedEmail.append(email); // Return original email if the username is too short
            }
        } else {
            encryptedEmail.append(email); // Return original email if it's too short
        }
        return encryptedEmail.toString();}
    public Boolean getGender() {
        return gender;
    }

    public int getUserStatus() {
        return userStatus;
    }

    @Override
    public String toString() {
        return "User{" + "userID=" + userID + ", firstName=" + firstName + ", lastName=" + lastName + ", address=" + address + ", phoneNumber=" + phoneNumber + ", dateOfBirth=" + dateOfBirth + ", gender=" + gender + ", userImage=" + userImage + ", password=" + password + ", email=" + email + ", lastLogin=" + lastLogin + ", userStatus=" + userStatus + ", reportTo=" + reportTo + ", roleID=" + roleID + ", rePassword=" + rePassword + '}';
    }

}
