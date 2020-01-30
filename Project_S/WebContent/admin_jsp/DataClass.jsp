<%@ page language="java" contentType="text/html; charset=UTF-8"
    import = "java.sql.*,javax.naming.*,javax.sql.*,election.ParameterBox" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>投票用ページ</title>
</head>
	<body>
	<%
		//SQL接続オブジェクト


		Connection conn = null;
		ResultSet rs;
		ResultSet rs2;
		ResultSet arears;
		ResultSet namers;
		PreparedStatement ps;
		PreparedStatement ps2;
		PreparedStatement areaps;
		PreparedStatement nameps;
		String  Can = "";


		// JDBCドライバーの読み込み
		Class.forName("com.mysql.jdbc.Driver");

		//MySQLに接続
		conn = DriverManager.getConnection("jdbc:mysql://localhost/election",//接続するDB
										   "root", //ユーザ名
										   "kcsf"  //パスワード
										   );

		areaps = conn.prepareStatement("SELECT DistrictName from constituency where ConstituencyID = ?");
		areaps.setInt(1, ParameterBox.getConstituencyID());
		arears = areaps.executeQuery();

		while(arears.next()){
			out.println(arears.getString("DistrictName") + "　　　");
		}//選挙する地区の表示

		nameps = conn.prepareStatement("SELECT nickname from user where ID = ? and Password = ?");
		nameps.setString(1, ParameterBox.getuserID());
		nameps.setString(2, ParameterBox.getpassword());
		namers = nameps.executeQuery();

		while(namers.next()){
			out.println(namers.getString("nickname")); %>	<br/>	<%
		}//投票者の名前を表示







		ps = conn.prepareStatement("SELECT CandidateID from candidate where ConstituencyID = ?");
		ps.setInt(1, ParameterBox.getConstituencyID());
		rs = ps.executeQuery();


		ps2 = conn.prepareStatement("SELECT CandidateName from candidate where CandidateID = ?");
		ps2.setString(1 , Can);
		rs2 = ps2.executeQuery();


		while(rs.next()){
			Can = rs.getString("CandidateID");
			rs2.next();
			out.println(rs2.getString("CandidateName")); %>	<br/>	<%
			//対応する選挙区の候補者名を表示






		}


	ps.close();
	ps2.close();
	nameps.close();
	areaps.close();

	rs.close();
	rs2.close();
	namers.close();
	arears.close();

	conn.close();
	%>
	</body>
</html>
