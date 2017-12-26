<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
</head>
<body>
	 
    <c:set var="menu" value="engMain" />
    <c:set var="innermenu" value="alert" />
	<%@include file="../engnavi/navi.jsp" %>
    <div class="cotainer-fluid">
    	<div class="row">
    		<div class="col-sm-3 col-sm-2 sidebar">
    			<ul class="nav nav-sidebar text-center">
		             <li class="${innermenu eq 'alert' ? 'active' :'' }"><a href="/engineer/alert.do">공지사항</a></li>
	      			 <li class="${innermenu eq 'recommend' ? 'active' :'' }"><a href="/engineer/recommend.do">건의사항</a></li>
		          </ul>
    		</div>
    	</div>
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<h1>직원 공지사항</h1>
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
				    				<form id="form-search" action="alert.do">
				    					<input type="hidden" name="pageNo" value="${param.pageNo }"/>
										<input type="hidden" name="rows" value="${param.rows }"/>
				    				</form>
				    				<ul class="list-group">
					    				<c:forEach var="alert" items="${alerts }">
					    					<li class="list-group-item"><p id="${alert.no }">${alert.title }</p></li>
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
		$('#list li').on('click', function (event) {
			$('table tr:first-child').empty();
			$('table tr:nth-child(2)').empty();
			$('table tr:nth-child(3)').empty();
			$('table tr:last-child').empty();
			var aNo = $(this).find('p').attr('id');
			
			$(this).addClass('active').siblings().removeClass('active');
			$.ajax ({
				type:"GET",
				url: "/alert/getalert.do",
				data:{noticeNo:aNo},
				dataType:"json", 
				success:function (alert) {
					var html1 = "<th>제목</th><td colspan='3'>"+alert.title+"</td>";
					var html2 = "<th>번호</th><td>"+alert.no+"</td>";
					var html3 = "<th>조회수</th><td>"+alert.count+"</td>";					
					var html4 = "<th>등록일</th><td>"+alert.createdate+"</td>";
					var html5 = "<th>내용</th><td colspan='3'>"+alert.contents+"</td>";
					
					$('table tr:first-child').append(html1);
					$('table tr:nth-child(2)').append(html2);
					$('table tr:nth-child(3)').append(html3).append(html4);
					$('table tr:last-child').append(html5);
				}
			})
		})
		$('.pagination a').click(function(event) {
			event.preventDefault();
			$(':input[name=pageNo]').val($(this).attr('href'));
			$("#form-search").submit();
		});
	});
</script>
</html>