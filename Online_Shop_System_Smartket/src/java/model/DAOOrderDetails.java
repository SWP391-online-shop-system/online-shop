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
import view.OrderDetails;

/**
 *
 * @author trant
 */
public class DAOOrderDetails extends DBConnect {

    public int insertOrderDetailsByPrepared(OrderDetails details) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`orderdetail`\n"
                + "(`OrderID`,\n"
                + "`ProductID`,\n"
                + "`QuantityPerUnit`,\n"
                + "`UnitPrice`,\n"
                + "`Discount`)\n"
                + "VALUES(?,?,?,?,?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, details.getOrderID());
            pre.setInt(2, details.getProductID());
            pre.setInt(3, details.getQuantity());
            pre.setDouble(4, details.getUnitPrice());
            pre.setInt(5, details.getDiscount());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrderDetails.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public Vector<OrderDetails> getOrderDetailsById(int OrderID) {
        Vector<OrderDetails> list = new Vector<>();
        String sql = "select * from OrderDetail where OrderID = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, OrderID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                OrderDetails pro = new OrderDetails(
                        rs.getInt("ProductID"),
                        rs.getInt("orderID"),
                        rs.getInt("quantityPerUnit"),
                        rs.getDouble("unitPrice"),
                        rs.getInt("discount")
                );
                list.add(pro);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
