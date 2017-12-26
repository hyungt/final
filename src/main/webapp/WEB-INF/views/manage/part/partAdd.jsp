<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="pragma" content="no-store"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Expires" content="-1"/>
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
img{
	width: 100px;
	height: 100px;
}
</style>
<script type="text/javascript" src="/resources/js/manage/part/partpaging.js"></script>
<script type="text/javascript">
	$(function(){
		$("#error-message-box").hide();
		var nameExp = /^[a-z][a-z\d]{2,100}$/;
		var modelExp = /^[a-z][a-z\d]{2,100}$/;
		var qtyExp =  /^[0-9]+$/;
		var priceExp =  /^[0-9]+$/;
		var costExp =  /^[0-9]+$/;
		$("#image").on('change', function(){
            readURL(this);
        });
		$('#part-form-modal').on('hidden.bs.modal',function(e){
			$("#partnum").val("");
			$("#name").val("");
			$("#modelName").val("");
			$("#statusId").val("0");
			$("#sel-cat").val("0");
			$("#divId").val("0");
			$("input[id^=check-cat]").prop("checked",false);
			$("#check-div div").remove();
			$("#check-product div").remove();
			$("#image").val("");
			$("#image").show();
			$("#infoimg").val("");
			$("#partImage").attr("src","");
			$("#qty").val("");
			$("#price").val("");
			$("#cost").val("");
			$("#part-modal").attr("action","/manage/part/add.do")
		})
		$("input[id^=check-cat]").click(function(){
			var catId = $(this).attr("id").replace("check-cat-","");
			var check = $(this).prop("checked");
			$.getJSON("/rest/divs/"+catId).done(function(divs){
				if(!check){
					$.each(divs,function(index, div){
						$("#div-"+div.id).remove();
					})
				}else{
					var html="";
					html += '<div>';
					$.each(divs,function(index, div){	
					html += "<div id='div-"+div.id+"' style='display: inline;'>"
						html += "<input type='checkbox' id='check-div-"+div.id+"'><label>"+div.name+"</label>";
					html += "</div>"
					})
					html += "</div>"
					$("#check-div").append(html);
				}
			})
		})
		$("#check-div").on("click","input[id^=check-div]",function(){
			var divId = $(this).attr("id").replace("check-div-","");
			var check = $(this).prop("checked");
			$.getJSON("/rest/product/"+divId).done(function(products){
				if(!check){
					$.each(products,function(index, product){
						$("#div-"+product.id).remove();
					})
				}else{
					var html="";
					html += '<div>';
					$.each(products,function(index, product){	
					html += "<div id='div-"+product.id+"' style='display: inline;'>"
						html += "<input type='checkbox' id='check-pro-"+product.id+"' value='"+product.id+"' name='products'><label>"+product.name+"</label>";
					html += "</div>"
					})
					html += "</div>"
					$("#check-product").append(html);
				}
			})
		})
		$("#part-table tbody").on("click","a[id^=part-no]",function(){
			var partNo = $(this).attr("id").replace("part-no-","");
			var selectedCat=[];
			var selectedDiv=[];
			var selectedProduct=[];
			$.getJSON("/rest/partModify/"+partNo).done(function(result){	
				var categoryId = result.part.division.category.id
				var divisionId = result.part.division.id
				$.getJSON("/rest/divs/"+categoryId).done(function(divs){
					var html="";
					$.each(divs,function(index, div){
						html += "<option value='"+div.id+"'>"+div.name+"</option>";
					})
					if(categoryId != null){
						$("#divId option").remove();
					}
					$("#divId").append(html);
					$("#divId").val(divisionId);
				})
				var imgpath = '/resources/images/part/'+result.part.imagepath
				$("#partnum").val(result.part.no);
				$("#name").val(result.part.name);
				$("#modelName").val(result.part.modelName);
				$("#statusId").val(result.part.partStatus.id);
				$("#sel-cat").val(result.part.division.category.id);
				$("#partImage").attr("src",imgpath);
				$("#image").hide();
				$("#qty").val(result.part.qty);
				$("#price").val(result.part.price);
				$("#cost").val(result.part.cost);
				$("#part-modal").attr("action","/manage/part/modify.do")
				$.each(result.partUsingModels,function(index, model){
					selectedCat.push(model.product.division.category.id)
					selectedDiv.push(model.product.division.id)
					selectedProduct.push(model.product.id)
				})
				Array.prototype.unique = function() { return [...new Set(this)]; }
				var uniqueCat = selectedCat.unique();
				var uniqueDiv = selectedDiv.unique();
				$.each(uniqueCat,function(index, cat){
					$("input[id^=check-cat-"+cat+"]").prop("checked",true);
					$.getJSON("/rest/divs/"+cat).done(function(divs){
						var html="";
						html += '<div>';
						$.each(divs,function(index, div){	
							html += "<div id='div-"+div.id+"' style='display: inline;'>"
							html += "<input type='checkbox' id='check-div-"+div.id+"'><label>"+div.name+"</label>";
							html += "</div>"
						})
						html += "</div>"
						$("#check-div").append(html);
						$.each(uniqueDiv,function(index, div){
							$("input[id^=check-div-"+div+"]").prop("checked",true);
							$.getJSON("/rest/product/"+div).done(function(products){
								var html="";
								html += '<div>';
								$.each(products,function(index, product){	
								html += "<div id='div-"+product.id+"' style='display: inline;'>"
								html += "<input type='checkbox' id='check-pro-"+product.id+"' value='"+product.id+"' name='products'><label>"+product.name+"</label>";
								html += "</div>"
								})
								html += "</div>"
								$("#check-product").append(html);
								$.each(selectedProduct,function(index, product){
									$("input[id^=check-pro-"+product+"]").prop("checked",true);
								})
							})
						})
					})
				})
			})
		})
		$("btn-add").click(function(e){
			e.preventDefault()
			if (!$.trim($("#name").val())) {
				$("#error-message").text("부품 이름은 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!nameExp.test($("#modelName").val())) {
				$("#error-message").text("부품 이름은 2글자이상 영어와 숫자만 가능합니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!$.trim($("#modelName").val())) {
				$("#error-message").text("모델명은 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!nameExp.test($("#name").val())) {
				$("#error-message").text("모델명은 2글자이상 영어와 숫자만 가능합니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!$.trim($("#qty").val())) {
				$("#error-message").text("재고는 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!qtyExp.test($("#qty").val())) {
				$("#error-message").text("재고는 숫자만 가능합니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!$.trim($("#price").val())) {
				$("#error-message").text("가격은 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!qtyExp.test($("#price").val())) {
				$("#error-message").text("가격은 숫자만 가능합니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!$.trim($("#cost").val())) {
				$("#error-message").text("원가는 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!qtyExp.test($("#cost").val())) {
				$("#error-message").text("원가는 숫자만 가능합니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!$.trim($("#statusId").val()) || qtyExp.test($("#statusId").val())==0) {
				$("#error-message").text("제품 상태는 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!$.trim($("#sel-cat").val()) || qtyExp.test($("#sel-cat").val())==0) {
				$("#error-message").text("카테고리는 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			if (!$.trim($("#partImage").val())) {
				$("#error-message").text("이미지는 필수입력값입니다.");
				$("#error-message-box").show();
				return false;
			}
			$("#part-modal").submit();
		})
		$("#sel-cat").change(function(){
			var categoryId = $(this).val();
			if(categoryId!=0){
				$.getJSON("/rest/divs/"+categoryId).done(function(divs){
					console.log(divs)
					var html="";
					$.each(divs,function(index, div){
						html += "<option value='"+div.id+"'>"+div.name+"</option>";
					})
					if(categoryId != null){
						$("#divId option").remove();
					}
					$("#divId").append(html);
				})
			}else{
				$("#divId option").remove();
				var html="";
				html += "<option value='0'>선택하시오</option>"
				$("#divId").append(html);
			}
		})
	})
	function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#partImage').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
            }
        }
</script>
<body>
	<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
	<div class="container">
	<div class="row" style="text-align: center;">
		<h1>새 부품 등록</h1>
	</div>
		<div class="row">
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
		<div class="row text-right">
			<a href="" data-toggle="modal" data-target="#part-form-modal" class="btn btn-primary btn-sm" id="btn-addpart">새 부품 등록</a>
		</div>
	</div>
	<div class="modal fade" id="part-form-modal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3>부품 등록</h3>
				</div>	
				<div class="alert alert-danger" id="error-message-box">
					<strong>Error!</strong> <span id="error-message"></span>
				</div>
				<form id="part-modal" class="form-horizontal" enctype="multipart/form-data" action="/manage/part/add.do" method="post">
					<input type="hidden" id="partnum" name="partnum">
					<div class="modal-body">
						<div class="row">
							<div class="col-sm-5 col-sm-offset-1">
								<div class="row form-group">
									<label>부품명 : </label>
									<input type="text" name="name" id="name"/>
								</div>
								<div class="row form-group">
									<label>모델명 : </label>
									<input type="text" name="modelName" id="modelName"/>
								</div>
							</div>
							<div class="col-sm-5 col-sm-offset-1">
								<label>부품 상태 및 종류 선택</label>
								<div class="row form-group">
									<select name="statusId" id="statusId">
										<option value="0">선택하시오</option>
										<c:forEach var="stat" items="${status }">
											<option value="${stat.id }">${stat.status }</option>
										</c:forEach>
									</select>
								</div>
								<div class="row form-group">
									<select id="sel-cat">
										<option value="0">선택하시오</option>
										<c:forEach var="category" items="${categories }">
											<option value="${category.id }">${category.name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<select name="divId" id="divId">
										<option value="0">선택하시오</option>					
									</select>
								</div>
							</div>
						</div>
						<div class="row well">
							<div class="row">
							<c:forEach var="category" items="${categories }">
								<input type="checkbox" id="check-cat-${category.id }"><label>${category.name }</label>
							</c:forEach>
							</div>
							<hr class="one">
							<div class="row" id="check-div">
							</div>
							<hr class="one">
							<div class="row" id="check-product">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<div class="row col-sm-5 col-sm-offset-1">
									<div class="row">
										<label>제품이미지 : </label>
										<div class="row">
											<img alt="" src="#" id="partImage">
											<input type="file" class="form-control" name="image" id="image">
										</div>
									</div>
									<div class="row">
										<label>제품 정보 : </label>
										<input type="file" class="form-control" name="infoimg" id="infoimg">
									</div>
								</div>
								<div class="col-sm-5 col-sm-offset-1">
									<div class="row form-group">
										<label>재  고 	: </label>
										<input type="number" name="qty" id="qty"/>
									</div>
									<div class="row form-group">
										<label>판매가 : </label>
										<input type="number" name="price" id="price"/>
									</div>
									<div class="row form-group">
										<label>원  가 	: </label>
										<input type="number" name="cost" id="cost"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary btn-sm" id="btn-add">부품 등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>