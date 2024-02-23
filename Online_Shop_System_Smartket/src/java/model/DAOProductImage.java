/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
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
}
