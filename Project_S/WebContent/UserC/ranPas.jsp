<!-- ユーザID、パスワード、選挙区ID配布 -->

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
		"jdbc:mysql://localhost/election", // 接続するDB,「sisaku」を変更
		"root", // ユーザ名
		"kcsf"  // パスワード
		);

// SQL文を準備
PreparedStatement ps1 = conn.prepareStatement(
		"SELECT * FROM constituency");

// SELECT文の結果を格納するオブジェクトを宣言
ResultSet rs1;

// SQL文の実行
rs1 = ps1.executeQuery();

%>

<html>
<head>
<meta charset="UTF-8">
<title>パスワード配布画面</title>
</head>
<body>
	<form method= "POST" action="random.jsp">
<div>
	<label>ユーザID・パスワードを配布する人数、選挙区を指定してください
	</label>
</div>
<div>
	<label>人数:<br />
		<input type="text" name="num" size="15" maxlength="10" />
	</label>
</div>
<div>
	<label>選挙区:<br />
		<select name="senkyoku">
			<%
			while(rs1.next()){
			%>
			<option value="<%=rs1.getString("ConstituencyID") %> ">	<!-- 「senkyokuID」を変更 -->
			<%=rs1.getString("DistrictName") %></option>		<!-- 「senkyokuNAME」を変更 -->
			<% } %>
		</select><br />
	</label>
</div>
<div>
	<input type="submit" value="実行" />
</div>
</form>
</body>
</html>
