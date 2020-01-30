<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*,javax.naming.*,javax.sql.*,election.ParameterBox"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%  //SQL接続オブジェクト


Connection conn = null;

// JDBCドライバーの読み込み
Class.forName("com.mysql.jdbc.Driver");

//MySQLに接続
conn = DriverManager.getConnection("jdbc:mysql://localhost/election",//接続するDB
								   "root", //ユーザ名
								   "kcsf"  //パスワード
								   );

//一時的に入力されたユーザID、パスワード、選挙区IDを保持する
String candidateid =  request.getParameter("candidate_button");
ParameterBox.setVoteFlag_Decision(candidateid);
%>
<title></title>
</head>
<body>
<div class="body_scale">
<form action="vote_complete.jsp">

お住いの地区 : <%=ParameterBox.getDistrictName() %><br><br>

名前　：　<%= ParameterBox.getnickname() %> 様<br><br>

投票される立候補者名 ：<%= ParameterBox.getDistrictName() %><br><br>

</form>

<%
	conn.close();
%>
</div>
<div class="relative" id="#bg01">
	<img src="image/コンポ 1.gif" alt=""/>
</div>
</body>
<style>
	img {
	  position: absolute;
	  top: -5;
	  left: -5;
	  width: 80vw;
	  height: auto;
	  background-size: cover;
	  z-index: -2;
	}
	.relative::before {
	    background-color: rgba( 255, 255, 255, .7 );
	    content: "";
	    height: 100%;
	    left: 0;
	    position: fixed;
	    top: 0;
	    width: 100%;
	    z-index: -1;
	}
    .body_scale{
        animation-name: Body_small;
        animation-duration: 10s;
        animation-fill-mode: forwards;
        animation-timing-function: ease-in;
        width: 70vw;
        height: 100%;
        background:#aaaaaa;
        border: 1px #ffffff;
    }
@keyframes Body_small{
    0% {

    }
    20% {
        -webkit-transform: scale(1);
        -moz-transform: scale(1);
    }
    40% {
        -webkit-transform: scale(0.7) translateY(0px);
        -moz-transform: scale(0.7) translateY(0px);
    }
    80% {
        -webkit-transform: scale(0.6) translateY(-2400%);
        -moz-transform: scale(0.6) translateY(-2400%);
    }
    100% {
        -webkit-transform: scale(0.6) translateY(-2400%);
        -moz-transform: scale(0.6) translateY(-2400%);
    }
}
</style>
</html>