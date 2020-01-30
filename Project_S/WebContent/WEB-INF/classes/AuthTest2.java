import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AuthTest2 extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException{

        response.setContentType("text/html; charset=Shift_JIS");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>ユーザー認証テスト</title>");
        out.println("</head>");
        out.println("<body>");

        out.println("<p>テストページ2</p>");

        out.println("<p><a href=\"/auth/AuthTest1\">テストページ1へ</a></p>");

        out.println("</body>");
        out.println("</html>");
    }
}