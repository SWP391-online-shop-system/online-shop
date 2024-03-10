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
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DAOProduct.getCurrentTimestamp;
import view.Slider;
import view.User;

/**
 *
 * @author admin
 */
public class DAOSlider extends DBConnect {
    //SliderID, UserID, SliderImage, SliderLink, CreateDate, SliderStatus
//insert into Slider values(2,4,'slide2.jpg','ProductListURL',curdate(),0);
     public int insertSlider(Slider s) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`slider`\n"
                + "(`SliderID`,\n"
                + "`UserID`,\n"
                + "`SliderImage`,\n"
                + "`SliderLink`,\n"
                + "`SliderStatus`,\n"
                + "`CreateDate`)\n"
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, s.getSliderID());
            pre.setInt(2, s.getUserID());
            pre.setString(3, s.getSliderImage());
            pre.setString(4, s.getSliderLink());
            pre.setBoolean(5, s.isSliderStatus());
            pre.setString(6, getCurrentTimestamp()); // Set current timestamp
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
         //SliderID, UserID, SliderImage, SliderLink, CreateDate, SliderStatus

    public int updateProduct(Slider pro) {
        int n = 0;
        String sql = "update slider set SliderImage= ?, SliderLink = ?, SliderStatus = ? WHERE SliderID = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, pro.getSliderImage());
            pre.setString(2, pro.getSliderLink());
            pre.setBoolean(3, pro.isSliderStatus());
            pre.setInt(4, pro.getSliderID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

       public Slider getSLiderByUserID(int id) {

        String sql = "select * from slider where sliderID =" + id;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Slider pro = new Slider(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getBoolean(5),
                        rs.getString(6)
                       
                );
                System.out.println("Not Null");
                return pro;

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        System.out.println("null user");
        return null;
    }
    public Vector<Slider> getSlider(String sql) {
        Vector<Slider> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int SliderID = rs.getInt("SliderID");
                int UserID = rs.getInt("UserID");
                String SliderImage = rs.getString("SliderImage");
                String SliderLink = rs.getString("SliderLink");
                boolean SliderStatus = rs.getBoolean("SliderStatus");
                String CreateDate = rs.getString("CreateDate");
                Slider s = new Slider(SliderID, UserID, SliderImage, SliderLink,SliderStatus,CreateDate);
                vector.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }
    public Slider getaSlider(String sql) {
         Slider s = new Slider();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
           
            while (rs.next()) {
                int SliderID = rs.getInt("SliderID");
                int UserID = rs.getInt("UserID");
                String SliderImage = rs.getString("SliderImage");
                String SliderLink = rs.getString("SliderLink");
                boolean SliderStatus = rs.getBoolean("SliderStatus");
                String CreateDate = rs.getString("CreateDate");
                s = new Slider(SliderID, UserID, SliderImage, SliderLink,SliderStatus,CreateDate);
            }

        } catch (SQLException ex) {
            System.out.println("sql errot at 141 in DAOSlider: "+ex);
        }
        return s;
    }
    
    
     public Vector<Slider> getAllSlider() {
        Vector<Slider> vector = new Vector<>();
        String sql = "select * from slider";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider(
                        rs.getInt("SliderID"),
                        rs.getInt("UserID"),
                        rs.getString("SliderImage"),
                        rs.getString("SliderLink"),
                        rs.getBoolean("SliderStatus"),
                        rs.getString("CreateDate")
                );
                vector.add(slider);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return vector;
    }
     public int updateStatus(int SliderID, int SliderStatus) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`Slider`\n"
                + "SET`SliderStatus` = ? WHERE `SliderID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, SliderStatus);
            pre.setInt(2, SliderID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
        }
        return n;
    }
}
