/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author admin
 */
public class ProductImage {

    private String ProductID;
    private String ProductURL;

    public ProductImage() {
    }

    public ProductImage(String ProductID, String ProductURL) {
        this.ProductID = ProductID;
        this.ProductURL = ProductURL;
    }

    public String getProductID() {
        return ProductID;
    }

    public void setProductID(String ProductID) {
        this.ProductID = ProductID;
    }

    public String getProductURL() {
        return ProductURL;
    }

    public void setProductURL(String ProductURL) {
        this.ProductURL = ProductURL;
    }

    public String getNoBackgroundImage(String productURL) {
        if (productURL.contains("_1")) {
            return productURL;
        }
        return null;
    }

    @Override
    public String toString() {
        return "ProductImage{" + "ProductID=" + ProductID + ", ProductURL=" + ProductURL + '}';
    }

}
