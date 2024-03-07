/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import view.Role;

/**
 *
 * @author admin
 */
public class DAORole extends DBConnect {

    public Role getRoleById(int RoleID) {

        String sql = "select * from `Role` where RoleID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, RoleID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role pro = new Role(
                        rs.getInt("RoleID"),
                        rs.getString("RoleName")
                );
                return pro;
            }
        } catch (SQLException e) {
            System.out.println("DAORole at line 33: " + e);
        }
        return null;
    }
}
