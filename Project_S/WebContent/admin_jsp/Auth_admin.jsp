<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*,javax.naming.*,election.ParameterBox"%>
<%
	boolean flag = false;
	boolean test = false;

	//一時的に入力されたユーザID、パスワード、選挙区IDを保持する
	String value1 = request.getParameter("userID");
	String value2 = request.getParameter("password");


	if(value1.equals("root") && value2.equals("senkyo")){//投票がまだの場合
		response.sendRedirect("yes.jsp");//投票用のページに移行
	}else{
	//idかpasswordが間違えている


	response.sendRedirect("login_admin.jsp");
	%><script>	alert("IDまたはPasswordが間違えています"); </script><%
	}

%>
</body>
</html>