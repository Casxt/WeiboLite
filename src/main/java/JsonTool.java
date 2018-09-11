import com.google.gson.Gson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

class JsonTool {
    private static Gson gson = new Gson();

    static <T> T fetch(HttpServletRequest req, Class<T> classOfT) throws IOException {
        StringBuilder sb = new StringBuilder();
        String s;
        //考虑到大多数json格式的body不存在换行问题
        while ((s = req.getReader().readLine()) != null) {
            sb.append(s);
        }
        return gson.fromJson(sb.toString(), classOfT);
    }

    static void response(HttpServletResponse resp, Object jsonRes) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write(new Gson().toJson(jsonRes));
    }
}
