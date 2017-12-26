<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
div.container {
	max-height: 1024px;
}

figure img {
	width: 40%;
	max-width: 160px;
}

#part-form-modal {
	display: none;
}

.single-item-box {
	padding-top: 10px;
	padding-bottom: 40px;
	margin-bottom: 30px;
	position: relative;
	max-height: 228px;	
}

#top-img {
	margin-top: 20px;
}

.single-item-inner {
	padding: 0px;
	margin: 0px;
	text-align: center;
}

.single-item-inner>* {
	margin-bottom: 10px;
}

.single-item-inner img {
	width: 100%;
}

#part-img{
	width: 152px;
	height: 100%;
}

.single-item-inner a:visited, .single-item-inner a:link {
	color: #03B7C8;
	text-decoration: none;
}

.single-item-inner a:hover {
	background: #03B7C8;
	color: white;
}

.single-item-price {
	color: gray;
}

.review-score i {
	color: gold;
}

.single-item-category {
	color: gray;
	font-size: 0.7em;
}

.single-item-title {
	font-weight: 700;
}
</style>
<script type="text/javascript">
	$(function(){
		$('.list-cat').siblings().hide();
		var initCat;
		if($("#hidden-cat").val() != ""){
			initCat = $("#hidden-cat").val()
		}else{
			initCat = 0;
		}
		var initDiv;
		if($("#hidden-div").val() != ""){
			initDiv = $("#hidden-div").val()
		}else{
			initDiv = 0;
		}
		$.getJSON("/rest/getexpendable", {pageNo:1, divisionId:initDiv, categoryId:initCat, rows:8}).done(function(result){
			$("li[id^=act]").removeClass("active");
		    $("li[id='act-"+result.cat+"']").addClass("active");
			var html="";
			if(result.parts.length!=0){
				$.each(result.parts, function(index, part){
					html += "<div class='single-item-box col-md-3'>"
					html += "<div class='single-item-inner'>"
					html += "<figure><a href='/order/detail.do?partNo="+part.no+"' ><img src='/resources/images/part/"+part.imagepath+"'></a></figure>"
					if(part.qty == 0){
						html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' ><strong>품절 </strong></a></p>"
					}else{
						html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' >"+ part.name + "</a></p>"
					}
					html += "<p>현재 재고 : "+ part.qty + "개</p>"
					html += "<p class='single-item-title'>가격 : " + part.price + "원</p>"
					html += "</div>"
					html += "</div>"
				})
			}else{
				html += "<div>"
				html += "<p>현재 등록된 상품이 없습니다</p>"
				html += "</div>"
			}
			$("#part-table").html(html);
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
			};
			$("#navi-pagination").html(html2);
		})
		$('.pagination').on("click","a",function(event){
			event.preventDefault();	
			var pageNo = $(this).attr("href");
			var categoryId = $("#ul-cat li[class=active]").children("a").attr("id");
			if($(".pickedDiv").attr("id")){
				var divisionId = $(".pickedDiv").attr("id").replace("list-div-","");
			}else{
				var divisionId = 0;
			}
			$.getJSON("/rest/getexpendable", {pageNo:pageNo, divisionId:divisionId, categoryId:categoryId, rows:8}).done(function(result){
				var html="";
				if(result.parts.length!=0){
					$.each(result.parts, function(index, part){
						html += "<div class='single-item-box col-md-3'>"
						html += "<div class='single-item-inner'>"
						html += "<figure><a href='/order/detail.do?partNo="+part.no+"' ><img src='/resources/images/part/"+part.imagepath+"'></a></figure>"
						if(part.qty == 0){
							html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' ><strong>품절 </strong></a></p>"
						}else{
							html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' >"+ part.name + "</a></p>"
						}
						html += "<p>현재 재고 : "+ part.qty + "개</p>"
						html += "<p class='single-item-title'>가격 : " + part.price + "원</p>"
						html += "</div>"
						html += "</div>"
					})
				}else{
					html += "<div>"
					html += "<p>현재 등록된 상품이 없습니다</p>"
					html += "</div>"
				}
				$("#part-table").html(html);
				if(result.parts.length!=0){
					var html2="";
					var navi = result.navi;
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
				};
				$("#navi-pagination").html(html2);
			})
		});
		$('.list-cat').on('click', function(e) {
			e.preventDefault();
		    $('.glyphicon', this)
		      .toggleClass('glyphicon-chevron-right')
		      .toggleClass('glyphicon-chevron-down');
		    $(this).parents("li").siblings().removeClass("active");
		    $(this).parents("li").addClass("active");
		    $(".pickedDiv").removeClass("pickedDiv");
		    var categoryId = $(this).attr("id");
		    var pageNo = 1;
		    if(categoryId!="0"){
		    	$("#main-img").attr("src","/resources/images/order/"+categoryId+".jpg")
		    	$('.glyphicon').removeClass('glyphicon-chevron-down')
		    	$('.glyphicon').addClass('glyphicon-chevron-right')
		    	$('.glyphicon', this)
		      .toggleClass('glyphicon-chevron-right')
		      .toggleClass('glyphicon-chevron-down');
		    	$('.list-cat').siblings().hide("slow");
		    	$(this).siblings().toggle("slow");
		    }else{
		    	$("#main-img").attr("src","/resources/images/order/main_visual.jpg")
		    	$('.glyphicon').removeClass('glyphicon-chevron-down')
		    	$('.glyphicon').addClass('glyphicon-chevron-right')
		    	$('.list-cat').siblings().hide("slow");
		    }
		    $.getJSON("/rest/getexpendable", {pageNo:pageNo, divisionId:0, categoryId:categoryId, rows:8}).done(function(result){
				var html="";
				if(result.parts.length!=0){
					$.each(result.parts, function(index, part){
						html += "<div class='single-item-box col-md-3'>"
						html += "<div class='single-item-inner'>"
						html += "<figure><a href='/order/detail.do?partNo="+part.no+"' ><img src='/resources/images/part/"+part.imagepath+"'></a></figure>"
						if(part.qty == 0){
							html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' ><strong>품절 </strong></a></p>"
						}else{
							html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' >"+ part.name + "</a></p>"
						}
						html += "<p>현재 재고 : "+ part.qty + "개</p>"
						html += "<p class='single-item-title'>가격 : " + part.price + "원</p>"
						html += "</div>"
						html += "</div>"
					})
				}else{
					html += "<div>"
					html += "<p>현재 등록된 상품이 없습니다</p>"
					html += "</div>"
				}
				$("#part-table").html(html);
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
				};
				$("#navi-pagination").html(html2);
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
		    if(categoryId!="0"){
			    $("#main-img").attr("src","/resources/images/order/"+categoryId+".jpg")
			}else{
			    $("#main-img").attr("src","/resources/images/order/main_visual.jpg")
			}
		    $("li[id^=act-]").siblings().removeClass("active");
		    $("li[id=act-"+categoryId+"]").addClass("active");
		    $.getJSON("/rest/getexpendable", {pageNo:pageNo, divisionId:divisionId, categoryId:categoryId, rows:8}).done(function(result){
				var html="";
				if(result.parts.length!=0){
					$.each(result.parts, function(index, part){
						html += "<div class='single-item-box col-md-3'>"
						html += "<div class='single-item-inner'>"
						html += "<figure><a href='/order/detail.do?partNo="+part.no+"' ><img src='/resources/images/part/"+part.imagepath+"'></a></figure>"
						if(part.qty == 0){
							html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' ><strong>품절 </strong></a></p>"
						}else{
							html += "<p class='single-item-category'><a href='/order/detail.do?partNo="+part.no+"' >"+ part.name + "</a></p>"
						}
						html += "<p>현재 재고 : "+ part.qty + "개</p>"
						html += "<p class='single-item-title'>가격 : " + part.price + "원</p>"
						html += "</div>"
						html += "</div>"
					})
				}else{
					html += "<div>"
					html += "<p>현재 등록된 상품이 없습니다</p>"
					html += "</div>"
				}
				$("#part-table").html(html);
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
				};
				$("#navi-pagination").html(html2);
			})
		})
	})
</script>
</head>
<body>
<%@ include file="../include/navi.jsp" %>
<div class="container">
	<div class="row" id="top-img">
		<div class="col-sm-8 col-sm-offset-4">
			<div class="row">
				<c:choose>
					<c:when test="${categoryId ne null}">
						<img alt="" src="/resources/images/order/${categoryId}.jpg" id="main-img">
					</c:when>
					<c:otherwise>
						<img alt="" src="/resources/images/order/main_visual.jpg" id="main-img" >
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="row">
		<hr style="border: solid 2px black;">
	</div>
		<div class="col-sm-3">
			<div class="row">
			<input type="hidden" id="hidden-cat" value="${categoryId }">
			<input type="hidden" id="hidden-div" value="${divisionId }">
				<ul class="nav nav-pills nav-stacked well" id="ul-cat">
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
			<div class="row" id="part-table"></div>
		</div>
		<div class="row text-center">
			<ul class="pagination" id="navi-pagination">
			</ul>
		</div>
	</div>
</body>
</html>