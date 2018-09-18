import org.apache.commons.dbutils.DbUtils;

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

/*http://localhost:8080/comment?Num=20&Offset=0&WeiboID=8*/
@WebServlet(description = "comment", urlPatterns = {"/comment"}, loadOnStartup = 1)
public class Comment extends HttpServlet {
    private static Pattern numPattern = Pattern.compile("^[\\d]*$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String num = req.getParameter("Num");
        String offset = req.getParameter("Offset");
        //user 无时显示当前用户的相关微博，否则显示User的微博和评论
        String weiboID = req.getParameter("WeiboID");
        LinkedList<CommentStruct> commentStructs = new LinkedList<>();
        ResponseField jsonRes;
        if (num == null || offset == null || weiboID == null || !numPattern.matcher(num).matches() ||
                !numPattern.matcher(offset).matches() || !numPattern.matcher(weiboID).matches()) {
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

        Connection conn = null;
        ResultSet commentList = null;
        PreparedStatement stmt = null;
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            conn = ds.getConnection();
            stmt = conn.prepareStatement("SELECT " +
                    "com.id AS id," +
                    "com.weibo_id AS weibo_id," +
                    "u.nickname AS nickname," +
                    "com.comment AS comment," +
                    "u2.nickname AS comment_nickname," +
                    "com.is_deleted AS is_deleted," +
                    "com.comment_date AS comment_date " +
                    "FROM " +
                    "comment AS com LEFT JOIN public.user AS u ON u.ID = com.user_id " +
                    "LEFT JOIN comment AS com2 ON com.comment_id = com2.ID " +
                    "LEFT JOIN public.user AS u2 ON com2.user_id = u2.ID " +
                    "WHERE " +
                    "com.weibo_id = ? " +
                    "ORDER BY " +
                    "com.comment_date DESC LIMIT ? OFFSET ?;");
            stmt.setLong(1, Long.parseLong(weiboID));
            stmt.setInt(2, Integer.parseInt(num));
            stmt.setInt(3, Integer.parseInt(offset));
            commentList = stmt.executeQuery();
            while (commentList.next()) {
                commentStructs.add(new CommentStruct(commentList));
            }
            conn.close();
            CommentResponseField commentListRes = new CommentResponseField("Success", "获取成功", commentStructs.toArray(new CommentStruct[0]));
            JsonTool.response(resp, commentListRes);
            return;
        } catch (SQLException e) {
            jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
            /*
            switch (e.getSQLState()) {
                default:
                    jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
            }
            */
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
        } finally {
            DbUtils.closeQuietly(commentList);
            DbUtils.closeQuietly(stmt);
            DbUtils.closeQuietly(conn);
        }
        JsonTool.response(resp, jsonRes);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        CommentPostField jsonReq = JsonTool.fetch(req, CommentPostField.class);
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

        Connection conn = null;
        PreparedStatement insertStmt = null, updateStmt = null;
        DataSource ds;
        try {
            ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
        } catch (NamingException e) {
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
            JsonTool.response(resp, jsonRes);
            return;
        }

        try {
            conn = ds.getConnection();
            conn.setAutoCommit(false);
            insertStmt = conn.prepareStatement("INSERT INTO public.comment (user_id,weibo_id,comment_id,comment) VALUES (?,?,?,?);");
            insertStmt.setLong(1, (long) session.getAttribute("uid"));
            insertStmt.setLong(2, jsonReq.WeiboID);
            if (jsonReq.CommentID == 0) {
                insertStmt.setNull(3, Types.BIGINT);
            } else {
                insertStmt.setLong(3, jsonReq.CommentID);
            }
            insertStmt.setString(4, jsonReq.Comment);
            insertStmt.executeUpdate();
            //记录评论
            updateStmt = conn.prepareStatement("UPDATE public.weibo SET comment_count=comment_count+1 WHERE id=?;");
            updateStmt.setLong(1, jsonReq.WeiboID);
            updateStmt.executeUpdate();
            conn.commit();
            jsonRes = new ResponseField("Success", "评论成功");
            DbUtils.closeQuietly(insertStmt);
            DbUtils.closeQuietly(updateStmt);
            DbUtils.commitAndCloseQuietly(conn);
        } catch (SQLException e) {
            DbUtils.closeQuietly(insertStmt);
            DbUtils.closeQuietly(updateStmt);
            DbUtils.rollbackAndCloseQuietly(conn);
            jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
        }
        JsonTool.response(resp, jsonRes);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        CommentDeleteField jsonReq = JsonTool.fetch(req, CommentDeleteField.class);
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
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            conn = ds.getConnection();
            stmt = conn.prepareStatement("UPDATE comment SET is_deleted=true WHERE user_id=? AND id=?");
            stmt.setLong(1, (long) session.getAttribute("uid"));
            stmt.setLong(2, jsonReq.CommentID);
            if (stmt.executeUpdate() == 1) {
                jsonRes = new ResponseField("Success", "删除成功");
            } else {
                jsonRes = new ResponseField("Failed", "删除失败");
            }
            DbUtils.closeQuietly(stmt);
            DbUtils.commitAndCloseQuietly(conn);
        } catch (SQLException e) {
            DbUtils.closeQuietly(stmt);
            DbUtils.rollbackAndCloseQuietly(conn);
            jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
        }
        JsonTool.response(resp, jsonRes);
    }
}


class CommentPostField {
    long WeiboID;
    long CommentID;
    String Comment;

    boolean Valid() {
        if (WeiboID < 0) {
            return false;
        }
        if (CommentID < 0) {
            return false;
        }
        return Comment.length() >= 2 && Comment.length() <= 255;
    }
}

class CommentDeleteField {
    long CommentID;

    boolean Valid() {
        return CommentID >= 0;
    }
}

class CommentResponseField extends ResponseField {
    CommentStruct[] CommentList;

    CommentResponseField(String state, String msg, CommentStruct[] commentList) {
        super(state, msg);
        CommentList = commentList;
    }

    CommentResponseField(String state, String msg, String detail, CommentStruct[] commentList) {
        super(state, msg, detail);
        CommentList = commentList;
    }
}


class CommentStruct {
    long CommentID = 0;
    long WeiboID = 0;
    String Nickname = "";
    String Comment = "";
    String CommentNickname = "";
    String Time = "";
    boolean Deleted = true;

    CommentStruct(ResultSet rs) throws SQLException {
        CommentID = rs.getLong("id");
        WeiboID = rs.getLong("weibo_id");
        Nickname = rs.getString("nickname");
        Comment = rs.getString("comment");
        CommentNickname = rs.getString("comment_nickname");
        Time = rs.getString("comment_date");
        Deleted = rs.getBoolean("is_deleted");
    }
}