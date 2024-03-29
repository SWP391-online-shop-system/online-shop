/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import view.Log;

/**
 *
 * @author trant
 */
public class DAOLog extends DBConnect {

    /*
       int ID;
     int LogTopic;
     String LogType;
     int UpdateBy;
     String UpdateAt;
     String Purpose;
     */
    public int insertLog(Log log) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`loghistory`(`ID`,`LogTopic`,`LogType`,`UpdateBy`,`UpdateAt`,`Purpose`)\n"
                + "VALUES(?,?,?,?,CURRENT_TIMESTAMP,?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, log.getID());
            pre.setInt(2, log.getLogTopic());
            pre.setString(3, log.getLogType());
            pre.setInt(4, log.getUpdateBy());
            pre.setString(5, log.getPurpose());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
        }
        return n;
    }

    public String convertTopic(int LogTopic) {
        String result = "";
        switch (LogTopic) {
            case 1:
                result = "Sản phẩm";
                break;
            case 2:
                result = "Khách hàng";
                break;
            case 3:
                result = "Slide";
                break;
            case 4:
                result = "Bài đăng";
                break;
            case 5:
                result = "Phản hồi";
                break;
            case 6:
                result = "Đơn hàng";
                break;
        }
        return result;
    }
}
