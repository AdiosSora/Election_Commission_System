<%@ page language="java" contentType="text/html; charset=UTF-8"
    import = "java.sql.*, javax.naming.*, javax.sql.*"%>
<%
//受信したデータのエンコーディング
request.setCharacterEncoding("UTF-8");
//SQL接続オブジェクト
Connection conn = null;

// JDBCドライバーの読み込み
Class.forName("com.mysql.jdbc.Driver");

//MySQLに接続
conn = DriverManager.getConnection("jdbc:mysql://localhost/election",//接続するDB
								   "root", //ユーザ名
								   "kcsf"  //パスワード
								   );
//SQL文を準備
PreparedStatement ps = conn.prepareStatement(
		"insert into User(ID,Password,ConstituencyID) " +
		"VALUES" +
		"(?,?,?)");
// SQL文にデータを設定（？部分にデータを設定)
ps.setString(1, request.getParameter("userID"));
ps.setString(2, request.getParameter("password"));
ps.setInt(3, Integer.parseInt(request.getParameter("ConstituencyID")));
ps.executeUpdate();
conn.close();
ps.close();


%>
