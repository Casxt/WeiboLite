import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(description = "User Sign In", urlPatterns = {"/signup"}, loadOnStartup = 1)
public class SignUp extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("sign.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        StringBuilder sb = new StringBuilder();
        String s;
        //考虑到大多数json格式的body不存在换行问题
        while ((s = req.getReader().readLine()) != null) {
            sb.append(s);
        }
        RequestFiled jsonReq = new Gson().fromJson(sb.toString(), RequestFiled.class);


        ResponseFiled jsonRes = new ResponseFiled("Success", "Sign Up Success");
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write(new Gson().toJson(jsonRes));
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

    ResponseFiled(String state, String msg) {
        this.State = state;
        this.Msg = msg;
    }
}