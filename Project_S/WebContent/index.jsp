<%@ page language="java" contentType="text/html; charset=UTF-8"
    import = "java.sql.*, javax.naming.*, javax.sql.*"%>

<!DOCTYPE>
<html lang="ja">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

    <title>トップページ - ネット投票所</title>
</head>
<body class="fadeout" style="background-color: #222;">
    <div class="row_top">
        <div class="relative" id="#bg01">
            <video playsinline autoplay muted loop source src="image/walking.mp4" type="video/mp4"></video>
        </div>
        <div class="relative_next relative_next_edge">
                <svg version="1.1" id="title_logo" width= "80%" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
                y="0px" viewBox="0 0 600 120" style="enable-background:new 0 0 600 120;" xml:space="preserve">
                <g transform="translate(0.000000,120.000000) scale(0.100000,-0.100000)">
        <path class="line01" d="M1180,990c0-6,7-24,15-40c13-26,21-30,55-30c46,0,47,3,20,48c-16,26-26,32-55,32C1196,1000,1180,995,1180,990z"/>
        <path class="line01" d="M1390,995c0-2,8-20,17-40c15-31,21-35,55-35c21,0,38,2,38,4s-7,20-15,40c-14,33-19,36-55,36C1408,1000,1390,998,1390,995z"
            />
        <path class="line01" d="M1628,945l-33-55h-267h-268v-35v-35h65c36,0,65-3,65-6s-29-55-65-114s-65-111-65-115c0-3,19-5,42-3l42,3l70,118l71,117h162
            h161l74-116c40-64,78-119,84-121c7-2,28-3,47-1l36,3l-74,115l-75,115l70,3l70,3v34v35h-75c-41,0-75,3-75,8c0,4,11,25,25,47
            c13,22,25,43,25,48c0,4-18,7-39,7C1663,1000,1659,997,1628,945z"/>
        <path class="line01" d="M1887,925c-20-42-37-78-37-80c0-3,16-5,35-5c28,0,37,5,50,30c14,26,21,30,59,30s45-3,50-25c5-21,12-25,46-25
            c38,0,39,1,30,24c-9,24-7,25,33,28c39,3,42,5,45,36l3,32h-106c-91,0-106,2-101,15c4,12-3,15-32,15C1925,1000,1924,998,1887,925z"/>
        <path class="line01" d="M2272,935c-18-36-32-68-32-70c0-3,17-5,38-5c32,0,41,5,50,25s19,25,47,25c31,0,38-4,46-30c9-26,16-30,46-30
            c33,0,34,1,28,30l-7,30h56h56v35v35h-116c-74,0-113,4-109,10s-9,10-32,10C2305,1000,2303,998,2272,935z"/>
        <path class="line01"  d="M514,976c-3-8-4-23-2-33c3-15,15-18,86-21c106-4,108-22,2-22h-80V720h240v70h-90c-83,0-90,1-90,20c0,18,7,20,80,20h80v160
            H630C543,990,518,987,514,976z"/>
        <path class="line01"  d="M784,976c-3-8-4-23-2-33c3-15,16-18,91-21c109-4,115-22,7-22h-80V730h240v60h-90c-83,0-90,2-90,20c0,17,8,19,83,22l82,3
            v150l-118,3C811,990,789,988,784,976z"/>
        <path class="line01"  d="M4855,922l-54,29c-33,18-58,26-64,20c-5-5-37-58-71-118l-62-108l-142-3l-142-3V330h580v410h-30c-16,0-30,3-30,6
            c0,4,15,33,33,66c26,47,36,58,52,54c17-5,126,8,378,45c111,16,91,32,277-223c60-82,66-88,112-98c27-5,53-10,58-10s-295,409-295,409
            l-45-1C5385,988,4855,922,4855,922z M4800,865c18-22-43-125-74-125c-12,0-25,3-28,6c-9,8,65,134,78,134C4782,880,4793,873,4800,865
            z M4830,650c0-19-7-20-220-20s-220,1-220,20s7,20,220,20S4830,669,4830,650z M4830,540c0-19-7-20-220-20s-220,1-220,20s7,20,220,20
            S4830,559,4830,540z M4830,420c0-19-7-20-220-20s-220,1-220,20s7,20,220,20S4830,439,4830,420z"/>
        <path class="line01"  d="M3795,964c-115-6-216-13-222-13c-8-1-13-15-13-37v-37l110,8l110,7v-26v-26h-165h-165v-40v-40h113h112l-95-58l-95-57l67-3
            c65-3,69-1,147,47l80,49l3-61l3-62h35h35l3,63c2,34,5,62,7,62s41-23,88-50c82-50,86-51,153-48l69,3l-95,55l-95,55l103,3l102,3v39
            v40h-165h-165v25c0,0,14,34,130,37l85,3l3,38l3,37l-38-1C4022,978,3911,971,3795,964z"/>
        <path class="line01"  d="M2964,947c-2-7,1-392,1-392l175-6v-89h-150v-70h150v-90h-200v-70h480v70h-210v90h150v69l-145,6l-6,85h181v410
            C3390,960,2968,957,2964,947z M3140,839v-50l-52,3c-52,3-53,4-56,36c-5,54,2,62,58,62h50V839z M3320,839v-50l-52,3
            c-52,3-53,4-56,36c-5,54,2,62,58,62h50V839z M3140,630h-110v90h110V630z M3320,630h-110v90h110V630z"/>
        <path class="line01" d="M2630,905c0-34,1-35,40-35h40V730h-35c-34,0-35-1-35-40s1-40,35-40h35V438l-40-15c-37-15-40-19-40-55c0-21,1-38,3-38
            c1,0,232,85,232,85l3,39c4,42,9,40-65,20c-23-6-23-5-23,85v91h41h40l-3,38c-3,35-5,37-40,40l-38,3v139h45c45,0,45,0,45,35v35h-240
            V905z"/>
        <path class="line01" d="M329,828c17-52,19-53,59-56c48-4,48-3,26,61c-16,46-17,47-59,47h-44L329,828z"/>
        <path class="line01"  d="M2200,795v-25h-330V640h35c31,0,35,3,35,25v25h600v-25c0-22,4-25,35-25h35v130h-330v25c0,23-4,25-40,25S2200,818,2200,795z
            "/>
        <path class="line01" d="M1430,749c-167-22-150-16-150-56v-36l65,5l65,6v-78h-230v-70h230v-70h-311l6-75l305-6v-79h-90v-80h170v159l305,6l6,75h-311
            v70h230v70h-230v88l45,6c43,7,45,9,45,42c0,34-1,34-42,33C1514,758,1466,754,1430,749z"/>
        <path class="line01" d="M5197,718c-2-18-4-34-3-35c3-3,349-73,351-71s5,18,7,37l3,34l-155,33C5202,758,5204,758,5197,718z"/>
        <path class="line01"  d="M640,675c0-22-4-25-40-25c-39,0-40-1-40-35s1-35,40-35s40-1,40-35v-35H499l6-65l268-3l267-2v70H910v35c0,34,1,35,40,35
            s40,1,40,35s-1,35-40,35c-36,0-40,3-40,25s-4,25-35,25s-35-3-35-25c0-24-2-25-65-25s-65,1-65,25c0,22-4,25-35,25S640,697,640,675z
             M840,510H710v70h130V510z"/>
        <path class="line01" d="M280,590h100V372l-50-37c-48-35-50-38-50-86v-50c0,0,136,101,139,101c4,0,85-80,85-80h556v40v40H534l-74,76v294H280V590z"
            />
        <path class="line01" d="M2010,220h480v210c0,0-410,2-410,15c0,12,30,15,188,17l187,3l6,195h-451V220z M2380,565v-25h-150h-150v25v25h150h150V565z
             M2420,325v-35h-170h-170v35v35h170h170V325z"/>
        <path class="line01" d="M5019,595c-1-14-2-30-3-37s31-19,82-29c45-9,85-19,88-22s-29-51-71-106c-48-64-71-103-63-105c7-2,81-14,163-26
            c275-41,263-37,267-73c3-28,8-33,40-41c21-5,40-7,43-4c7,6-24,211-33,220c-4,3-23,8-42,10c-34,3-35,2-32-33l3-35l-133,21
            c-93,15-132,25-130,34c3,16,82,121,91,121c3,0,89-18,191-39c102-22,188-36,191-33c7,8,20,72,15,72c-2,0-146,29-319,65
            s-322,65-331,65C5026,620,5019,611,5019,595z"/>
        <path class="line01" d="M3667,560c-5-18-14-20-116-20h-111v-40v-40h95c52,0,95-2,95-5s-7-22-15-42c-18-42-19-63-4-63c6,0,36-8,67-17l57-17l-105-20
            l-105-21l-3-39c-3-36-2-38,20-33c13,3,100,19,193,37l170,32c0,0,224-57,228-53c5,5,7,21,5,37c-3,27-9,30-88,52c-47,13-86,25-87,26
            c-2,1,51,125,51,125l191,6v35v35l-232,3c-225,2-231,3-226,22c5,18,0,20-35,20C3681,580,3671,576,3667,560z M3930,455
            c0-13-45-95-53-95c-12,0-170,41-179,46c-4,3-2,16,4,29c11,24,14,25,120,25C3881,460,3930,458,3930,455z"/>
        <path class="line01" d="M604,398c-4-7-14-23-22-35c-14-23-14-23,31-23c41,0,47,3,66,35l20,35h-44C631,410,608,404,604,398z"/>
        <path class="line01" d="M882,375c20-31,28-35,66-35c23,0,42,3,42,6s-9,19-21,35c-17,25-27,29-65,29h-44L882,375z"/>
        <path class="line01" d="M4342,260c-12-16-22-32-22-35s23-5,51-5c52,0,63,6,90,53c9,15,4,17-44,17C4370,290,4361,287,4342,260z"/>
        <path class="line01" d="M4789,258c18-30,25-33,76-36l56-3l-23,35c-22,34-26,36-76,36h-54L4789,258z"/>
    </g>
            </svg>
            <br>
            <p class="text-center titlesub_text">あなたの一票が未来を変える</p><br />
            <a href="login.html" class="cp_btn">投票する</a>

        </div>
	</div>
	<div class="content_line" style="background-color: #fff;">
           <br />
               <h1 class="parentheses">選挙管理委員会とは</h1>
           <br /><br />
               市長選挙や町議会議員選挙など、様々な地域の選挙を簡単に投票できるようになっております。<br />ご利用は下部のログインページからご利用ください。
   		<br /><br /><br />
   	</div>
   	<br /><br />
	<div class="content_line" style="background-color: #fff;">
           <br />
               <h1 class="parentheses">立候補者紹介</h1>
               <div class="sa sa--lr">
					<table style="width:100%">
					<tr><td rowspan="3"><img src="image/human_image/icon_01.png"></td><td style="font-size:32px; font-weight: bold;">向井 充</td></tr>
					<tr><td style="font-size:24px; font-weight: bold;">java党</td></tr>
					<tr><td>java党党首。強い出世意欲の持ち主。前職の保険業界の営業においては、同僚を強制的に担当する保険プランに加入させ、驚異の数字を叩き出してきた。<br>
					掲げる公約は、現在の生活保護費をなくし、その財源で闇金融会社を設立することだ。</td></tr>
					</table>
				</div>
				<div class="sa sa--rl">
					<table style="width:100%;text-align:end;">
					<tr><td style="font-size:32px; font-weight: bold;text-aligen:end;">蓮見 雅樹</td><td rowspan="3"><img src="image/human_image/icon_02.png"></td></tr>
					<tr><td style="font-size:24px; font-weight: bold;text-aligen:end;">java党</td></tr>
					<tr><td style="text-aligen:end;">血の気が多い性格。高速道路にて後ろの車に追い越された際には必ず、クラッシュするまで追跡をやめない。<br>
					今までクラッシュさせてきた車はおよそ１０００台に上るといわれている。</td></tr>
					</table>
				</div>
				<div class="sa sa--lr">
					<table style="width:100%">
					<tr><td rowspan="3"><img src="image/human_image/icon_11.png"></td><td style="font-size:32px; font-weight: bold;">石澤 千晴</td></tr>
					<tr><td style="font-size:24px; font-weight: bold;">java党</td></tr>
					<tr><td>表向きは穏便な性格。反面、夫には暴力的な言動を行い訴えられたこともある。だが、彼女にとっては暴力は愛情表現の一つでもあるのだ。<br>
					大きな性格のギャップに魅了された市民は、今回のダークホースとして期待しているらしい。</td></tr>
					</table>
				</div>
				<div class="sa sa--rl">
					<table style="width:100%;text-align:end;">
					<tr><td style="font-size:32px; font-weight: bold;text-aligen:end;">荻野 正幸</td><td rowspan="3"><img src="image/human_image/icon_04.png"></td></tr>
					<tr><td style="font-size:24px; font-weight: bold;text-aligen:end;">java党</td></tr>
					<tr><td style="text-aligen:end;">初めて台湾から日本にタピオカミルクティーを持ち帰り、昨今のタピオカブームをもたらした男。<br>
					彼の先見の明はタピオカのみにはとどまらないだろう。掲げる公約はキャッサバの関税をなくすことだ。</td></tr>
					</table>
				</div>
				<div class="sa sa--lr">
					<table style="width:100%">
					<tr><td rowspan="3"><img src="image/human_image/icon_13.png"></td><td style="font-size:32px; font-weight: bold;">服部 佳実</td></tr>
					<tr><td style="font-size:24px; font-weight: bold;">python党</td></tr>
					<tr><td>職場で冷静沈着な議員。どんな時でもクールでさわやかである。それの反動からか家庭では夫にぞっこんのようである。<br>
					そう、デレデレなのである。</td></tr>
					</table>
				</div>
				<div class="sa sa--rl">
					<table style="width:100%;text-align:end;">
					<tr><td style="font-size:32px; font-weight: bold;text-aligen:end;">岡部 咲子</td><td rowspan="3"><img src="image/human_image/icon_12.png"></td></tr>
					<tr><td style="font-size:24px; font-weight: bold;text-aligen:end;">python党</td></tr>
					<tr><td style="text-aligen:end;">java党党首に惹かれている。前職は探偵に勤めていたため、持ち前の技量で党首をストーカーすることは間違いないであろう。<br>掲げる公約は向井充との結婚である。</td></tr>
					</table>
				</div>
				<div class="sa sa--lr">
					<table style="width:100%">
					<tr><td rowspan="3"><img src="image/human_image/icon_15.png"></td><td style="font-size:32px; font-weight: bold;">水樹 真明</td></tr>
					<tr><td style="font-size:24px; font-weight: bold;">c+党</td></tr>
					<tr><td>人情に厚い。学生時代においては、よく横断歩道を渡るおばあちゃんの荷物の持ち運びを手伝っていたらしい。<br>
					そのため、遅刻することが多々あったようだ。掲げる公約は、’時間厳守’という言葉の廃絶である。</td></tr>
					</table>
				</div>
				<div class="sa sa--rl">
					<table style="width:100%;text-align:end;">
					<tr><td style="font-size:32px; font-weight: bold;text-aligen:end;">向井 寛二</td><td rowspan="3"><img src="image/human_image/icon_06.png"></td></tr>
					<tr><td style="font-size:24px; font-weight: bold;text-aligen:end;">c+党</td></tr>
					<tr><td style="text-aligen:end;">充の弟。沖縄県が出身地ではあるが、父が北九州市への縁があるため、幼少期の頃から現在に至るまで北九州市で育つ。<br>
					先日、家が火災に遭い悲しみに暮れていたが、自動販売機の下の部分から5円が出てきたことにより悲しみは吹っ切れたらしい。</td></tr>
					</table>
				</div>
				<div class="sa sa--lr">
					<table style="width:100%">
					<tr><td rowspan="3"><img src="image/human_image/icon_07.png"></td><td style="font-size:32px; font-weight: bold;">島田 浩平</td></tr>
					<tr><td style="font-size:24px; font-weight: bold;">c+党</td></tr>
					<tr><td>２人兄弟の弟。よく近所のスーパーにて、洗剤と豆腐を万引きする。自身もそうだが、母、父、兄ともに万引きによって一度捕まっている。<br>
					近隣住民によると一家は通称、「万引き家族」と呼ばれ親しまれている。公約は福岡市民へのベーシックインカム。</td></tr>
					</table>
				</div>
				<div class="sa sa--rl">
					<table style="width:100%;text-align:end;">
					<tr><td style="font-size:32px; font-weight: bold;text-aligen:end;">中島 満</td><td rowspan="3"><img src="image/human_image/icon_08.png"></td></tr>
					<tr><td style="font-size:24px; font-weight: bold;text-aligen:end;">c+党</td></tr>
					<tr><td style="text-aligen:end;">以前はガス管理会社に勤めていたが、度重なる上司のパワハラにより退職を決意。退職後は、新たな仕事を探すも中々見つからない。<br>
					何とか社会へ貢献したいという思いで一念発起し今回の市議会選に産声をあげた。掲げる公約はギャンブルによる配当金を2倍にすることだ。</td></tr>
					</table>
				</div>

				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	</div>

<script>
var scrollAnimationElm = document.querySelectorAll('.sa');
var scrollAnimationFunc = function() {
  for(var i = 0; i < scrollAnimationElm.length; i++) {
    var triggerMargin = 300;
    if (window.innerHeight > scrollAnimationElm[i].getBoundingClientRect().top + triggerMargin) {
      scrollAnimationElm[i].classList.add('show');
    }
  }
}
window.addEventListener('load', scrollAnimationFunc);
window.addEventListener('scroll', scrollAnimationFunc);
</script>
</body>
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
</script>
</html>