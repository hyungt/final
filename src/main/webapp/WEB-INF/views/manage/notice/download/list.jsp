<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8">
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="pragma" content="no-store"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Expires" content="-1"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script type="text/javascript" src="/resources/SmartEditor2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" ></script>
</head>
<style>
	div.container {max-width: 1024px;}
</style>
<body>
<div class="container">
	<div class="row">
		<div class="col-sm-6">
			<h1>운영자 다운로드 게시판</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<form id="form-select" class="form-inline pull-right" action="*.do">
				<input type="hidden" name="" value=""/>
				<div class="form-group">
					<label class="sr-only">셀렉트 박스</label>
					<select id="" class="form-control" name="">
						<option value="">모바일</option>
						<option value="">전자제품</option>
						<option value="">기타</option>
					</select>
					<select id="" class="form-control" name="">
						<option value="">휴대폰</option>
						<option value="">기어</option>
						<option value="">컴퓨터</option>
						<option value="">프린터</option>
					</select>
				</div>
			</form>
		</div>
	</div>
	<div class="row">
		<table class="table table-condensed">
			<colgroup>
				<col width="20%">
				<col width="40%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>제목</th>
					<th>내용</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>첨부</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>스마트폰 SW</td>
					<td>스마트폰 간 데이터 이동</td>
					<td>2017-11-22</td>
					<td>559</td>
					<td><a href="" class="btn btn-primary btn-xs">스마트 스위치</a></td>
				</tr>
				<tr>
					<td>스마트폰 SW</td>
					<td>Note시리즈 note app 업데이트</td>
					<td>2017-11-22</td>
					<td>459</td>
					<td><a href="" class="btn btn-primary btn-xs">SNote</a></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row text-right">
		<a href="addform.do" class="btn btn-primary btn-sm">업로드</a>
	</div>
</body>
<script type="text/javascript">
</script>
























</html>