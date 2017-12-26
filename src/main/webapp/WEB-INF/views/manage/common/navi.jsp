<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-static-top navbar-default">
	<div class="container">
		<c:if test="${loginedHR.department.id eq 'DEPT-HR' }">
			<div class="navbar-header ">
				<a class="navbar-brand" href="#"><strong>인사</strong></a>
			</div>
			<ul class="nav navbar-nav">
				<li class=""><a href="/manage/personnel/main.do"><strong>홈</strong></a></li>
				<li><a href="/manage/personnel/emplist.do"><strong>직원 명부</strong></a></li>
				<li><a href="/manage/personnel/hoildayPer.do"><strong>휴가자 현황</strong></a></li>
				<li><a href="/manage/personnel/apply.do"><strong>휴가 신청 현황</strong></a></li>
				<li><a href="/manage/personnel/form.do"><strong>직원 등록</strong></a></li>
			</ul>
		</c:if>
		<c:if test="${loginedHR.department.id eq 'DEPT-FIN' }">
			<div class="navbar-header ">
			<a class="navbar-brand" href="/manage/finance/main.do"><strong>재무</strong></a>
		</div>
		<ul class="nav navbar-nav active">
			<li class=""><a href="/manage/finance/main.do">메인 페이지</a></li>
			<li><a href="/manage/finance/payAnalysis.do">수입/지출 분석</a></li>
			<li><a href="/manage/finance/inputPay.do">월급 지급</a></li>
		</ul>
		</c:if>
		<c:if test="${loginedHR.department.id eq 'DEPT-INVEN' }">
			<div class="navbar-header ">
				<a class="navbar-brand" href="/manage/part/main.do"><strong>물류</strong></a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="/manage/part/main.do"><strong>홈</strong></a></li>
				<li><a href="/manage/part/partList.do"><strong>물품 재고 현황</strong></a></li>
				<li><a href="/manage/part/partStock.do"><strong>부품 입고</strong></a></li>
				<li><a href="/manage/part/partAdd.do"><strong>새 부품 등록</strong></a></li>
				<li><a href="/manage/part/deliveryManage.do"><strong>배송 처리</strong></a></li>
			</ul>
		</c:if>
		<c:if test="${loginedHR.department.id eq 'DEPT-ADMIN' }">
		<div class="navbar-header ">
			<a class="navbar-brand" href="#"><strong>운영팀</strong></a>
		</div>
		<ul class="nav navbar-nav">
			<li class=""><a href="/manage/dayResult.do"><strong>홈</strong></a></li>
			<li class="dropdown active"><a class="dropdown-toggle"
				data-toggle="dropdown" href="/notice/employee/list.do"><strong>공지사항 관리</strong><span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="/manage/notice/employee/list.do">사내용</a></li>
					<li><a href="/manage/notice/customer/list.do">고객용</a></li>
				</ul></li>
			<li><a href="/manage/suggestion/list.do"><strong>건의사항 답변</strong></a></li>
			<li><a href="/manage/upload.do"><strong>다운로드 게시판 관리</strong></a></li>
			<li><a href="/manage/dayResult.do"><strong>일일 결산</strong></a></li>
		</ul>
		</c:if>
		<ul class="nav navbar-nav navbar-right">
				<c:if test="${loginedHR.department.id eq 'DEPT-INVEN' or loginedHR.department.id eq'DEPT-ADMIN' or loginedHR.department.id eq 'DEPT-HR' or loginedHR.department.id eq'DEPT-FIN' }">
    				<li><a href="/manage/personnel/changeInfoEmp.do">프로필 수정</a></li>
    			</c:if>
   			<li><a href="/manage/logout.do"><span class="glyphicon glyphicon-log-out">로그아웃</span></a></li>
 	  		</ul>
	</div>
</nav>