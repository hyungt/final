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
</head>
<body>
    <c:set var="menu" value="service" />
    <c:set var="innermenu" value="stock" />
	<%@include file="../engnavi/navi.jsp" %>
    <div class="container-fluid">
    	<div class="row">
    		<div class="col-sm-3 col-sm-2 sidebar">
    			<ul class="nav nav-sidebar text-center">
		            <li class="${innermenu eq 'reserve' ? 'active' :'' }"><a href="/engineer/reserve.do">예약 확인</a></li>
	      			<li class="${innermenu eq 'stock' ? 'active' :'' }"><a href="/engineer/stock.do">재고 확인</a></li>
		          </ul>
    		</div>
    	</div>
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<h1>DashBoard</h1>
    		<hr>
    		<div class="container">
    			<div class="row">
    				<div class="col-sm-12" id="blank"></div>
    			</div>
    			<div class="row">
	    			<div class="col-sm-6">
		    			<div class="col-sm-11">
		    			<div id="select" class="col-sm-12">
		    				<div class="col-sm-12" id="list">
		    					<div class="row">
		    						<div class="col-sm-6 form-group">
			    						<select id="category-select" class="form-control">
			    							<option value="">---대분류---</option>
			    							<c:forEach items="${categoryList}" var="category">
			    								<option value="${category.id}">${category.name }</option>
			    							</c:forEach>
			    						</select>
		    						</div>
		    						<div class="col-sm-6 form-group">
			    						<select id="division-select" class="form-control">
			    							<option value="">---중분류---</option>
			    						</select>
		    						</div>
		    					</div>
			    				<div class="row">
			    					<div id="part-div" class="list-group text-center">
			  							<span>분류를 선택하세요</span>
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
			    				<table id="part-table" class="table table-condensed">
		    						<tr><th class="bg-primary">부품명</th></tr>
									<tr><td id="part-name"></td></tr>
									<tr><th class="bg-primary">원가</th></tr>
									<tr><td id="part-cost"></td></tr>
									<tr><th class="bg-primary">가격</th></tr>
									<tr><td id="part-price"></td></tr>
									<tr><th class="bg-primary">현재 수량</th></tr>
									<tr><td id="part-qty"></td></tr>
									<tr><th class="bg-primary">제품형태</th></tr>
									<tr><td id="part-status"></td></tr>
			    				</table>
		    				</div>
	    				</div>
	    	  		</div>
    	  		</div>
    	  	</div>
    	</div>
    </div>
</body>
<script type="text/javascript">
$(function() {
	function getPartsAjax(divisionId, pageNo) {
		$.ajax({
			type:"get",
			url:"/engineer/reserve/getDivisionPart.do",
			data: {
				divisionId : divisionId,
				pageNo : pageNo
			},
			dataType: "json",
			success: function(result) {
				console.log(result);
				var html = "";
				$.each(result.partList, function(index, part) {
					html += '<a class="list-group-item" href="'+part.no+'">'+part.name+'</a>';
				});
				var pageHtml = "";
				if(result.partList.length > 0) {
					if(pageNo > 1) {
						pageHtml = "<li><a href='"+(pageNo - 1)+"'>prev</a></li>";
					}
					for(var i = result.criteria.beginPage; i <= result.criteria.endPage; ++i) {
						pageHtml += "<li class='"+(pageNo == i? "active":"")+"'><a href='"+i+"'>"+i+"</a></li>"
					}
					if(result.criteria.totalPages > pageNo) {
						pageHtml += "<li><a href='"+(parseInt(pageNo) + 1)+"'>next</a></li>";
					}
				}
				$("#page").html(pageHtml);
				$("#part-div").html(html);
			}
		});
	}
	$("#category-select").change(function(e) {
		var categoryId = $(this).val();
		
		$.ajax({
			type:"get",
			url:"/engineer/stock/getDivision.do",
			data: {categoryId:categoryId},
			dataType: "json",
			success: function(result) {
				var htmlContents = '<option value="">---중분류---</option>';
				$.each(result, function(index, division) {
					htmlContents += '<option value="'+division.id+'">'+division.name+'</option>';
				});
				$("#division-select").html(htmlContents);
			}
		})
		
	});
	$("#division-select").change(function(e) {
		var divisionId = $(this).val();
		getPartsAjax(divisionId, 1);
	});
	$("#part-div").on("click", "a", function(e) {
		e.preventDefault();
		var partNo = $(this).attr("href");
		$.ajax({
			type: "get",
			url: "/engineer/stock/getPartDetail.do",
			data: {partNo:partNo},
			dataType: "json",
			success : function(part) {
				$("#part-name").text(part.name);
				$("#part-cost").text(part.cost);
				$("#part-price").text(part.price);
				$("#part-qty").text(part.qty);
				$("#part-status").text(part.partStatus.status);
			}
		});
	});
	$("#page").on("click", "a", function(e) {
		e.preventDefault();
		getPartsAjax($("#division-select").val(), parseInt($(this).attr("href")));
	});
});
</script>
</html>