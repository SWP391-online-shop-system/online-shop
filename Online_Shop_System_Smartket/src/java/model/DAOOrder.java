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

    public int insertUserByPreparedReturnId(Order order) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`order`\n"
                + "(`UserID`,\n"
                + "`SaleID`,\n"
                + "`OrderDate`,\n"
                + "`StatusID`)\n"
                + "VALUES(?,?,?,?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setInt(1, order.getUserID());
            pre.setInt(2, order.getSaleID());
            pre.setString(3,order.getOrderDate());
            pre.setInt(4, order.getStatusID());
            n = pre.executeUpdate();
            ResultSet key = pre.getGeneratedKeys();
            if (key.next()) {
                n = key.getInt(4);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
