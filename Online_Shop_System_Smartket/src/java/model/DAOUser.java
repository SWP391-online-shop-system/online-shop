/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import view.User;

/**
 *
 * @author HP
 */
public class DAOUser extends DBConnect {

    public int insertUserByPrepared(User user) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`user`\n"
                + "(`FirstName`,\n"
                + "`LastName`,\n"
                + "`Address`,\n"
                + "`PhoneNumber`,\n"
                + "`DateOfBirth`,\n"
                + "`Gender`,\n"
                + "`UserImage`,\n"
                + "`Password`,\n"
                + "`Email`,\n"
                + "`LastLogin`,\n"
                + "`UserStatus`,\n"
                + "`ReportTo`,\n"
                + "`RoleID`),\n"
                + "`CreateDate`)\n"
                + "VALUES\n"
                + "(?,?,?,?,?,?,?,?,?,?,?,?,?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, user.getFirstName());
            pre.setString(2, user.getLastName());
            pre.setString(3, user.getAddress());
            pre.setString(4, user.getPhoneNumber());
            pre.setString(5, user.getDateOfBirth());
            pre.setBoolean(6, true);
            pre.setString(7, user.getUserImage());
            pre.setString(8, user.getPassword());
            pre.setString(9, user.getEmail());
            pre.setString(10, user.getLastLogin());
            pre.setBoolean(11, true);
            pre.setInt(12, user.getReportTo());
            pre.setInt(13, user.getRoleID());
            pre.setString(14, user.getCreateDate());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public void signup(String fname, String lname, String pass, String email) {
        String sql = "INSERT INTO `online_shop_system`.`user`\n"
                + "(`FirstName`,\n"
                + "`LastName`,\n"
                + "`Password`,\n"
                + "`Email`,\n"
                + "`UserStatus`,\n"
                + "`ReportTo`,\n"
                + "`RoleID`,\n"
                + "`CreateDate`)\n" // Include CreateDate column in the query
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "0,\n"
                + "1,\n"
                + "1,\n"
                + "now())"; // Use CURRENT_TIMESTAMP to set the current timestamp
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, fname);
            pre.setString(2, lname);
            pre.setString(3, pass);
            pre.setString(4, email);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int addNewUserByMKT(User user) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`user`(`FirstName`,`LastName`,`Address`,`PhoneNumber`,`Gender`,`Password`,`Email`,`UserStatus`,`ReportTo`,`RoleID`,`CreateDate`)\n"
                + "VALUES(?,?,?,?,?,?,?,1,1,1,CURRENT_TIMESTAMP);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, user.getFirstName());
            pre.setString(2, user.getLastName());
            pre.setString(3, user.getAddress());
            pre.setString(4, user.getPhoneNumber());
            pre.setInt(5, user.getGender() ? 1 : 0);
            pre.setString(6, user.getPassword());
            pre.setString(7, user.getEmail());
            n = pre.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int updateStatus(int uid, int status) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`user`\n"
                + "SET`UserStatus` = ? WHERE `UserID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, uid);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
        }
        return n;
    }

    public int checkEmail(String email) {
        DAOUser dao = new DAOUser();
        int n = 0;
        ResultSet rs = dao.getData("select * from `user` where Email ='" + email + "'");
        try {
            while (rs.next()) {
                if (rs != null) {
                    n = 1;
                }
            }
        } catch (SQLException e) {
        }
        return n;
    }

    public User getUserByEmail(String Email) {

        String sql = "select * from user where Email ='" + Email + "'";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User pro = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getInt(12),
                        rs.getInt(13),
                        rs.getInt(14),
                        rs.getString(15)
                );
                System.out.println("Not Null");
                return pro;

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        System.out.println("null user");
        return null;
    }

    public User getUserByUserID(int id) {

        String sql = "select * from user where UserID =" + id;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User pro = new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getInt(12),
                        rs.getInt(13),
                        rs.getInt(14),
                        rs.getString(15)
                );
                System.out.println("Not Null");
                return pro;

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        System.out.println("null user");
        return null;
    }

    public int deleteUser(int id) {
        int n = 0;
        String sql = "DELETE FROM `online_shop_system`.`user`\n"
                + "WHERE UserID = " + id;

        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int updateUser(User user) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`user`\n"
                + "SET\n"
                + "`FirstName` = ?,\n"
                + "`LastName` = ?,\n"
                + "`Address` = ?,\n"
                + "`PhoneNumber` = ?,\n"
                + "`DateOfBirth` = ?,\n"
                + "`Gender` = ?,\n"
                + "`UserImage` = ?,\n"
                + "`Password` = ?,\n"
                + "`Email` = ?,\n"
                + "`LastLogin` = ?,\n"
                + "`UserStatus` = ?,\n"
                + "`ReportTo` = ?,\n"
                + "`RoleID` = ?,\n"
                + "`CreateDate` = ?\n"
                + "WHERE `UserID` = ?;";
        try {
            // number ? = number fields
            // index of ? start is 1
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, user.getFirstName());
            pre.setString(2, user.getLastName());
            pre.setString(3, user.getAddress());
            pre.setString(4, user.getPhoneNumber());
            pre.setString(5, user.getDateOfBirth());
            pre.setBoolean(6, true);
            pre.setString(7, user.getUserImage());
            pre.setString(8, user.getPassword());
            pre.setString(9, user.getEmail());
            pre.setString(10, user.getLastLogin());
            pre.setBoolean(11, true);
            pre.setInt(12, user.getReportTo());
            pre.setInt(13, user.getRoleID());
            pre.setString(14, user.getCreateDate());
            pre.setInt(15, user.getUserID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateUserImage(int userID, String userImage) {
        int n = 0;
        String sql = "update User set UserImage = '?' where UserID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, userImage);
            pre.setInt(2, userID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public Vector<User> getUser(String sql) {
        Vector<User> vector = new Vector<User>();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String fName = rs.getString(2);
                String lName = rs.getString(3);
                String address = rs.getString(4);
                String phoneNumber = rs.getString(5);
                String dob = rs.getString(6);
                Boolean gender = rs.getBoolean(7);
                String image = rs.getString(8);
                String password = rs.getString(9);
                String email = rs.getString(10);
                String lastLogin = rs.getString(11);
                int userStatus = rs.getInt(12);
                int reportTo = rs.getInt(13);
                int roleID = rs.getInt(14);
                String CreateDate = rs.getString(15);
                User user = new User(id, fName, lName, address,
                        phoneNumber, dob, gender, image,
                        password, email, lastLogin, userStatus,
                        reportTo, roleID, CreateDate);
                vector.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public User check(String email, String pass) {
        String sql = "SELECT `user`.`UserID`,\n"
                + "    `user`.`FirstName`,\n"
                + "    `user`.`LastName`,\n"
                + "    `user`.`Address`,\n"
                + "    `user`.`PhoneNumber`,\n"
                + "    `user`.`DateOfBirth`,\n"
                + "    `user`.`Gender`,\n"
                + "    `user`.`UserImage`,\n"
                + "    `user`.`Password`,\n"
                + "    `user`.`Email`,\n"
                + "    `user`.`LastLogin`,\n"
                + "    `user`.`UserStatus`,\n"
                + "    `user`.`ReportTo`,\n"
                + "    `user`.`RoleID`,\n"
                + "    `user`.`CreateDate`\n"
                + "FROM `online_shop_system`.`user`\n"
                + "where Email = ? and password = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            pre.setString(2, pass);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getInt(12),
                        rs.getInt(13),
                        rs.getInt(14),
                        rs.getString(15));
                return user;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public User checkAccountExist(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getInt(12),
                        rs.getInt(13),
                        rs.getInt(14),
                        rs.getString(15)
                );
            }
        } catch (SQLException e) {
            // Handle exception appropriately (e.g., logging)
        }
        return null;
    }

    public void updateLastLogin(int userId) {
        try {
            String sql = "UPDATE user SET LastLogin = CURRENT_TIMESTAMP WHERE UserID = ?";
            try (
                     PreparedStatement pre = conn.prepareStatement(sql)) {
                pre.setInt(1, userId);
                pre.executeUpdate();
            }
            // Close the connection
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception according to your needs
        }
    }

    public void updateCreateDate(int userId) {
        try {
            String sql = "UPDATE user SET CreateDate = CURRENT_TIMESTAMP WHERE UserID = ?";
            try (
                     PreparedStatement pre = conn.prepareStatement(sql)) {
                pre.setInt(1, userId);
                pre.executeUpdate();
            }
            // Close the connection
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception according to your needs
        }
    }

    public static void main(String[] args) {
        DAOUser dao = new DAOUser();

    }

    public String convertStatus(int UserStatus) {
        String result = "";
        switch (UserStatus) {
            case 0:
                result = "<span class=\"badge badge-warning\">Chưa xác nhận email</span>";
                break;
            case 1:
                result = "<span class=\"badge badge-success\">Hoạt động</span>";
                break;
            case 2:
                result = "<span class=\"badge badge-danger\">Khóa</span>";
                break;
        }
        return result;
    }
}
