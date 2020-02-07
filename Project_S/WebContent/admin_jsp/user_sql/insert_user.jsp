<!-- 選択した選挙区の投票結果画面 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*" %>

<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/style.css">
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

// SQL文を準備
PreparedStatement ps = conn.prepareStatement("INSERT INTO `user` (`ID`, `Password`, `ConstituencyID`, `VoteFlag`, `nickname`, `Age`) VALUES" +
		"('0WlKCB', 'B4hdWc', 22222, 'X-XX', '万 博美', 18)," +
		"('1U1O4j', 'v8cCMr', 33333, '0', '角馬　圭太', 34)," +
		"('2C9025', 'oXciis', 11111, 'X-06', '鬼道 有人', 49)," +
		"('2XCaJU', 'SfSNEN', 11111, 'X-06', '佐久間 次郎', 54)," +
		"('7mzH3r', 'wKcGns', 11111, 'X-06', '不動 明王', 28)," +
		"('8cfiRL', 'Dln467', 11111, '0', '源田 幸次郎', 80)," +
		"('8k3ZDP', 'PHz54I', 22222, 'X-07', '木暮 夕弥', 50)," +
		"('8xOcMf', 'KI1u4a', 11111, 'X-09', '万丈 一道', 60)," +
		"('9llGe0', '0lLe12', 11111, '	X-09', '成神 健也', 39)," +
		"('9TAZjE', 'a62fv4', 11111, 'X-09', '五条 勝', 48)," +
		"('A7ntsv', 'nj5ZjC', 11111, 'X-06', '少林寺 歩', 56)," +
		"('AeD5GG', '72nKyN', 33333, 'X-05', '砂木 沼治', 87)," +
		"('AiF1Sq', 'jvTzQc', 22222, 'X-02', '立向居 勇気', 76)," +
		"('AJx6t4', 'YTTcDI', 22222, 'X-04', '戸田 雄一郎', 75)," +
		"('aYw96E', 'EDdlbA', 11111, 'X-01', '豪炎寺 修也', 47)," +
		"('Az3OX9', 'XCd8nZ', 33333, 'X-05', '冬海 卓', 59)," +
		"('CQWIVv', 'q9hquB', 22222, 'X-04', '綱海 条介', 57)," +
		"('d18dhc', '3Ifx1v', 33333, 'X-05', '響木 正剛', 78)," +
		"('dxAy9X', 'SXUQ3c', 11111, 'X-01', '染岡 竜吾', 86)," +
		"('dZDbj9', 'ijdwcS', 11111, 'X-01', '目金 欠流', 36)," +
		"('eFhrNl', 'uTWiiM', 11111, 'X-01', '土門 飛鳥', 47)," +
		"('ehwzD2', 'oQENaD', 11111, 'X-01', '一之瀬 一哉', 47)," +
		"('ekRK59', 'Jl1NWf', 33333, 'X-03', '吉良 瞳子', 75)," +
		"('EOCdS6', 'OSmgJJ', 22222, 'X-04', '音村 楽也', 69)," +
		"('F4B2MM', '70zLfn', 11111, 'X-06', '宍戸 佐吉', 52)," +
		"('f6qc6W', 'MbTXbU', 33333, 'X-08', '地木流 灰人', 37)," +
		"('fSCxrs', 'AVr1ZP', 22222, 'X-02', '喜屋武 梨花', 92)," +
		"('fV8Cvh', 'UvKkcD', 11111, 'X-01', '松野 空介', 37)," +
		"('gD0NlM', 'RksqwK', 11111, 'X-01', '栗松 鉄平', 32)," +
		"('IkMikl', 'ZCfScO', 33333, 'X-03', '円堂 大介', 34)," +
		"('itwZan', '3X75gO', 11111, 'X-01', '闇野 カゲト', 65)," +
		"('j7GdcI', 'c3pvk5', 22222, '0', '御堂 玲華', 20)," +
		"('j8Wk82', 'k964mw', 11111, 'X-01', '円堂 守', 23)," +
		"('KeEdPY', 'OFqsm8', 11111, 'X-01', '影野 仁', 38)," +
		"('kxUz2S', 'lnTqjH', 33333, 'X-03', '久遠 道也', 43)," +
		"('Lfresn', 'UvInj0', 11111, 'X-01', '半田 真一', 42)," +
		"('Mcc8oC', 'RbwyI8', 33333, 'X-03', '影山 零治', 65)," +
		"('MFZRO6', 'au4QRo', 22222, 'X-07', '亜風炉 照美', 51)," +
		"('MoECs9', 'yHxlSJ', 11111, 'X-01', '風丸 一郎太', 65)," +
		"('mpgss9', 'fido2t', 33333, 'X-03', '二階堂 修吾', 54)," +
		"('N2x37g', 'tXS28x', 22222, 'X-02', '真都路 珠香', 84)," +
		"('Nsjuvl', '24AUhR', 11111, 'X-06', '大野 伝助', 80)," +
		"('nWcI6X', '3boEoN', 22222, 'X-07', '吹雪 士郎', 21)," +
		"('NX4bo2', 'dscwWz', 22222, 'X-XX', '喜多 海流', 71)," +
		"('O223Xr', 'TfrXLD', 11111, 'X-09', '辺見 渡', 96)," +
		"('o4Jqxu', '7T21da', 33333, 'X-08', '如月 まこ', 85)," +
		"('odDY4X', 'Pc4o2G', 22222, 'X-07', '空野 礼文', 36)," +
		"('pccpg3', 'erPhOs', 22222, 'X-07', '荒谷 紺子', 38)," +
		"('PF8VeK', 'udFK3c', 11111, 'X-01', '壁山 塀吾郎', 76)," +
		"('pManNP', 'u58dtR', 22222, 'X-07', '堀 道子', 42)," +
		"('ps1rnw', 'QtSvfy', 22222, 'X-07', '筑紫 国光', 47)," +
		"('PsN9Kv', 'q0ggKz', 33333, 'X-08', '鬼瓦 源五郎', 97)," +
		"('pXbo8V', 'BUOl1A', 33333, 'X-08', '豪炎寺 夕香', 24)," +
		"('r4auvQ', 'OQpF4i', 33333, 'X-08', '角馬 王将', 52)," +
		"('r7Hsqs', 'tOUItp', 33333, 'X-05', '久遠 冬花', 68)," +
		"('s3nFyY', 'hMSTTr', 11111, 'X-09', '神童 拓人', 42)," +
		"('SOhVJY', 'a8AMzK', 33333, 'X-05', '宇都宮 虎丸', 32)," +
		"('SVNCr1', 'E4EViO', 22222, 'X-07', '影田 巡', 48)," +
		"('TLFR71', 'Mny1GB', 11111, 'X-XX', '松風 天馬', 20)," +
		"('uBjOtl', 'rf5gzz', 22222, 'X-07', '浦部 リカ', 30)," +
		"('uETewB', '4fKYAu', 33333, 'X-05', '飛鷹 征矢', 46)," +
		"('Ugqrlp', 'UMBQtu', 11111, 'X-09', '西園 信助', 26)," +
		"('UVJcHu', 'kngLBw', 33333, 'X-05', '緑川 リュウジ', 24)," +
		"('V4M3q1', 'Z8Jc56', 11111, 'X-09', '三国 太一', 62)," +
		"('VHGxZT', 'CkDOSw', 11111, 'X-XX', '剣城 京介', 25)," +
		"('W1IpFJ', 'lIfI3c', 33333, 'X-XX', '基山 ヒロト', 22)," +
		"('XH8a3h', '9WP5Cl', 22222, 'X-07', '氷上 烈斗', 24)," +
		"('yd27Os', '3w1obP', 22222, 'X-04', '円堂 夏美', 67)," +
		"('ZILms3', 'Iy0T3E', 11111, 'X-09', '霧野 蘭丸', 27)," +
		"('ZZMgSY', 'GKOzix', 33333, 'X-XX', '土方 雷電', 24);");
ps.executeUpdate();

ps.close();
conn.close();

%>
<!DOCTYPE>
<html>
<head>
<script>
setTimeout("location.href='../statistics.jsp'",100);
</script>
</head>
</html>
