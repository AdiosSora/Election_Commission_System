<!-- ログイン成功、選挙区選択画面 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>

<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/style.css">



<html>
<head>
<meta charset="UTF-8">
<title>プレビュー</title>
</head>
<body>
<div class="row min_window" >
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
<div class="col-10">
	<br>
<div class="page-header">
	<h1 style="border-bottom: 1px solid #eee;">選挙管理画面</h1>
</div>
<div>
	<iframe src="../index.html" width="100%" height="100%"></iframe>
</div>
</div>
</div>
</body>
</html>


