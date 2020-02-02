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
ResultSet vote_clear[] = new ResultSet[5];
for(int sql_ready = 0; sql_ready < selectID.length; sql_ready++){
	// SQL文を準備
	ps = conn.prepareStatement(
			"SELECT VoteFlag,Age FROM user where ConstituencyID=?  ;");	// 「senkyoku」,「senkyokuID」を変更
	ps.setString(1, selectID[sql_ready]);
	vote_clear[sql_ready] = ps.executeQuery();

}
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
int[][][] user_age_vote_count = {
										{
											{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0}
										},
										{
											{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0}
										},
										{
											{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0}
										},
									};
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
for(int sql_ready = 0; sql_ready < selectID.length; sql_ready++){
	k = 0;
	while(vote_clear[sql_ready].next()){
		int num = Integer.parseInt(vote_clear[sql_ready].getString("Age"));
		if(num >= 18 && num <=29){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][0]+=1;
			}
			user_age_vote_count[sql_ready][1][0]+=1 ;
		}
		if(num >= 30 && num <=39){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][1]+=1;
			}
			user_age_vote_count[sql_ready][1][1]+=1 ;
		}
		if(num >= 40 && num <=49){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][2]+=1;
			}
			user_age_vote_count[sql_ready][1][2]+=1 ;
		}
		if(num >= 50 && num <=59){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][3]+=1;
			}
			user_age_vote_count[sql_ready][1][3]+=1 ;
		}
		if(num >= 60 && num <=69){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][4]+=1;
			}
			user_age_vote_count[sql_ready][1][4]+=1 ;
		}
		if(num >= 70 && num <=79){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][5]+=1;
			}
			user_age_vote_count[sql_ready][1][5]+=1 ;
		}
		if(num >= 80 && num <=89){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][6]+=1;
			}
			user_age_vote_count[sql_ready][1][6]+=1 ;
		}
		if(num >= 90 && num <=99){
			if(!(vote_clear[sql_ready].getString("VoteFlag").equals("X-XX"))){
				user_age_vote_count[sql_ready][0][7]+=1;
			}
			user_age_vote_count[sql_ready][1][7]+=1 ;
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
<div class="row min_window" >
	<img src="../image/Logo.png" width="80%">
</div>
<div class="row" >
<div class="col-2 admin_sidebar">
	<div class="Logo_admin">
		<img src="../image/Logo.png" width="80%"><br>
	</div>
	<div class="btn-group-vertical">
		 <a class="btn btn-secondary" href="yes.jsp">投票結果</a><br>
		 <a class="btn btn-secondary" href="statistics.jsp">投票統計</a><br>
		 <a class="btn btn-secondary" href="in_index.jsp">プレビュー</a><br>
	</div>
	</div>
	<div class="col-sm-10">

		<div class="page-header">
			<br>
			<h1 style="border-bottom: 1px solid #eee;text-aligen:center;">選挙統計画面</h1>
		</div>
		<div class="chart-container graph_shadow" style="display: inline-block; height:225px; width:450px">
			<canvas id="doughnut" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
		<div class="chart-container graph_shadow" style="display: inline-block; height:225px; width:450px">
			<canvas id="doughnut2" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
		<div class="chart-container graph_shadow" style="display: inline-block; height:225px; width:450px">
			<canvas id="doughnut3" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
		<hr class="style2"></hr>
		<div class="chart-container graph_shadow" style="display: inline-block; height:225px; width:450px">
			<canvas id="line" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
		<div class="chart-container graph_shadow" style="display: inline-block; height:225px; width:450px">
			<canvas id="line2" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
		<div class="chart-container graph_shadow" style="display: inline-block; height:225px; width:450px">
			<canvas id="line3" aria-label="Hello ARIA World" role="img"></canvas>
		</div>
	</div>
</div>
</body>
</html>

<script type="text/javascript">
<%
String graph_name_list[] = {"doughnut","doughnut2","doughnut3"};
String graph_name2_list[] = {"line","line2","line3"};
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
for(int graph_ready = 0; graph_ready < selectID.length; graph_ready++){
	String graph_name = graph_name2_list[graph_ready];
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