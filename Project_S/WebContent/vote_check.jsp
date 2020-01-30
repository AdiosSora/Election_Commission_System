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
String candidateid = request.getParameter("candidate");
String candidate_name = "";

PreparedStatement ps = conn.prepareStatement("SELECT CandidateID from candidate");
ResultSet rs;  //UserID認証用データ

PreparedStatement ps2 = conn.prepareStatement("SELECT CandidateName from candidate where CandidateID = ?");
ps2.setString(1, candidateid);
ResultSet rs2;

rs = ps.executeQuery();
rs2 = ps2.executeQuery();
while(rs.next()){
	if(candidateid.equals("確認する")){
		%> <script>
			location.href = "vote.jsp";
		</script> <%
	}else if(candidateid.equals("0")){
		candidate_name = "無記名";
	}else if(candidateid.equals(rs.getString("CandidateID"))){
		rs2 = ps2.executeQuery();
		rs2.next();
		candidate_name = rs2.getString("CandidateName");
		rs2.close();
	}

}
ParameterBox.setVoteFlag_Decision(candidateid);
%>
<title></title>
</head>
<body>
<div>
<form action="vote_complete.jsp">

お住いの地区 : <%=ParameterBox.getDistrictName() %><br><br>

名前　：　<%= ParameterBox.getnickname() %> 様<br><br>

投票される立候補者名 ：<%=candidate_name %><br><br>

この方に投票してもよろしいですか？<br><br>
<input type="hidden" name="candidate_name" value="<%= ParameterBox.getvoteflag() %>">
<input type = "submit" name ="candidate_button" value="投票する">
<button type="button" onclick="history.back()">戻る</button>
</form>

<%	ps.close();
	ps2.close();
	rs.close();
	conn.close();
%>
</div>
</body>
</html>