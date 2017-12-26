<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="pragma" content="no-store" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
div.container {
	max-height: 1024px;
}

img {
	width: 100%;
	max-width: 760px;
	vertical-align: middle
}

#part-form-modal {
	display: none;
}
</style>
<script type="text/javascript" src="/resources/js/manage/part/partpaging.js"></script>
<script type="text/javascript">
$(function() {
	$('.list-cat').siblings().hide();
	function getrows(result){
		var html="";
		if(result.parts.length!=0){
			$.each(result.parts, function(index, part){
				html += "<tr>"
				html += "<td>"+part.no+"</td>"
				html += "<td><a href='' data-toggle='modal' data-target='#part-form-modal' id='part-no-"+part.no+"'>"+part.name+"</a></td>"
				html += "<td>"+part.qty+"</td>"
				html += "<td>"+part.cost+"</td>"
				html += "<td>"+part.price+"</td>"
				html += "</tr>"
			})
		}else{
			html += "<tr>"
			html += "<td>등록된 부품이 없습니다</td>"
			html += "</tr>"
		}
		$("#part-table tbody tr").remove();
		$("#part-table tbody").append(html);
		
		var html2='';
		var navi = result.navi;
		if(result.parts.length!=0){
			html2 += '<li><a href="1">&laquo;</a>';
			if (navi.pageNo >= 2) {
				html2 += '<li><a href="'+(navi.pageNo-1)+'">&lt;</a>';
			} else {
				html2 += '<li class="disabled"><span>&lt;</span></li>';
			}
			for(var i=navi.beginPage; i <=navi.endPage;i++){
				html2 += '<li class="'+((navi.pageNo == i) ? "active" : "")+'"><a href='+i+'>'+i+'</a></li>';
			}
			if (navi.pageNo <navi.totalPages) {
				html2 += '<li><a href="'+(navi.pageNo+1)+'">&gt;</a>';
			} else {
				html2 += '<li class="disabled"><span>&gt;</span></li>';
			}
			html2 += '<li><a href="'+navi.totalPages+'">&raquo;</a>';			
		}
		$("#navi-pagination").html(html2);
	}
	$('.list-cat').on('click', function(e) {
		e.preventDefault();
	    $('.glyphicon', this)
	      .toggleClass('glyphicon-chevron-right')
	      .toggleClass('glyphicon-chevron-down');
	    $(this).parents("li").siblings().removeClass("active");
	    $(this).parents("li").addClass("active");
	    var categoryId = $(this).attr("id");
	    var divisionId = "0";
	    var pageNo = 1;
	    if(categoryId!="0"){
	    	$('.glyphicon').removeClass('glyphicon-chevron-down')
	    	$('.glyphicon').addClass('glyphicon-chevron-right')
	    	$('.glyphicon', this)
	      .toggleClass('glyphicon-chevron-right')
	      .toggleClass('glyphicon-chevron-down');
	    	$('.list-cat').siblings().hide("slow");
	    	$(this).siblings().toggle("slow");
	    }else{
	    	$('.glyphicon').removeClass('glyphicon-chevron-down')
	    	$('.glyphicon').addClass('glyphicon-chevron-right')
	    	$('.list-cat').siblings().hide("slow");
	    }
	    $.getJSON("/rest/getparts", {pageNo:pageNo, divisionId:divisionId, categoryId:categoryId}).done(function(result){
	    	getrows(result)
		})
	});
	$("a[id^=list-div]").click(function(e){
		e.preventDefault();
		$(".pickedDiv").removeClass("pickedDiv");
		$(this).addClass("pickedDiv");
		if($(".pickedDiv").attr("id")){
			var divisionId = $(".pickedDiv").attr("id").replace("list-div-","");
		}else{
			var divisionId = 0;
		}
		var categoryId = $(this).parents("ul[id^=list]").attr("id").replace("list-","");
	    var pageNo = 1;
	    $("li[id^=act-]").siblings().removeClass("active");
	    $("li[id=act-"+categoryId+"]").addClass("active");
	    $.getJSON("/rest/getparts", {pageNo:pageNo, divisionId:divisionId, categoryId:categoryId}).done(function(result){
	    	getrows(result)
		})
	})
	$("#part-table tbody").on("click","a[id^=part-no]",function(){
		var partNo = $(this).attr("id").replace("part-no-","");
		$.getJSON("/rest/part/"+partNo).done(function(part){
			var imgpath = '/resources/images/part/'+part.imagepath
			$("#part-no").text(part.no);
			$("#part-name").text(part.name);
			$("#part-modelName").text(part.modelName);
			$("#part-qty").text(part.qty);
			$("#part-img").attr("src", imgpath);
		})
	})
})
</script>
<body>
	<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
	<div class="container">
	<div class="row" style="text-align: center;">
		<h1>물품 재고 현황</h1>
	</div>
	<div class="row">
		<div class="col-sm-3">
			<div class="row">
				<ul class="nav nav-pills nav-stacked" id="ul-cat">
					<li class="active" id="act-0"><a href="#" class="list-cat" id="0">전체</a></li>
					<c:forEach var="category" items="${categories}">
						<li id="act-${category.id }"><a href="" class="list-cat" data-toggle="collapse"
							id="${category.id }"><i
								class="glyphicon glyphicon-chevron-right"></i>${category.name }</a>
							<ul id="list-${category.id }">
								<c:if test="${category.id eq 'CAT-PH'}">
									<c:forEach var="division" items="${phoneDivisions }">
										<li><a href="" id="list-div-${division.id }">${division.name }</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${category.id eq 'CAT-COM'}">
									<c:forEach var="division" items="${computerDivisions }">
										<li><a href="" id="list-div-${division.id }">${division.name }</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${category.id eq 'CAT-AP'}">
									<c:forEach var="division" items="${appliancesDivisions }">
										<li><a href="" id="list-div-${division.id }">${division.name }</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${category.id eq 'CAT-WE'}">
									<c:forEach var="division" items="${wearableDivisions }">
										<li><a href="" id="list-div-${division.id }">${division.name }</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${category.id eq 'CAT-SD'}">
									<c:forEach var="division" items="${soundDiviceDivisions }">
										<li><a href="" id="list-div-${division.id }">${division.name }</a></li>
									</c:forEach>
								</c:if>
							</ul></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="col-sm-8 col-sm-offset-1">
			<table class="table table-condenced" id="part-table">
				<thead>
					<tr>
						<th>물품번호</th>
						<th>물품명</th>
						<th>재고수량</th>
						<th>입고가</th>
						<th>출고가</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<div class="row text-center">
				<ul class="pagination" id="navi-pagination">
				</ul>
			</div>
		</div>
	</div>
	</div>
	<div class="modal fade" id="part-form-modal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3>물품 상세정보</h3>
				</div>
				<form class="form-horizontal">
					<div class="modal-body">
						<div class="form-group">
							<label>물품번호 : </label> <label id="part-no"></label>
						</div>
						<div class="form-group">
							<label>제품명 : </label> <label id="part-name"></label>
						</div>
						<div class="form-group">
							<label>모델명 : </label> <label id="part-modelName"></label>
						</div>
						<div class="form-group">
							<div class="col-sm-6" style="width: 100px; height: 100px">
								<img alt="" src="" id="part-img">
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label>재고 현황</label> <label id="part-qty"></label>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

</html>