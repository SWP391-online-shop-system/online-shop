/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import view.Receiver;

/**
 *
 * @author trant
 */
public class DAOReceiver extends DBConnect {

    public int insertReceiverByPrepared(Receiver receiver) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`receiver`\n"
                + "(`OrderID`,\n"
                + "`ReceiverName`,\n"
                + "`ReceiverPhoneNumber`,\n"
                + "`ReceiverAddress`,\n"
                + "`ReceiverEmail`,\n"
                + "`ReceiverGender`,\n"
                + "`Note`)\n"
                + "VALUES\n"
                + "(?,?,?,?,?,?,?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, receiver.getOrderID());
            pre.setString(2, receiver.getReceiverName());
            pre.setString(3, receiver.getReceiverPhoneNumber());
            pre.setString(4, receiver.getRceiverAddress());
            pre.setString(5, receiver.getReceiverEmail());
            pre.setBoolean(6, receiver.getReceiverGender());
            pre.setString(7, receiver.getNote());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOReceiver.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
