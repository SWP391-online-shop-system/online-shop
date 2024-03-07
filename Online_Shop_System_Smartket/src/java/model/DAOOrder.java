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
import view.Categories;
import view.Order;
import view.Status;

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

    public Vector<Status> getStatus(String sql) {
        Vector<Status> vector = new Vector<>();
        try ( Statement state = conn.createStatement(
                ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);  ResultSet rs = state.executeQuery(sql)) {

            while (rs.next()) {
                int statusID = rs.getInt(1);
                String statusName = rs.getString(2);
                Status status = new Status(statusID, statusName);
                vector.add(status);
            }
        } catch (SQLException ex) {
            // Handle SQLException appropriately
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public int UpdateSaleID(int sID, int orderID) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`order`\n"
                + "SET\n"
                + "`SaleID` = ?\n"
                + "WHERE `OrderID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, sID);
            pre.setInt(2, orderID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
