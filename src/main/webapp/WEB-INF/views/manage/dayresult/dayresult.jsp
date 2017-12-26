<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load("current", {packages:['corechart', 'bar']});
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>
<script src="/resources/js/common/jquery.mtz.monthpicker.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.19.2/moment.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
  <div class="container">
	 <div class="row">
   		<div class="col-sm-12">
   				<h3>최근 주간 결산 현황</h3>
      			<div id="weekResult"></div>
   	    </div>
   	 		<div class="col-sm-12">
   	 			<h3>월별 결산 현황</h3>
   	 			<div class="row">
	   	 			<div id="month-input-div" class="col-sm-3 col-sm-offset-9 form-group">
						<input type="text" placeholder="월을 선택하세요" id="chart-month" class="form-control"/>
					</div>
   	 			</div>
   	 			<div class="row" id="monthResult"></div>
   	 		</div>
   	</div>
  </div>
  <%@include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script type="text/javascript">
$(function () {
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth();
	
	function timeToString(time) {
		return moment(new Date(time)).format("YYYY-MM-DD");
	}	
	
	function timeToStringDay(time) {
		return moment(new Date(time)).format("DD");
	}	
	
	var currentYear = (new Date()).getFullYear();
    var startYear = currentYear-10;
	
	var options = {
            startYear: startYear,
            finalYear: currentYear,
            pattern: 'yyyy-mm',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    };
	$("#chart-month").monthpicker(options);
	
	
	$("#chart-tab li a").click(function(e) {
    	e.preventDefault();
    	$(this).closest("li").addClass("active").siblings().removeClass("active");
    })
	
	function getData () {
	var startdate = moment().startOf('week').subtract(6, 'days').format('YYYY-MM-DD');
	var enddate = moment().startOf('week').format('YYYY-MM-DD');
		$.ajax({
			type:"get",
			url:"/manage/weekResult.do",
			data: {startdate:startdate, enddate:enddate},
			success: function(result) {
				dayChartDraw(result)
			}, error:function(err) {
				alert(err)
			}
		});
	}	
	
	$('#chart-month').change(function(e) {
		console.log($(this).val())
		var dataInfo = $(this).val();
		var year = dataInfo.substring(0,4)
		var month = dataInfo.substring(5,7)
		var enddate = timeToString(new Date(year, month, ""));
		var startdate = year + "-" + month + "-01";
		
		getMonthData(startdate, enddate)
	})
	
	function openPageMonth() {
		console.log("hi")
		var enddate = timeToString(new Date(year, month+1, ""));
		var startdate = year + "-" + (month+1) + "-01";
		
		getMonthData(startdate, enddate)
	}
	
	function getMonthData (startdate, enddate) {
		console.log(startdate, enddate)
		$.ajax({
			type:"get",
			url:"/manage/weekResult.do",
			data: {startdate:startdate, enddate:enddate},
			success: function(result) {
				console.log(result)
				monthChartDraw(result)
			}, error:function(err) {
				alert(err)
			}
		})
	}
	
	function dayChartDraw(dayData) {
		var data = new google.visualization.DataTable(dayData);
		data.addColumn('string', '날짜');
		data.addColumn('number', '자산');
		var dataArr = [];
		$.each(dayData, function(index, data) {
			dataArr.push([timeToString(data.dates), data.assets]);
		});
		data.addRows(dataArr);
		
		var chart = new google.visualization.ColumnChart(document.getElementById('weekResult'));
		 chart.draw(data); 
	}
	
	function monthChartDraw(dayData) {
		var data = new google.visualization.DataTable(dayData);
		data.addColumn('string', '날짜');	
		data.addColumn('number', '자산');
		var dataArr = [];
		$.each(dayData, function(index, data) {
			dataArr.push([timeToStringDay(data.dates), data.assets]);
		});
		data.addRows(dataArr);
		var options = {
			curveType:'function',
			legend:{position:'bottom'}
		};
		 var chart = new google.visualization.LineChart(document.getElementById('monthResult'));
		 chart.draw(data); 
	}
	
	function callFunction() {
		getData();
		openPageMonth();
	}
	google.charts.setOnLoadCallback(callFunction())
})
</script>
</html>