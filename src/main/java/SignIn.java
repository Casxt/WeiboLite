import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(description = "User Sign In", urlPatterns = {"/signin"}, loadOnStartup = 1)
public class SignIn extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("sign.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Sign.SignInRequestField jsonReq = JsonTool.fetch(req, Sign.SignInRequestField.class);
        ResponseField jsonRes;

        if (!jsonReq.Vaild()) {
            jsonRes = new ResponseField("Failed", "Invalid Parameter");
            JsonTool.response(resp, jsonRes);
            return;
        }

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT id,salt,salt_pass FROM public.user WHERE nickname=?;");
            stmt.setString(1, jsonReq.Nickname);
            ResultSet res = stmt.executeQuery();
            if (res.next()) {
                String userPass = SHA256.hash256(res.getString("salt") + jsonReq.Password);
                if (userPass.equals(res.getString("salt_pass"))) {
                    req.getSession().setAttribute("nickname", jsonReq.Nickname);
                    req.getSession().setAttribute("uid", res.getLong("id"));
                    jsonRes = new ResponseField("Success", "登陆成功");
                } else {
                    jsonRes = new ResponseField("Failed", "密码错误");
                }
            } else {
                jsonRes = new ResponseField("Failed", "用户名不存在");
            }
            conn.close();
        } catch (SQLException e) {
            switch (e.getSQLState()) {
                default:
                    jsonRes = new ResponseField("Failed", e.getMessage(), String.format("%s", e.getSQLState()));
            }
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "服务器资源不足", e.getExplanation());
        }
        JsonTool.response(resp, jsonRes);
    }
}

