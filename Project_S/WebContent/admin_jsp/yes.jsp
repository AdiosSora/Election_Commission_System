<!-- ログイン成功、選挙区選択画面 -->

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
PreparedStatement ps1 = conn.prepareStatement(
		"SELECT * FROM constituency");

PreparedStatement ps2 = conn.prepareStatement(
		"select constituencyID, count(constituencyID) as '総議席数' " +
		"from candidate " +
		"group by constituencyID; ");
// SELECT文の結果を格納するオブジェクトを宣言
ResultSet rs1;
ResultSet rs2;

// SQL文の実行
rs1 = ps1.executeQuery();
rs2 = ps2.executeQuery();

//
String id = "";
%>

<html>
<head>
<meta charset="UTF-8">
<title>投票結果</title>
</head>
<body>
<div class="row" >
<div class="col-2" style="text-align:center;padding:100px 0px 0px 0px;">
	 <a class="" href="yes.jsp">投票結果</a><br>
	 <a class="" href="statistics.jsp">投票統計</a>
</div>
<div class="col-10">
	<form method= "POST" action="result.jsp">
	<br>
<div class="page-header">
	<h2 style="border-bottom: 1px solid #eee;">選挙管理画面</h2>
</div>
<div class="form-group">
	選挙区/議席数を選択してください
	<br><br>
	<legend>選挙区</legend>
		<select class="form-control" name="senkyoku">
			<%
			while(rs1.next()){
			%>
			<option value="<%=rs1.getString("ConstituencyID") %> ">	<!-- 「senkyokuID」を変更 -->
			<%=rs1.getString("DistrictName") %></option>		<!-- 「senkyokuNAME」を変更 -->
			<% } %>
		</select><br />
	<legend>当選議席数</legend>
		<select class="form-control" name="tosen">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
		</select>
</div>
<div>
	<input type="submit" class="btn btn-primary" value="選択" />
</div>
</form>
</div>
</div>
</body>
</html>

<%

//ResultSetを閉じる
rs1.close();
rs2.close();

// PreparedStatementを閉じる
ps1.close();
ps2.close();

// Connectionを閉じる
conn.close();

%>
