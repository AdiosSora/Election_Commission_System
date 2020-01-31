<!-- ランダム配布、および数値型判定 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>


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


// パスワード配布用の英数字の配列を用意
String[]  m = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
			   "a","b","c","d","e","f","g","h","i","j","k","l","n","m","o","p","q","r","s","t","u","v","w","x","y","z",
			   "0","1","2","3","4","5","6","7","8","9"};

String id ="";
String pass = "";
String selectID = "";

int i=0;
int l=0;
int n=0;
int res=0;

try{	// 数値以外の場合の例外処理
	for(i=0; i < Integer.parseInt(request.getParameter("num")); i++){
		l = 0;
		n = 0;
		while(l<=5){	// ID列に配布
			double xi =  Math.random()*62;
			id = id + m[(int)xi];
			if(l>=5){
				// SQL文を準備
				PreparedStatement ps1 = conn.prepareStatement(
						"SELECT COUNT(*) FROM user WHERE ID='" + id +
						"' OR Password='" + id + "' ;");

				ResultSet rs;

				// SQL文実行
				rs = ps1.executeQuery();

				while(rs.next()){
					res = rs.getInt("COUNT(*)");
				}
					//res = Integer.parseInt(rs.getString("COUNT(*)"));
				if(res != 0){
					id = "";

					//ResultSetを閉じる
					rs.close();

					//PreparedStatementを閉じる
					ps1.close();

					l = 0;

					continue;

				}else{
					//ResultSetを閉じる
					rs.close();

					//PreparedStatementを閉じる
					ps1.close();
				}

			}

			l++;

		}

		while(n<=5){	// Password列に配布
			double xp =  Math.random()*62;
			pass = pass + m[(int)xp];
			if(n>=5){
				// SQL文を準備
				PreparedStatement ps1 = conn.prepareStatement(
						"SELECT COUNT(*) FROM user WHERE ID='" + pass +
						"' OR Password='" + pass + "' ;");

				ResultSet rs;

				// SQL文実行
				rs = ps1.executeQuery();

				while(rs.next()){
					res = rs.getInt("COUNT(*)");
				}
						//res = Integer.parseInt(rs.getString("COUNT(*)"));
				if(res != 0){
					pass = "";

					//ResultSetを閉じる
					rs.close();

					//PreparedStatementを閉じる
					ps1.close();

					n = 0;

					continue;

				}else{
					//ResultSetを閉じる
					rs.close();

					//PreparedStatementを閉じる
					ps1.close();
				}
			}

			n++;
		}
		// データ挿入
		PreparedStatement ps2 = conn.prepareStatement(
				"INSERT INTO user(ID,Password,ConstituencyID) VALUES ('" +
				id +"','" + pass +"',?) ;");

		selectID = request.getParameter("senkyoku");
		ps2.setString(1, selectID);

		// SQL文実行
		ps2.executeUpdate();

		//PreparedStatementを閉じる
		ps2.close();

		id = "";
		pass = "";

	}

	// 成功画面へ
	response.sendRedirect("complete.jsp");

	//Connectionを閉じる
	conn.close();
}catch(Exception e){
	//Connectionを閉じる
	conn.close();

	// 失敗画面へ
	response.sendRedirect("failed.jsp");
}
%>
