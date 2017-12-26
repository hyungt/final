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
		<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
<style type="text/css">
	img {width: 80%; height: 80%;}
	table {font-size: 16px;}
	.modal-header {background-color: #0C70BC;}
	#modalHeader {font-weight: bold; color: white; padding: 15px; font-size: 25px;}
	.modal-body {font-size: 17px;}
</style>
</head>
<body>
    <c:set var="menu" value="accept" />
	<%@ include file="/WEB-INF/views/engineer/engnavi/navi.jsp" %>
   	 <div class="cotainer-fluid">
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<div class="container">
    			<div class="row">
	    			<div class="col-sm-12">
		    			<h1>휴가 결재</h1>
        				<hr>
        				<table class="table table-hover">
        					<colgroup>
        					</colgroup>
        					<thead>
        						<tr class="text-center">
        							<th>사원번호</th>
        							<th>이름</th>
        							<th>시작일</th>
        							<th>종료일</th>
        							<th>신청 일자</th>
        							<th>직급</th>
        							<th>부서</th>
        							<th></th>
        						</tr>
        					</thead>
        					<tbody id="accept">			 
        					</tbody>
        				</table>		        				
        			 </div>
	    	  	  </div>
    	  		</div>
    	  	</div>
    	</div>
    	
    	<!-- Modal -->
		<div id="myVacationAccept" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
       			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
       			<h4 class="modal-title" id="modalHeader">휴가 결재</h4>
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
	                <div class="modal-footer">
				       <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				       <button type="button" class="btn btn-danger" id="reject">반려</button>
				       <button type="button" class="btn btn-primary" id="go-vacation">승인</button>
				    </div>
		      </div>
		    </div>
		   </div>
		  </div>
</body>
<script type="text/javascript">
$(function () {
	var center = "${centerId }";
	
	var breakNo = 0;
	
	function timeToString(time) {
		return moment(new Date(time)).format("YYYY-MM-DD hh");
	}
	
	function startPage(centerId) {
		$.ajax ({
			url:"/engineer/vacation.do",
			data:{centerId:centerId},
			dataType:"json",
			success:function(data) {
				var html = "";
				if(data != null) {
					$.each (data, function (index, item) {
						console.log(item)
						html += "<tr>";
						html += "<td>"+item.no+"</td>";
						html += "<td>"+item.employee.name+"</td>";
						html += "<td class='hidden'>"+item.employee.email+"</td>";
						html += "<td>"+timeToString(item.startdate)+"</td>";
						html += "<td>"+timeToString(item.enddate)+"</td>";
						html += "<td>"+timeToString(item.apply)+"</td>";
						html += "<td>"+item.employee.position.name+"</td>";
						html += "<td>"+item.employee.department.name+"</td>";
						html += "<td><button type='button' id='accept-btn-"+item.no+"' class='btn btn-warning btn-md'>대기</button></td>";
						html += "</tr>";
					})
					} else {
						html += "<tr>";
						html += "<td colspan='3'>대기 중인 휴가 결재가 없습니다.</td>";
						html += "</tr>";
				}
				$('tbody').html(html);
				
				console.log(data)
			}, error:function () {
				alert("오류 발생");
			}
		})
	}
	
	$('#accept').on ('click', 'button[id^=accept-btn-]', function () {
		$('#myVacationAccept').modal('show');
		breakNo = $(this).attr('id').replace("accept-btn-", "");
		var empEmail = $(this).closest('td').parent().find('.hidden').text();
		
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
	
	$('#go-vacation').click (function () {
		$.ajax({
			url:"/engineer/acceptbreak.do",
			data:{breakNo:breakNo},
			dataType:"json",
			success:function(data) {
				$('#myVacationAccept').modal('hide');
				startPage(center);
			},error:function () {
				alert("오류 발생");
			}
		})
	})
	
	$('#reject').click (function () {
		var acc = 2;
		$.ajax({
			url:"/engineer/rejectbreak.do",
			data:{breakNo:breakNo},
			dataType:"json",
			success:function(data) {
				$('#myVacationAccept').modal('hide');
				startPage(center);
			},error:function () {
				alert("오류 발생");
			}
		})
	})
	
	startPage(center);
})
</script>
</html>