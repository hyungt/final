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
<script src='https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
		<link rel='stylesheet' href='../resources/fullcalendar/fullcalendar.css' />
	<script src='../resources/fullcalendar/fullcalendar.js'></script>
	<script src='../resources/fullcalendar/ko.js'></script>
<style type='text/css'>
	body {
		text-align: center;
		font-size: 14px;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		}

	#calendar {
		width: 900px;
		margin: 0 auto;
		}
	#modalTable {
		padding-top: 15px; 
		padding-left: 70px; 
		padding-right: 70px; 
		font-size: 20px;
	}
	#tableHeader {
		font-weight: bold; 
		color: white; 
		padding: 15px;
	}
	#tablePanel {
		background-color: #0C70BC;
	}
	#allday {
		list-style: none;
		font-size: 14px;
		padding-top: 9px;
		padding-bottom: 9px;
	}
	.list-group-item {
		cursor:pointer;
	}
	
</style>
</head>

<body>
	 
    <c:set var="menu" value="mypage" />
    <c:set var="innermenu" value="vacation" />
	<%@include file="/WEB-INF/views/engineer/engnavi/navi.jsp" %>
    	
    <div class="cotainer-fluid">
    	<div class="row">
    		<div class="col-sm-3 col-sm-2 sidebar">
    			<ul class="nav nav-sidebar text-center">
		            <li class="${innermenu eq 'vacation' ? 'active' :'' }"><a href="/engineer/mypage.do">휴가신청</a></li>
			        <li class="${innermenu eq 'myinfo' ? 'active' :'' }"><a href="/engineer/myinfo.do">정보수정</a></li>
			        <li class="${innermenu eq 'myinfocheck' ? 'active' :'' }"><a href="/engineer/myinfocheck.do">내 정보</a></li>
			        <li class="${innermenu eq 'paystub' ? 'active' :'' }"><a href="/engineer/paystub.do">급여명세서 출력</a></li>
		          </ul>
    		</div>
    	</div>
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<div class="container">
    			<div class="row">
    				<div class="col-sm-12" id="blank"></div>
    			</div>
    			<div class="row">
	    			<div class="col-sm-10">
		    			<div id="calendar"></div>
	    			</div>
	    			<div class="col-sm-2">
		    			<div class="panel panel-default">
		    				<div class="panel-heading">메뉴</div>
							<ul class="list-group" id="member-list">
								<li class="list-group-item" id="Exitbreak-no-${engiNo }">모든 반려 휴가 보기</li>
								<li id="allday"><a href="/engineer/mypage.do">모든 일정 보기</a></li>
							</ul>
		    			</div>
	    	  		</div>
    	  		</div>
    	  	</div>
    	</div>
    	<div class="modal fade" id="event-form-modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
	  		<div class="modal-dialog" role="document">
	    		<div class="modal-content">
	      			<div class="modal-header">
	        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        			<h4 class="modal-title" id="gridSystemModalLabel">휴가 신청 작성</h4>
	      			</div>
	      			<div class="modal-body">
	      				<form class="form-horizontal well" action="add-plan.do" enctype="multipart/form-data" method="POST">
	  						<div class="form-group">
	    						<label for="description" class="col-sm-2 control-label">사유</label>
	    						<div class="col-sm-10">
	      							<textarea rows="3" class="form-control" id="event-description" name="reason" placeholder="내용을 입력하세요" ></textarea>
	    						</div>
	  						</div>
	  						<div class="form-group">
	    						<label for="start-date" class="col-sm-2 control-label">시작 일시</label>
	    						<div class="col-sm-4">
	      							<input type="date" class="form-control" id="event-start-date" name="startdate" >
	    						</div>
	    						<div class="col-sm-2">
	      							<input type="number" class="form-control" id="event-start-hour" name="startHour"  min="0" max="23" step="1">
	      							<input type="hidden" class="form-control" name="startMinute" value="00" />
	    						</div>
	    						<label for="start-hour" class="col-sm-1 control-label">시</label>
	  						</div>
	  						<div class="form-group">
	    						<label for="end-date" class="col-sm-2 control-label">종료 일시</label>
	    						<div class="col-sm-4">
	      							<input type="date" class="form-control" id="event-end-date" name="enddate" >
	    						</div>
	    						<div class="col-sm-2">
	      							<input type="number" class="form-control" id="event-end-hour" name="endHour" min="0" max="23" step="1">
	      							<input type="hidden" class="form-control" name="endMinute" value="00" />
	    						</div>
	    						<label for="end-hour" class="col-sm-1 control-label">시</label>
	  						</div>
	  						<div class="form-group">
	    						<label for="fetchFile" class="col-sm-2 control-label">신청서 경로</label>
	    						<div class="col-sm-4 text-right">
	    							<input type="file" class="form-control" id="event-url-image" name="fetchFile">
	    						</div>
	  						</div> 
			      			<div class="modal-footer">
			        			<button type="button" class="btn btn-default" id="close" data-dismiss="modal">닫기</button>
			        			<button type="submit" class="btn btn-primary" id="add-event-btn">등록</button>
			      			</div>
						</form>
	      			</div>
	    		</div>
	  		</div>
		</div>
		
		<!-- Modal -->
		<div id="DetailVacation" class="modal fade" role="dialog">
		  <div class="modal-dialog modal-lg">
		
		    <!-- Modal content-->
		    <div class="modal-content" style="height: 600px;">
		      <div class="modal-header" id="tablePanel">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h3 class="modal-title" id="tableHeader">휴가 신청서</h3>
		      </div>
		      <div class="modal-body">
		      	<div class="row" id="modalTable">
		      		<table class="table table-condensed">
		      			<tr>
		      				<th>작성 번호</th><td></td>
		      			</tr>
		      			<tr>
		      				<th>작성 일자</th><td></td>
		      			</tr>
		      			<tr>
		      				<th>휴가 시작일</th><td></td>
		      			</tr>
		      			<tr>
		      				<th>휴가 종료일</th><td></td>
		      			</tr>
		      			<tr>
		      				<th>작성자 이름</th><td></td>
		      			</tr>
		      			<tr>
		      				<th>휴가 사유</th><td></td>
		      			</tr>
		      			<tr>
		      				<th>신청서 파일</th><td></td>
		      			</tr>
		      			<tr>
		      				<th>상태</th><td></td>
		      			</tr>
		      		</table>
		      	</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
	
		<!-- 경고메세지 출력용 작은 모달창 -->
		<div id="small-modal" class="modal bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
	 			<div class="modal-dialog modal-sm" role="document">
				<div class="modal-contetablePanelnt">
			      	<div class="modal-header">
			        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        	<h4 class="modal-title" id="small-modal-title"></h4>
			      	</div>
			      	<div class="modal-body" id="small-modal-body"></div>
				</div>
		  	</div>
		</div>
    </div>
    <%@include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script type="text/javascript">
$(function() {
	
	function timeToString(time) {
		return moment(new Date(time)).format("YYYY-MM-DD");
	}	
	function timeToHour(time) {
		return moment(new Date(time)).format("HH");
	}	
	
	function showSmallModal(title, message) {
		$('#small-modal-title').text(title);
		$("#small-modal-body").html("<small>" + message + "</small>");
		$('#small-modal').modal('show');
	}
	
	function initializeForm(date) {
		var yyyymmdd = date.format();
		var now = new Date();
		var hour = now.getHours();
		
		$("#event-form-modal #event-description").val("");
		$("#event-form-modal #event-start-date").val(yyyymmdd);
		$("#event-form-modal #event-end-date").val(yyyymmdd);
		$("#event-form-modal #event-start-hour").val(hour);
		$("#event-form-modal #event-start-minute").val("00");
		$("#event-form-modal #event-end-hour").val(parseInt(hour)+1);
		$("#event-form-modal #event-end-minute").val("00");		
		$("#event-form-modal #event-url-image").val("");  
	}
	
	$('#calendar').fullCalendar({
		events:function(start, end, timezone, callback) {
			var paramData = {start:start.format(), end:end.format()};
			var requestUrl = "all-plan.do";
			var totallBreakNo = 0;
			
			if ($("#member-list li.active").length) {
				var clickedBreak = $("#member-list li.active").attr("id").replace("Exitbreak-no-", "");
				
				paramData['breakNo'] = clickedBreak;
				requestUrl = "other-plan.do";	
			} 
			
			$.ajax ({
				url:requestUrl,
				data:paramData,
				dataType:"json",
				success:function(data) {

					var events = [];
					$.each(data, function(index, item) {
						console.log(item)
						var eventObj = {};
						var param = item.reason + " - " + item.employee.name;
						var completed = item.completed;
						eventObj.id = item.no;
						if(completed == "Y") {
						eventObj.backgroundColor = '#0770BE';							
						eventObj.borderColor = '#0770BE';							
						} else if(completed == "N"){
							eventObj.backgroundColor = "#ff9933";
							eventObj.borderColor = "#ff9933";
						} else {
							eventObj.backgroundColor = "#D8524E";
							eventObj.borderColor = "#D8524E";
						}
						eventObj.title = param;
						eventObj.start = item.startdate
						eventObj.end = item.enddate
						
						events.push(eventObj);
					});
					
					callback(events);
					
				}
			});
		},
		dayClick: function(date, jsEvent, view) {
				initializeForm(date)
				$('#add-event-btn').show();
				
				$("#event-form-modal").modal("show");			
		}, 
		eventClick: function(event, jsEvent, view) {
			var breakNo = event.id;
				
			$('#add-event-btn').hide();
			
			$("#DetailVacation").modal("show");
			$.ajax ({
				url:"detail-plan.do",
				data:{breakNo:breakNo},
				dataType:"json",
				success:function(data) {
					console.log(data)
					if(data.completed != "D") {
						$("#DetailVacation table tr:nth-child(1) td").text(data.no);
						$("#DetailVacation table tr:nth-child(2) td").text(timeToString(data.apply));
						$("#DetailVacation table tr:nth-child(3) td").text(timeToString(data.startdate));
						$("#DetailVacation table tr:nth-child(4) td").text(timeToString(data.enddate));
						$("#DetailVacation table tr:nth-child(5) td").text(data.employee.name);
						$("#DetailVacation table tr:nth-child(6) td").text(data.reason);
						$("#DetailVacation table tr:nth-child(7) td").text(data.fetchFile);
						if(data.completed == "Y") {
							$("#DetailVacation table tr:nth-child(8) td").text("허가");
						} else if (data.completed == "N") {
							$("#DetailVacation table tr:nth-child(8) td").text("대기");							
						}
					} else {
						$('#tablePanel').css('background-color', '#D8524E')
						$("#DetailVacation table tr:nth-child(1) td").text(data.no);
						$("#DetailVacation table tr:nth-child(2) td").text(timeToString(data.apply));
						$("#DetailVacation table tr:nth-child(3) td").text(timeToString(data.startdate));
						$("#DetailVacation table tr:nth-child(4) td").text(timeToString(data.enddate));
						$("#DetailVacation table tr:nth-child(5) td").text(data.employee.name);
						$("#DetailVacation table tr:nth-child(6) td").text(data.reason);
						$("#DetailVacation table tr:nth-child(7) td").text(data.fetchFile);
						$("#DetailVacation table tr:nth-child(8) td").text("반려");
					}
					
				},  error:function () {
					alert("오류 발생");
				}
			})
		}
	});
	
	$('#DetailVacation-close').click(function () {
		$('#DetailVacation').modal('hide');
	})
	
	$("#member-list li").click(function() {
		$(this).addClass("active").siblings().removeClass("active");
		$("#calendar").fullCalendar('refetchEvents');
	});
});
</script>
</html>