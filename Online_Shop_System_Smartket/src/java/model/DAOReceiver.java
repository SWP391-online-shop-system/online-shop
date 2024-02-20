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
public class DAOReceiver extends DBConnect{

    public int insertReceiverByPrepared(Receiver receiver) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`receiver`\n"
                + "(`OrderID`,\n"
                + "`ReceiverName`,\n"
                + "`ReceiverPhoneNumber`,\n"
                + "`ReceiverAddress`)\n"
                + "VALUES(?,?,?,?);";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, receiver.getOrderID());
            pre.setString(2, receiver.getReceName());
            pre.setString(3, receiver.getRecePhone());
            pre.setString(4, receiver.getReceAdress());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOReceiver.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}
