
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
import java.util.UUID;
import java.util.regex.Pattern;

@WebServlet(description = "User Sign Up", urlPatterns = {"/resetpassword"}, loadOnStartup = 1)
public class ResetPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("resetPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ResetPassswordRequestField jsonReq = JsonTool.fetch(req, ResetPassswordRequestField.class);
        ResponseField jsonRes;

        if (!jsonReq.Vaild()) {
            jsonRes = new ResponseField("Failed", "Invalid Parameter");
            JsonTool.response(resp, jsonRes);
            return;
        }

        HttpSession session = req.getSession();
        //未登录
        if (session.getAttribute("uid") == null) {
            jsonRes = new ResponseField("Failed", "User Not Login");
            JsonTool.response(resp, jsonRes);
            return;
        }

        UUID uuid = UUID.randomUUID();
        String salt = SHA256.hash256(uuid.toString());
        String saltPass = SHA256.hash256(salt + jsonReq.NewPassword);

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/postgres");
            assert ds != null;
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT  salt,salt_pass FROM public.user WHERE id=?;");
            stmt.setLong(1, (long) session.getAttribute("uid"));
            ResultSet rs = stmt.executeQuery();
            rs.next();

            String userPass = SHA256.hash256(rs.getString("salt") + jsonReq.OldPassword);
            assert userPass != null;
            if (!userPass.equals(rs.getString("salt_pass"))) {
                conn.close();
                jsonRes = new ResponseField("Failed", "密码错误");
                JsonTool.response(resp, jsonRes);
                return;
            }

            stmt = conn.prepareStatement("UPDATE public.user SET salt=?, salt_pass=? WHERE id=?;");
            stmt.setString(1, salt);
            stmt.setString(2, saltPass);
            stmt.setLong(3, (long) session.getAttribute("uid"));
            if (stmt.executeUpdate() == 1) {
                jsonRes = new ResponseField("Success", "重置成功");
            } else {
                jsonRes = new ResponseField("Failed", "重置失败");
            }
            conn.close();
        } catch (SQLException e) {
            switch (e.getSQLState()) {
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

class ResetPassswordRequestField {
    private static Pattern passwordPattern = Pattern.compile("^[A-Za-z0-9]{64}$");
    String OldPassword;
    String NewPassword;

    boolean Vaild() {
        if (OldPassword == null || !passwordPattern.matcher(OldPassword).matches()) {
            return false;
        }
        if (NewPassword == null || !passwordPattern.matcher(NewPassword).matches()) {
            return false;
        }
        OldPassword = OldPassword.toLowerCase();
        NewPassword = NewPassword.toLowerCase();
        return true;
    }
}
