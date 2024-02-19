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
import view.Slider;

/**
 *
 * @author admin
 */
public class DAOSlider extends DBConnect {

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
                Slider s = new Slider(SliderID, UserID, SliderImage, SliderLink,SliderStatus);
                vector.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }
}
