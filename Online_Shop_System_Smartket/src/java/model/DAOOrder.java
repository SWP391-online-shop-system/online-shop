/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import view.Order;

/**
 *
 * @author trant
 */
public class DAOOrder extends DBConnect {

    public int insertOrderByPreparedReturnId(Order order) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`order`\n"
                + "(`UserID`,`SaleID`,`TotalPrice`,`OrderDate`,`StatusID`,`OrderStatus`)\n"
                + "VALUES\n"
                + "(?,?,?,current_timestamp(),?,1);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setInt(1, order.getUserID());
            pre.setInt(2, order.getSaleID());
            pre.setDouble(3, order.getTotalPrice());
            pre.setInt(4, order.getStatusID());
            n = pre.executeUpdate();
            ResultSet key = pre.getGeneratedKeys();
            if (key.next()) {
                n = key.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateSale(int saleId, int quantity) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`sale` SET\n"
                + "                OrderQuantity = ?\n"
                + "                WHERE SaleID = ?;";
        try {
            // number ? = number fields
            // index of ? start is 1
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, quantity);
            pre.setInt(2, saleId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateStatus(int orderId) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`order`\n"
                + "SET\n"
                + "`StatusID` = 2\n"
                + "WHERE `OrderID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, orderId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public int updateQrImage(String QrImage, int orderId) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`order`\n"
                + "SET\n"
                + "`OrderImage` = ?\n"
                + "WHERE `OrderID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, QrImage);
            pre.setInt(2, orderId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
