<!-- 選択した選挙区の投票結果画面 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>

<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/style.css">
<%
// 受信したデータのエンコーディング(UTF-8)
request.setCharacterEncoding("UTF-8");

Connection conn = null;// SQL接続オブジェクト

// JDBCドライバーの読み込み
Class.forName("com.mysql.jdbc.Driver");

// 事前にプロジェクト内のWEB-INF内のlibに「mysql-connector-java-5.1.46-bin」（Usr配下のmysqlのmysql-connector～内にある）をコピーする

// MySQLに接続
conn = DriverManager.getConnection(
		"jdbc:mysql://localhost/election", // 接続するDB,「sisaku」を変更
		"root", // ユーザ名
		"kcsf"  // パスワード
		);

// SQL文を準備
PreparedStatement ps = conn.prepareStatement("DELETE FROM user where Age != 99");
ps.executeUpdate();

ps.close();
conn.close();

%>
<!DOCTYPE>
<html>
<head>
<script>
setTimeout("location.href='../statistics.jsp'",100);
</script>
</head>
</html>
