

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>

<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

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
	<h2 style="border-bottom: 1px solid #eee;"><%
	//選択された１つのデータを取得
	if(rs.next()){
		out.println(rs.getString("DistrictName") + "の集計");	// 「senkyokuNAME」を変更
	}%></h2><%
	// 投票結果を取得,該当するテーブル、列に変更
	ps = conn.prepareStatement(
			"select CandidateName as '候補者' , count(VoteFlag) as '獲得投票数', " +
			"round((count(VoteFlag) / (select count(*) from user where ConstituencyID=?))*100, 1) as '投票率' " +
			"from user u join Candidate can " +
			"on VoteFlag = CandidateID " +
			"where u.ConstituencyID=? " +
			"group by VoteFlag " +
			"order by 獲得投票数 desc ;");
	ps.setString(1, selectID);
	ps.setString(2, selectID);

	//SQL文の実行
	rs_Main = ps.executeQuery();

	// 該当者なし、未投票を集計
	ps = conn.prepareStatement(
			"select voteflag, count(voteflag), " +
			"round((count(VoteFlag) / (select count(*) from user where ConstituencyID=?))*100, 1) as '投票率' " +
			"from user " +
			"where (voteflag='0' or voteflag='X-XX' ) " +
			"and ConstituencyID=? " +
			"group by voteflag " +
			"order by voteflag ;");
	ps.setString(1, selectID);
	ps.setString(2, selectID);

	//SQL文の実行
	rs_Sub = ps.executeQuery();

	// カウント変数
	int i = 0;
	%>
<div class="page-header">
	<h2 style="border-bottom: 1px solid #eee;">選挙統計</h2>
	<div id="chartContainer" style="height: 370px; max-width: 920px; margin: 0px auto;"></div>
</div>
</div>
<div class="col-2"></div>
</div>
</body>
</html>
<script>
window.onload = function() {

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	title: {
		text: "Desktop Search Engine Market Share - 2016"
	},
	data: [{
		type: "pie",
		startAngle: 240,
		yValueFormatString: "##0.00'%'",
		indexLabel: "{label} {y}",
		dataPoints: [
			<% while(rs_Main.next()){ %>
			{y: <%=rs_Main.getString("投票率") %>, label: <%=rs_Main.getString("候補者") %>},
					<%
					i++;
					%>
				<% } %>
		]
	}]
});
chart.render();

}
</script>
<%

//ResultSetを閉じる
rs.close();

//PreparedStatementを閉じる
ps.close();

//Connectionを閉じる
conn.close();

%>
<script src="../js/canvasjs.min.js"></script>