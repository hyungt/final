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
		<h1>운영자 업로드</h1>
		<form method="post" action="add.do">
			<div class="form-group">
				<label>제목</label>
				<input type="text" class="form-control" name="title">
			</div>
			<div class="form-group">
				<label>내용</label>
				<textarea row="8" class="form-control" id="contents" name="contents"></textarea>
			</div>
			<div class="form-group">
				<label>구분 직접 집어넣기</label>
				<input type="text" class="form-control" name="division">					
			</div>
			<div class="form-group">
				<label>구분</label>
				<select id="" class="form-control" name="">
					<option value="">주변기기</option>
					<option value="">냉장고</option>
					<option value="">세탁기</option>
					<option value="">청소기</option>
					<option value="">텔레비젼</option>
					<option value="">에어컨</option>
					<option value="">스마트워치</option>
					<option value="">노트북</option>
					<option value="">VR기기</option>
					<option value="">스마트폰</option>
					<option value="">태블릿</option>
					<option value="">데스크탑</option>
					<option value="">이어폰</option>
					<option value="">스피커</option>
					<option value="">헤드셋</option>
				</select>
			</div>
			<div class="form-group">
				<label>첨부</label>
				<input type="file" class="form-control" id="attachfile" name="attachfile">
			</div>
			<div class="form-group text-right">
				<a href="list.do" class="btn btn-default btn-sm">돌아가기</a>
				<button type="submit" class="btn btn-primary btn-sm" id="btn-add-board">업로드</button>
			</div>
		</form>
	</div>
</body>
</html>