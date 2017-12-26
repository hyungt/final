<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
img {
	width: 100%;
	max-width: 760px;
	vertical-align: middle;
}
div.container {
	max-height: 1024px;
}
</style>
<script type="text/javascript">
var imgObj = new Image();
function showImgWin(imgName) {
  imgObj.src = imgName;
  setTimeout("createImgWin(imgObj)", 100);
}
function createImgWin(imgObj) {
  if (! imgObj.complete) {
    setTimeout("createImgWin(imgObj)", 100);
    return;
  }
  imgwin = window.open("", "imageWin","width=" + imgObj.width + ",height=" + imgObj.height);
  imgwin.document.write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>");
  imgwin.document.write("<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>"); // euc-kr? utf-8?
  imgwin.document.write("<title>큰이미지</title>");  // 새창 페이지 제목
  imgwin.document.write("</head><body style='margin:0px;padding:0px'>");
  imgwin.document.write("<a href='#' onclick='javascript:window.close()'><img src='" + imgObj.src + "' onclick='self.close();' alt='이미지를 클릭하시면 창이 닫힙니다.'></a>\n");
  imgwin.document.write("</body><html>");
  imgwin.document.title = imgObj.src;
}
</script>
<script type="text/javascript">
	$(function(){
		$("#error-message-box").hide();
		$("#buy").click(function(e){
			var qty = $("#totalQty").val()
			var buyQty = $("#count").val()
			if(parseInt(buyQty) > parseInt(qty)){
				$("#error-message").text("구매 가능 수량을 초과하였습니다.");
      			$("#error-message-box").show();
      			return false;
			}
			$("#formbox-order").submit();
		})
	})
</script>
</head>
<body>
	<%@ include file="../include/navi.jsp" %>
	<div class="container">
		<div class="row" style="margin-top: 30px;">
			<div class="row">
				<p><a href="/home.do"><strong>HOME</strong></a> > 
				<a href="list.do"><strong>쇼핑</strong></a> > 
				<a href="list.do?categoryId=${part.division.category.id }"><strong>${part.division.category.name }</strong></a> > 
				<a href="list.do?categoryId=${part.division.category.id }&divisionId=${part.division.id }"><strong>${part.division.name }</strong></a></p>
			</div>
			<hr size="2" color="black">
			<div class="row">
				<h2>${part.division.category.name }</h2>
			</div>
			<hr size="2" color="black">
		</div>
		<div class="row">
			<div class="row">
				<h4>${part.division.name }</h4>
			</div>
			<hr size="2" color="black">
			<div class="row">
				<form action="/order/purchase.do" method="get" id="formbox-order">
				<input type="hidden" name="partNo" value="${part.no }">
				<input type="hidden" id="totalQty" value="${part.qty }">
				<div class="col-sm-4">
					<div class="row" style="width: 300px; height: 500px; text-align: center;">
						<a href="javascript:showImgWin('/resources/images/part/${part.imagepath }')"><img alt="" src="/resources/images/part/${part.imagepath }" style="border: 2px solid lightblue;">
						&lt확대하기&gt</a>
					</div>
					<div>
					</div>
				</div>
				<div class="col-sm-8">
					<div class="row">
						<h3>${part.name }</h3>
					</div>
					<div class="row">
						<table class="table table-condenced well">
							<tr>
								<th>상품모델명</th>
								<td>${part.modelName }</td>
							</tr>
							<tr>
								<th>제조사</th>
								<td>응수전자</td>
							</tr>
							<tr>
								<th>상품번호</th>
								<td>${part.no }</td>
							</tr>
							<tr>
								<th>판매가격</th>
								<td>
									<c:if test="${part.qty gt 0 }">
										${part.price }원
									</c:if>
									<c:if test="${part.qty eq 0 }">
										<strong>품절입니다</str	ong>
									</c:if>
								</td>
							</tr>
							<tr>
								<th>수량</th>
								<td>
									<div class="alert alert-danger" id="error-message-box">
			   							<strong>Error!</strong> <span id="error-message"></span> 
		   							</div>
		   							<div>
										<input type="number" placeholder="1" value="1" size="3" maxlength="3" name="count" id="count" /> 개
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="row text-right">
						<c:if test="${part.qty gt 0 }">
							<a class="btn btn-info btn-sm" id="buy">구매</a> 
						</c:if>
						<a href="/order/list.do" class="btn btn-warning btn-sm">목록</a>
					</div>
					<div class="row">
						<c:if test="${not empty usingModels}">
						<div class="row">
							<h5>상품 적용 모델</h5>
						</div>
							<div class="row">|
								<c:forEach var="usingModel" items="${usingModels }">
									${usingModel.product.name } |
								</c:forEach>
							</div>
						</c:if>
					</div>
				</div>
				</form>
			</div>
		</div>
		<div class="row" >
			<ul class="nav nav-pills">
				<li class="active"><a href="#part" name="part">상세 정보</a></li>
				<li><a href="#appr">상품 한줄 평</a></li>
				<li><a href="#delivery">배송 정보</a></li>
				<li><a href="#refund">교환/반품</a></li>
				<li><a href="#as">A/S 안내</a></li>
			</ul>
		</div>
		<div class="row" id="goods-info">
			${part.info }
		</div>
		<div class="row" >
			<ul class="nav nav-pills">
				<li><a href="#part">상세 정보</a></li>
				<li class="active"><a href="#appr" name="appr">상품 한줄 평</a></li>
				<li><a href="#delivery">배송 정보</a></li>
				<li><a href="#refund">교환/반품</a></li>
				<li><a href="#as">A/S 안내</a></li>
			</ul>
		</div>
		<div class="row" id="goods-appr">
			<table class="table table-condensed well">
				<thead>
					<tr>
						<th>아이디</th>
						<th>한줄 평</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${apparaisals ne null }">
						<c:forEach var="apparaisal" items="${apparaisals }">
							<tr>
								<td>${apparaisal.user.id }</td>
								<td>${apparaisal.contents }</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="row">
			<ul class="nav nav-pills">
				<li><a href="#part">상세 정보</a></li>
				<li><a href="#appr">상품 한줄 평</a></li>
				<li class="active"><a href="#delivery" id="delivery">배송 정보</a></li>
				<li><a href="#refund">교환/반품</a></li>
				<li><a href="#as">A/S 안내</a></li>
			</ul>
		</div>
		<div class="row">
			<table class="table table-bordered well">
				<tr>
					<th>배송가능기간</th>
					<td>결제 후 3~5일 (휴일 제외)</td>
				</tr>
				<tr>
					<th>배송가능지역</th>
					<td>전국</td>
				</tr>
				<tr>
					<th>배송 수단</th>
					<td>우체국택배 (다른 배송수단 이용불가 > 예: 우체국택배가 아닌 택배, 소포, 퀵배송 등)</td>
				</tr>
			</table>
		</div>
		<div class="row">
			<ul class="nav nav-pills">
				<li><a href="#part">상세 정보</a></li>
				<li><a href="#appr">상품 한줄 평</a></li>
				<li><a href="#delivery">배송 정보</a></li>
				<li class="active"><a href="#refund" name="refund">교환/반품</a></li>
				<li><a href="#as">A/S 안내</a></li>
			</ul>
		</div>
		<div class="row well">
			<div class="row">
				<ul>
					<li>아래와 같은 경우는 교환및반품이 가능합니다</li>
					<li>1. 주문하신 상품 등을 실제 받으신 날로부터 7일내에 요청하실 경우</li>
					<li>2. 받으신 상품 등의 내용이 표시, 광고상의 내용 또는 주문하실 때의 내용과 다를 경우 (배송된 상품
						자체에 하자가 있거나 배송 중에 상품이 손상된 경우도 포함)
						<ul>
							<li>a. 상품등을 실제로 받으신 날로부터 3개월 이내</li>
							<li>b. 표시, 광고 및 주문내용과 다르다는 사실을 안 날 또는 알 수 있었던 날로부터 30일이내</li>
						</ul>
					</li>
					<li>3. 동일 상품에 대해서만 교환 가능하며, 타 상품과는 교환이 되지 않습니다.</li>
					<li>4. 전자상거래등에서의 소비자 보호에 관한 법률에 규정되어 있는 소비자 청약철회 가능 범위에 해당하는
						경우</li>
				</ul>
			</div>
			<div class="row">
				<ul>
					<li>아래와 같은 경우는 교환및반품이 불가능합니다</li>
					<li>1. 고객님의 부주의로 인하여 상품 등이 멸실 또는 훼손된 경우
						<ul>
							<li>a. 포장을 개봉하여 사용하거나 또는 설치가 완료되어 상품의 가치가 훼손된 경우에는 반품 및 교환이
								불가하오니 이점 양해하여 주시기 바랍니다. 단, 상품의 내용을 확인하기 위하여 포장을 개봉한 경우에는 교환 및
								반품이 가능합니다.</li>
						</ul>
					</li>
					<li>2. 시간이 경과되어 재판매가 어려울 정도로 상품 등의 가치가 크게 감소한 경우</li>
					<li>3. 기타 전자상거래등에서의 소비자 보호에 관한 법률이 정하는 소비자 청약 철회 제한에 해당하는 경우</li>
				</ul>
			</div>
		</div>
		<div class="row">
			<ul class="nav nav-pills">
				<li><a href="#part">상세 정보</a></li>
				<li><a href="#appr">상품 한줄 평</a></li>
				<li><a href="#delivery">배송 정보</a></li>
				<li><a href="#refund">교환/반품</a></li>
				<li class="active"><a href="#as" name="as">A/S 안내</a></li>
			</ul>
		</div>
		<div class="row well">
			<table class="table table-bordered">
				<tr>
					<th>1.</th>
					<td>당사 쇼핑몰에 판매되는 상품은 동일 상품에 대해서 가까운 삼성전자서비스 지점을 방문하시면 교환 및
					A/S가 가능합니다. (A/S 문의전화 : 1588-3366) 단, 반품 및 환불은 쇼핑몰을 통해서만 가능합니다.</td>
				</tr>
				<tr>
					<th>2.</th>
					<td>부품 교체가 요구되는 불량 증상일 경우 삼성전자 서비스 기준에 의거 처리됩니다. (예: 보증기간 내
					무상 A/S가능, 단 보증기간 이후 및 고객 과실건은 유상 A/S임)</td>
				</tr>
				<tr>
					<th>3.</th>
					<td>상품에 대한 소모품 액세서리는 가까운 삼성전자 서비스 지점을 방문하시면 추가 구입이 가능합니다.
					(예: 이어폰 고무, 이어폰, 블루투스 내장형 배터리 등)</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>