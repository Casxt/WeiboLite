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
import java.sql.SQLException;
import java.util.UUID;

@WebServlet(description = "User Sign Up", urlPatterns = {"/signup"}, loadOnStartup = 1)
public class SignUp extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("sign.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SignUpRequestField jsonReq = JsonTool.fetch(req, SignUpRequestField.class);
        ResponseField jsonRes;

        if (!jsonReq.Vaild()) {
            jsonRes = new ResponseField("Failed", "Invalid Parameter");
            JsonTool.response(resp, jsonRes);
            return;
        }

        UUID uuid = UUID.randomUUID();
        String salt = SHA256.hash256(uuid.toString());
        String saltPass = SHA256.hash256(salt + jsonReq.Password);

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO public.user (mail,nickname,salt,salt_pass) VALUES (?,?,?,?);");
            stmt.setString(1, jsonReq.Mail);
            stmt.setString(2, jsonReq.Nickname);
            stmt.setString(3, salt);
            stmt.setString(4, saltPass);
            stmt.executeUpdate();
            conn.close();
            jsonRes = new ResponseField("Success", "注册成功");
        } catch (SQLException e) {
            switch (e.getSQLState()) {
                case "23505":
                    jsonRes = new ResponseField("Failed", "用户名重复");
                    break;
                default:
                    jsonRes = new ResponseField("Failed", e.getMessage(), String.format("%s", e.getSQLState()));
            }
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseField("Failed", "Context NamingException", e.getExplanation());
        }
        JsonTool.response(resp, jsonRes);
    }
}

