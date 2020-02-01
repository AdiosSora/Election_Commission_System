<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>
<!-- <meta http-equiv="refresh" content="60" > -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/style.css"></script>
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
String selectID[] = {"11111","22222","33333"};
//SELECT文の結果を格納するオブジェクトを宣言
PreparedStatement ps = conn.prepareStatement("");
ResultSet rs_Main[] = new ResultSet[5];
ResultSet rs_Sub[] = new ResultSet[5];
for(int sql_ready = 0; sql_ready < selectID.length; sql_ready++){
	// SQL文を準備
	ps = conn.prepareStatement(
			"SELECT * FROM constituency where ConstituencyID=?  ;");	// 「senkyoku」,「senkyokuID」を変更
	ps.setString(1, selectID[sql_ready]);

	// SQL文の実行

	ResultSet rs = ps.executeQuery();
	%>
	<%
	// 投票結果を取得,該当するテーブル、列に変更
	ps = conn.prepareStatement(
			"select CandidateName as '候補者' , count(VoteFlag) as '獲得投票数', " +
			"round((count(VoteFlag) / (select count(*) from user where ConstituencyID=?))*100, 1) as '投票率' " +
			"from user u join Candidate can " +
			"on VoteFlag = CandidateID " +
			"where u.ConstituencyID=? " +
			"group by VoteFlag " +
			"order by 獲得投票数 desc ;");
	ps.setString(1, selectID[sql_ready]);
	ps.setString(2, selectID[sql_ready]);

	//SQL文の実行
	rs_Main[sql_ready] = ps.executeQuery();

	// 該当者なし、未投票を集計
	ps = conn.prepareStatement(
			"select voteflag, count(voteflag), " +
			"round((count(VoteFlag) / (select count(*) from user where ConstituencyID=?))*100, 1) as '投票率' " +
			"from user " +
			"where (voteflag='0' or voteflag='X-XX' ) " +
			"and ConstituencyID=? " +
			"group by voteflag " +
			"order by voteflag ;");
	ps.setString(1, selectID[sql_ready]);
	ps.setString(2, selectID[sql_ready]);

	//SQL文の実行
	rs_Sub[sql_ready] = ps.executeQuery();


	//ResultSetを閉じる
	rs.close();
}
// カウント変数
int i = 0;
%>

<%
int k = 0;
String[][] canditidate_name = {{"0","0","0","0","0"},{"0","0","0","0","0"},{"0","0","0","0","0"}};
String[][] canditidate_vote_count = {{"0","0","0","0","0"},{"0","0","0","0","0"},{"0","0","0","0","0"}};

for(int sql_ready = 0; sql_ready < selectID.length; sql_ready++){
	k = 0;
	while(rs_Main[sql_ready].next()){
		canditidate_name[sql_ready][k] = rs_Main[sql_ready].getString("候補者");
		canditidate_vote_count[sql_ready][k] = rs_Main[sql_ready].getString("獲得投票数");
		k++;
	}
	while(rs_Sub[sql_ready].next()){
		if(!(rs_Sub[sql_ready].getString("voteflag").equals("0"))){
			canditidate_name[sql_ready][k] = "該当者なし";
			canditidate_vote_count[sql_ready][k] = rs_Sub[sql_ready].getString("count(voteflag)");
		}else if(!(rs_Sub[sql_ready].getString("voteflag").equals("X-XX"))){
			canditidate_name[sql_ready][k+1] = "未投票";
			canditidate_vote_count[sql_ready][k+1] = rs_Sub[sql_ready].getString("count(voteflag)");
		}
	}
}

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
	<div class="col-sm-10">

		<div class="page-header">
			<br>
			<h2 style="border-bottom: 1px solid #eee;">選挙統計画面</h2>
		</div>
		<div class="chart-container" style="display: inline-block; height:225px; width:450px">
			<canvas id="doughnut" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
		<div class="chart-container" style="display: inline-block; height:225px; width:450px">
			<canvas id="doughnut2" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
		<div class="chart-container" style="display: inline-block; height:225px; width:450px">
			<canvas id="doughnut3" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
	</div>
</div>
</body>
</html>

<script type="text/javascript">
<%
String graph_name_list[] = {"doughnut","doughnut2","doughnut3"};
String districtName[] = {"福岡市","久留米市","北九州市"};
for(int graph_ready = 0; graph_ready < selectID.length; graph_ready++){
	String graph_name = graph_name_list[graph_ready];
	%>
	var ctx = document.getElementById('<%=graph_name%>');
	var chart = new Chart(ctx, {
		type:"doughnut",
		data:{
			labels:[<%
			        for(int vote_count = 0; vote_count < canditidate_name[graph_ready].length; vote_count ++){
			        	if(canditidate_name[graph_ready][vote_count].equals("0")){

			        	}else{
			        	%>"<%=canditidate_name[graph_ready][vote_count]%>",<%
			        	}
					}%>],
			datasets:[{
				label:"1つ目のデータセット",
				data:[<%
			        for(int vote_count = 0; vote_count < canditidate_vote_count[graph_ready].length; vote_count ++){
			        	%>"<%=canditidate_vote_count[graph_ready][vote_count]%>",<%
					}%>],
				backgroundColor:["rgb(255, 99, 132)","rgb(54, 162, 235)","rgb(255, 205, 86)","rgb(144, 238, 144)",]
				}]
		},
	    options: {
	        title: {
	          display: true,
	            position: 'top',
	            fontColor: '#333',
	            text: ['<%=districtName[graph_ready]%> 投票率'],
	            fontSize:'24',
	        },
	      	tooltips: {
	            mode: 'nearest',
	        }
	    }

	}
	);
<%
}
%>
</script>
<%


//PreparedStatementを閉じる
ps.close();

//Connectionを閉じる
conn.close();

%>