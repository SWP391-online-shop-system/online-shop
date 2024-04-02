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
import view.Setting;

/**
 *
 * @author admin SettingID, SettingName, SettingOrder, SettingValue,
 * SettingDescription, SettingStatus, CreateDate
 */
public class DAOSetting extends DBConnect {

    public Setting getaSlider(String sql) {
        Setting s = new Setting();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);

            while (rs.next()) {
                int SettingID = rs.getInt("SettingID");
                String SettingName = rs.getString("SettingName");
                int SettingOrder = rs.getInt("SettingOrder");
                String SettingValue = rs.getString("SettingValue");
                String SettingDescription = rs.getString("SettingDescription");
                int SettingStatus = rs.getInt("SettingStatus");
                String CreateDate = rs.getString("CreateDate");
                s = new Setting(SettingID, SettingName, SettingOrder, SettingValue, SettingDescription, SettingStatus, CreateDate);
            }

        } catch (SQLException ex) {
            System.out.println("sql errot at 141 in DAOSlider: " + ex);
        }
        return s;
    }

    public int addNewUserByMKT(Setting Setting) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`setting`(`SettingName`,`SettingOrder`,`SettingValue`,`SettingDescription`,`SettingStatus`,`CreateDate`)\n"
                + "VALUES(?,?,?,?,?,CURRENT_TIMESTAMP);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, Setting.getSettingName());
            pre.setInt(2, Setting.getSettingOrder());
            pre.setString(3, Setting.getSettingValue());
            pre.setString(4, Setting.getSettingDescription());
            pre.setInt(5, Setting.getSettingStatus());
            n = pre.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int updateSetting(Setting setting, String a) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`Setting`\n"
                + "SET\n"
                + "`SettingStatus` =" + a + "\n"
                + "WHERE `SettingID` = ?";
        System.out.println("sql = " + sql);
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, setting.getSettingID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

    public int updateCate(Setting setting, String a) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`Categories`\n"
                + "SET\n"
                + "`CategoryStatus` =" + a + "\n"
                + "WHERE `CategoryID` = ?";
        System.out.println("sql = " + sql);
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, setting.getSettingOrder());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

    public Vector<Setting> getSetting(String sql) {
        Vector<Setting> vector = new Vector<Setting>();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int SettingID = rs.getInt(1);
                String SettingName = rs.getString(2);
                int SettingOrder = rs.getInt(3);
                String SettingValue = rs.getString(4);
                String SettingDescription = rs.getString(5);
                int SettingStatus = rs.getInt(6);
                String CreateDate = rs.getString(7);

                Setting Setting = new Setting(SettingID, SettingName, SettingOrder, SettingValue, SettingDescription, SettingStatus, CreateDate);
                vector.add(Setting);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOSetting.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public int updatePro(Setting setting, String a) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`product`\n"
                + "SET\n"
                + "`ProductStatus` =" + a + "\n"
                + "WHERE `ProductID` = ?";
        System.out.println("sql = " + sql);
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, setting.getSettingOrder());
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
