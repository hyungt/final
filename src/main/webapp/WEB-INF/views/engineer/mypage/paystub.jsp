<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/commons/jstl.jsp" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ page import="java.text.SimpleDateFormat" %>
   
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
<script src='/resources/js/common/jquery.number.min.js'></script>
</head>
<style type="text/css">
  		html{
            font:0.75em/1.5 sans-serif;
            color:#333;
            background-color:#fff;
        }
        table{
            width:100%;
            margin-bottom:1em;
            border-collapse: collapse;
        }
        th{
            font-weight:bold;
            background-color:#ddd;
            width: 12%;
        }
        th,
        td{
            padding:0.5em;
            border:1px solid #ccc;
        }
        table {
        	border-style: 1px solid;
        }
        #blank {
        	font-size: 30px;
        	
        	font-weight: bold;
        }
       #title {
      		 padding-top: 15px;
        	padding-bottom: 15px;
       }
       .btn {
       		font-weight: bold;
       		font-size: 17px;
       }
</style>
<body>
	 
    <c:set var="menu" value="mypage" />
    <c:set var="innermenu" value="paystub" />
	<%@include file="/WEB-INF/views/engineer/engnavi/navi.jsp" %>
   	<div class="container-fluid">
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
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-2 main">
    		<h1>급여 명세서 출력</h1>
    		<hr>
    		<div class="container col-sm-9">
    			<div class="col-sm-12" id="title">
    				<div class="col-sm-10 text-center" id="blank">급여 명세서 미리 보기</div>
    				
    			</div>
    			<div class="col-sm-12">
    			<div class="row">
    				<div class="col-sm-12 text-right" id="out">
    				<button type="button" id="export" class="btn btn-default bt-lg">출력</button>
    				</div>
    				<div class="col-sm-12" id="nonePay">
    					<table>
    						<tr>
    							<td colspan="6">조회된 급여 명세서가 없습니다.</td>
    						</tr>
    					</table>
    				</div>
	    			<div class="col-sm-12" id="table-div">
	    				   <table>
						        <tr>
						            <th>부서명</th><td>${loginEngineer.department.name }</td><th>센터명</th><td>${loginEngineer.center.name }</td><th>이름</th><td>${loginEngineer.name }</td>
						        </tr>
						        <tr>
						            <th>직위</th><td>${loginEngineer.position.name }</td><th>전화번호</th><td>${loginEngineer.phone }</td><th>입사일</th><td><fmt:formatDate value="${loginEngineer.hiredate }"/></td>
						        </tr>
						   </table>
						   <table>
						        <tr>
						        	<fmt:formatNumber value="${loginEngineer.salary div 12}" var="salary"  />
						        	<fmt:formatNumber value="${loginEngineer.salary div (12*10) }"  var="tax" />
						            <th>급여</th><td>${salary }원</td><th>세금, 공제 금액</th><td>${tax }원</td>
						        </tr>      
						   </table>		
						   	<table id="footer-table">
						   		 <tr>
						           <th>최종급여</th><td><fmt:formatNumber value="${(loginEngineer.salary div 12)  - (loginEngineer.salary div (12*10)) }" />원</td>
						        </tr>
						   	</table>				
	    			</div>
    	  		</div>
    	  		</div>
    	  	</div>
	    			<div class="col-sm-2">
	    				<div class="panel panel-default">
		    				<div class="panel-heading">월별 급여 보기</div>
							<ul class="list-group" id="month-list">
								<li id="allday-1" class="list-group-item" value="01">1 월</li>
								<li id="allday-2" class="list-group-item" value="02">2 월</li>
								<li id="allday-3" class="list-group-item" value="03">3 월</li>
								<li id="allday-4" class="list-group-item" value="04">4 월</li>
								<li id="allday-5" class="list-group-item" value="05">5 월</li>
								<li id="allday-6" class="list-group-item" value="06">6 월</li>
								<li id="allday-7" class="list-group-item" value="07">7 월</li>
								<li id="allday-8" class="list-group-item" value="08">8 월</li>
								<li id="allday-9" class="list-group-item" value="09">9 월</li>
								<li id="allday-10" class="list-group-item" value="10">10 월</li>
								<li id="allday-11" class="list-group-item" value="11">11 월</li>
								<li id="allday-12" class="list-group-item" value="12">12 월</li>
							</ul>
							
		    			</div>
	    			</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script type="text/javascript">
$(function () {
	var Now = new Date();
	var NowYear = Now.getFullYear();
	
	$('#export').click(function () {
		if($("#month-list li.active").length) {
			var monNo = $("#month-list li.active").val();
			var exportMon = "";
			if(monNo < 10) {
				exportMon = NowYear + '-0' + monNo;
			} else {
				exportMon = NowYear + '-' + monNo;
			}
			
			location.href="/engineer/excelExport.do?exportMon=" + exportMon;
			return;
		} else {
			alert("급여 명세서의 정보가 없습니다.");
			return;
		}
		
		location.href="/engineer/excelExport.do";
	})
	
	$('#nonePay').hide();
	
	
	function timeToString(time) {
		return moment(new Date(time)).format("YYYY-MM-DD");
	}	
	
	function monthReset () {
		$('#table-div table:nth-child(1) tr:first td:first').text("");
		$('#table-div table:nth-child(1) tr:first td:nth-child(2)').text("");
		$('#table-div table:nth-child(1) tr:first td:last').text("");
		
		$('#table-div table:nth-child(1) tr:last td:first').text("");
		$('#table-div table:nth-child(1) tr:last td:nth-child(2)').text("");
		$('#table-div table:nth-child(1) tr:last td:last').text("");
		
		$('#table-div table:nth-child(2) tr:last td:first').text("");
		$('#table-div table:nth-child(2) tr:last td:last').text("");
		
		$('#table-div table:nth-child(3) tr td').text("");
	}
	
	$("#month-list li").click(function () {
		var monthNo = $(this).val();
		console.log(monthNo)
		
		if(monthNo < 10) {
		var yyyyMM = NowYear + '-0' + monthNo;
		console.log(yyyyMM)
			
		} else {
		var yyyyMM = NowYear + '-' + monthNo;
			console.log(yyyyMM)
		}
		
		$('#table-div').show()
		$('#nonePay').hide();
		monthReset();
		
		$.ajax({
			url:"/engineer/monthlyPay.do",
			data:{yyyyMM:yyyyMM},
			dataType:"json",
			success:function(data) {
				console.log(data)
				var salary = (data.employee.salary/12);
				var tax = (data.employee.salary/12/10);
				var totalSalary = (data.employee.salary/12)- (data.employee.salary/12/10);
				
					$('#table-div table:nth-child(1) tr:first td:first').text(data.employee.department.name);
					$('#table-div table:nth-child(1) tr:first td:nth-child(2)').text(data.employee.center.name);
					$('#table-div table:nth-child(1) tr:first td:last').text(data.employee.name);
					
					$('#table-div table:nth-child(1) tr:last td:first').text(data.employee.position.name);
					$('#table-div table:nth-child(1) tr:last td:nth-child(2)').text(data.employee.phone);
					$('#table-div table:nth-child(1) tr:last td:last').text(timeToString(data.employee.hiredate));
					
					$('#table-div table:nth-child(2) tr:last td:first').text($.number(salary, ',')+"원");
					$('#table-div table:nth-child(2) tr:last td:last').text($.number(tax, ',')+"원");
					
					$('#table-div table:nth-child(3) tr td').text($.number(totalSalary, ',')+"원");
					
			}, error:function (err) {
				$('#nonePay').show();
				$('#table-div').hide()
			}
		})
		
	}) 

	
	$("#month-list li").click(function() {
		$(this).addClass("active").siblings().removeClass("active");
	});
})
</script>
</html>