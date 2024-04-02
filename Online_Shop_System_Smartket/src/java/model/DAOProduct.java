package model;

import view.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class DAOProduct extends DBConnect {

    public Vector<Product> getProduct(String sql) {
        Vector<Product> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int ProductID = rs.getInt("ProductID");
                int CategoryID = rs.getInt("CategoryID");
                String ProductName = rs.getString("ProductName");
                String ProductDescription = rs.getString("ProductDescription");
                int UnitInStock = rs.getInt("UnitInStock");
                double UnitPrice = rs.getDouble("UnitPrice");
                int UnitDiscount = rs.getInt("UnitDiscount");
                String CreateDate = rs.getString("CreateDate");
                int TotalRate = rs.getInt("TotalRate");
                int TotalStock = rs.getInt("TotalStock");
                boolean ProductStatus = rs.getBoolean("ProductStatus");
                Product pro = new Product(ProductID, ProductName,
                        CategoryID, ProductDescription, UnitInStock,
                        UnitPrice, UnitDiscount, CreateDate, TotalRate, TotalStock, ProductStatus);
                vector.add(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public String getProductURL(int productId) {
        String productURL = null;
        try {
            String sql = "SELECT ProductURL FROM ProductImage WHERE ProductStatus = 0 and ProductID = ?";
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, productId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                productURL = rs.getString("ProductURL");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return productURL;
    }

    public int insertProduct(Product pro) {
        int n = 0;
        String sql = "INSERT INTO `online_shop_system`.`product`\n"
                + "(`ProductID`,\n"
                + "`ProductName`,\n"
                + "`CategoryID`,\n"
                + "`ProductDescription`,\n"
                + "`UnitInStock`,\n"
                + "`UnitPrice`,\n"
                + "`UnitDiscount`,\n"
                + "`CreateDate`,\n"
                + "`TotalRate`,\n"
                + "`TotalStock`,\n"
                + "`ProductStatus`)\n"
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "now(),\n"
                + "?,\n"
                + "?,\n"
                + "?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, pro.getProductID());
            pre.setString(2, pro.getProductName());
            pre.setInt(3, pro.getCategoryID());
            pre.setString(4, pro.getProductDescription());
            pre.setInt(5, pro.getUnitInStock());
            pre.setDouble(6, pro.getUnitPrice());
            pre.setInt(7, pro.getUnitDiscount());
            pre.setString(8, getCurrentTimestamp()); // Set current timestamp
            pre.setInt(9, pro.getTotalRate());
            pre.setInt(10, pro.getTotalStock());
            pre.setBoolean(11, pro.isProductStatus());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateProduct(Product pro) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`product`\n"
                + "SET\n"
                + "`ProductName` = ?,\n"
                + "`CategoryID` = ?,\n"
                + "`ProductDescription` = ?,\n"
                + "`UnitInStock` = ?,\n"
                + "`UnitPrice` = ?,\n"
                + "`UnitDiscount` = ?,\n"
                + "`CreateDate` =?,\n"
                + "`TotalRate` = ?,\n"
                + "`TotalStock` = ?,\n"
                + "`ProductStatus` = ?\n" // Moved ProductStatus to the end
                + "WHERE `ProductID` = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, pro.getProductName());
            pre.setInt(2, pro.getCategoryID());
            pre.setString(3, pro.getProductDescription());
            pre.setInt(4, pro.getUnitInStock());
            pre.setDouble(5, pro.getUnitPrice());
            pre.setInt(6, pro.getUnitDiscount());
            pre.setString(7, pro.getCreateDate());
            pre.setInt(8, pro.getTotalRate());
            pre.setInt(9, pro.getTotalStock());
            pre.setInt(10, pro.isProductStatus() ? 0 : 1);  // Convert boolean to int
            pre.setInt(11, pro.getProductID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

    public int updateUnitInStock(int proId, int stock) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`product`\n"
                + "SET\n"
                + "`UnitInStock` = ?\n"
                + "WHERE `ProductID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, stock);
            pre.setInt(2, proId);
            n = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

    public Product getProductById(int productID) {

        String sql = "select * from Product where ProductStatus = 0 and ProductID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, productID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product pro = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductDescription"),
                        rs.getInt("UnitInStock"),
                        rs.getDouble("UnitPrice"),
                        rs.getInt("UnitDiscount"),
                        rs.getString("CreateDate"),
                        rs.getInt("TotalRate"),
                        rs.getInt("TotalStock"),
                        rs.getBoolean("ProductStatus")
                );
                return pro;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Vector<Product> getProductByCategoryID(int categoryID) {
        Vector<Product> vector = new Vector<>();
        String sql = "select * from Product where ProductStatus = 0 and CategoryID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, categoryID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product pro = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductDescription"),
                        rs.getInt("UnitInStock"),
                        rs.getDouble("UnitPrice"),
                        rs.getInt("UnitDiscount"),
                        rs.getString("CreateDate"),
                        rs.getInt("TotalRate"),
                        rs.getInt("TotalStock"),
                        rs.getBoolean("ProductStatus")
                );
                vector.add(pro);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return vector;
    }

    public int getTotalProductBySearch(String key, double min, double max) {
        String sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and ProductName like N'%" + key + "%' or CategoryName like '%" + key + "%'";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductBySearchCategory(String key, int CategoryID, double min, double max) {
        String sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and c.CategoryID =" + CategoryID + " and UnitPrice between " + min + " and " + max + " and ProductName like N'%" + key + "%' or CategoryName like '%" + key + "%'";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByCateID(int CateID, double min, double max) {
        String sql = "select count(*) from Product where ProductStatus = 0 and CategoryID=" + CateID + " and UnitPrice between " + min + " and " + max;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProduct(double min, double max) {
        String sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProduct() {
        String sql = "select count(*) from Product";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalTypeProduct(String type, double min, double max) {
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "select count(*) from Product where ProductStatus = 0 and " + type + " and UnitPrice between " + min + " and " + max;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalTypeAndCategoryIDProduct(String type, int CategoryID, double min, double max) {
        if (type.equals("showNew")) {
            type = "CreateDate = curDate()";
        }
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "select count(*) from Product where ProductStatus = 0 and " + type + " and CategoryID = " + CategoryID + " and UnitPrice between " + min + " and " + max;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByPrice(double min, double max) {
        String sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByRate(int rate, double min, double max) {
        String sql = "";
        if (rate == 0) {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + "and TotalRate between 0 and 5";
        } else {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and TotalRate = " + rate + ";";
        }
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByRateAndTypeSearch(String key, int rate, String type, double min, double max) {
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        if (rate == 0) {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and " + type + " and TotalRate between 0 and 5 and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%'";
        } else {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and " + type + " and TotalRate =" + rate + " and productName like N'%" + key + "%' or c.CategoryName like '%" + key + "%'";
        }
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByRateAndTypeSearchCategory(String key, int CategoryID, int rate, String type, double min, double max) {
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        if (rate == 0) {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and " + type + " and CategoryID= " + CategoryID + " and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%'";
        } else {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and " + type + "and TotalRate = " + rate + " and CategoryID= " + CategoryID + " and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%'";
        }
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByTypeSearch(String key, String type, double min, double max) {
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%' and " + type;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByTypeSearchCategory(String key, int CategoryID, String type, double min, double max) {
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " c.CategoryID = " + CategoryID + " and ProductName like N'% and " + key + "%' or c.CategoryName like '% " + key + "%'and " + type;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByRateSearch(String key, int rate, double min, double max) {
        String sql = "";
        if (rate == 0) {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and TotalRate between 0 and 5 and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%'";
        } else {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + "and TotalRate = " + rate + " and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%' and UnitDiscount != 0";
        }
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByRateSearchCategory(String key, int CategoryID, int rate, double min, double max) {
        String sql = "";
        if (rate == 0) {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and c.CategoryID = " + CategoryID
                    + " and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%'";
        } else {
            sql = "select count(*) from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and TotalRate = " + rate + " and c.CategoryID = " + CategoryID
                    + " and ProductName like N'%" + key + "%' or c.CategoryName like '%" + key + "%' and UnitDiscount != 0";
        }
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalTypeAndRateProduct(String type, int totalRate, double min, double max) {
        if (type.equals("showNew")) {
            type = "CreateDate = curDate()";
        }
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        if (totalRate == 0) {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and " + type + " and TotalRate between 0 and 5";
        } else {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and " + type + " and TotalRate = " + totalRate;
        }

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalTypeAndRateProductCategory(String type, int CategoryID, int totalRate, double min, double max) {
        if (type.equals("showNew")) {
            type = "CreateDate = curDate()";
        }
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        if (totalRate == 0) {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and CategoryID =" + CategoryID + " and  " + type + " and TotalRate between 0 and 5";
        } else {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and CategoryID =" + CategoryID + " and  " + type + " and TotalRate = " + totalRate;
        }

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                System.out.println("=======" + rs.getInt(1));
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalTypeAndRateAndCategoryID(String type, int totalRate, int CategoryID, double min, double max) {
        if (type.equals("showNew")) {
            type = "CreateDate = curDate()";
        }
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        if (totalRate == 0) {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + "and " + type + " and TotalRate between 0 and 5 and CategoryID = " + CategoryID;
        } else {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and " + type + " and TotalRate = " + totalRate + " and CategoryID = " + CategoryID;
        }

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProductByRateAndCategoryID(int rate, int categoryID, double min, double max) {
        String sql = "";
        if (rate == 0) {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and TotalRate between 0 and  5 and CategoryID = " + categoryID;

        } else {
            sql = "select count(*) from Product where ProductStatus = 0 and UnitPrice between " + min + " and " + max + " and TotalRate = " + rate + " and CategoryID = " + categoryID;
        }
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getMaxUnitPrice() {
        String sql = "select UnitPrice from Product where ProductStatus = 0 order by UnitPrice desc limit 1";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getMinUnitPrice() {
        String sql = "select UnitPrice from Product where ProductStatus = 0 order by UnitPrice asc limit 1 ";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getMaxUnitPriceSearch(String keyWord) {
        String sql = "select UnitPrice from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and ProductName like'%" + keyWord + "%' or c.CategoryName like '%" + keyWord + "%' order by UnitPrice desc limit 1";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getMinUnitPriceSearch(String keyWord) {
        String sql = "select UnitPrice from Product as p join Categories as c on p.CategoryID = c.CategoryID where ProductStatus = 0 and ProductName like'%" + keyWord + "%' order by UnitPrice asc limit 1";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public ResultSet getDataWithStatus(String statusQuery) {
        ResultSet rs = null;
        try {
            Statement stm = conn.createStatement();
            String query = "SELECT * FROM Product AS p "
                    + "JOIN Categories AS c ON p.CategoryID = c.CategoryID "
                    + "JOIN ProductImage AS pi ON p.ProductID = pi.ProductID where ProductStatus = 0"
                    + statusQuery;  // Append status condition to the query
            rs = stm.executeQuery(query);
        } catch (SQLException e) {
            System.out.println(e);
        }
        return rs;
    }

    public static String getCurrentTimestamp() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        return dateFormat.format(date);
    }

    public int updateStatus(int ProductID, int ProductStatus) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`product`\n"
                + "SET\n"
                + "`ProductStatus` = ?\n"
                + "WHERE `ProductID` = ?;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, ProductStatus);
            pre.setInt(2, ProductID);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
        }
        return n;
    }

    public boolean checkQuantity(String proId) {
        int quantityInCart = 0, quantityProduct = 0;
        String cart = "SELECT * FROM online_shop_system.cart where ProductID = " + proId + ";";
        String product = "SELECT * FROM online_shop_system.product where ProductID = " + proId + ";";
        try {
            PreparedStatement stCart = conn.prepareStatement(cart);
            ResultSet rsCart = stCart.executeQuery();
            while (rsCart.next()) {
                quantityInCart = rsCart.getInt("Quantity");
            }
            PreparedStatement stProduct = conn.prepareStatement(product);
            ResultSet rsProduct = stProduct.executeQuery();
            while (rsProduct.next()) {
                quantityProduct = rsProduct.getInt("UnitInStock");
            }
            if (quantityInCart > quantityProduct) {
                return false;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return true;
    }
//    public static void main(String[] args) {
//        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        Calendar calendar = Calendar.getInstance();
//        String date1 = null, date2 = null, date3 = null;
//        for (int i = 0; i < 3; i++) {
//            // Get the date for the current day
//            Date date = calendar.getTime();
//            // Format the date and store it in the corresponding variable
//            switch (i) {
//                case 0:
//
//                    date1 = dateFormat.format(date);
//                    break;
//                case 1:
//                    date2 = dateFormat.format(date);
//                    break;
//                default:
//                    date3 = dateFormat.format(date);
//                    break;
//            }
//            calendar.add(Calendar.DAY_OF_MONTH, -1);
//        }
//        System.out.println(date1);
//        System.out.println(date2);
//        System.out.println(date3);
//        System.out.println();
//        DAOProduct dao = new DAOProduct();
//        ResultSet rs = dao.getData("select * from Product");
//        try {
//            while (rs.next()) {
//                String s = rs.getString("CreateDate").substring(0, 10);
//                System.out.println(s);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }

}
