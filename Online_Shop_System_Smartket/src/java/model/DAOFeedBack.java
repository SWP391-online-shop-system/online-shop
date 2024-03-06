package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.DBConnect;
import view.FeedBack;

/**
 *
 * @author admin
 */
public class DAOFeedBack extends DBConnect {

    public FeedBack getFeedBackById(int FeedBackID) {

        String sql = "select * from FeedBack where FeedBackID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, FeedBackID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                FeedBack pro = new FeedBack(
                        rs.getInt("FeedBackID"),
                        rs.getInt("ProductID"),
                        rs.getInt("UserID"),
                        rs.getString("FeedBackContent"),
                        rs.getInt("FeedBackRate"),
                        rs.getString("FeedBackDate"),
                        rs.getBoolean("FeedBackStatus")
                );
                return pro;
            }
        } catch (SQLException e) {
            System.out.println("line 38 in DAOFeedBack: " + e);
        }
        return null;
    }

    public int updateStatus(int FeedBackID, int FeedBackStatus) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`FeedBack`\n"
                + "SET`FeedBackStatus` = ? WHERE `FeedBackID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, FeedBackStatus);
            pre.setInt(2, FeedBackID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
        }
        return n;
    }
}
