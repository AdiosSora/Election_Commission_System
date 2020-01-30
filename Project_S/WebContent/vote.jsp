<%@ page language="java" contentType="text/html; charset=UTF-8"
    import = "java.sql.*, javax.naming.*, javax.sql.*,election.ParameterBox"%>

<%
	Connection conn = null;

	Class.forName("com.mysql.jdbc.Driver");

	conn = DriverManager.getConnection("jdbc:mysql://localhost/election",//接続するDB
									   "root", //ユーザ
									   "kcsf" ); //パスワード
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>投票ページ - ネット投票所</title>

  	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  	<link href="css/radio.css" rel="stylesheet">
  	<link href="css/animate.css" rel="stylesheet">
</head>
<header></header>
<body class="fadeout">
	<br />
	<div class="page-header animated infinite fadeInLeft">
	    <h1 class="vote_titlebar animated infinite zoomInDown"> <%= ParameterBox.getDistrictName() %>　 <%= ParameterBox.getnickname() %> 様</h1>
	</div>
	<br />
	<div class="row">
		<div class="col-sm"></div>
		<div class="col-4-sm">
			<form name="myform" action="vote_check.jsp">
			<div>
				<h3 class="element js-animation">　候補者を選択してください</h3>
				<% String vflag;
				PreparedStatement ps5 = conn.prepareStatement("SELECT * from candidate where ConstituencyID = ?");
				ps5.setInt(1,ParameterBox.getConstituencyID() );
				ResultSet rs5;
				rs5 = ps5.executeQuery();//選挙区IDに対応した候補者名を取得し配列に保存する
				while(rs5.next()){
					String nameID =rs5.getString("CandidateID");
					%>
					<div class="element js-animation">
						<input type="radio" name="candidate" value="<%out.print(nameID);%>" id="<%out.print(nameID);%>vote">
						<label for="<%out.print(nameID);%>vote" class="label_vote">
							<table align="left" style="margin: 0 20px">
								<tr>
									<td rowspan="2"><img src="<%out.print(rs5.getString("Imagepass"));%>" width="128px" height="128px" alt="<%out.print(rs5.getString("Imagepass"));%>"/></td>
									<td rowspan="2">　　　　</td>
									<td><span class="candidate_name"><%out.print(rs5.getString("CandidateName")+"\n");%></span></td>
								</tr>
								<tr>
									<td style="font-size:24px;text-align:center;"><%out.print(rs5.getString("Politicalparty")+"\n");%></td>
								</tr>
							</table>
						</label>
					</div>
				<%


				}
			rs5.close();
			ps5.close();
			conn.close();%>
					<div class="element js-animation">
						<input type="radio" name="candidate" value="0" id="0vote">
						<label for="0vote" class="label_vote">
							<table align="left" style="margin: 0 20px">
								<tr>
									<td rowspan="2"><img src="image/human_image/icon_99.png" width="128px" height="128px" alt="icon_99.png"/></td>
									<td rowspan="2">　　　　</td>
									<td><span class="candidate_name">無記名</span></td>
								</tr>
								<tr>
									<td></td>
								</tr>
							</table>
						</label>
					</div>
			<br>
			</div>
			   <input type="hidden" name="candidate" value="確認する">
			</form>
		</div>
		<div class="col-sm"></div>
	</div>
	<div style="dispay:inline-block; text-align:center; margin:20px 0;">
             <a class="btn btn-dark" href="javascript:myform.submit()" >確認</a>
	</div>

<script>
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
</script>
</body>
</html>