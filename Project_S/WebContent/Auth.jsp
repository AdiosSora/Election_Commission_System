<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*,javax.naming.*,javax.sql.*,election.ParameterBox"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

	<%  //SQL接続オブジェクト


	Connection conn = null;

	// JDBCドライバーの読み込み
	Class.forName("com.mysql.jdbc.Driver");

	//MySQLに接続
	conn = DriverManager.getConnection("jdbc:mysql://localhost/election",//接続するDB
									   "root", //ユーザ名
									   "kcsf"  //パスワード
									   );




	boolean flag = false;
	boolean test = false;
	String votestring = "";
	String[] candidate = new String[10];

	//一時的に入力されたユーザID、パスワード、選挙区IDを保持する
	String value1 = request.getParameter("userID");
	String value2 = request.getParameter("password");



	ParameterBox.setuserID(value1);
	ParameterBox.setpassword(value2);



	PreparedStatement ps = conn.prepareStatement("SELECT ID from user");
	ResultSet rs;  //UserID認証用データ

	PreparedStatement ps2 = conn.prepareStatement("SELECT password from user");
	ResultSet rs2; //Password認証用データ

	PreparedStatement ps3 = conn.prepareStatement("SELECT VoteFlag from user where ID = ? AND  Password = ? ");
	ps3.setString(1, ParameterBox.getuserID());
	ps3.setString(2, ParameterBox.getpassword());
	ResultSet rs3; //VoteFlag認証用データ

	PreparedStatement ps4 = conn.prepareStatement("SELECT ConstituencyID from user where ID = ? AND  Password = ? ");
	ps4.setString(1, ParameterBox.getuserID());
	ps4.setString(2, ParameterBox.getpassword());
	ResultSet rs4;//ConstituencyIDデータ

	PreparedStatement ps5 = conn.prepareStatement("SELECT nickname from user where ID = ? AND  Password = ? ");
	ps5.setString(1, ParameterBox.getuserID());
	ps5.setString(2, ParameterBox.getpassword());
	ResultSet rs5;//nicknameデータ

	PreparedStatement ps6 = conn.prepareStatement("SELECT DistrictName from constituency where ConstituencyID = ?  ");
	ResultSet rs6;//DistrictNameデータ

	rs = ps.executeQuery();
	rs2 = ps2.executeQuery();


	// ログイン認証処理
	while(rs.next() && rs2.next()){
		// userID,passwordが一致すればtrue
		if( ParameterBox.getuserID().equals( rs.getString("ID"))&&
				ParameterBox.getpassword().equals( rs2.getString("password"))){

			flag=true;

			rs3 = ps3.executeQuery();
			rs3.next();
			ParameterBox.setvoteflag(rs3.getString("VoteFlag"));

			rs4 = ps4.executeQuery();
			rs4.next();
			ParameterBox.setConstituencyID(rs4.getInt("ConstituencyID"));

			rs5 = ps5.executeQuery();
			rs5.next();
			ParameterBox.setnickname(rs5.getString("nickname"));

			ps6.setInt(1, rs4.getInt("ConstituencyID"));
			rs6 = ps6.executeQuery();
			rs6.next();
			ParameterBox.setDistrictName(rs6.getString("DistrictName"));
			%>
			<script>alert( rs3.getString("VoteFlag"));</script> <%
			rs3.close();
			rs4.close();
			rs5.close();
			rs6.close();
		}
	}

		if(flag){//idとpasswordが一致した場合
			if(ParameterBox.getvoteflag().equals("X-XX")){//投票がまだの場合
				%><script>	location.href = "vote.jsp";</script><%//投票用のページに移行
			}else if(ParameterBox.getvoteflag().equals(null)) {//投票済みの場合
				%> <script>
						location.href = "login3.html";
					</script><%
			}else{//投票済みの場合
				%> <script>
						location.href = "login3.html";
					</script><%
			}
		}else{
			//idかpasswordが間違えている
			%>
			<script>
			location.href = "login2.html";
			</script> <%

		}


	ps.close();
	ps2.close();
	ps3.close();
	ps4.close();
	ps5.close();
	rs.close();
	rs2.close();


	conn.close();

%>
</body>
</html>