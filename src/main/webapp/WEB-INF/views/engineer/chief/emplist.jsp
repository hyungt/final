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
	table {font-size: 15px;}
	.modal-header {background-color: #0C70BC;}
	#modalHeader {font-weight: bold; color: white; padding: 15px; font-size: 25px;}
	.modal-body {font-size: 17px;}
</style>
</head>
<body>
    <c:set var="menu" value="emplist" />
	<%@ include file="/WEB-INF/views/engineer/engnavi/navi.jsp" %>
   	 <div class="cotainer-fluid">
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<div class="container">
    			<div class="row">
	    			<div class="col-sm-12">
		    			<h1>${loginEngineer.center.name } 직원 명단</h1>
        				<hr>
        				<table class="table table-hover">
        					<thead>
        						<tr>
        							<th>사원번호</th>
        							<th>이름</th>
        							<th>이메일</th>
        							<th>전화번호</th>
        							<th>입사일</th>
        							<th>직급</th>
        							<th>부서</th>
        						</tr>
        					</thead>
        					<tbody>
        					<c:choose>
        						<c:when test="${AllEmployees != null }">
		        					<c:forEach var="x" items="${AllEmployees }">
		        					<tr>
		        						<td>${x.no }</td>
		        						<td>${x.name }</td>
		        						<td>${x.email }</td>
		        						<td>${x.phone }</td>
		        						<td><fmt:formatDate value="${x.hiredate }"/> </td>
		        						<td>${x.position.name }</td>
		        						<td>${x.department.name }</td>
		        					<tr>
			        				</c:forEach>
		        				</c:when>
		        				<c:otherwise>
		        				<tr>
		        					<td colspan="3">직원이 없습니다.</td>
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
    	
		<!-- Modal -->
		<div id="myEmpInfo" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
       			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
       			<h4 class="modal-title" id="modalHeader">직원 정보</h4>
      		  </div>
		      <div class="modal-body">
		      	<div class="row">
			      	<div class="form-group col-sm-12">
	                    <label class="control-label col-sm-3" for="email">이메일</label>
	                    <div class="col-sm-4">
	                    </div>
	                </div>
	                <div class="form-group col-sm-12">
	                    <label class="control-label col-sm-3" for="id">이름</label>
	                    <div class="col-sm-4">
	                    </div>
	                </div>
	                <div class="form-group col-sm-12">
	                    <label class="control-label col-sm-3" for="id">전화번호</label>
	                    <div class="col-sm-4">
	                    </div>
	                </div>
	                 <div class="form-group col-sm-12">
	                    <label class="control-label col-sm-3" for="id">직급</label>
	                    <div class="col-sm-4">
	                    </div>
	                </div>	
	                 <div class="form-group col-sm-12">
	                    <label class="control-label col-sm-3" for="id">부서</label>
	                    <div class="col-sm-4">
	                    </div>
	                </div>
	                 <div class="form-group col-sm-12">
	                    <label class="control-label col-sm-3" for="id">센터</label>
	                    <div class="col-sm-4">
	                    </div>
	                </div>
                </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
    	
</body>
<script type="text/javascript">
$(function () {
	$('tbody tr').click (function () {
		var empEmail = $(this).find('td:nth-child(3)').text();
		
		$('#myEmpInfo').modal('show');
		
		$.ajax({
			url:"/engineer/empdetail.do",
			data:{empemail:empEmail},
			dataType:"json",
			success:function(data) {
				$('.modal-body .form-group .col-sm-4:eq(0)').text(data.email)
				$('.modal-body .form-group .col-sm-4:eq(1)').text(data.name)
				$('.modal-body .form-group .col-sm-4:eq(2)').text(data.phone)
				$('.modal-body .form-group .col-sm-4:eq(3)').text(data.position.name)
				$('.modal-body .form-group .col-sm-4:eq(4)').text(data.department.name)
				$('.modal-body .form-group .col-sm-4:eq(5)').text(data.center.name)
			},error:function () {
				alert("오류 발생");
			}
		})
	})
})
</script>
</html>