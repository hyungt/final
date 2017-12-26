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
<style type="text/css">
.container {width:1024px;}
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
    <c:set var="menu" value="service" />
    <c:set var="innermenu" value="reserve" />
	<%@include file="../engnavi/navi.jsp" %>
	<div class="cotainer-fluid">
    	<div class="row">
    		<div class="col-sm-3 col-sm-2 sidebar">
    			<ul class="nav nav-sidebar text-center">
		            <li class="${innermenu eq 'reserve' ? 'active' :'' }"><a href="/engineer/reserve.do">예약 확인</a></li>
	      			<li class="${innermenu eq 'stock' ? 'active' :'' }"><a href="/engineer/stock.do">재고 확인</a></li>
		          </ul>
    		</div>
    	</div>
	<div class="container">
		<h1>예약 현황</h1>
		<hr/>
		<div class="row">
			<div class="col-sm-12" id="blank"></div>
		</div>
		<div class="row">
			<div class="col-sm-6">
				<div class="col-sm-12">
		 			<div id="select" class="col-sm-12">
		 				<div class="col-sm-12" id="list">
			  				<div class="row">
			  					<div class="list-group" id="reserve-list">
			  						 
			  					</div>
			  				</div>
			  				<div class="row text-center">
				  				<ul class="pagination" id="page">
				  				</ul>
			  				</div>
		 				</div>
		 			</div>
				</div>
			</div>
			<div class="col-sm-6">
					<div class="row">
					<div class="col-sm-12" id="result">
	 				<table class="table table-bordered" id="reserve-detail">
	 					<tr class="bg-primary"><th>고객명</th></tr>
	 					<tr><td id="name"></td></tr>
	 					<tr class="bg-primary"><th>고객 전화번호</th></tr>
	 					<tr><td id="phone"></td></tr>
	 					<tr class="bg-primary"><th>고장 제품 종류</th></tr>
	 					<tr><td id="division" data-division=""></td></tr>
	 					<tr class="bg-primary"><th>고장 증세</th></tr>
	 					<tr><td id="symptom"></td></tr>
	 					<tr class="bg-primary"><th>완료여부</th></tr>
	 					<tr><td id="status"></td></tr>
	 					<tr><td><button id="btn" data-no="" class="btn btn-primary pull-right" data-toggle="modal" data-target="#myModal">완료</button></td></tr>
	 				</table>
					</div>
				</div>
	  		</div>
	 		</div>
	 	</div>
	 </div>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
	
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Modal Header</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>수리형태</label>
					<select id="select-repair" class="form-control">
						<option value="">---수리 형태을 선택하세요---</option>
						<c:forEach items="${repairInfoList}" var="repair">
							<option value="${repair.id }" data-price="${repair.price }">${repair.type }</option>
						</c:forEach>
					</select>
				</div>
				<div id="usingparts-div">
					<div id="usingparts-section">
						
					</div>
					<div id="usingpart-add-btn-box" class="text-center">
						<button id="add-parts-btn" class="btn btn-primary">부품 추가</button>
					</div>
				</div>
				<div class="form-group">
					<label>총 수리비</label>
					<input name="repairPrice" id="price" class="form-control" readonly/>
				</div>
			</div>
			<div class="modal-footer">
				<button id="repaire-success-btn" type="button" class="btn btn-primary">수리완료</button>
			</div>
			<div id="loading-modal" class="loading"><img id="loading-image" src="/resources/images/ajax-loader.gif" alt="Loading..." /></div>
		</div>
	</div>
</div>
<div id="loading" class="loading"><img id="loading-image" src="/resources/images/ajax-loader.gif" alt="Loading..." /></div>
</body>
<script type="text/javascript">
$(function() {
	var pno = 1;
	var partCnt = 0;
	var repairPrice = 0;
	$("#usingparts-div").hide();
	function getReserve(pageNo){
		$.ajax({
			type:"get",
			url: "/engineer/reserve/getReserve.do",
			data: {pageNo:pageNo},
			dataType: "json",
			success: function(result) {
				console.log(result);
				var htmlContents = "";
				$.each(result.serviceList, function(index, reserve) {
					var date = new Date(reserve.reservation);
					console.log(date);
					var reservation = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate() + "  " + ((date.getHours() == 9)?"09":date.getHours()) + "시" + ((date.getMinutes() == 0)?"00":"30") + "분";
					htmlContents += '<a class="list-group-item" href="'+reserve.no+'">'+reservation+'<span class="label label-primary pull-right">'+reserve.serviceStatus.status+'</span></a>';
				});
				var pageHtml = "";
				if(pageNo > 1) {
					pageHtml = "<li><a href='"+(pageNo - 1)+"'>prev</a></li>";
				}
				for(var i = result.criteria.beginPage; i <= result.criteria.endPage; ++i) {
					pageHtml += "<li class='"+(pageNo == i? "active":"")+"'><a href='"+i+"'>"+i+"</a></li>"
				}
				if(result.criteria.totalPages > pageNo) {
					pageHtml += "<li><a href='"+(parseInt(pageNo) + 1)+"'>next</a></li>";
				}
				$("#reserve-list").html(htmlContents);
				$("#page").html(pageHtml);
			}
		})
	}
	var partList = null;
	$("#select-repair").change(function(e) {
		if($(this).val() == "REP-SHI") {
			$("#usingparts-div").show();
			var division = $("#division").attr("data-division");
			$("#loading-modal").show();
			$.ajax({
				type:"get",
				url:"/engineer/reserve/getASDivision.do",
				data: {divisionId : division},
				dataType: "json",
				success: function(result) {
					partList = result;
				},
				complete: function() {
					$("#loading-modal").hide();
				}
			})
		} else {
			$("#usingparts-div").hide();
			$("#select-usingparts").val("");
			$("#usingparts-section div[id^=usingpart-]").remove();
			partCnt = 0;
		}
		repairPriceChange();
	});
	
	$("#usingparts-section").change(function(e) {
		repairPriceChange();
	});
	
	function repairPriceChange() {
		var totalPrice = 0;
		$("option:selected").each(function(index){
			totalPrice += parseInt($(this).attr("data-price"));
		});
		if(isNaN(totalPrice)) {
			totalPrice = 0;
		}
		$("#price").val(Number(totalPrice).toLocaleString() + "원");
	}
	
	$("#add-parts-btn").click(function(e) {
		partCnt++;
		
		var htmlContents = "";
		htmlContents += '<div id="usingpart-'+partCnt+'" class="row form-group">';
		htmlContents += '<div class="col-sm-10">';
		htmlContents += '<label>사용부품</label>';
		htmlContents += '<select id="select-usingparts-'+partCnt+'" class="form-control">';
		htmlContents += '<option value="" data-price="0">--------------</option>';
		
		$.each(partList, function(index, part) {
			htmlContents += '<option value="'+part.no+'" data-price="'+part.price+'">'+part.name+'</option>';
		});
		
		htmlContents += '</select>';
		htmlContents += '</div>';
		htmlContents += '<div class="col-sm-2">';
		htmlContents += '<label>삭제</label>';
		htmlContents += '<button id="delete-usingpart-'+partCnt+'" class="btn btn-danger">삭제하기</button>';
		htmlContents += '</div>';
		htmlContents += '</div>';
		
		$("#usingparts-section").append(htmlContents);
		
	});
	$("#usingparts-section").on("click", "button[id^=delete-usingpart-]", function(e) {
		var cntNumber = $(this).attr("id").replace("delete-usingpart-", "");
		$("#usingpart-"+cntNumber).remove();
		repairPriceChange();
	});
	$("#page").on("click", "a", function(e){
		e.preventDefault();
		pno = $(this).attr("href");
		getReserve(pno)
	});
	
	function getReserveById(reserveNo) {
		$.ajax({
			type:"get",
			url: "/engineer/reserve/getAfterService.do",
			data: {reserveNo:reserveNo},
			dataType:"json",
			success: function(result) {
				$("#btn").hide();
				$("#name").text(result.user.name);
				$("#phone").text(result.user.phone);
				$("#division").text(result.division.name);
				$("#division").attr("data-division", result.division.id);
				$("#symptom").text(result.symptom)
				$("#status").text(result.serviceStatus.status)
				if(result.serviceStatus.id == "STA_STANDBY"){
					$("#btn").show();
					$("#btn").attr("data-no", result.no)
				}
			}
		});
	}
	
	$("#reserve-list").on("click", "a", function(e) {
		e.preventDefault();
		var reserveNo = $(this).attr("href");
		
		getReserveById(reserveNo)
	});
	$("#btn").hide();
	getReserve(1);
	$('#btn').click(function (e) {
		$("#usingparts-section div[id^=usingpart-]").remove();
		$("#select-repair option:eq(0)").prop("selected", true);
		$("#usingparts-div").hide();
		repairPriceChange();
	});
	function getResultData() {
		var resultData = {
			serviceNo: $("#btn").attr("data-no"),
			repairId: $("#select-repair").val(),
			totalPrice: $("#price").val().replace("원","").replace(",",""),
			usingParts: getUsingParts()
		};
		console.log(resultData);
		return resultData;
	}
	function getUsingParts() {
		var partsList = [];
		$("#usingparts-section div[id^=usingpart-]").each(function(index) {
			$select = $(this).find("select");
			if($select.val() == "") {
				return;
			}
			console.log($select.val());
			partsList.push($select.val());
		});
		console.log($(partsList))
		return partsList.join(",");
	}
	$("#repaire-success-btn").click(function(e) {
		$("#myModal").modal('hide');
		$('#loading').show();
		var data = getResultData()
		$.ajax({
			type:"post",
			url:"/engineer/reserve/addResult.do",
			data: data,
			dataType:"text",
			success: function(result) {
				console.log(result);
				getReserve(pno);
				getReserveById(data.serviceNo);
				alert("서비스가 완료처리 되었습니다.");
			},
			error: function(err) {
				console.log(err);
			},
			complete: function() {
				$('#loading').hide();
			}
		});
	});
})
</script>
</html>