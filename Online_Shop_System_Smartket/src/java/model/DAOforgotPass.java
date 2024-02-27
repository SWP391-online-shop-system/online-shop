/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import view.User;

/**
 *
 * @author admin
 */
public class DAOforgotPass extends DBConnect {

    private static final String EMAIL_REGEX
            = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

    public static boolean validateEmail(String email) {
        Pattern pattern = Pattern.compile(EMAIL_REGEX);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    public static boolean isNumeric(String input) {
        if (input == null || input.trim().isEmpty()) {
            return false;
        }

        for (char c : input.toCharArray()) {
            if (!Character.isDigit(c)) {
                return false;
            }
        }

        return true;
    }

    public User checkEmailExist(String mail) {
        String sql = "SELECT * FROM User WHERE Email = ?";
        try ( PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, mail);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getString(6),
                            rs.getBoolean(7),
                            rs.getString(8),
                            rs.getString(9),
                            rs.getString(10),
                            rs.getString(11),
                            rs.getInt(12),
                            rs.getInt(13),
                            rs.getInt(14));
                }
            }
        } catch (Exception e) {
            // Xử lý ngoại lệ
        }
        return null;
    }

    public int rePass(String pass, String mail) {
        int row = 0;
        String sql = "update user set Password = ? where Email = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, pass);
            pre.setString(2, mail);
            int affectedRows = pre.executeUpdate();
            if (affectedRows != 0) {
                row = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }

    public static boolean validatePassword(String password) {
        // Kiểm tra độ dài của mật khẩu
        if (password.length() < 6) {
            return false;
        }

        // Kiểm tra xem mật khẩu có chứa ít nhất một chữ số hay không
        boolean hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isDigit(c)) {
                hasDigit = true;
                break;
            }
        }
        return hasDigit;
    }

    public static void main(String[] args) {
        DAOforgotPass dao = new DAOforgotPass();
        int row = dao.rePass("Matkhau22", "giangpthe171781@fpt.edu.vn");
        System.out.println(row);
        User user = dao.checkEmailExist("giangpthe171781@fpt.edu.vn");
        if (user != null) {
            System.out.println("Email đã tồn tại: " + user.getEmail());
        } else {
            System.out.println("Email không tồn tại trong cơ sở dữ liệu.");
        }
    }
}
