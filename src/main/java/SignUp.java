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

@WebServlet(description = "User Sign In", urlPatterns = {"/signup"}, loadOnStartup = 1)
public class SignUp extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("sign.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        RequestFiled jsonReq = JsonTool.fetch(req, RequestFiled.class);
        UUID uuid = UUID.randomUUID();
        String salt = SHA256.hash256(uuid.toString());
        String saltPass = SHA256.hash256(salt + jsonReq.Password);

        ResponseFiled jsonRes;
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO public.user (mail,nickname,salt,salt_pass) VALUES (?,?,?,?);");
            //Statement statement = con.createStatement();
            //ResultSet rs = statement.executeQuery("INSERT INTO profile(mail,nickname,salt,salt_pass) VALUES (?,?,?,?);");
            stmt.setString(1, String.format("%s@qq.com", jsonReq.Nickname));
            stmt.setString(2, jsonReq.Nickname);
            stmt.setString(3, salt);
            stmt.setString(4, saltPass);
            stmt.executeUpdate();
            conn.close();
            jsonRes = new ResponseFiled("Success", "注册成功");
        } catch (SQLException e) {
            switch (e.getErrorCode()) {
                case 42701:
                    jsonRes = new ResponseFiled("Failed", "用户名重复");
                    break;
                default:
                    jsonRes = new ResponseFiled("Failed", e.getMessage(), String.format("%s", e.getErrorCode()));
            }
        } catch (NamingException e) {
            e.printStackTrace();
            jsonRes = new ResponseFiled("Failed", "Context NamingException", e.getExplanation());
        }
        JsonTool.response(resp, jsonRes);
    }
}

class RequestFiled {
    String Mail;
    String Nickname;
    String Password;
}

class ResponseFiled {
    String State;
    String Msg;
    String Detail = null;

    ResponseFiled(String state, String msg) {
        this.State = state;
        this.Msg = msg;
    }

    ResponseFiled(String state, String msg, String detail) {
        this.State = state;
        this.Msg = msg;
        this.Detail = detail;
    }
}