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

    public Vector<ProductImage> getProductImageByProductID(int ProductID) {
        Vector<ProductImage> vector = new Vector<>();
        String sql = "select * from ProductImage where ProductID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, ProductID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductImage pro = new ProductImage(
                        rs.getInt("ProductID"),
                        rs.getString("ProductURL")
                );
                vector.add(pro);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return vector;
    }
}
