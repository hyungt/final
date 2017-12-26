<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	img {width: 80%; height: 80%;}
</style>
</head>
<body>
    <c:set var="menu" value="reservestatus" />
	<%@ include file="/WEB-INF/views/engineer/engnavi/navi.jsp" %>
   	 <div class="cotainer-fluid">
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<div class="container">
    			<div class="row">
	    			<div class="col-sm-12">
		    			<h1>${loginEngineer.center.name }의 예약 현황</h1>
			            <hr>
        				<table class="table table-hover">
        					<colgroup>
        					</colgroup>
        					<thead>
        						<tr>
        							<th>서비스 번호</th>
        							<th>증상</th>
        							<th>고객명</th>
        							<th>사원이름</th>
        							<th>직급</th>
        							<th>예약일</th>
        							<th>서비스 상태</th>
        							<th>서비스 형태</th>
        						</tr>
        					</thead>
        					<tbody>
        					<c:choose>
        						<c:when test="${Reserve != null }">
		        					<c:forEach var="x" items="${Reserve }">
		        					<tr>
		        						<td>${x.no }</td>
		        						<td>${x.symptom }</td>
		        						<td>${x.user.name }</td>
		        						<td>${x.employee.name }</td>
		        						<td>${x.employee.position.name }</td>
		        						<td><fmt:formatDate value="${x.reservation }"/> </td>
		        						<td>${x.serviceType.name }</td>
		        						<td>${x.serviceStatus.status }</td>
		        					<tr>
			        				</c:forEach>
		        				</c:when>
		        				<c:otherwise>
		        				<tr>
		        					<td colspan="3">예약이 없습니다.</td>
		        				</tr>
		        				</c:otherwise>
		        			</c:choose>
        					</tbody>
        				</table>
        			  </div>
	    	  		</div>
    	  		</div>
    	  	</div>
    	</div>
</body>
<script type="text/javascript">
</script>
</html>