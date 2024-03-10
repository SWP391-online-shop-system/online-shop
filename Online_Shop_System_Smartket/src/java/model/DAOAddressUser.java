/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import view.AddressUser;

/**
 *
 * @author trant
 */
public class DAOAddressUser extends DBConnect {

    public int insertAddressByPrepared(AddressUser add) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`addressuser`\n"
                + "(`UserID`,`Name`,`CityDistrictWard`,`AddDetail`,`Phone`,`Email`,`Gender`,`Status`)\n"
                + "VALUES(?,?,?,?,?,?,?,0);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setInt(1, add.getUserId());
            pre.setString(2, add.getName());
            pre.setString(3, add.getCityDistrictWard());
            pre.setString(4, add.getAddressDetail());
            pre.setString(5, add.getPhone());
            pre.setString(6, add.getEmail());
            pre.setBoolean(7, add.isGender());
            n = pre.executeUpdate();
            ResultSet key = pre.getGeneratedKeys();
            if (key.next()) {
                n = key.getInt(1);
            }
            pre.close();
        } catch (SQLException ex) {
        }
        return n;
    }

    public int updateStatus(int id) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`addressuser`\n"
                + "SET\n"
                + "`Status` = 1\n"
                + "WHERE `AddressID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            n = pre.executeUpdate();
            pre.close();
        } catch (SQLException ex) {
        }
        return n;
    }

    public int clearStatus(int userId) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`addressuser`\n"
                + "SET\n"
                + "`Status` = 0\n"
                + "WHERE `UserID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userId);
            n = pre.executeUpdate();
            pre.close();
        } catch (SQLException ex) {
        }
        return n;
    }
}
