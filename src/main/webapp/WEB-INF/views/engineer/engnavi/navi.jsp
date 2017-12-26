<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.sidebar {position: fixed; top: 70px; display: block; padding: 20px; background-color: #f5f5f5; border-right: 1px solid #eee; overflow-x: hidden;
				overflow-y: auto; z-index: 1000; bottom:0; left:0; font-size: 20px; font-weight: bold;}
	h1 {padding-left: 11%;}
	#blank {height: 50px;}
	.navbar {font-weight: bold; font-size: 25px;}
	.container-fluid {padding-top: 5px;}
	#result, #select {border: 1px solid; height: 500px; border-radius: 12px; border-style: outset; border-color: #cccccc; border-width: 4px; padding-top: 20px; font-family: Arial, Helvetica, sans-serif;}
	#logo {width: 200px; height: 66px; padding-top: 10px; padding-bottom: 10px;}
	a:active, a:link, a:visited {text-decoration: none; color: black;}
	.nav {font-size: 25px;}
</style>
<nav class="navbar navbar-inverse">
		  <div class="col-sm-2 text-center"><img id="logo" src="/resources/images/main/image/main log.png"></div>
	  <div class="container-fluid">
	    <ul class="nav navbar-nav">
	    <c:choose>
	    	<c:when test="${loginEngineer.position.id == 'POS-CM' }">
	    	<li class="${menu eq 'notice' ? 'active' :'' }"><a href="/engineer/alert.do">공지사항</a></li>
	    	<li class="${menu eq 'emplist' ? 'active' :'' }"><a href="/engineer/emplist.do">직원 목록</a></li>
            <li class="${menu eq 'accept' ? 'active' :'' }"><a href="/engineer/accept.do">휴가 결제</a></li>
            <li class="${menu eq 'reservestatus' ? 'active' :'' }"><a href="/engineer/reservestatus.do">예약 현황</a></li>
            <li class="${menu eq 'mypage' ? 'active' :'' }"><a href="/engineer/mypage.do">마이 페이지</a></li>
            </c:when>
            <c:otherwise>
            <li class="${menu eq 'notice' ? 'active' :'' }"><a href="/engineer/alert.do">공지사항</a></li>
            <li class="${menu eq 'service' ? 'active' :'' }"><a href="/engineer/reserve.do">서비스 관리</a></li>
            <li class="${menu eq 'mypage' ? 'active' :'' }"><a href="/engineer/mypage.do">마이 페이지</a></li>
            </c:otherwise>
        </c:choose>
	    </ul>
	    <ul class="nav navbar-nav navbar-right">
	      <li><a href="/engineer/main.do"><span class="glyphicon glyphicon-log-in"></span> 로그아웃</a></li>
	    </ul>
	  </div>
	</nav>