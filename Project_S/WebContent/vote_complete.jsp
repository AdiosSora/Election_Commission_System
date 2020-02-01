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
            <h1 style="font-size: 36px">第2020回　<%= ParameterBox.getDistrictName() %>長選挙</h1>
            <br>
             <h3><%=ParameterBox.getDistrictName() %>　<%= ParameterBox.getnickname() %> 様</h3>
             <br>
             <h2>候補者名</h2>
             <br>
             <h1><%= request.getParameter("candidate_name_value")%></h1>
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
<div class="vote_thx_gif">
    	ご投票ありがとうございました
</div>
    <div class="vote_thx_button">
    	<a href="index.html" class="btn btn-secondary">トップページに戻る</a>
    </div>

<style>
	body {
		position: relative;
		top:0%;
		background-color:#FBFBFB;
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
        background-color :#ffffff;
        z-index :2;
    }
    .vote_gif{
    	position: absolute;
    	animation-name: Vote_gif;
        animation-duration: 20s;
        animation-fill-mode: forwards;
        top: -25vw;
    	width:100vw;
    	text-aligen:center;
    	z-index:-1;

    }
    .vote_thx_gif{
    	position: absolute;
    	animation-name: Vote_thx_gif;
        animation-duration: 10s;
        animation-fill-mode: forwards;
        top: 6vw;
        left: 30%;
    	width:100%;
    	text-aligen:center;
    	z-index:1;
    	font-size :3vw;
    }
      .vote_thx_button{
    	position: absolute;
    	animation-name: Vote_thx_gif;
        animation-duration: 10s;
        animation-fill-mode: forwards;
        top: 38vw;
    	width:100%;
    	text-aligen:center;
    	z-index:1;
    	font-size :3vw;
    	left: 38vw;
    }
    @media screen and (min-width: 640px) {
		.vote_thx_button{
			left: 40vw;
		}
    }
    @media screen and (min-width: 800px) {
		.vote_thx_button{
			left: 42vw;
		}
    }
    @media screen and (min-width: 1200px) {
		.vote_thx_button{
			left: 45vw;
		}
    }
    @media screen and (min-width: 1600px) {
		.vote_thx_button{
			left: 46vw;
		}
    }
	@media screen and (orientation: landscape) {
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
@keyframes Vote_thx_gif{
	0% {
		opacity: 0;
	}
	80%{
		opacity: 0;
	}
    90% {
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