<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*,javax.naming.*,javax.sql.*,election.ParameterBox"%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/boostrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery-3.3.1.slim.min.js"></script>

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
	if(candidateid.equals("確認")){
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
<body class="fadeout">
<form method="GET" action="vote_complete.jsp">
    <div class="vote_template">
        <div class="vertical">
            <div id="view_time"></div>
            <h1 style="font-size: 36px">第2020回　<%= ParameterBox.getDistrictName() %>長選挙</h1>
            <br>
             <h3><%=ParameterBox.getDistrictName() %>　<%= ParameterBox.getnickname() %> 様</h3>
             <br>
             <h2>候補者名</h2>
             <br>
             <h1><%=candidate_name %></h1>
             <br><br>
        </div>
        <input type="hidden" name="candidate_name" value="<%= ParameterBox.getvoteflag() %>">
    </div>
    <div class ="center_button">
    	この方に投票してもよろしいですか？<br><br>
        <button type="button" class="btn btn-secondary"onclick="history.back()">戻る</button>
        <input type="hidden" name="candidate_id_value" value="<%= candidateid%>">
        <input type="hidden" name="candidate_name_value" value="<%= candidate_name%>">
        <input type = "submit" class="btn btn-primary" name ="candidate_button" value="投票する">
    </div>
</form>

<%	ps.close();
	ps2.close();
	rs.close();
	conn.close();
%>
</div>
</body>
</html>
<style>
    .vote_template {
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
    .center_button {
        text-align: center;
    }
</style>
<script type="text/javascript">
$(window).on('load', function(){
    $('body').removeClass('fadeout');
});
$(function() {
  // ハッシュリンク(#)と別ウィンドウでページを開く場合はスルー
  $('a:not([href^="#"]):not([target])').on('click', function(e){
    e.preventDefault(); // ナビゲートをキャンセル
    url = $(this).attr('href'); // 遷移先のURLを取得
    if (url !== '') {
      $('body').addClass('fadeout');  // bodyに class="fadeout"を挿入
      setTimeout(function(){
        window.location = url;  // 0.8秒後に取得したURLに遷移
      }, 800);
    }
    return false;
  });
});
function showElementAnimation() {

	  var element = document.getElementsByClassName('js-animation');
	  if(!element) return; // 要素がなかったら処理をキャンセル

	  var showTiming = window.innerHeight > 768 ? 200 : 40; // 要素が出てくるタイミングはここで調整
	  var scrollY = window.pageYOffset;
	  var windowH = window.innerHeight;

	  for(var i=0;i<element.length;i++) { var elemClientRect = element[i].getBoundingClientRect(); var elemY = scrollY + elemClientRect.top; if(scrollY + windowH - showTiming > elemY) {
	      element[i].classList.add('is-show');
	    } else if(scrollY + windowH < elemY) {
	      // 上にスクロールして再度非表示にする場合はこちらを記述
	      element[i].classList.remove('is-show');
	    }
	  }
	}
	showElementAnimation();


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