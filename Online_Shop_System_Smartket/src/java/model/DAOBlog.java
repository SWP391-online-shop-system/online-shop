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
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import view.Blog;
import view.Categories;

/**
 *
 * @author admin
 */
public class DAOBlog extends DBConnect {

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
                int CategoryID = rs.getInt("CategoryID");
                String AuthorImage = rs.getString("AuthorImage");
                String BlogImage = rs.getString("ProductDescription");
                String BlogTitle = rs.getString("BlogTitle");
                String BlogContent = rs.getString("BlogContent");
                int BlogRate = rs.getInt("BlogRate");
                int HiddenStatus = rs.getInt("HiddenStatus");
                String CreateTime = rs.getString("CreateTime");
                Blog blog = new Blog(BlogID, UserID, BlogAuthor,CategoryID,
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

    public List<Blog> searchByName(String txtSearch,int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "where BlogTitle like ?\n"
                + "order by BlogID desc\n"
                + "LIMIT ?, 6";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + txtSearch + "%");
            st.setInt(2, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }
    public List<Blog> searchByCategories(int Cid,int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "where CategoryID like ?\n"
                + "order by BlogID desc\n"
                + "LIMIT ?, 6";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1,Cid);
            st.setInt(2, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }
   

    public List<Blog> getAllBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }
    public List<Categories> getAllCategories() {
        List<Categories> list = new ArrayList<>();
        String sql = "select * from Categories";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                list.add(new Categories(rs.getInt(1),
                        rs.getString(2),
                        rs.getDate(3),
                        rs.getBoolean(4)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }
    public Blog getBlogByID(int Bid) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * \n"
                + "FROM Blog\n"
                + "where BlogID=?";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, Bid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Blog(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                );
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Blog> getNewBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT*\n"
                + "FROM Blog\n"
                + "ORDER BY BlogID DESC\n"
                + "LIMIT 3";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Blog> getGoodBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * \n"
                + "FROM Blog\n"
                + "order by BlogRate desc\n"
                + "LIMIT 3";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public int getTotalSearchBlog(String txtSearch) {
        String sql = "select count(*) from Blog\n"
                + "where BlogTitle like ?";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + txtSearch + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalBlog() {
        String sql = "SELECT count(*)\n"
                + "FROM Blog";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    public int getTotalCategoriesBlog(int Cid) {
        String sql = "select count(*) from Blog\n"
                + "where CategoryID like ?";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1,Cid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<Blog> pagingBlog(int index) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT*\n"
                + "FROM Blog\n"
                + "order by BlogID desc\n"
                + "LIMIT ?, 6";
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (index - 1) * 6);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        DAOBlog dao = new DAOBlog();
        List<Categories> list = dao.getAllCategories();
        Blog b = dao.getBlogByID(1);
        int count = dao.getTotalCategoriesBlog(1);
        for (Categories o : list) {
            System.out.println(o);
        }
        System.out.println(count);
    }
}
