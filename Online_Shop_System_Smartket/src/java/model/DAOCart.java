/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import view.Cart;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author trant
 */
public class DAOCart extends DBConnect {

    public int insertCartByPrepared(Cart cart) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`cart`\n"
                + "(`UserID`,\n"
                + "`ProductID`,\n"
                + "`Quantity`)\n"
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, cart.getUserId());
            pre.setInt(2, cart.getProductId());
            pre.setInt(3, cart.getQuantity());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int deleteCart(int userID, int proID) {
        int n = 0;
        String sql = "DELETE FROM `online_shop_system`.`cart`\n"
                + "WHERE `UserID` = ? and `ProductID` = ? ;";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userID);
            pre.setInt(2, proID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int deleteAllCart(int userID) {
        int n = 0;
        String sql = "DELETE FROM `online_shop_system`.`cart`\n"
                + "WHERE `UserID` = ? ;";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateCart(Cart cart, int oldid) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`cart`\n"
                + "SET\n"
                + "`UserID` = ?,\n"
                + "`ProductID` = ?,\n"
                + "`Quantity` = ?\n"
                + "WHERE `UserID` = ?;";
        try {
            // number ? = number fields
            // index of ? start is 1
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, cart.getUserId());
            pre.setInt(2, cart.getProductId());
            pre.setInt(3, cart.getQuantity());
            pre.setInt(4, oldid);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;

    }

    public int updateCartByUserAndPro(Cart cart, int oldid, int proid) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`cart`\n"
                + "SET\n"
                + "`UserID` = ?,\n"
                + "`ProductID` = ?,\n"
                + "`Quantity` = ?\n"
                + "WHERE `UserID` = ? and `ProductID` = ? ;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, cart.getUserId());
            pre.setInt(2, cart.getProductId());
            pre.setInt(3, cart.getQuantity());
            pre.setInt(4, oldid);
            pre.setInt(5, proid);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;

    }

    public Vector<Cart> getCart(String sql) {
        Vector<Cart> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int userID = rs.getInt(1);
                int productID = rs.getInt(2);
                int quantity = rs.getInt(3);
                Cart cart = new Cart(userID, productID, quantity);

                vector.add(cart);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }

        return vector;
    }

    public boolean productExistsInCart(int userID, int productID) {
        // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng của người dùng chưa
        // Viết truy vấn SQL tương ứng để kiểm tra
        DAOCart dao = new DAOCart();
        String sql = "select * from `online_shop_system`.`cart` where `UserID` =" + userID + " and `ProductID` =" + productID;
        Vector<Cart> vector = dao.getCart(sql);
        // Trả về true nếu tồn tại, ngược lại trả về false
        return !vector.isEmpty();
    }

    public Cart getCartByUser(int userID, int productID) {
        String sql = "select * from `online_shop_system`.`cart` where `UserID` =" + userID + " and `ProductID` =" + productID;
        DAOCart dao = new DAOCart();
        Vector<Cart> vector = dao.getCart(sql);
        return vector.firstElement();
    }

    public void updateQuantity(int userID, int productID, int quantity) {
        String sql = "UPDATE `online_shop_system`.`cart`\n"
                + "SET\n"
                + "`Quantity` = ?\n"
                + "WHERE `UserID` = ? and `ProductID` = ? ;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, quantity);
            pre.setInt(2, userID);
            pre.setInt(3, productID);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
//    public static void main(String[] args) {
//        DAOCart dao = new DAOCart();
////        Cart cart = dao.getCartByUser(2, 2);
////        System.out.println(cart);
////        System.out.println(dao.productExistsInCart(2, 2));
//        int n = dao.deleteCart(2, 1);
//        System.out.println(n);
//
//    }
}
