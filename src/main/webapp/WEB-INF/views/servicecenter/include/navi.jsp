<%@ page pageEncoding="UTF-8"%>
<style type="text/css">
	.navbar {height: 83px; font-size: 20px; z-index: 15; position: relative; border-bottom: 1px solid; border-color: #b3b3b3; margin-bottom: 0px;}
	#blank {height: 17px;}
	#navbar {padding-bottom: 9px;}
	li .m2 {z-index: 10; position: absolute; font-weight: bold;}
	#m2 {padding-top: 20px; background-color: white;}
	li {list-style: none;}
	#navbar li a {text-align: center;} 
	#logo {font-weight: bold; font-size: 30px; color: #0F4DA0;}
	#detail-navbar {z-index: 10; position: absolute; width: 100%; background-color: white; opacity: 0.97;}
	#detail-navbar li a {text-align: center; position: relative; color: black; font-size: 16px;}
	#detail-navbar li  {line-height: 40px; text-align: center; margin-right: 10px;}
	a:active, a:link, a:visited {text-decoration: none;} 
	#good {border-right: 1px ridge; border-color:#cccccc;}
	#listheader {font-weight: bold; font-size: 17px;}
</style>

<nav class="navbar">
	<div class="col-sm-12" id="blank"></div>
	  <div class="container" id="navbar">
	    <div class="container" id="myNavbar">
	    	<div class="row">
		      <ul class="nav navbar-nav col-sm-10">
		        <li class="col-sm-3"><a href="/servicecenter/notice/download/list.do" class="m2">다운로드</a></li>
		        <li class="col-sm-3"><a href="/reserve/visitReserve/reserveView.do" class="m2">서비스 신청/안내</a></li>
		        <li class="col-sm-3"><a href="/home.do" class="m2" id="logo">ESElectronics</a></li>
		        <li class="col-sm-3"><a href="/user/list.do" class="m2">공지사항</a></li>
		      </ul>
		      
	      
	      <ul class="nav navbar-nav navbar-right col-sm-2">
	      <c:choose>
	    	<c:when test="${loginUser == null }">
		        <li><a href="/user/registe.do"><span class="glyphicon glyphicon-user"></span></a></li>
		        <li><a href="/user/login.do"><span class="glyphicon glyphicon-log-in"></span></a></li>
	        </c:when>
            <c:otherwise>
                <li><a href="/user/userMyPage.do"><img src="/resources/images/main/usermypage/mypage.PNG"></a></li>
                <li><a href="/user/logout.do"><span class="glyphicon glyphicon-share"></span></a></li>
            </c:otherwise>
        </c:choose>
	      </ul>
	      </div>
	    </div>
	  </div>
<div class="container-fluid" id="detail-navbar">
	<div class="container">
		<div class="col-sm-12" id="blank"></div>
		<div class="row col-sm-10">
			<div class="col-sm-4" id="good">
				<ul>
					<li id="listheader"><span class="glyphicon glyphicon-chevron-right"></span> 빠른 해결지원</li>
					<li><a href="/reserve/visitReserve/reserveView.do">방문예약</a></li>
					<li><a href="/reserve/visitReserve/reserveCheck.do">예약확인</a></li>
				</ul>
			</div>
			<div class="col-sm-4" id="good">
				<ul>
					<li id="listheader"><a href="/servicecenter/notice/download/list.do?category=all"><span class="glyphicon glyphicon-chevron-right"></span> 다운 로드</a></li>
					<li><a href="/servicecenter/notice/download/list.do?category=smartPhone">스마트폰</a></li>
					<li><a href="/servicecenter/notice/download/list.do?category=notebook">노트북</a></li>
					<li><a href="/servicecenter/notice/download/list.do?category=deTop">데스크탑</a></li>
				</ul>
			</div>
			<div class="col-sm-4" id="good">
				<img alt="" src="/resources/images/order/phoneimg.jpg" style="width: 230px; height: 230px;">
			</div>
		</div>
		<div class="col-sm-2">
			<ul>
				<li id="listheader"><a href="/order/list.do"><span class="glyphicon glyphicon-chevron-right"></span> 소모품구매</a></li>
				<li><a href="/order/list.do">전체</a></li>
				<li><a href="/order/list.do?categoryId=CAT-WE">웨어러블 기기</a></li>
				<li><a href="/order/list.do?categoryId=CAT-SD">음향 기기</a></li>
				<li><a href="/order/list.do?categoryId=CAT-PH">모바일</a></li>
				<li><a href="/order/list.do?categoryId=CAT-COM">컴퓨터</a></li>
				<li><a href="/order/list.do?categoryId=CAT-AP">생활가전</a></li>
			</ul>
		</div>
		<div class="col-sm-12" id="blank"></div>
	</div>
</div>
</nav>

<script type="text/javascript">
$(function () {
	$('#detail-navbar').hide();
	
	$('#myNavbar').mouseenter(function () {
		$('#detail-navbar').show();
	})
	$('#detail-navbar').mouseleave(function () {
		$('#detail-navbar').hide();
	})
	
})
</script>