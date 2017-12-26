<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<c:set var="menu" value="board" />
<%@ include file="/WEB-INF/views/manage/common/navi.jsp" %>
<div class="container">
	<h1>게시글</h1>
	
	<table class="table table-condensed">
		<colgroup>
			<col width="10%">
			<col width="40%">
			<col width="10%">
			<col width="40%">
		</colgroup>
		<tbody>
			<tr>
				<th>제목</th><td colspan="3"><c:out value="${board.title }"/></td>
			</tr>
			<tr>
				<th>번호</th><td>${board.no }</td>
				<th>조회수</th><td>${board.count }</td>
			</tr>
			<tr>
				<th></th><td></td>
				<th>등록일</th><td><fmt:formatDate value="${board.createdate }" pattern="yyyy-MM-dd"/> </td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><c:out value="${board.contents }"/></td>
			</tr>
		</tbody>
	</table>
	<div class="text-right">
		<a href="list.do" class="btn btn-primary btn-sm">목록</a>
	</div>
</div>
<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
</html>