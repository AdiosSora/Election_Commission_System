<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>

<%
// 受信したデータのエンコーディング(UTF-8)
request.setCharacterEncoding("UTF-8");

Connection conn = null;// SQL接続オブジェクト

// JDBCドライバーの読み込み
Class.forName("com.mysql.jdbc.Driver");

// 事前にプロジェクト内のWEB-INF内のlibに「mysql-connector-java-5.1.46-bin」（Usr配下のmysqlのmysql-connector～内にある）をコピーする

// MySQLに接続
conn = DriverManager.getConnection(
		"jdbc:mysql://localhost/election", // 接続するDB
		"root", // ユーザ名
		"kcsf"  // パスワード
		);

// SQL文を準備
PreparedStatement ps = conn.prepareStatement(
		"SELECT VoteFlag from user where ID = 'abcd123' and Password = 'aaaaa'");
//ps.setString(1, request.getParameter("title"));
//ps.setString(2, request.getParameter("memo"));

// SELECT文の結果を格納するオブジェクトを宣言
ResultSet rs;

// SQL文の実行
rs = ps.executeQuery();



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>簡易スケジュール帳</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>日付</th><th>時刻</th><th>予定名</th><th>備考</th><th>削除</th>
		</tr>
			<%while(rs.next()){ %>
		<tr>
			<td><%=rs.getString("VoteFlag") %></td>

		</tr>
		<%}
			// ResultSetを閉じる
			rs.close();

			// PreparedStatementを閉じる
			ps.close();

			// Connectionを閉じる
			conn.close();
		%>
	</table>
</body>
</html>