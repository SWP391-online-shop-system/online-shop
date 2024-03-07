/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import view.Status;

/**
 *
 * @author admin
 */
public class DAOStatus extends DBConnect {

    public Status getStatusByID(int StatusID) {

        String sql = "select * from Status where StatusID =" + StatusID;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Status pro = new Status(
                        rs.getInt(1),
                        rs.getString(2)
                );
                System.out.println("Not Null");
                return pro;

            }
        } catch (SQLException e) {
            System.out.println("line 34 at DAOStatus: " +e );
        }
        return null;
    }
}
