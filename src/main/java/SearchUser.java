import org.apache.commons.dbutils.DbUtils;

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
import java.util.regex.Pattern;

/*http://localhost:8080/follow*/
@WebServlet(description = "comment", urlPatterns = {"/searchuser"}, loadOnStartup = 1)
public class SearchUser extends HttpServlet {
    private static Pattern numPattern = Pattern.compile("^[\\d]*$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.getRequestDispatcher("searchUser.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SearchUserPostField jsonReq = JsonTool.fetch(req, SearchUserPostField.class);
        ResponseField jsonRes;
        LinkedList<UserStruct> users = new LinkedList<>();
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
        PreparedStatement stmt = null;
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            conn = ds.getConnection();
            //我关注的人
            stmt = conn.prepareStatement("SELECT\n" +
                    "\tnickname,\n" +
                    "\tprofile_picture,\n" +
                    "\tEXISTS(SELECT * FROM follow WHERE follow_id = ? AND user_id=u.id) AS follow_me,\n" +
                    "\tEXISTS(SELECT * FROM follow WHERE follow_id = u.id AND user_id= ? ) AS my_follow\n" +
                    "FROM PUBLIC.USER AS u WHERE nickname LIKE ?;");
            stmt.setLong(1, (long) session.getAttribute("uid"));
            stmt.setLong(2, (long) session.getAttribute("uid"));
            stmt.setString(3, "%" + jsonReq.Keyword.replaceAll("\\s+", "%") + "%");
            ResultSet userList = stmt.executeQuery();
            while (userList.next()) {
                users.add(new UserStruct(userList));
            }
            SearchUserResponseField userListRes = new SearchUserResponseField("Success", "获取成功", users.toArray(new UserStruct[0]));
            JsonTool.response(resp, userListRes);
            return;
        } catch (SQLException e) {
            switch (e.getSQLState()) {
                default:
                    jsonRes = new ResponseField("Failed", e.getMessage(), String.format("SQLState:%s", e.getSQLState()));
            }
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
        } finally {
            DbUtils.closeQuietly(stmt);
            DbUtils.closeQuietly(conn);
        }
        JsonTool.response(resp, jsonRes);
    }
}

class SearchUserResponseField extends ResponseField {
    UserStruct[] Users;//关注我的和我关注的

    SearchUserResponseField(String state, String msg, UserStruct[] follow) {
        super(state, msg);
        Users = follow;
    }

    SearchUserResponseField(String state, String msg, String detail, UserStruct[] follow) {
        super(state, msg, detail);
        Users = follow;
    }
}

class SearchUserPostField {
    private static Pattern nickNamePattern = Pattern.compile("^[A-Za-z0-9@_\\-]{5,64}$");
    String Keyword;

    boolean Valid() {
        return Keyword != null && Keyword != "";
    }
}