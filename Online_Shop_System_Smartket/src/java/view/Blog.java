    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;
/**
 *
 * @author admin
 */
public class Blog {

    private int BlogID;
    private int UserID;
    private String BlogAuthor;
    private int CategoryID;
    private String AuthorImage;
    private String BlogImage;
    private String BlogTitle;
    private String BlogContent;
    private int BlogRate;
    private int HiddenStatus;
    private String CreateTime;

    public Blog() {
    }

    public Blog(int BlogID, int UserID, String BlogAuthor, int CategoryID, String AuthorImage, String BlogImage, String BlogTitle, String BlogContent, int BlogRate, int HiddenStatus, String CreateTime) {
        this.BlogID = BlogID;
        this.UserID = UserID;
        this.BlogAuthor = BlogAuthor;
        this.CategoryID = CategoryID;
        this.AuthorImage = AuthorImage;
        this.BlogImage = BlogImage;
        this.BlogTitle = BlogTitle;
        this.BlogContent = BlogContent;
        this.BlogRate = BlogRate;
        this.HiddenStatus = HiddenStatus;
        this.CreateTime = CreateTime;
    }

    public int getBlogID() {
        return BlogID;
    }

    public void setBlogID(int BlogID) {
        this.BlogID = BlogID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getBlogAuthor() {
        return BlogAuthor;
    }

    public void setBlogAuthor(String BlogAuthor) {
        this.BlogAuthor = BlogAuthor;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getAuthorImage() {
        return AuthorImage;
    }

    public void setAuthorImage(String AuthorImage) {
        this.AuthorImage = AuthorImage;
    }

    public String getBlogImage() {
        return BlogImage;
    }

    public void setBlogImage(String BlogImage) {
        this.BlogImage = BlogImage;
    }

    public String getBlogTitle() {
        return BlogTitle;
    }

    public void setBlogTitle(String BlogTitle) {
        this.BlogTitle = BlogTitle;
    }

    public String getBlogContent() {
        return BlogContent;
    }

    public void setBlogContent(String BlogContent) {
        this.BlogContent = BlogContent;
    }

    public int getBlogRate() {
        return BlogRate;
    }

    public void setBlogRate(int BlogRate) {
        this.BlogRate = BlogRate;
    }

    public int getHiddenStatus() {
        return HiddenStatus;
    }

    public void setHiddenStatus(int HiddenStatus) {
        this.HiddenStatus = HiddenStatus;
    }

    public String getCreateTime() {
        return CreateTime;
    }

    public void setCreateTime(String CreateTime) {
        this.CreateTime = CreateTime;
    }

    @Override
    public String toString() {
        return "Blog{" + "BlogID=" + BlogID + ", UserID=" + UserID + ", BlogAuthor=" + BlogAuthor + ", CategoryID=" + CategoryID + ", AuthorImage=" + AuthorImage + ", BlogImage=" + BlogImage + ", BlogTitle=" + BlogTitle + ", BlogContent=" + BlogContent + ", BlogRate=" + BlogRate + ", HiddenStatus=" + HiddenStatus + ", CreateTime=" + CreateTime + '}';
    }

}
