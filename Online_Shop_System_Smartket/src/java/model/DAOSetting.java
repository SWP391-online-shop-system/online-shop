/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import view.Setting;

/**
 *
 * @author admin
 */
public class DAOSetting extends DBConnect {

    public int updateSetting(Setting setting) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`Setting`\n"
                + "SET\n"
                + "`SettingName` = ?,\n"
                + "`SettingOrder` = ?,\n"
                + "`SettingValue` = ?,\n"
                + "`SettingDescription` = ?,\n"
                + "`SettingStatus` =?,\n"
                + "`CreateDate` = ?\n"
                + "WHERE `SettingID` = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, setting.getSettingName());
            pre.setInt(2, setting.getSettingOrder());
            pre.setString(3, setting.getSettingValue());
            pre.setString(4, setting.getSettingDescription());
            pre.setInt(5, setting.getSettingStatus());
            pre.setString(6, setting.getCreateDate());
            pre.setInt(7, setting.getSettingID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

    public Setting getSettingById(int SettingID) {

        String sql = "select * from Setting where SettingID =?";
        /*
          private int SettingID;
    private String SettingName;
    private int SettingOrder;
    private String SettingValue;
    private String SettingDescription;
    private int SettingStatus;
    private String CreateDate;
         */
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, SettingID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Setting pro = new Setting(
                        rs.getInt("SettingID"),
                        rs.getString("SettingName"),
                        rs.getInt("SettingOrder"),
                        rs.getString("SettingValue"),
                        rs.getString("SettingDescription"),
                        rs.getInt("SettingStatus"),
                        rs.getString("CreateDate")
                );
                return pro;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
