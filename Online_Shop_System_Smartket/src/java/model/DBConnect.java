package model;

import java.io.File;
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
            System.err.println("GetData wrong sql: "+ex);
        }
        return rs;
    }

    public void executeSQL(String sql) {
        try {
            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    /**
     *
     * @param imageRoot: name of image you want to change
     * @param imageChange: name of image you want to replace
     */
    public static void changeImage(String imageRoot, String imageChange) {
        String rootDirectory = "D:\\fpt\\Semeter_5\\SWP391\\Project\\Online_Shop_System_Smartket\\";
        String oldFileName = rootDirectory + "web\\" + imageRoot.replaceAll("/", "\\\\");
        String newFileName = rootDirectory + "web\\" + imageChange.replaceAll("/", "\\\\");
        File oldFile = new File(oldFileName);
        File newFile = new File(newFileName);
        if (oldFile.exists() && newFile.exists()) {
            File tempFile = new File(newFileName + ".temp");
            if (newFile.renameTo(tempFile) && oldFile.renameTo(newFile) && tempFile.renameTo(oldFile)) {
                System.out.println("Image files renamed successfully.");
            } else {
                System.out.println("Failed to rename image files.");
            }
        } else {
            System.out.println("One or both image files do not exist.");
        }
    }

    public static void main(String[] args) throws SQLException {
        DBConnect dao = new DBConnect();

    }
}
