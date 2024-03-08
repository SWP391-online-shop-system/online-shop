/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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

    public Status getStatusById(int StatusID) {

        String sql = "select * from `Status` where StatusID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, StatusID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Status pro = new Status(
                        rs.getInt("StatusID"),
                        rs.getString("StatusName")
                );
                return pro;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public int getTotalOrderOfUser(int userID) {
        String sql = "select count(*) from `order` where UserID = ?";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, userID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public static void main(String[] args) {
        DAOOrder dao =new DAOOrder();
        int a = dao.getTotalOrderOfUser(10);
        System.out.println(a);
    }
}
