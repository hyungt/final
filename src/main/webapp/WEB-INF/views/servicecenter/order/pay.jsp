<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
div.container {
	max-height: 1024px;
}
</style>
</head>
<body>
<%@ include file="../include/navi.jsp" %>
<div class="container">
	<div class="row">
			<a href=""><span class="label label-default">1. 주문서 작성<span class="glyphicon glyphicon-shopping-cart"></span></span></a>
			 > 
			<a href=""><span class="label label-default">2. 결제<span class="glyphicon glyphicon-usd"></span></span></a>
			 > 
			<a href=""><span class="label label-primary">3. 주문완료<span class="glyphicon glyphicon-gift"></span></span></a>
	</div>
	<div class="row">
		<h2>결제가 완료되었습니다.</h2>
	</div>
	<div class="row well">
		<table class="table table-condensed">
			<tr>
				<th>주문번호</th>
				<td>${order.no }</td>
			</tr>
			<tr>
				<th>결제 방식</th>
				<td>카드 결제</td>
			</tr>
			<tr>
				<th>받는 사람</th>
				<td>${order.recipient }</td>
			</tr>
			<tr>
				<th>배송지</th>
				<td>${order.address }</td>
			</tr>
			<tr>
				<th>구매 제품</th>
				<td>${order.part.name }</td>
			</tr>
			<tr>
				<th>주문수량</th>
				<td>${order.count }</td>
			</tr>
			<tr>
				<th>결제 금액</th>
				<td>${order.purchase }</td>
			</tr>
		</table>
	</div>
	<div class="row text-right">
		<a href="/order/list.do" class="btn btn-info">목록</a>
	</div>
</div>
</body>
</html>