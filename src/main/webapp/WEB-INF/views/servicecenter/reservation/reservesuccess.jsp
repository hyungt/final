<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.row { margin-top: 30px; }
.cont {width: 1024px;}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/servicecenter/include/navi.jsp" %>
	<div class="container cont">
		<div class="row">
			<div class="jumbotron col-sm-12">
				<h2>예약이 완료되었습니다.</h2>
				<div class="row">
					<p><strong><fmt:formatDate value="${as.reservation }" pattern="yyyy년 MM월 dd일 hh시mm분"/>
					 	${as.center.name } ${as.employee.name} 엔지니어</strong>에게 예약이 완료되었습니다.
					 </p>
					<p><small>※예약시간 10분전 도착하셔서 접수하시면 빠른 서비스를 받아 보실 수 있습니다.</small></p>
					<p><small>※예약시간 10분이 지나면 자동으로 예약은 취소됩니다. 이점 참고하시길 바랍니다.</small> </p>
				</div>
				<div class="row text-center">
					<div class="col-sm-offset-6 col-sm-3"><a href="/home.do" class="btn btn-success">홈으로</a></div>
					<div class="col-sm-3"><a href="/reserve/visitReserve/reserveCheck.do" class="btn btn-success">예약확인</a></div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
</html>