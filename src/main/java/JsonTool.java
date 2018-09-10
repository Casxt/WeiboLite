import com.google.gson.Gson;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class JsonTool {
    public static <T> T fetch(HttpServletRequest req, Class<T> classOfT) throws IOException {
        StringBuilder sb = new StringBuilder();
        String s;
        //考虑到大多数json格式的body不存在换行问题
        while ((s = req.getReader().readLine()) != null) {
            sb.append(s);
        }
        T jsonReq = new Gson().fromJson(sb.toString(), classOfT);
        return jsonReq;
    }
}
