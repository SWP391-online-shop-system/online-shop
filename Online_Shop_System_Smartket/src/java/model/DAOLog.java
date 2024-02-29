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

    public int insertLog(Log log) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`loghistory`(`UserId`,`updateBy`,`updateAt`,`purpose`)\n"
                + "VALUES(?,?,CURRENT_TIMESTAMP,?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, log.getUserId());
            pre.setInt(2, log.getUpdateBy());
            pre.setString(3, log.getPurpose());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
        }
        return n;
    }

//    public int updateLog(Log cart, int oldid) {
//        int n = 0;
//        String sql = "UPDATE `online_shop_system`.`cart`\n"
//                + "SET\n"
//                + "`UserID` = ?,\n"
//                + "`ProductID` = ?,\n"
//                + "`Quantity` = ?\n"
//                + "WHERE `UserID` = ?;";
//        try {
//            // number ? = number fields
//            // index of ? start is 1
//            PreparedStatement pre = conn.prepareStatement(sql);
//            pre.setInt(1, cart.getUserId());
//            pre.setInt(2, cart.getProductId());
//            pre.setInt(3, cart.getQuantity());
//            pre.setInt(4, oldid);
//            n = pre.executeUpdate();
//        } catch (SQLException ex) {
//            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return n;
//    }
}
