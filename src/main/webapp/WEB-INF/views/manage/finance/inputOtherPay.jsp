<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>
<script src="/resources/js/common/jquery.mtz.monthpicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.19.2/moment.min.js"></script>
<style>
container {
    width: 1024px;
}
.panel-heading {
	cursor: pointer;
}
.backco {
	background-color: #125ab8;
}
.loading {
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	position: fixed;
	display: block;
	opacity: 0.7;
	background-color: #fff;
	z-index: 9999;
	text-align: center;
	display:none;
}

.loading-image {
	position: absolute;  
	top: 50%;
	left: 50%;
	z-index: 9998;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
	<div class="container">
		<h1>지출 입력</h1>
		<hr/>
		<div class="row">
			<div class="row panel-group" id="salary-accordion">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" data-parent="#salary-accordion" href="#collapse1">
						<h3 class="panel-title">급여 지급 및 내역</h3>
					</div>
				</div>
				<div id="collapse1" class="panel-collapse collapse">
					<div class="panel-body">
						<h2 id="title"></h2>
						<hr/>
						<div class="row">
							<div class="form-group col-sm-3 text-right">
								<input type="text" placeholder="이곳을 클릭하여 해당 월을 선택하세요" class="form-control" name="month" id="date-picker"/>
							</div>
						</div>
						<div class="row">
							<table class="table table-condensed">
								<colgroup>
									<col width="10%"/>
									<col width="10%"/>
									<col width="10%"/>
									<col width="20%"/>
									<col width="10%"/>
									<col width="10%"/>
									<col width="*"/>
								</colgroup>
								<thead>
									<tr>
										<th>사원번호</th>
										<th>직위</th>
										<th>이름</th>
										<th>입사일</th>
										<th>소속</th>
										<th>부서</th>
										<th id="pay-title">지급 예상액</th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="row" style="height: 500px; overflow :auto; ">
							<table class="table table-condensed">
								<colgroup>
									<col width="10%"/>
									<col width="10%"/>
									<col width="10%"/>
									<col width="20%"/>
									<col width="10%"/>
									<col width="10%"/>
									<col width="*"/>
								</colgroup>
								<tbody id="salary-body">
								
								</tbody>
							</table>
						</div>
						<div class="row">
							<div class="col-sm-offset-7 col-sm-2 text-right">
								<label>총 금액 </label>
							</div>
							<div class="col-sm-3">
								<input type="text" class="form-control pull-right" readonly="readonly" id="total-money">
							</div>
						</div>
						<div id="btn-box" class="row text-right">
							<button id="btn-salary" class="btn btn-lg btn-primary">전체 급여 지급</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr/>
		<div class="row">
			<div class="row panel-group" id="other-accordion">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" data-parent="#other-accordion" href="#collapse2">
						<h3 class="panel-title">기타 지출 입력</h3>
					</div>
				</div>
				<div id="collapse2" class="panel-collapse collapse">
					<div class="panel-body">
						<div id="other-input" style="height:auto; max-height: 600px; overflow: auto;" class="row">
							
						</div>
						<div class="row form-group">
							<div class="col-sm-offset-7 col-sm-2 text-right">
								<label>총 금액 </label>
							</div>
							<div class="col-sm-3">
								<input type="text" class="form-control pull-right" readonly="readonly" id="total-other-pay">
							</div>
						</div>
						<div class="row text-center">
							<button id="add-other-row" class="btn btn-primary btn-lg">추가</button>
							<button id="add-other" class="btn btn-primary btn-lg pull-right">적용</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<div id="loading" class="loading"><img id="loading-image" src="/resources/images/ajax-loader.gif" alt="Loading..." /></div>
</body>
</body>
<script type="text/javascript">
$(function() {
	var btnIndex = 1;
	$("#add-other-row").click(function(e) {
		var htmlContents = "";
		htmlContents += '<div class="form-group col-sm-12" id="row-'+btnIndex+'">'
		htmlContents += '<div class="col-sm-3">';
		htmlContents += '<select id="department-'+btnIndex+'" class="form-control">';
		htmlContents += '<option value="">---부서 선택---</option>';
		htmlContents += '<option value="DEPT-FIN">재무</option>';
		htmlContents += '<option value="DEPT-ADMIN">운영</option>';
		htmlContents += '<option value="DEPT-SC">서비스센터</option>';
		htmlContents += '<option value="DEPT-HR">인사</option>';
		htmlContents += '<option value="DEPT-INVEN">물류</option>';
		htmlContents += '</select>';
		htmlContents += '</div>';
		htmlContents += '<div class="col-sm-3">';
		htmlContents += '<input class="form-control" placeholder="지출 금액을 입력하세요." type="number" id="money-'+btnIndex+'"/>';
		htmlContents += '</div>';
		htmlContents += '<div class="col-sm-4">';
		htmlContents += '<input class="form-control" placeholder="사유를 입력하세요." type="text" id="reason-'+btnIndex+'"/>';
		htmlContents += '</div>';
		htmlContents += '<div class="col-sm-offset-1 col-sm-1">';
		htmlContents += '<button id="btn-row-'+(btnIndex++)+'" class="btn btn-danger">삭제</button>';
		htmlContents += '</div>';
		htmlContents += '</div>';
		$("#other-input").append(htmlContents);
		var div = document.getElementById("other-input")
		div.scrollTop = div.scrollHeight;
	});
	
	$("#add-other").click(function(e){
		
		var departmentArr = [], moneyArr = [], reasonArr = [];
		var rowCheck = false;
		$("#other-input").find("div[id^=row-]").each(function(index) {
			var idNumber = $(this).attr("id").replace("row-", "");
			if($("#department-"+idNumber).val() && $("#money-"+idNumber).val() && $("#reason-"+idNumber).val()) {
				departmentArr.push($("#department-"+idNumber).val());
				moneyArr.push($("#money-"+idNumber).val());
				reasonArr.push($("#reason-"+idNumber).val());
				$(this).remove();
			} else {
				rowCheck = true;
			}
		});
		
		$.ajax({
			type: "post",
			url: "/manage/finance/other/addOtherPay.do",
			data: {
				deptArr : departmentArr.join(","),
				moneyArr : moneyArr.join(","),
				reasonArr : reasonArr.join(",")
			},
			dataType: "text",
			success: function(result) {
				if(rowCheck) {
					alert("비정상적인 데이터를 제외 후 정보 적용이 완료되었습니다.");
				} else {
					alert("적용이 완료되었습니다.");
				}
			}
		});
	});
	$("#other-input").on("change", "input[id^=money-]", function(e){
		var totalMoney = 0;
		$("input[id^=money-]").each(function(index) {
			if(isNaN(parseInt($(this).val()))){
				return;
			}
			console.log(parseInt($(this).val()));
			totalMoney += parseInt($(this).val());
		});
		$("#total-other-pay").val(Number(totalMoney).toLocaleString() + "원");
	});
	
	$("#other-input").on("click", "button[id^=btn-row-]", function(e) {
		var idNumber = $(this).attr("id").replace("btn-row-", "");
		$("#row-"+idNumber).remove();
	});
	
	$("#btn-box").hide();
	var currentYear = (new Date()).getFullYear();
    var startYear = currentYear-10;
    
    var options = {
            startYear: startYear,
            finalYear: currentYear,
            pattern: 'yyyy-mm',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    };
	$("#date-picker").monthpicker(options);
	$(".panel-heading").click(function(e) {
		$(this).toggleClass("backco");
		if($(this).hasClass("backco")) {
			$(this).css("background-color", "#125ab8");	
			$(this).css("color", "white");
		} else {
			$(this).css("background-color", "#f5f5f5");
			$(this).css("color", "black");
		}
	});
	
	$("#btn-salary").click(function(e) {
		$('#loading').show();
		$.ajax({
			type:"get",
			url:"/manage/finance/salary/paymentsSalary.do",
			dataType: "text",
			success: function(result) {
				alert("직원 월급이 모두 지급되었습니다!");
				location.href="/manage/finance/inputPay.do"
			}
		});
	});
	
	$("#date-picker").change(function(e) {
		$.ajax({
			type:"get",
			url:"/manage/finance/salary/getAllSalary.do",
			data: {month:$(this).val()},
			dataType: "json",
			success: function(result) {
				var list = null;
				var htmlContents = "";
				if(result.payments == "N" && !result.monthlyEmpList && !result.monthlyList) {
					htmlContents +="<tr class='text-center'><td colspan='7'>해당 월의 정보가 없습니다.</td></tr>"
				}
				console.log(result);
				if(result.monthlyEmpList) {
					list = result.monthlyEmpList;
					$.each(list, function(index, emp) {
						htmlContents += "<tr>";
						htmlContents += "<td>"+emp.no+"</td>";
						htmlContents += "<td>"+emp.position.name+"</td>";
						htmlContents += "<td>"+emp.name+"</td>";
						htmlContents += "<td>"+moment(emp.hiredate).format("YYYY-MM-DD")+"</td>";
						htmlContents += "<td>"+emp.center.name+"</td>";
						htmlContents += "<td>"+emp.department.name+"</td>";
						htmlContents += "<td>"+Number(parseInt(parseInt(emp.salary)/12)).toLocaleString()+"원</td>";
						htmlContents += "</tr>";
					});
				}
				if(result.monthlyList) {
					list = result.monthlyList;
					$.each(list, function(index, item) {
						htmlContents += "<tr>";
						htmlContents += "<td>"+item.employee.no+"</td>";
						htmlContents += "<td>"+item.employee.position.name+"</td>";
						htmlContents += "<td>"+item.employee.name+"</td>";
						htmlContents += "<td>"+moment(item.employee.hiredate).format("YYYY-MM-DD")+"</td>";
						htmlContents += "<td>"+item.employee.center.name+"</td>";
						htmlContents += "<td>"+item.employee.department.name+"</td>";
						htmlContents += "<td>"+Number(parseInt(item.pay)).toLocaleString()+"원</td>";
						htmlContents += "</tr>";
					});
				}
				$("#title").text(result.payments == 'Y'? "예상 지급 현황" : "지급 내역 현황");
				$("#pay-title").text(result.payments == 'Y'? "예상 지급액" : "지급액");
				if(result.payments == 'Y') {
					$("#btn-box").show();
				} else {
					$("#btn-box").hide();
				}
				$("#salary-body").html(htmlContents);
				var totalPay = 0;
				$.each($("#salary-body tr").find("td:nth-child(7)"), function(index, item) {
					totalPay += parseInt($(item).text().replace(/[^\d]+/g,"").replace("원",""));
				});
				
				$("#total-money").val(Number(totalPay).toLocaleString() + "원");
				
			}
		})
		
	});
	
});
</script>
</html>