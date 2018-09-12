import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
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

/*http://localhost:8080/ranking*/
@WebServlet(description = "comment", urlPatterns = {"/ranking"}, loadOnStartup = 1)
public class WeiboRanking extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.getRequestDispatcher("hotWeibo.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ResponseField jsonRes;
        LinkedList<WeiboStruct> weiboStructs = new LinkedList<>();
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
            PreparedStatement stmt = conn.prepareStatement("SELECT\n" +
                    "\tweibo.ID AS ID,\n" +
                    "\tu.nickname AS nickname,\n" +
                    "\tu.profile_picture AS profile_picture,\n" +
                    "\tCONTENT,\n" +
                    "\tFORWARD,\n" +
                    "\tweibo.is_deleted AS is_deleted,\n" +
                    "\tweibo_date \n" +
                    "FROM\n" +
                    "\tweibo\n" +
                    "\tINNER JOIN PUBLIC.USER u ON weibo.user_id = u.ID \n" +
                    "WHERE\n" +
                    "\tweibo.is_deleted = FALSE \n" +
                    "ORDER BY\n" +
                    "\tcomment_count DESC \n" +
                    "\tLIMIT 10 OFFSET 0;");
            ResultSet weiboList = stmt.executeQuery();
            while (weiboList.next()) {
                WeiboStruct w = new WeiboStruct(weiboList);
                long forward = weiboList.getLong("forward");
                if (!weiboList.wasNull()) {
                    stmt = conn.prepareStatement("SELECT weibo.id as id, u.nickname as nickname,  u.profile_picture as profile_picture, content, forward, weibo.is_deleted as is_deleted, weibo_date FROM weibo INNER JOIN public.user u on weibo.user_id = u.id WHERE weibo.id = ?;");
                    stmt.setLong(1, forward);
                    ResultSet rs = stmt.executeQuery();
                    rs.next();
                    w.Forward = new WeiboStruct(rs);
                }
                weiboStructs.add(w);
            }
            WeiboResponseField weiboListRes = new WeiboResponseField("Success", "获取成功", weiboStructs.toArray(new WeiboStruct[0]));
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
}