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
</head>
<body>
<%@ include file="/WEB-INF/views/servicecenter/include/navi.jsp" %>

	<div class="container">
		<div class="row">
			<h1>${loginUser.name }님의 예약 내역</h1>
			<table class="table table-condensed">
				<thead>
					<tr>
						<th>예약번호</th>
						<th>증상</th>
						<th>예약일</th>
						<th>담당자</th>
						<th>센터</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${reserveCheck != null }">
							<c:forEach var="check" items="${reserveCheck }">
								<tr>
									<td>${check.no }</td>
									<td>${check.symptom }</td>
									<td><fmt:formatDate value="${check.reservation }"/></td>
									<td>${check.employee.name }</td>
									<td>${check.center.name }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5">예약 내역이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>				
			</table>
		</div>
	</div>   
	
	<div class="footer">
                  	<div class="text-center">
                        <ul class="pagination">
                        	<c:if test="${navi.totalRows gt 0 }">
								<c:choose>
									<c:when test="${navi.pageNo gt 1 }">
										<li><a href="/reserve/visitReserve/reserveCheck.do?pageNo=${navi.pageNo - 1 }">&lt;</a></li>
									</c:when>
									<c:otherwise>
										<li class="disabled"><span>&lt;</span></li>
									</c:otherwise>
								</c:choose>
								<c:forEach var="p" begin="${navi.beginPage }" end="${navi.endPage }">
									<li class="${navi.pageNo eq p ? 'active' : '' }"><a href="/reserve/visitReserve/reserveCheck.do?pageNo=${p }">${p }</a></li>
								</c:forEach>
								<c:choose>
									<c:when test="${navi.pageNo lt navi.totalPages }">
									<li><a href="/reserve/visitReserve/reserveCheck.do?pageNo=${navi.pageNo + 1 }">&gt;</a></li>
									</c:when>
									<c:otherwise>
										<li class="disabled"><span>&gt;</span></li>
									</c:otherwise>
								</c:choose>
							</c:if>
                        </ul>
                    </div>
                  </div> 
   
   <%@include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
</html>