<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../commons/jstl.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
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
<title>재무 메인 페이지</title>
<style type="text/css">
div.container {
    width: 1280px;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
<div class="container">
	<div class="row">
		<h1>수입/지출 분석</h1>
		<hr/>
	</div>
	<div class="row">
		<div class="row">
			<ul class="nav nav-tabs" id="chart-tab">
				<li class="active"><a href="week">일별 수입/지출</a></li>
				<li><a href="month">월별 일 수입/지출</a></li>
				<li><a href="year">연도별 월 수입/지출</a></li>
			</ul>
		</div>
		<div id="day-input-div" class="row">
			<div class="form-group col-sm-offset-6 col-sm-3">
				<input type="date" placeholder="시작일" id="start-date" class="form-control"/>
			</div>
			<div class="form-group col-sm-3">
				<input type="date" placeholder="종료일" id="end-date" class="form-control"/>
			</div>
		</div>
		<div id="month-input-div" class="col-sm-3 col-sm-offset-9 form-group">
			<input type="text" placeholder="월을 선택하세요" id="chart-month" class="form-control"/>
		</div>
		<div class="col-sm-12" id="chart-div-day" style="height:400px;">
			
		</div>
		<div class="col-sm-6">
			<div class="col-sm-12" id="chart-div-category" style="height:400px;">
			
			</div>
		</div>
		<div class="col-sm-6">
			<div class="col-sm-12" id="chart-div-income" style="height:200px;">
			
			</div>
			<div class="col-sm-12" id="chart-div-expenditure" style="height:200px;">
			
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12" style="height:600px;">
			<div class="row">
				<table class="table table-condensed table-striped">
					<colgroup >
						<col width="20%">
						<col width="*">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>일시</th>
							<th>내역</th>
							<th>수입/지출</th>
							<th>금액</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="row" style="height:500px; overflow: auto;">
				<table class="table table-condensed table-striped">
					<colgroup >
						<col width="20%">
						<col width="*">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<tbody id="table-body">
						<tr>
							<td>일시</td>
							<td>내역</td>
							<td>수입/지출</td>
							<td>금액</td>
						</tr>
					</tbody>
				</table>
				<div>
					
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
$(function() {
	
	$("#end-date").click(function(e) {
		if(!$("#start-date").val()) {
			alert("시작일을 선택해 주세요!");
			return false;
		}
	});
	
	$("#start-date").change(function(e){
		var startDate = new Date($(this).val());
		var endDate = new Date($("#end-date").val());
		var today = new Date(moment().format("YYYY-MM-DD"))
		
		if(startDate > today) {
			alert("금일 이후의 값은 가져올 수 없습니다.");
			$(this).val(moment().format("YYYY-MM-DD"));
			return false;
		}
		if(startDate > endDate) {
			alert("종료일보다 작은 날짜를 선택해주세요.");
			$(this).val(moment().format("YYYY-MM-DD"));
			return false;
		}
		drawChart("week", $("#start-date").val() + "~" + $("#end-date").val());
		//getSalesAnalysis($("#start-date").val(), $("#end-date").val(), $("#order-select").val(), $("#type-select").val());
	});
	
	$("#end-date").change(function(e){
		var endDate = new Date($(this).val());
		var startDate = new Date($("#start-date").val());
		var today = new Date(moment().format("YYYY-MM-DD"))
		
		if(endDate > today) {
			alert("금일 이후의 값은 가져올 수 없습니다.");
			$(this).val(moment().format("YYYY-MM-DD"));
			return false;
		}
		if(startDate > endDate) {
			alert("시작일보다 큰 날짜를 선택해주세요.");
			$(this).val($("#start-date").val());
			return false;
		}
		drawChart("week", $("#start-date").val() + "~" + $("#end-date").val());
	});
	
	/*$("#order-select").change(function(e){
		var type = $(this).val();
		
		getSalesAnalysis($("#start-date").val(), $("#end-date").val(), $("#order-select").val(), $("#type-select").val());
	});
	
	$("#type-select").change(function(e) {
		getSalesAnalysis($("#start-date").val(), $("#end-date").val(), $("#order-select").val(), $("#type-select").val());
	});*/
	
	function getSalesAnalysis(startDate, endDate, type, changeType) {
		$.ajax({
			type:"get",
			url:"/manage/finance/payChange/getAnalysis.do",
			data: {
				startDate: startDate,
				endDate: endDate,
				type: type,
				changeType: changeType
			},
			dataType:"json",
			success: function(result) {
				var htmlContents = "";
				console.log(result);
				$.each(result, function(index, change) {
					htmlContents += "<tr>";
					htmlContents += "<td>"+moment(change.changedate).format("YYYY-MM-DD HH:mm:ss")+"</td>";
					htmlContents += "<td>"+((change.changeType.id=="PC-OTHER-PAY")? (change.changeType.info+" ("+change.reason+")") : change.changeType.info)+"</td>";
					htmlContents += "<td>"+change.type+"</td>";
					htmlContents += "<td>"+Number(change.money).toLocaleString()+"원</td>";
					htmlContents += "</tr>";
				});
				$("#table-body").html(htmlContents);
			}
		});
	}
	function drawChart(type, dateInfo) {
		console.log(dateInfo)
		$.ajax({
			type:"get",
			url:"/manage/finance/analysis/getData.do",
			data: {
				chartType: type,
				date: dateInfo
			},
			dataType: "json",
			success: function(result) {
				console.log(result);
				if(result.type == "week") {
					dayChartDraw(result.data, result.type)
					$("#day-input-div").show();
				} else if(result.type == "month") {
					dayChartDraw(result.data, result.type)
					$("#month-input-div").show();
				} else if(result.type == "year") {
					dayChartDraw(result.data, result.type)
				}
				dayTypeBarChartDraw(result.typeData);
				incomeDonutChartDraw(result.typeData);
				expenditureDonutChartDraw(result.typeData);
				
				getSalesAnalysis(result.startDate, result.endDate, "all", "all");
			}
		});
	}
	
	function dayChartDraw(dayData, type) {
		var data = new google.visualization.DataTable();
		data.addColumn('string', '날짜');
		data.addColumn('number', '수입');
		data.addColumn('number', '지출');
		var dataArr = [];
		$.each(dayData, function(index, data) {
			if(type == "year") {
				dataArr.push([data.day, data.income, data.expenditure]);
			} else {
				dataArr.push([data.day.substr(8, data.day.length), data.income, data.expenditure]);
			}
		});
		data.addRows(dataArr);
		var options = {
			title: dayData[0].day + " ~ " + dayData[dayData.length-1].day + " 수입/지출 현황",
		}
		var chart = new google.visualization.ColumnChart(document.getElementById('chart-div-day'));
		chart.draw(data, options);
	}
	
	function dayTypeBarChartDraw(typeData) {
		var data = new google.visualization.DataTable();
		data.addColumn('string', '항목');
		data.addColumn('number', '수입');
		data.addColumn('number', '지출');
		var dataArr = [];
		$.each(typeData, function(index, data) {
			dataArr.push([data.type, data.income, data.expenditure]);
		});
		data.addRows(dataArr);
		var options = {
			title: "항목별 수입/지출 현황",
		}
		var chart = new google.visualization.ColumnChart(document.getElementById('chart-div-category'));
		chart.draw(data, options);
	}
	
	function incomeDonutChartDraw(typeData) {
		var dataArr = [];
		dataArr.push(['수입', 'number']);
		$.each(typeData, function(index, item) {
			dataArr.push([item.type, item.income]);
		});
		
		var data = google.visualization.arrayToDataTable(dataArr);

        var options = {
          title: '항목별 수입 지분',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('chart-div-income'));
        chart.draw(data, options);
	}
	
	function expenditureDonutChartDraw(typeData) {
		var dataArr = [];
		dataArr.push(['지출', 'number']);
		$.each(typeData, function(index, item) {
			dataArr.push([item.type, item.expenditure]);
		});
		
		var data = google.visualization.arrayToDataTable(dataArr);

        var options = {
          title: '항목별 지출 지분',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('chart-div-expenditure'));
        chart.draw(data, options);
	}
	
	var currentYear = (new Date()).getFullYear();
    var startYear = currentYear-10;
    
    var options = {
            startYear: startYear,
            finalYear: currentYear,
            pattern: 'yyyy-mm',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    };
    $("#chart-tab li a").click(function(e) {
    	e.preventDefault();
    	$(this).closest("li").addClass("active").siblings().removeClass("active");
    	var type = $(this).attr("href");
    	$("#month-input-div").hide();
		$("#day-input-div").hide();
    	if(type == "week") {
    		drawChart("week", moment().add(-7, 'days').format("YYYY-MM-DD") + "~" + moment().format("YYYY-MM-DD"));
		} else if(type == "month") {
			drawChart(type, moment().format("YYYY-MM"));
		} else if(type == "year") {
			drawChart(type, moment().format("YYYY"));
		}
    })
    
    
	$("#chart-month").monthpicker(options);
	$("#chart-month").change(function(e) {
		drawChart("month", $(this).val())
	});
	
	$("#start-date").val(moment().add(-7, 'days').format("YYYY-MM-DD"))
	$("#end-date").val(moment().format("YYYY-MM-DD"));
	$("#day-input-div").show();
	$("#month-input-div").hide();
	google.charts.setOnLoadCallback(drawChart("week", moment().add(-7, 'days').format("YYYY-MM-DD") + "~" + moment().format("YYYY-MM-DD")));
});
</script>
</html>