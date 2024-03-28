/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package view;

/**
 *
 * @author trant
 */
public class Log {

    private int ID;
    private int LogTopic;
    private String LogType;
    private int UpdateBy;
    private String UpdateAt;
    private String Purpose;

    public Log() {
    }

    public Log(int ID, int LogTopic, String LogType, int UpdateBy, String Purpose) {
        this.ID = ID;
        this.LogTopic = LogTopic;
        this.LogType = LogType;
        this.UpdateBy = UpdateBy;
        this.Purpose = Purpose;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public int getLogTopic() {
        return LogTopic;
    }

    public void setLogTopic(int LogTopic) {
        this.LogTopic = LogTopic;
    }

    public String getLogType() {
        return LogType;
    }

    public void setLogType(String LogType) {
        this.LogType = LogType;
    }

    public int getUpdateBy() {
        return UpdateBy;
    }

    public void setUpdateBy(int UpdateBy) {
        this.UpdateBy = UpdateBy;
    }

    public String getUpdateAt() {
        return UpdateAt;
    }

    public void setUpdateAt(String UpdateAt) {
        this.UpdateAt = UpdateAt;
    }

    public String getPurpose() {
        return Purpose;
    }

    public void setPurpose(String Purpose) {
        this.Purpose = Purpose;
    }

    @Override
    public String toString() {
        return "Log{" + "ID=" + ID + ", LogTopic=" + LogTopic + ", LogType=" + LogType + ", UpdateBy=" + UpdateBy + ", UpdateAt=" + UpdateAt + ", Purpose=" + Purpose + '}';
    }

}
