package view;

public class Product {

    private int ProductID;
    private String ProductName;
    private int CategoryID;
    private String ProductDescription;
    private int UnitInStock;
    private double UnitPrice;
    private int UnitDiscount;
    private String CreateDate;
    private int TotalRate;
    private int TotalStock;

    public Product() {
    }

    public Product(int ProductID, String ProductName, int CategoryID, String ProductDescription, int UnitInStock, double UnitPrice, int UnitDiscount, String CreateDate, int TotalRate, int TotalStock) {
        this.ProductID = ProductID;
        this.ProductName = ProductName;
        this.CategoryID = CategoryID;
        this.ProductDescription = ProductDescription;
        this.UnitInStock = UnitInStock;
        this.UnitPrice = UnitPrice;
        this.UnitDiscount = UnitDiscount;
        this.CreateDate = CreateDate;
        this.TotalRate = TotalRate;
        this.TotalStock = TotalStock;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getProductDescription() {
        return ProductDescription;
    }

    public void setProductDescription(String ProductDescription) {
        this.ProductDescription = ProductDescription;
    }

    public int getUnitInStock() {
        return UnitInStock;
    }

    public void setUnitInStock(int UnitInStock) {
        this.UnitInStock = UnitInStock;
    }

    public double getUnitPrice() {
        return UnitPrice;
    }

    public void setUnitPrice(double UnitPrice) {
        this.UnitPrice = UnitPrice;
    }

    public int getUnitDiscount() {
        return UnitDiscount;
    }

    public void setUnitDiscount(int UnitDiscount) {
        this.UnitDiscount = UnitDiscount;
    }
    public String getCreateDate() {
        return CreateDate;
    }

    public void setCreateDate(String CreateDate) {
        this.CreateDate = CreateDate;
    }

    public int getTotalRate() {
        return TotalRate;
    }

    public void setTotalRate(int TotalRate) {
        this.TotalRate = TotalRate;
    }

    public int getTotalStock() {
        return TotalStock;
    }

    public void setTotalStock(int TotalStock) {
        this.TotalStock = TotalStock;
    }

    @Override
    public String toString() {
        return "Product{" + "ProductID=" + ProductID + ", ProductName=" + ProductName + ", CategoryID=" + CategoryID + ", ProductDescription=" + ProductDescription + ", UnitInStock=" + UnitInStock + ", UnitPrice=" + UnitPrice + ", UnitDiscount=" + UnitDiscount + ", CreateDate=" + CreateDate + ", TotalRate=" + TotalRate + ", TotalStock=" + TotalStock + '}';
    }
}
