package model;

import view.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

    public void insertProduct(Product pro) {
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
                + "`TotalStock`\n"
                + "`ProductStatus`)\n"
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?),\n";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, pro.getProductID());
            pre.setString(2, pro.getProductName());
            pre.setInt(3, pro.getCategoryID());
            pre.setString(4, pro.getProductDescription());
            pre.setInt(5, pro.getUnitInStock());
            pre.setDouble(6, pro.getUnitPrice());
            pre.setInt(7, pro.getUnitDiscount());
            pre.setString(8, pro.getCreateDate());
            pre.setInt(9, pro.getTotalRate());
            pre.setInt(10, pro.getTotalStock());
            pre.setBoolean(11, pro.isProductStatus());
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int updateProduct(Product pro) {
        int n = 0;
        String sql = "UPDATE `online_shop_system`.`product`\n"
                + "SET\n"
                + "`ProductID` = ?,\n"
                + "`ProductName` = ?,\n"
                + "`CategoryID` = ?,\n"
                + "`ProductDescription` = ?,\n"
                + "`UnitInStock` = ?,\n"
                + "`UnitPrice` = ?,\n"
                + "`UnitDiscount` = ?,\n"
                + "`CreateDate` =?,\n"
                + "`TotalRate` = ?,\n"
                + "`TotalStock` = ?\n"
                + "`ProductStatus` = ?\n"
                + "WHERE `ProductID` = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, pro.getProductID());
            pre.setString(2, pro.getProductName());
            pre.setInt(3, pro.getCategoryID());
            pre.setString(4, pro.getProductDescription());
            pre.setInt(5, pro.getUnitInStock());
            pre.setDouble(6, pro.getUnitPrice());
            pre.setInt(7, pro.getUnitDiscount());
            pre.setString(8, pro.getCreateDate());
            pre.setInt(9, pro.getTotalRate());
            pre.setInt(10, pro.getTotalStock());
            pre.setInt(11, pro.getProductID());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

    public Product getProductById(int productID) {

        String sql = "select * from Product where ProductID =?";
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
        System.out.println("null");
        return null;
    }

    public Vector<Product> getProductByCategoryID(int categoryID) {
        Vector<Product> vector = new Vector<>();
        String sql = "select * from Product where CategoryID =?";
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

    public Vector<Product> searchProductByName(String keyWord) {
        Vector<Product> list = new Vector<>();
        String sql = "select * from Product where ProductName like ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "N%" + keyWord + "%");
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
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<Product> get12Next(int ammount, String orderBy) {
        Vector<Product> list = new Vector<>();
        String sql = "select * from Product \n"
                + "order by " + orderBy + "\n"
                + "limit 12 \n"
                + "offset ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (ammount - 1) * 12);
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
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<Product> get12NextByCateId(int ammount, int CateID, String filter) {
        Vector<Product> list = new Vector<>();
        String sql = "select * from Product \n"
                + "Where CategoryID =" + CateID + " \n"
                + "order by " + filter + "\n"
                + "limit 12 \n"
                + "offset ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (ammount - 1) * 12);
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
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<Product> get12NextBySearch(int ammount, String key, String filter) {
        Vector<Product> list = new Vector<>();
        String sql = "select * from product as p join productImage as pi on p.ProductID = pi.ProductID "
                + "where p.ProductName like N'%" + key + "%'"
                + " and pi.productURL like '%_1%' order by " + filter + " limit 12 offset ?;";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (ammount - 1) * 12);
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
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<Product> get10Next(int index) {
        Vector<Product> vector = new Vector<>();
        String sql = "select * from Product order by ProductID limit 10 offset ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (index - 1) * 10);
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
        String sql = "select count(*) from Product where ProductName like N'%" + key + "%' and UnitPrice between " + min + " and " + max;
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
        String sql = "select count(*) from Product where CategoryID=" + CateID + " and UnitPrice between " + min + " and " + max;
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
        String sql = "select count(*) from Product where UnitPrice between " + min + " and " + max;
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
        String sql = "select count(*) from Product where " + type + " and UnitPrice between " + min + " and " + max;
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
        String sql = "select count(*) from Product where " + type + " and CategoryID = " + CategoryID + " and UnitPrice between " + min + " and " + max;
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
        String sql = "select count(*) from Product where UnitPrice between " + min + " and " + max;
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
            sql = "select count(*) from Product where TotalRate between 0 and 5 and UnitPrice between " + min + " and " + max;
        } else {
            sql = "select count(*) from Product where TotalRate = " + rate + " and UnitPrice between " + min + " and " + max;
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
            sql = "select count(*) from Product where ProductName like N'%" + key + "%' and " + type + " and TotalRate between 0 and 5 and UnitPrice between " + min + " and " + max;
        } else {
            sql = "select count(*) from Product where ProductName like N'%" + key + "%' and " + type + " and TotalRate = " + rate + " and UnitPrice between " + min + " and " + max;
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
        sql = "select count(*) from Product where ProductName like N'%" + key + "%' and " + type + " and UnitPrice between " + min + " and " + max;
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
            sql = "select count(*) from Product where ProductName like N'%" + key + "%' and TotalRate between 0 and 5 and UnitPrice between " + min + " and " + max;
        } else {
            sql = "select count(*) from Product where ProductName like N'%" + key + "%' and TotalRate = " + rate + " and UnitDiscount != 0 and TotalRate = " + rate + " and UnitPrice between " + min + " and " + max;
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
            sql = "select count(*) from Product where " + type + " and TotalRate between 0 and 5 and UnitPrice between " + min + " and " + max;
        } else {
            sql = "select count(*) from Product where " + type + " and TotalRate = " + totalRate + " and UnitPrice between " + min + " and " + max;
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

    public int getTotalTypeAndRateAndCategoryID(String type, int totalRate, int CategoryID, double min, double max) {
        if (type.equals("showNew")) {
            type = "CreateDate = curDate()";
        }
        if (type.equals("showSale")) {
            type = "UnitDiscount != 0";
        }
        String sql = "";
        if (totalRate == 0) {
            sql = "select count(*) from Product where " + type + " and TotalRate between 0 and 5 and CategoryID = " + CategoryID + " and UnitPrice between " + min + " and " + max;
        } else {
            sql = "select count(*) from Product where " + type + " and TotalRate = " + totalRate + " and CategoryID = " + CategoryID + " and UnitPrice between " + min + " and " + max;
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
            sql = "select count(*) from Product where TotalRate between 0 and  5 and CategoryID = " + categoryID + " and UnitPrice between " + min + " and " + max;

        } else {
            sql = "select count(*) from Product where TotalRate = " + rate + " and CategoryID = " + categoryID + " and UnitPrice between " + min + " and " + max;
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
        String sql = "select UnitPrice from Product order by UnitPrice desc limit 1";
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
        String sql = "select UnitPrice from Product order by UnitPrice asc limit 1 ";
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
        String sql = "select UnitPrice from Product where ProductName like'%" + keyWord + "%' order by UnitPrice desc limit 1";
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
        String sql = "select UnitPrice from Product where ProductName like'%" + keyWord + "%' order by UnitPrice asc limit 1";
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
