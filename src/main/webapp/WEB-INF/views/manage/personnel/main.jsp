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
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
<title>인사 메인 페이지</title>
<style type="text/css">
div.container {
    max-height: 1024px;
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
	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<h1>공지사항</h1>
    		<hr>
    		<div class="container">
    			<div class="row">
    				<div class="col-sm-12" id="blank"></div>
    			</div>
    			<div class="row">
	    			<div class="col-sm-6">
		    			<div class="col-sm-11">
			    			<div id="select" class="col-sm-12">
			    				<div class="col-sm-12" id="list">
				    				<form id="form-search" action="newMain.do">
				    					<input type="hidden" name="pageNo" value="${param.pageNo }"/>
										<input type="hidden" name="rows" value="${param.rows }"/>
				    				</form>
				    				<ul class="list-group">
					    				<c:forEach var="noti" items="${notis }">
					    					<li class="list-group-item"><p id="noti-${noti.no }">${noti.title }</p></li>
					    				</c:forEach>
					    			</ul>
			    				</div>
				    			<%@ include file="/WEB-INF/views/manage/notice/include/pagination.jsp" %>	
			    			</div>
		    			</div>
	    			</div>
	    			<div class="col-sm-6">
		    				<div class="row">
		    				<div class="col-sm-12" id="result"  style="height: 500px; overflow: auto;">
			    				<table class="table table-condensed">
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
    	</div>
    </div>
</body>
<script type="text/javascript">
	$(function () {
		$('p[id^=noti-]').on('click', function (event) {
			$('table tr').remove();
			var aNo = $(this).attr('id').replace('noti-','');
			
			$(this).closest("li").addClass('active').siblings().removeClass("active");
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
					
					$("table").html(html);
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