import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.regex.Pattern;

/*http://localhost:8080/follow*/
@WebServlet(description = "comment", urlPatterns = {"/follow"}, loadOnStartup = 1)
public class Follow extends HttpServlet {
    private static Pattern numPattern = Pattern.compile("^[\\d]*$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        LinkedList<UserStruct> allFollow = new LinkedList<>();
        ResponseField jsonRes;

        HttpSession session = req.getSession();
        if (session.getAttribute("uid") == null) {
            jsonRes = new ResponseField("Failed", "User Not Login");
            JsonTool.response(resp, jsonRes);
            return;
        }

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            //我关注的人
            PreparedStatement stmt = conn.prepareStatement("SELECT\n" +
                    "\tnickname,\n" +
                    "\tprofile_picture,\n" +
                    "\tEXISTS(SELECT * FROM follow WHERE follow_id = ? AND user_id=u.id) AS follow_me,\n" +
                    "\tEXISTS(SELECT * FROM follow WHERE follow_id = u.id AND user_id= ? ) AS my_follow\n" +
                    "FROM\n" +
                    "\t( SELECT user_id AS ID FROM follow WHERE follow_id = ? UNION SELECT follow_id AS ID FROM follow WHERE user_id = ? ) AS f\n" +
                    "\tJOIN PUBLIC.USER AS u ON f.ID = u.ID;");
            stmt.setLong(1, (long) session.getAttribute("uid"));
            stmt.setLong(2, (long) session.getAttribute("uid"));
            stmt.setLong(3, (long) session.getAttribute("uid"));
            stmt.setLong(4, (long) session.getAttribute("uid"));
            ResultSet followList = stmt.executeQuery();
            while (followList.next()) {
                UserStruct u = new UserStruct();
                u.Nickname = followList.getString("nickname");
                u.ProfilePic = followList.getString("profile_picture");
                u.Following = followList.getBoolean("my_follow");
                u.FollowMe = followList.getBoolean("follow_me");
                allFollow.add(u);
            }
            FollowResponseField followListRes = new FollowResponseField("Success", "获取成功", allFollow.toArray(new UserStruct[0]));
            JsonTool.response(resp, followListRes);
            return;
        } catch (SQLException e) {
            switch (e.getSQLState()) {
                default:
                    jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
            }
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
        }
        JsonTool.response(resp, jsonRes);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        FollowPostField jsonReq = JsonTool.fetch(req, FollowPostField.class);
        ResponseField jsonRes;

        if (!jsonReq.Valid()) {
            jsonRes = new ResponseField("Failed", "Invalid Parameter");
            JsonTool.response(resp, jsonRes);
            return;
        }

        HttpSession session = req.getSession();
        if (session.getAttribute("uid") == null) {
            jsonRes = new ResponseField("Failed", "User Not Login");
            JsonTool.response(resp, jsonRes);
            return;
        }

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO public.follow (user_id,follow_id) SELECT ?,id FROM public.user WHERE nickname=?;");
            stmt.setLong(1, (long) session.getAttribute("uid"));
            stmt.setString(2, jsonReq.Nickname);
            stmt.executeUpdate();
            conn.close();
            jsonRes = new ResponseField("Success", "关注成功");
        } catch (SQLException e) {
            switch (e.getSQLState()) {
                default:
                    jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
            }
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
        }
        JsonTool.response(resp, jsonRes);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        FollowPostField jsonReq = JsonTool.fetch(req, FollowPostField.class);
        ResponseField jsonRes;

        if (!jsonReq.Valid()) {
            jsonRes = new ResponseField("Failed", "Invalid Parameter");
            JsonTool.response(resp, jsonRes);
            return;
        }

        //登陆校验
        HttpSession session = req.getSession();
        if (session.getAttribute("uid") == null) {
            jsonRes = new ResponseField("Failed", "User Not Login");
            JsonTool.response(resp, jsonRes);
            return;
        }

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM public.follow AS f WHERE f.user_id=? AND f.follow_id IN (SELECT id FROM public.user WHERE nickname=?);");
            stmt.setLong(1, (long) session.getAttribute("uid"));
            stmt.setString(2, jsonReq.Nickname);
            if (stmt.executeUpdate() == 1) {
                jsonRes = new ResponseField("Success", "取消关注成功");
            } else {
                jsonRes = new ResponseField("Success", "取消关注失败");
            }
            conn.close();
        } catch (SQLException e) {
            switch (e.getSQLState()) {
                default:
                    jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
            }
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
        }
        JsonTool.response(resp, jsonRes);
    }
}


class FollowPostField {
    private static Pattern nickNamePattern = Pattern.compile("^[A-Za-z0-9@_\\-]{5,64}$");
    String Nickname;

    boolean Valid() {
        if (!nickNamePattern.matcher(Nickname).matches()) {
            return false;
        }
        Nickname = Nickname.toLowerCase();
        return true;
    }
}

class FollowResponseField extends ResponseField {
    UserStruct[] Follow;//关注我的和我关注的

    FollowResponseField(String state, String msg, UserStruct[] follow) {
        super(state, msg);
        Follow = follow;
    }

    FollowResponseField(String state, String msg, String detail, UserStruct[] follow) {
        super(state, msg, detail);
        Follow = follow;
    }
}