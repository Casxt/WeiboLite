import java.sql.ResultSet;
import java.sql.SQLException;

public class UserStruct {
    String Nickname;
    String ProfilePic;
    boolean FollowMe;//关注我的
    boolean Following;//我关注的

    UserStruct(ResultSet userList) throws SQLException {
        Nickname = userList.getString("nickname");
        ProfilePic = userList.getString("profile_picture");
        Following = userList.getBoolean("my_follow");
        FollowMe = userList.getBoolean("follow_me");
    }
}
