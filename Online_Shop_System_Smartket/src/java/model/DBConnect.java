package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {

    Connection conn = null;

    public DBConnect(String url, String user, String pass) {
        try {
            //call driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            //connect
            conn = DriverManager.getConnection(url, user, pass);
            System.out.println("connected");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public DBConnect() {
        this("jdbc:mysql://localhost:3306/Online_Shop_System", "root", "12345678");
    }

    public ResultSet getData(String sql) {
        ResultSet rs = null;
        Statement state;
        try {
            state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = state.executeQuery(sql);
        } catch (SQLException ex) {

        }
        return rs;
    }

    public static void main(String[] args) {
        new DBConnect();
////        DBConnect db = new DBConnect();
////        ResultSet rs = db.getData("SELECT * FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where c.UserID = 1;");
////        try {
////            while (rs.next()) {                
////                System.out.println(rs.getInt(1));
////                System.out.println(rs.getString(5));
////                System.out.println(rs.getString(7));
////            }
////        } catch (SQLException e) {
////        }
    }
}
