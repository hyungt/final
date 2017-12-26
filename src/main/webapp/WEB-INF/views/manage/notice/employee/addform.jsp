<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div class="container">
		<h1>글 작성</h1>
		<form method="post" action="add.do">
			<div class="form-group">
				<label>제목</label>
				<input type="text" class="form-control" id="title" name="title">
			</div>
			<div class="form-group">
				<label>내용</label>
				<textarea row="7" class="form-control" id="contents" name="contents"></textarea>
			</div>
			<div class="form-group text-right">
				<button type="submit" class="btn btn-primary btn-sm">저장</button>
				<a href="list.do" class="btn btn-default btn-sm">돌아가기</a>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
</html>