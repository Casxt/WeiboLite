import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.LinkedList;
import java.util.regex.Pattern;

/*http://localhost:8080/weibo?Num=20&Offset=0&User=maple*/
@WebServlet(description = "User Sign In", urlPatterns = {"/weibo"}, loadOnStartup = 1)
public class Weibo extends HttpServlet {
    private static Pattern numPattern = Pattern.compile("^[\\d]*$");
    private static Pattern nickNamePattern = Pattern.compile("^[A-Za-z0-9@_\\-]{5,64}$");

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String num = req.getParameter("Num");
        String offset = req.getParameter("Offset");
        //user 无时显示当前用户的相关微博，否则显示User的微博和评论
        String user = req.getParameter("User");
        LinkedList<WeiboStruct> weiboStructs = new LinkedList<>();
        ResponseField jsonRes;
        if (num == null || offset == null || !numPattern.matcher(num).matches() || !numPattern.matcher(offset).matches()) {
            jsonRes = new ResponseField("Failed", "Invalid Parameter");
            JsonTool.response(resp, jsonRes);
            return;
        }

        if (user != null && !nickNamePattern.matcher(user).matches()) {
            jsonRes = new ResponseField("Failed", "Invalid Parameter");
            JsonTool.response(resp, jsonRes);
            return;
        }

        HttpSession session = req.getSession();
        //未登录且未指定用户
        if (session.getAttribute("uid") == null && user == null) {
            //未登录只能查看用户主页
            jsonRes = new ResponseField("Failed", "User Not Login");
            JsonTool.response(resp, jsonRes);
            return;
        }

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            PreparedStatement stmt;
            ResultSet weiboList;
            if (user == null) {
                stmt = conn.prepareStatement("SELECT follow_id FROM follow WHERE user_id=?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                stmt.setLong(1, (long) session.getAttribute("uid"));
                ResultSet follow = stmt.executeQuery();
                //获取follow数量
                follow.last();
                int size = follow.getRow();
                follow.beforeFirst();
                //获取follow值
                Long[] followID = new Long[size];
                int i = 0;
                while (follow.next()) {
                    followID[i] = follow.getLong("follow_id");
                    i += 1;
                }
                stmt = conn.prepareStatement("SELECT weibo.id as id, u.nickname as nickname,  u.profile_picture as profile_picture, content, forward, weibo.is_deleted as is_deleted, weibo_date FROM weibo INNER JOIN public.user u on weibo.user_id = u.id WHERE user_id = ANY(?) ORDER BY weibo_date DESC LIMIT ? OFFSET ?;");
                stmt.setArray(1, conn.createArrayOf("int64", followID));
                stmt.setInt(2, Integer.parseInt(num));
                stmt.setInt(3, Integer.parseInt(offset));
                weiboList = stmt.executeQuery();
            } else {
                stmt = conn.prepareStatement("SELECT weibo.id as id, u.nickname as nickname,  u.profile_picture as profile_picture, content, forward, weibo.is_deleted as is_deleted, weibo_date FROM weibo INNER JOIN public.user u on weibo.user_id = u.id WHERE nickname = ? ORDER BY weibo_date DESC LIMIT ? OFFSET ?;");
                stmt.setString(1, user);
                stmt.setInt(2, Integer.parseInt(num));
                stmt.setInt(3, Integer.parseInt(offset));
                weiboList = stmt.executeQuery();
            }

            //获取转发信息
            while (weiboList.next()) {
                WeiboStruct w = new WeiboStruct().getInfo(weiboList);
                long forward = weiboList.getLong("forward");
                if (weiboList.wasNull()) {
                    continue;
                }
                stmt = conn.prepareStatement("SELECT weibo.id as id, u.nickname as nickname,  u.profile_picture as profile_picture, content, forward, weibo.is_deleted as is_deleted, weibo_date FROM weibo INNER JOIN public.user u on weibo.user_id = u.id WHERE weibo.id = ?;");
                stmt.setLong(1, forward);
                ResultSet rs = stmt.executeQuery();
                rs.next();
                w.Forward = new WeiboStruct().getInfo(rs);
                weiboStructs.add(w);
            }
            conn.close();
            WeiboResponseField weiboListRes = new WeiboResponseField("Success", "获取成功", weiboStructs.toArray(new WeiboStruct[weiboStructs.size()]));
            JsonTool.response(resp, weiboListRes);
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
        WeiboRequestField jsonReq = JsonTool.fetch(req, WeiboRequestField.class);
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
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO public.weibo (user_id,content,forward) VALUES (?,?,?);");
            stmt.setLong(1, (long) session.getAttribute("uid"));
            stmt.setString(2, jsonReq.Content);
            if (jsonReq.Forward == 0) {
                stmt.setNull(3, Types.BIGINT);
            } else {
                stmt.setLong(3, jsonReq.Forward);
            }
            stmt.executeUpdate();
            conn.close();
            jsonRes = new ResponseField("Success", "发布成功");
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

class WeiboRequestField {
    private static Pattern imgPattern = Pattern.compile("[A-Za-z0-9]{64}");
    String Content;
    String[] Imgs;
    long Forward;

    boolean Valid() {
        if (Content.length() > 255 || Content.length() < 5) {
            return false;
        }
        if (Forward < 0) {
            return false;
        }
        for (int i = 0; i < Imgs.length; i++) {
            if (!imgPattern.matcher(Imgs[i]).matches()) {
                return false;
            }
            Imgs[i] = Imgs[i].toLowerCase();
        }
        return true;
    }
}

class WeiboResponseField extends ResponseField {
    WeiboStruct[] WeiboList;

    WeiboResponseField(String state, String msg, WeiboStruct[] weiboList) {
        super(state, msg);
        WeiboList = weiboList;
    }

    WeiboResponseField(String state, String msg, String detail, WeiboStruct[] weiboList) {
        super(state, msg, detail);
        WeiboList = weiboList;
    }
}

class WeiboStruct {
    long WeiboID = 0;
    String Nickname = "";
    String ProfilePic = "";
    String Time = "";
    boolean Deleted = true;
    WeiboStruct Forward = null;

    WeiboStruct getInfo(ResultSet weiboList) throws SQLException {
        Deleted = weiboList.getBoolean("is_deleted");
        if (Deleted) {
            return this;
        }
        WeiboID = weiboList.getLong("id");
        Nickname = weiboList.getString("nickname");
        ProfilePic = weiboList.getString("profile_picture");
        Time = weiboList.getString("weibo_date");
        return this;
    }
}