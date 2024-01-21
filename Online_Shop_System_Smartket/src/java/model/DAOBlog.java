/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import view.Blog;

/**
 *
 * @author admin
 */
public class DAOBlog extends DBConnect {

    @Override
    public ResultSet getData(String sql) {
        ResultSet rs = null;
        Statement state;
        try {
            state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = state.executeQuery(sql);
        } catch (SQLException ex) {

        }
        return rs;
    }

    public Vector<Blog> getBlog(String sql) {
        Vector<Blog> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int BlogID = rs.getInt("BlogID");
                int UserID = rs.getInt("UserID");
                String BlogAuthor = rs.getString("BlogAuthor");
                String AuthorImage = rs.getString("AuthorImage");
                String BlogImage = rs.getString("ProductDescription");
                String BlogTitle = rs.getString("BlogTitle");
                String BlogContent = rs.getString("BlogContent");
                int BlogRate = rs.getInt("BlogRate");
                int HiddenStatus = rs.getInt("HiddenStatus");
                String CreateTime = rs.getString("CreateTime");
                Blog blog = new Blog(BlogID, UserID, BlogAuthor,
                        AuthorImage, BlogImage, BlogTitle, BlogContent,
                        BlogRate, HiddenStatus, CreateTime);
                vector.add(blog);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }
}
