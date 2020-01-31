

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>

<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<!-- Load c3.css -->
<link href="../css/c3-0.7.10/c3.css" rel="stylesheet">

<!-- Load d3.js and c3.js -->
<script src="../css/c3-0.7.10/d3.v5.min.js" charset="utf-8"></script>
<script src="../css/c3-0.7.10/c3.min.js"></script>

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
PreparedStatement ps = conn.prepareStatement(
		"SELECT * FROM constituency where ConstituencyID=?  ;");	// 「senkyoku」,「senkyokuID」を変更
String selectID = "福岡市";
ps.setString(1, selectID);

// SELECT文の結果を格納するオブジェクトを宣言
ResultSet rs;
ResultSet rs_Main;
ResultSet rs_Sub;

// SQL文の実行
rs = ps.executeQuery();

%>

<html>
<head>
<meta charset="UTF-8">
<title>投票結果</title>
</head>
<body>
<div class="row" >
<div class="col-4" style="text-align:center;padding:100px 0px 0px 0px;">
	 <a class="" href="yes.jsp">投票結果</a><br>
	 <a class="" href="statistics.jsp">投票統計</a>
</div>
<div class="col-6">

	<div class="page-header">
		<h2 style="border-bottom: 1px solid #eee;">選挙統計</h2>
		<div id="chartContainer" style="height: 370px; max-width: 920px; margin: 0px auto;"></div>
	</div>
</div>
<div class="col-2"></div>
</div>
</body>
</html>
<%

//ResultSetを閉じる
rs.close();

//PreparedStatementを閉じる
ps.close();

//Connectionを閉じる
conn.close();

%>
<script src="../js/canvasjs.min.js"></script>