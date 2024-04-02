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
import java.util.ArrayList;
import java.util.List;
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
                + "(`UserID`,`SaleID`,`Quantity`,`TotalPrice`,`OrderDate`,`StatusID`,`OrderStatus`)\n"
                + "VALUES\n"
                + "(?,?,?,?,current_timestamp(),?,1);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setInt(1, order.getUserID());
            pre.setInt(2, order.getSaleID());
            pre.setInt(3, order.getQuantity());
            pre.setDouble(4, order.getTotalPrice());
            pre.setInt(5, order.getStatusID());
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

    public int updateShippedDate(int orderID) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`order`\n"
                + "SET\n"
                + "`ShippedDate` = current_timestamp()\n"
                + "WHERE `OrderID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, orderID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateOrderQuantity(int SaleID) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`sale`\n"
                + "SET `OrderQuantity` = `OrderQuantity` - 1\n"
                + "WHERE `SaleID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, SaleID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateProduct(int UnitInStock, int orderID) {
    int n = 0;
    String sql = "UPDATE `online_shop_system`.`product`\n"
                + "SET\n"
                + "`UnitInStock` = `UnitInStock` + ?\n"
                + "WHERE `ProductID` IN (SELECT od.ProductID FROM OrderDetail od WHERE od.OrderID = ?)";
    try {
        PreparedStatement pre = conn.prepareStatement(sql);
        pre.setInt(1, UnitInStock);
        pre.setInt(2, orderID);
        n = pre.executeUpdate();
    } catch (SQLException ex) {
        Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
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

    public int updateStatus1(int statusID, int orderId) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`order`\n"
                + "SET\n"
                + "`StatusID` = ?\n"
                + "WHERE `OrderID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, statusID);
            pre.setInt(2, orderId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
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

    public int getQuantityOfOrder(int orderId, int productId) {
        String sql = "SELECT * FROM online_shop_system.orderdetail where OrderID =? and ProductID = ?;";
        int quantity = 0;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, orderId);
            st.setInt(2, productId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                quantity = rs.getInt("QuantityPerUnit");
            }
        } catch (SQLException e) {
        }
        return quantity;
    }

    public Order getOrderById(int OrderID) {

        String sql = "select * from `Order` where OrderID =" + OrderID;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, OrderID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order pro = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getInt("SaleID"),
                        rs.getInt("Quantity"),
                        rs.getDouble("TotalPrice"),
                        rs.getString("OrderDate"),
                        rs.getString("ShippedDate"),
                        rs.getInt("StatusID"),
                        rs.getBoolean("OrderStatus"),
                        rs.getString("OrderImage")
                );
                return pro;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
