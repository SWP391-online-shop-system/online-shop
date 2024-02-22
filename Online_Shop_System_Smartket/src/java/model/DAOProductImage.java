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
import static model.DAOProduct.getCurrentTimestamp;
import view.ProductImage;

/**
 *
 * @author admin
 */
public class DAOProductImage extends DBConnect {

    public ProductImage getProductImageByProductID(int ProductID) {
        String sql = "select * from ProductImage where ProductID =? and ProductURL like '%_1%'";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, ProductID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductImage pro = new ProductImage(
                        rs.getInt("ProductID"),
                        rs.getString("ProductURL")
                );
                return pro;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int insertImage(ProductImage productImage) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`productimage`\n"
                + "(`ProductID`,\n"
                + "`ProductURL`)\n"
                + "VALUES\n"
                + "(?,\n"
                + "?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, productImage.getProductID());
            pre.setString(2, productImage.getProductURL());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProductImage.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
