///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package model;
//
//import view.Product;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.Vector;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
///**
// *
// * @author admin
// */
//public class DAOProduct extends DBConnect {
//
//    public Vector<Product> getProduct(String sql) {
//        Vector<Product> vector = new Vector<>();
//        try {
//            Statement state = conn.createStatement(
//                    ResultSet.TYPE_SCROLL_SENSITIVE,
//                    ResultSet.CONCUR_UPDATABLE);
//            ResultSet rs = state.executeQuery(sql);
//            while (rs.next()) {
//                int ProductID = rs.getInt("ProductID");
//                int CategoryID = rs.getInt("CategoryID");
//                String ProductName = rs.getString("ProductName");
//                String ProductDescription = rs.getString("ProductDescription");
//                int UnitInStock = rs.getInt("UnitInStock");
//                double UnitPrice = rs.getDouble("UnitPrice");
//                int UnitDiscount = rs.getInt("UnitDiscount");
//                int ProductImageID = rs.getInt("ProductImageID");
//                String CreateDate = rs.getString("CreateDate");
//                int TotalRate = rs.getInt("TotalRate");
//                int TotalStock = rs.getInt("TotalStock");
//                Product pro = new Product(ProductID, ProductName,
//                        CategoryID, ProductDescription, UnitInStock,
//                        UnitPrice, UnitDiscount, ProductImageID, CreateDate, TotalRate, TotalStock);
//                vector.add(pro);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return vector;
//    }
//
//    public void insertProduct(Product pro) {
//        String sql = "INSERT INTO `online_shop_system`.`product`\n"
//                + "(`ProductID`,\n"
//                + "`ProductName`,\n"
//                + "`CategoryID`,\n"
//                + "`ProductDescription`,\n"
//                + "`UnitInStock`,\n"
//                + "`UnitPrice`,\n"
//                + "`UnitDiscount`,\n"
//                + "`ProductImage`,\n"
//                + "`CreateDate`,\n"
//                + "`TotalRate`,\n"
//                + "`TotalStock`)\n"
//                + "VALUES\n"
//                + "(?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?,\n"
//                + "?),\n";
//        try {
//            PreparedStatement pre = conn.prepareStatement(sql);
//            // pre.setDataType(indexOf?,para);
//            pre.setInt(1, pro.getProductID());
//            pre.setString(2, pro.getProductName());
//            pre.setInt(3, pro.getCategoryID());
//            pre.setString(4, pro.getProductDescription());
//            pre.setInt(5, pro.getUnitInStock());
//            pre.setDouble(6, pro.getUnitPrice());
//            pre.setInt(7, pro.getUnitDiscount());
//            pre.setInt(8, pro.getProductImageID());
//            pre.setString(9, pro.getCreateDate());
//            pre.setInt(10, pro.getTotalRate());
//            pre.setInt(11, pro.getTotalStock());
//            pre.executeUpdate();
//        } catch (SQLException ex) {
//            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
//    public void updateProduct(Product pro) {
//        String sql = "UPDATE [dbo].[Products]\n"
//                + "   SET [ProductID] = ?\n"
//                + "      ,[CategoryID] =?\n"
//                + "      ,[ProductName] =?\n"
//                + "      ,[ProductDescription] = ?\n"
//                + "      ,[UnitPrice] = ?\n"
//                + "      ,[UnitInStock] = ?\n"
//                + "      ,[Discount] =?\n"
//                + "      ,[Images] =?\n"
//                + "      ,[Status] =?\n"
//                + " WHERE ProductID=?";
//        try {
////            PreparedStatement pre = conn.prepareStatement(sql);
////            pre.setInt(1, pro.getProductID());
////            pre.setInt(2, pro.getCategoryID());
////            pre.setString(3, pro.getProductName());
////            pre.setString(4, pro.getProductDescription());
////            pre.setDouble(5, pro.getUnitPrice());
////            pre.setInt(6, pro.getUnitInStock());
////            pre.setDouble(7, pro.getDiscount());
////            pre.setString(8, pro.getImages());
////            pre.setInt(9, pro.getStatus());
////            pre.setInt(10, pro.getProductID());
//            pre.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println("error : " + e);
//        }
//    }
//
//    public int getMaxProductID() {
//        String sql = "select top 1 * from [Products] order by ProductID desc";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return 0;
//    }
//
//    public int deleteProductsById(int id) {
//        int n = 0;
//        String sql = "DELETE FROM [dbo].[Products]\n"
//                + "      WHERE ProductID=" + id;
//        try {
//            Statement state = conn.createStatement();
//
//            n = state.executeUpdate(sql);
//        } catch (SQLException e) {
//            Logger.getLogger(DAOProduct.class.getName()).log(Level.SEVERE, null, e);
//        }
//        return n;
//    }
//
//    public Product getProducstsById(int productID) {
//
//        String sql = "select * from Products where ProductID =?";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setInt(1, productID);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
////                Product pro = new Product(rs.getInt("ProductID"),
////                        rs.getInt("CategoryID"),
////                        rs.getString("ProductName"),
////                        rs.getString("ProductDescription"),
////                        rs.getDouble("UnitPrice"),
////                        rs.getInt("UnitInStock"),
////                        rs.getDouble("Discount"),
////                        rs.getString("Images"),
////                        rs.getInt("Status")
////                );
//                System.out.println("get success");
////                return pro;
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        System.out.println("null");
//        return null;
//    }
//
//    public Vector<Product> getProducstsByCategoryID(int categoryID) {
//        Vector<Product> vector = new Vector<>();
//        String sql = "select * from Products where CategoryID =?";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setInt(1, categoryID);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
////                Product pro = new Product(rs.getInt("ProductID"),
////                        rs.getInt("CategoryID"),
////                        rs.getString("ProductName"),
////                        rs.getString("ProductDescription"),
////                        rs.getDouble("UnitPrice"),
////                        rs.getInt("UnitInStock"),
////                        rs.getDouble("Discount"),
////                        rs.getString("Images"),
////                        rs.getInt("Status")
////                );
////                vector.add(pro);
//
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return vector;
//    }
//
//    public Vector<Product> searchByName(String txtSearch) {
//        Vector<Product> list = new Vector<>();
//        String sql = "select * from Products where ProductName like ?";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setString(1, "%" + txtSearch + "%");
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
////                Product pro = new Product(rs.getInt("ProductID"),
////                        rs.getInt("CategoryID"),
////                        rs.getString("ProductName"),
////                        rs.getString("ProductDescription"),
////                        rs.getDouble("UnitPrice"),
////                        rs.getInt("UnitInStock"),
////                        rs.getDouble("Discount"),
////                        rs.getString("Images"),
////                        rs.getInt("Status")
////                );
////                list.add(pro);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return list;
//    }
//
//    public Vector<Product> get6Next(int ammount) {
//        Vector<Product> list = new Vector<>();
//        String sql = "select * from Products \n"
//                + "order by ProductID \n"
//                + "offset ? rows \n"
//                + "fetch next 9 rows only";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setInt(1, (ammount - 1) * 9);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
////                Products pro = new Product(rs.getInt("ProductID"),
////                        rs.getInt("CategoryID"),
////                        rs.getString("ProductName"),
////                        rs.getString("ProductDescription"),
////                        rs.getDouble("UnitPrice"),
////                        rs.getInt("UnitInStock"),
////                        rs.getDouble("Discount"),
////                        rs.getString("Images"),
////                        rs.getInt("Status")
////                );
////                list.add(pro);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return list;
//    }
//
//    public Vector<Product> get6NextByCateId(int ammount, int CateID) {
//        Vector<Product> list = new Vector<>();
//        String sql = "select * from Products \n"
//                + "Where CategoryID =" + CateID + " \n"
//                + "order by ProductID \n"
//                + "offset ? rows \n"
//                + "fetch next 9 rows only";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setInt(1, (ammount - 1) * 9);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
////                Product pro = new Product(rs.getInt("ProductID"),
////                        rs.getInt("CategoryID"),
////                        rs.getString("ProductName"),
////                        rs.getString("ProductDescription"),
////                        rs.getDouble("UnitPrice"),
////                        rs.getInt("UnitInStock"),
////                        rs.getDouble("Discount"),
////                        rs.getString("Images"),
////                        rs.getInt("Status")
////                );
////                list.add(pro);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return list;
//    }
//
//    //count products
//    public int getTotalProducts() {
//        String sql = "select count(*) from [Products]";
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return 0;
//    }
//
//    public int getTotalProductsByCateID(int CateID) {
//        String sql = "select count(*) from [Products] where CategoryID=" + CateID;
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return 0;
//    }
//
//}
