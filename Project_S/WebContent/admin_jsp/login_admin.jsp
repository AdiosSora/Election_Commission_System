<%@ page language="java" contentType="text/html; charset=UTF-8"
    import = "java.sql.*, javax.naming.*, javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>監理者ログイン - ネット投票所</title>

  <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
  <link rel="stylesheet" type="text/css" href="../css/style.css">
  <style type="text/css">
  .bs-component + .bs-component {
    margin-top: 1rem;
  }
  @media (min-width: 768px) {
    .bs-docs-section {
      margin-top: 8em;
    }
    .bs-component {
      position: relative;
    }
    .bs-component .modal {
      position: relative;
      top: auto;
      right: auto;
      bottom: auto;
      left: auto;
      z-index: 1;
      display: block;
    }
    .bs-component .modal-dialog {
      width: 90%;
    }
    .bs-component .popover {
      position: relative;
      display: inline-block;
      width: 220px;
      margin: 20px;
    }
    .nav-tabs {
      margin-bottom: 15px;
    }
    .progress {
      margin-bottom: 10px;
    }
  }
  </style>
</head>
<header>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
      <a class="navbar-brand" href="../index.jsp">
        <img src="../image/Logo_white_outline.png" alt="選挙管理委員会ロゴ">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="index.jsp">Top <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              選挙とは
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="./bootstrap-ja.html">選挙の仕組み</a>
              <a class="dropdown-item" href="./bootstrap.html">立候補者一覧</a>
            </div>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="login.jsp">ログイン</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="login_admin.jsp">管理</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>
<br />
<body>
<div class="container">
    <div class="row">
        <div class="col"></div>
        <div class="col-6">
            <form method="POST" action="Auth_admin.jsp">
                <fieldset>
                    <div class="form-group">
                        <legend>管理者ログイン認証</legend>
                        <label for="exampleInputEmail1">ID</label>
                        <div class="col-xs-5">
                            <input type="text" class="form-control" id="InputID" name="userID" placeholder="IDを入力してください。">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>パスワード</label>
                        <div class="col-xs-5">
                            <input type="password" class="form-control" id="InputPassword" name="password" placeholder="パスワードを入力してください。">
                            <div class="form-check">
                            <label class="form-check-label">
                            <input class="form-check-input" type="checkbox" id="password-check">
                            パスワードを表示する。
                            </label>
                            </div>
                        </div>
	                    <script>
	                    const pwd = document.getElementById('InputPassword');
	                    const pwdCheck = document.getElementById('password-check');
	                    pwdCheck.addEventListener('change', function() {
	                    	if(pwdCheck.checked) {
	                    		pwd.setAttribute('type', 'text');
	                    		} else {
	                    			pwd.setAttribute('type', 'password');
	                    			}
	                    	}, false);
	                    </script>
                    </div>
                    <button onclick="clickEvent()" class="btn btn-primary">ログイン</button>
                </fieldset>
            </form>
        </div>
        <div class="col"></div>
    </div>
    <br />
</div>


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="./js/bootstrap.min.js"></script>

<script type="text/javascript">
  $('.bs-component [data-toggle="popover"]').popover();
  $('.bs-component [data-toggle="tooltip"]').tooltip();

  $('#anti-yu-gothic-button').on('click', function() {
    if ( $('body').hasClass('no-thank-yu') ) {
      $('body').removeClass('no-thank-yu');
      $(this).text('游ゴシックを無効にする').removeClass('btn-primary').addClass('btn-danger');
      $("#anti-yu-gothic-message").html('現在デモページは游ゴシックの指定が<span class="text-primary">有効</span>になっています。');
    }
    else {
      $('body').addClass('no-thank-yu');
      $(this).text('游ゴシックを有効にする').removeClass('btn-danger').addClass('btn-primary');
      $("#anti-yu-gothic-message").html('現在デモページは游ゴシックの指定が<span class="text-danger">無効</span>になっています。');
    }
  });
</script>
</body>
<footer style="background-color:#dddddd;text-align: center;">
    <br />
    © 2019 選挙管理委員会
    <br />
</footer>
</body>
</html>