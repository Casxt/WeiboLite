import java.sql.ResultSet;
import java.sql.SQLException;

class WeiboStruct {
    long WeiboID = 0;
    String Nickname = "";
    String ProfilePic = "";
    String Content = "";
    String Time = "";
    boolean Deleted = true;
    WeiboStruct Forward = null;

    WeiboStruct(ResultSet weiboList) throws SQLException {
        Deleted = weiboList.getBoolean("is_deleted");
        if (Deleted) {
            Content = "该微博已删除";
            return;
        }
        WeiboID = weiboList.getLong("id");
        Nickname = weiboList.getString("nickname");
        ProfilePic = weiboList.getString("profile_picture");
        Content = weiboList.getString("content");
        Time = weiboList.getString("weibo_date");

    }

    WeiboStruct getInfo(ResultSet weiboList) throws SQLException {
        Deleted = weiboList.getBoolean("is_deleted");
        if (Deleted) {
            Content = "该微博已删除";
            return this;
        }
        WeiboID = weiboList.getLong("id");
        Nickname = weiboList.getString("nickname");
        ProfilePic = weiboList.getString("profile_picture");
        Content = weiboList.getString("content");
        Time = weiboList.getString("weibo_date");
        return this;
    }
}
