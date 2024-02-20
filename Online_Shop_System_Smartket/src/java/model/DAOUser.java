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
                + "`RoleID`)\n"
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
                + "`RoleID`)\n"
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "0,\n"
                + "1,\n"
                + "1);";
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
                        rs.getBoolean(12),
                        rs.getInt(13),
                        rs.getInt(14)
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
                + "`RoleID` = ?\n"
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
            pre.setInt(14, user.getUserID());
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
                Boolean userStatus = rs.getBoolean(12);
                int reportTo = rs.getInt(13);
                int roleID = rs.getInt(14);
                User user = new User(id, fName, lName, address,
                        phoneNumber, dob, gender, image,
                        password, email, lastLogin, userStatus,
                        reportTo, roleID);
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
                + "    `user`.`RoleID`\n"
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
                        rs.getBoolean(12),
                        rs.getInt(13),
                        rs.getInt(14));
                return user;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public User checkAccountExist(String email) {
        String sql = "select * from user where email = '?'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
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
                        rs.getBoolean(12),
                        rs.getInt(13),
                        rs.getInt(14));
            }
        } catch (SQLException e) {
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

    public Vector<User> getCusPaging(int limit, int index) {
        Vector<User> list = new Vector<>();
        String sql = "SELECT * FROM online_shop_system.user where roleID = 1 limit " + limit + " offset ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, ((index - 1) * limit));
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt("UserID"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Address"),
                        rs.getString("PhoneNumber"),
                        rs.getString("DateOfBirth"),
                        rs.getBoolean("Gender"),
                        rs.getString("UserImage"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("LastLogin"),
                        rs.getBoolean("UserStatus"),
                        rs.getInt("ReportTo"),
                        rs.getInt("RoleID"));
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getTotalCus() {
        String sql = "select count(*) from User where roleID =1";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public static void main(String[] args) {
//        DAOUser dao = new DAOUser();
//        Vector<User> list = dao.getCusPaging(3, 3);
//        for (User user : list) {
//            System.out.println(user);
//        }
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
