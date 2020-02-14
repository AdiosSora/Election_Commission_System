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
PreparedStatement ps = conn.prepareStatement(
		"SELECT * FROM constituency where ConstituencyID=?  ;");	// 「senkyoku」,「senkyokuID」を変更
String selectID = request.getParameter("senkyoku");
ps.setString(1, selectID);

// SELECT文の結果を格納するオブジェクトを宣言
ResultSet rs;
ResultSet rs_Main;
ResultSet rs_Main2;
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
	<div class="col-sm-9">
<br>
<h1 style="border-bottom: 1px solid #eee;text-aligen:center;"><%
//選択された１つのデータを取得
if(rs.next()){
	out.println(rs.getString("DistrictName") + "の集計");	// 「senkyokuNAME」を変更
}%></h1><%
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

ps = conn.prepareStatement(
		"select count(*) as x from candidate where constituencyid=? ;  ");
ps.setString(1, selectID);

//SQL文の実行
rs_Main2 = ps.executeQuery();

int arrayInt[];
int x=0;

while(rs_Main2.next()){
	x = Integer.parseInt(rs_Main2.getString("x"));
}
arrayInt = new int[x];
int t = 0;
while(rs_Main.next()){
	arrayInt[t]=Integer.parseInt(rs_Main.getString("獲得投票数"));
	t++;
}


//投票結果を取得,該当するテーブル、列に変更
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

// 当選議席数
int tosen = Integer.parseInt(request.getParameter("tosen"));
int num = Integer.parseInt(request.getParameter("tosen"));

// 0:初期値、1:当選、2:落選、3:くじ引き
int back = 0;

// 判定変数 0:off, 1:on
int judge = 0;
%>

<table border="1" class="table table-hover">
		<tr bgcolor="#dddddd" text-aligen="">
			<th>候補者</th><th>投票数</th><th>投票率</th><th>当選判定</th>
		</tr>
		<% while(rs_Main.next()){ %>
		<tr>
			<td><%=rs_Main.getString("候補者") %></td>
			<td><%=rs_Main.getString("獲得投票数") %></td>
			<td><%=rs_Main.getString("投票率") %>%</td>

				<%
				// 選択した当選数分に「当選」
				int kuji = 0;


				if(arrayInt.length <= tosen){
					// すべて当選の場合
					%><td style="color:red;">当選</td>
					<% back = 1;
				 }else if(back == 2 || tosen < 1 && judge == 0){
					// すでに当選議席数がない
					%><td>落選</td>
					<% back = 2;
				}else if(i == arrayInt.length - 1){
					// 立候補者の最下位の判定
					%>くじ引き（<%=num %>名当選）</td>
					<% back = 3;
				}else{
					for(int j = i+1; j < arrayInt.length && arrayInt[i] == arrayInt[j]; j++){
						// 同票がどこまで続くか
						kuji++;
					}

					if(tosen > kuji){
						// 同票でも議席数内に収まる場合
						%><td style="color:red;">当選</td>
						<% back = 1;
						tosen--;
						num--;
					}else{
						// くじ引きの発生
						if(kuji > 0){
							// 同票の途中
							%>くじ引き（<%=num %>名当選）</td>
							<% back = 3;
							tosen--;
							judge = 1;
						}else{
							// 同票の最後
							%>くじ引き（<%=num %>名当選）</td>
							<% back = 3;
							tosen--;
							judge = 0;
							num = 0;
						}
					}
				}
				i++;
				%>
		</tr><% } %>
		<% while(rs_Sub.next()){ %>
		<tr>
			<td><%
				// voteflagが「0」「X-XX」の判定]
				if(rs_Sub.getString("voteflag").equals("0")){
					%>該当者なし</td>
					<td><%=rs_Sub.getString("count(voteflag)") %></td>
					<td><%=rs_Sub.getString("投票率") %>%</td>
				<% }else if(rs_Sub.getString("voteflag").equals("X-XX")){
					%>未投票</td>
					<td><%=rs_Sub.getString("count(voteflag)") %></td>
					<td><%=rs_Sub.getString("投票率") %>%</td>
				<% } %>
				<td>----</td>
		</tr><% } %>
</table>

<form method= "POST" action="yes.jsp">
	<div>
		<input type="submit" value="戻る" />
	</div>
</form>
</div>
<div class="col-sm-1"></div>
</div>
</body>
</html>


<%

//ResultSetを閉じる
rs.close();

// PreparedStatementを閉じる
ps.close();

// Connectionを閉じる
conn.close();

%>
