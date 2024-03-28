/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author admin
 */
public class Comment {
    private int BlogID;
    private int CommentID;
    private String CommentContent;
    private int DirectID;
    private int UserID;
    private String CommentDate;
    private boolean CommentStatus;
    private int CommentRate;

    public Comment() {
    }

    public Comment(int BlogID, int CommentID, String CommentContent, int DirectID, int UserID, String CommentDate, boolean CommentStatus, int CommentRate) {
        this.BlogID = BlogID;
        this.CommentID = CommentID;
        this.CommentContent = CommentContent;
        this.DirectID = DirectID;
        this.UserID = UserID;
        this.CommentDate = CommentDate;
        this.CommentStatus = CommentStatus;
        this.CommentRate = CommentRate;
    }

    public int getBlogID() {
        return BlogID;
    }

    public void setBlogID(int BlogID) {
        this.BlogID = BlogID;
    }

    public int getCommentID() {
        return CommentID;
    }

    public void setCommentID(int CommentID) {
        this.CommentID = CommentID;
    }

    public String getCommentContent() {
        return CommentContent;
    }

    public void setCommentContent(String CommentContent) {
        this.CommentContent = CommentContent;
    }

    public int getDirectID() {
        return DirectID;
    }

    public void setDirectID(int DirectID) {
        this.DirectID = DirectID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getCommentDate() {
        return CommentDate;
    }

    public void setCommentDate(String CommentDate) {
        this.CommentDate = CommentDate;
    }

    public boolean isCommentStatus() {
        return CommentStatus;
    }

    public void setCommentStatus(boolean CommentStatus) {
        this.CommentStatus = CommentStatus;
    }

    public int getCommentRate() {
        return CommentRate;
    }

    public void setCommentRate(int CommentRate) {
        this.CommentRate = CommentRate;
    }

    @Override
    public String toString() {
        return "Comment{" + "BlogID=" + BlogID + ", CommentID=" + CommentID + ", CommentContent=" + CommentContent + ", DirectID=" + DirectID + ", UserID=" + UserID + ", CommentDate=" + CommentDate + ", CommentStatus=" + CommentStatus + ", CommentRate=" + CommentRate + '}';
    }
    
    
}
