/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import view.Categories;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class DAOCategories extends DBConnect {

    public Vector<Categories> getCategories(String sql) {
        Vector<Categories> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int CategoryID = rs.getInt("CategoryID");
                String CategoryName = rs.getString("CategoryName");
                boolean CategoryStatus = rs.getBoolean("CategoryStatus");
                String CreateDate = rs.getString("createDate");
                Categories cat = new Categories(CategoryID,
                        CategoryName, CreateDate, CategoryStatus);
                vector.add(cat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategories.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public Categories getCategoriesById(int cateID) {

        String sql = "select * from Categories where CategoryID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, cateID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories cate = new Categories(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName"),
                        rs.getString("CreateDate"),
                        rs.getBoolean("CategoryStatus")
                );
                System.out.println("get success");
                return cate;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        System.out.println("null");
        return null;
    }
}
