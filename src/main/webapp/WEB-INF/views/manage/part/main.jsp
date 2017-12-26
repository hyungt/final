<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../commons/jstl.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>물류 메인 페이지</title>
<style type="text/css">
div.container {
    max-height: 1024px;
}
.notice-list {
	cursor: pointer;
}
#result, #select {
	border: 1px solid; height: 500px; border-radius: 12px; 
	border-style: outset; border-color: #cccccc; 
	border-width: 4px; padding-top: 20px; 
	font-family: Arial, Helvetica, sans-serif;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
<div class="container">
	<div class="row">
		<h1>공지 사항</h1>
		<hr/>
	</div>
	<div class="row">
		<form id="form-search" action="/manage/finance/main.do">
		<input type="hidden" name="pageNo" value="${param.pageNo }" />
		</form>
		<div id="select" class="col-sm-6">
			<div class="row">
				<table class="table table-condensed">
					<colgroup >
						<col width="70%">
						<col width="30%">
					</colgroup>
					<thead>
						<tr>
							<th>제목</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="noti" items="${notis }">
							<tr>
								<td class="notice-list" id="notice-id-${noti.no}">${noti.title }</td>
								<td><fmt:formatDate value="${noti.createdate }" pattern="yyyy-MM-dd"/></td>
							</tr>
					    </c:forEach>
					</tbody>
				</table>
				<%@ include file="/WEB-INF/views/manage/notice/include/pagination.jsp" %>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="row">
 				<div class="col-sm-12" id="result"  style="height: 500px; overflow: auto;">
	  				<table id="notice-table" class="table table-condensed">
	  					<colgroup>
							<col width="10%">
							<col width="40%">
							<col width="10%">
							<col width="40%">
						</colgroup>			    	
	  						<tr></tr>
	  						<tr></tr>
	  						<tr></tr>
	  						<tr></tr>			   
	  				</table>
 				</div>
			</div>
  		</div>
	</div>
</div>
</body>
<script>
$(function () {
	$('td[id^=notice-id-]').hover(function(e){
		$(this).addClass("active");
	}, function(e){
		$(this).removeClass("active");
	})
	$('td[id^=notice-id-]').on('click', function (event) {
		$('#notice-table tr').remove();
		var aNo = $(this).attr('id').replace('notice-id-','');
		var html = "";
		$.ajax ({
			type:"GET",
			url: "/manage/personnel/viewNoti.do",
			data:{notiNo:aNo},
			dataType:"json", 
			success:function (noti) {
				html += "<tr><th>제목</th><td colspan='3'>"+noti.title+"</td></tr>";
				html += "<tr><th>번호</th><td>"+noti.no+"</td></tr>";
				html += "<tr><th>조회수</th><td>"+noti.count+"</td></tr>";					
				html += "<tr><th>등록일</th><td>"+noti.createdate+"</td></tr>";
				html += "<tr><th>내용</th><td colspan='3'>"+noti.contents+"</td></tr>";
				
				$("#notice-table").html(html);
				$("#notice-table").removeClass("table").removeClass("table-condensed")
				$("#notice-table").addClass("table").addClass("table-condensed")
			}
		})
	})
	$('.pagination a').click(function(event) {
		event.preventDefault();
		$(':input[name=rows]').val(5);
		$(':input[name=pageNo]').val($(this).attr('href'));
		$("#form-search").submit();
	});
});
</script>
</html>