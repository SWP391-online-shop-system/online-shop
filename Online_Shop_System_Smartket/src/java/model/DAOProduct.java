package model;

import view.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class DAOProduct extends DBConnect {

    @Override
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
                Product pro = new Product(ProductID, ProductName,
                        CategoryID, ProductDescription, UnitInStock,
                        UnitPrice, UnitDiscount, CreateDate, TotalRate, TotalStock);
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
                + "`TotalStock`)\n"
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
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateProduct(Product pro) {
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
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
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
                        rs.getInt("TotalStock")
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
                        rs.getInt("TotalStock")
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
                        rs.getInt("TotalStock")
                );
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<Product> get9Next(int ammount) {
        Vector<Product> list = new Vector<>();
        String sql = "select * from Product \n"
                + "order by ProductID \n"
                + "limit 9 \n"
                + "offset ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (ammount - 1) * 9);
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
                        rs.getInt("TotalStock")
                );
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<Product> get9NextByCateId(int ammount, int CateID) {
        Vector<Product> list = new Vector<>();
        String sql = "select * from Product \n"
                + "Where CategoryID =" + CateID + " \n"
                + "order by ProductID \n"
                + "limit 9 \n"
                + "offset ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (ammount - 1) * 9);
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
                        rs.getInt("TotalStock")
                );
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getTotalProductByCateID(int CateID) {
        String sql = "select count(*) from Product where CategoryID=" + CateID;
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
}
