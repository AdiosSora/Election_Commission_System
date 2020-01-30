<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*,javax.naming.*,javax.sql.*,election.ParameterBox"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>ご投票ありがとうございました！ - ネット投票所</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<link href="css/animate.css" rel="stylesheet">

<%  //SQL接続オブジェクト


Connection conn = null;

// JDBCドライバーの読み込み
Class.forName("com.mysql.jdbc.Driver");

//MySQLに接続
conn = DriverManager.getConnection("jdbc:mysql://localhost/election",//接続するDB
								   "root", //ユーザ名
								   "kcsf"  //パスワード
								   );

String vote_value = request.getParameter("candidate_id_value");
PreparedStatement ps = conn.prepareStatement("update user set VoteFlag= ? where ID = ? ;");
ps.setString(1,vote_value);
ps.setString(2,ParameterBox.getuserID());
ps.executeUpdate();

//一時的に入力されたユーザID、パスワード、選挙区IDを保持する
String candidateid =  request.getParameter("candidate_button");
ParameterBox.setVoteFlag_Decision(candidateid);
%>
<title></title>
</head>
<body>
    <div class="body_scale">
        <div class="vertical">
            <div id="view_time"></div>
            <h1 style="font-size: 36px">第二千二十回　福岡市長選挙</h1>
            <br>
             <h3><%=ParameterBox.getDistrictName() %>　<%= ParameterBox.getnickname() %> 様</h3>
             <br>
             <h2>候補者名</h2>
             <br>
             <h2><%= request.getParameter("candidate_name_value")%></h2>
             <br><br>
        </div>
        <input type="hidden" name="candidate_name" value="<%= ParameterBox.getvoteflag() %>">
    </div>
    <div class="vote_gif">
    	<img src="image/Vote_anm.gif"width="100%" alt="">

    </div>


<%
	ps.close();
	conn.close();
%>
</body>
<style>
	body {
		position: relative;
	}
    .body_scale{
        animation-name: Body_small;
        animation-duration: 10s;
        animation-fill-mode: forwards;
        border: 1px solid #777;
        width:auto;
        text-align: center;
        margin : 5vw 10%;
        background-color: white;
        box-shadow: 4px 4px 6px gray;
    }
    #view_time {
        margin: 20px 30px 0 0;
        text-align: right;
    }
    .vote_gif{
    	position: absolute;
    	animation-name: Vote_gif;
        animation-duration: 20s;
        animation-fill-mode: forwards;
        right: 0px;
    	bottom: 0px;
    	width:100vw;
    }
@keyframes Body_small{
	0% {
        -webkit-transform: scale(1);
        -moz-transform: scale(1);
    }
    20% {
        -webkit-transform: scale(0.7) translateY(0px);
        -moz-transform: scale(0.7) translateY(0px);
    }
    80% {
        -webkit-transform: scale(0.7) translateY(-2400%);
        -moz-transform: scale(0.7) translateY(-2400%);
    }
    100% {
        -webkit-transform: scale(0.7) translateY(-2400%);
        -moz-transform: scale(0.7) translateY(-2400%);
    }
}
@keyframes Vote_gif{
	0% {
		opacity: 0;
	}
    50% {
    	opacity: 1;
    }
}
</style>
<script>
document.getElementById("view_time").innerHTML = getNow();

function getNow() {
	var now = new Date();
	var year = now.getFullYear();
	var mon = now.getMonth()+1; //１を足すこと
	var day = now.getDate();

	//出力用
	var s = year + "年" + mon + "月" + day + "日";
	return s;
}
</script>
</html>