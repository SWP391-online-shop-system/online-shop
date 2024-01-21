/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import view.User;

/**
 *
 * @author HP
 */
public class DAOMail extends DBConnect {

    public int GetMaxId() {
        String sql = "SELECT Max(UserID) as user_id  FROM user;";
        try {
            PreparedStatement a = conn.prepareStatement(sql);
            ResultSet rs = a.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOMail.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }
    public int changeStatus(int UserID) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`user`\n"
                + "SET\n"
                + "`UserStatus` = 1\n"
                + "WHERE `UserID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, UserID);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DAOMail.class.getName()).log(Level.SEVERE, null, e);
        }
        return UserID;
    }

    public static void main(String[] args) {
        DAOMail dao = new DAOMail();
        int n = dao.GetMaxId();
        System.out.println(n);
    }
}
