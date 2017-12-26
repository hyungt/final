<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/jstl.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;

						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('address1').value = fullAddr;

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('address2').focus();
					}
				}).open();
	}
</script>
<script type="text/javascript">
	$(
			function() {
				var ws = null;
				$("#error-message-box").hide();
				var nameExp = /^[가-힣]{2,}$/;
				var emailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				var phoneExp = /^01[016789]-\d{3,4}-\d{4}$/;
				var cardExp = /d{4}$/;
				$("#pick-user").change(function() {
					var check = $(this).prop("checked")
					if (check) {
						var userAddr = "${loginUser.address}"
						var addr = userAddr.split(',');
						var addr1 = addr[0];
						var addr2 = addr[1];

						$("input[name=recipient]").val("${loginUser.name}")
						$("input[name=email]").val("${loginUser.email}")
						$("input[name=phone]").val("${loginUser.phone}")
						$("input[name=zipcode]").val("${loginUser.zipcode}")
						$("input[name=address1]").val(addr1)
						$("input[name=address2]").val(addr2)
					} else {
						$("input[name=recipient]").val("")
						$("input[name=email]").val("")
						$("input[name=phone]").val("")
						$("input[name=zipcode]").val("")
						$("input[name=address1]").val("")
						$("input[name=address2]").val("")
					}
				})
				$("#buy")
						.click(
								function(e) {
									e.preventDefault()
									if (!$.trim($("#recipient").val())) {
										$("#error-message").text(
												"이름은 필수입력값입니다.");
										$("#error-message-box").show();
										return false;
									}
									if (!nameExp.test($("#recipient").val())) {
										$("#error-message").text(
												"이름은 2글자이상 한글만 가능합니다.");
										$("#error-message-box").show();
										return false;
									}
									if (!$.trim($("#email").val())) {
										$("#error-message").text(
												"이메일은 필수입력값입니다.");
										$("#error-message-box").show();
										return false;
									}
									if (!emailExp.test($("#email").val())) {
										$("#error-message").text(
												"유효한 이메일 주소형식이 아닙니다.");
										$("#error-message-box").show();
										return false;
									}
									if (!$.trim($("#address1").val())) {
										$("#error-message").text(
												"주소는 필수입력값입니다.");
										$("#error-message-box").show();
										return false;
									}
									connectWebSocket();
									$("#qrcode-img").attr(
											"src",
											"/order/genCode.do?userId="
													+ "${loginUser.no }")

									//$("#formbox-order").submit();
								});

				function connectWebSocket() {
					ws = new WebSocket("ws://"+location.host+"/authorization/verifyConnect.do");
					
					ws.onopen = function() {
						console.log("서버랑 연결됨")
					}
					
					ws.onmessage = function(event) {
						var code = event.data;
						
						if(code == "ok") {
							alert("본인 인증이 완료되었습니다.");
							$("#formbox-order").submit();
						} else {
							alert("인증에 실패하였습니다.");
						}
						
					}
					ws.onerror = function() {
						console.log("서버와 통신중 에러가 발생")
					}
					ws.onclose = function() {
						console.log("서버와 연결이 끊어짐")
					}
				}
			})
</script>
</head>
<body>
	<%@ include file="../include/navi.jsp"%>
	<div class="container">
		<form:form action="/order/addOrder.do" method="post"
			commandName="purchaseForm" id="formbox-order">
			<div class="row">
				<div class="row">
					<p>HOME > 쇼핑 > 음향기기 > 헤드셋</p>
				</div>
				<div class="row">
					<h1>주문하기</h1>
				</div>
			</div>
			<div class="row">
				<a href=""><span class="label label-primary">1. 주문서 작성<span
						class="glyphicon glyphicon-shopping-cart"></span></span></a> > <a href=""><span
					class="label label-default">2. 결제<span
						class="glyphicon glyphicon-usd"></span></span></a> > <a href=""><span
					class="label label-default">3. 주문완료<span
						class="glyphicon glyphicon-gift"></span></span></a>
			</div>
			<div class="row">
				<table class="table table-condensed">
					<thead>
						<tr>
							<th class="col-sm-8">상 품 명</th>
							<th class="col-sm-2">개수</th>
							<th class="col-sm-2">가격</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="col-sm-8">
								<div class="col-sm-4">
									<img alt="" src="/resources/images/part/${part.imagepath }">
								</div>
								<div class="col-sm-8">
									<input type="hidden" name="partNo" value="${part.no }" />
									<p>${part.name }</p>
									<p>${part.modelName }</p>
								</div>
							</td>
							<td class="col-sm-2">
								<div>
									<input type="hidden" name="count" value="${count }" />
									<p>${count }</p>
								</div>
							</td>
							<td class="col-sm-2">
								<div>
									<input type="hidden" name="purchase" value="${part.price }" />
									<p>${part.price }원</p>
								</div>
							</td>
						</tr>
						<tr>
					</tbody>
				</table>
				<table class="table table-condensed well">
					<tr>
						<th>업체명 :</th>
						<td>ES서비스센터</td>
						<th>배송료 :</th>
						<td>무료</td>
					</tr>
					<tr>
						<th></th>
						<td></td>
						<th>전체 상품 금액 :</th>
						<td>${part.price * count}원</td>
					</tr>
				</table>
			</div>
			<div class="row">
				<div class="alert alert-danger" id="error-message-box">
					<strong>Error!</strong> <span id="error-message"></span>
				</div>
				<input type="hidden" name="buyerNo" value="${loginUser.no }" />
				<div class="col-sm-6">
					<h3>배송정보 입력</h3>
					<hr class="one">
					<div class="row">
						<input type="checkbox" id="pick-user" />회원과 동일
					</div>
					<div class="row">
						<div class="form-group">
							<form:input type="text" class="form-control" path="recipient"
								placeholder="받는사람을 입력하세요" />
							<form:errors path="recipient" cssClass="text-danger"></form:errors>
						</div>
						<div class="form-group">
							<form:input type="text" class="form-control" path="email"
								placeholder="받는 사람의 이메일을 입력하세요" />
							<form:errors path="email" cssClass="text-danger"></form:errors>
						</div>
						<div class="form-group">
							<form:input type="text" class="form-control" path="phone"
								placeholder="받는 사람의 전화번호를 입력하세요" />
							<form:errors path="phone" cssClass="text-danger"></form:errors>
						</div>
						<div class="form-group">
							<input type="text" id="zipcode" name="zipcode" placeholder="우편번호"
								readonly="readonly" /> <input type="button"
								onclick="sample6_execDaumPostcode()" value="우편번호 찾기" /><br>
							<form:input type="text" class="form-control" path="address1"
								placeholder="주소" readonly="readonly" />
							<form:errors path="address1" cssClass="text-danger"></form:errors>
							<form:input type="text" class="form-control" path="address2"
								placeholder="상세주소" />
						</div>
						<div class="form-group">
							<textarea rows="3" class="form-control" name="message"
								placeholder="부재시 메세지를 입력하세요"></textarea>
						</div>
					</div>
				</div>
				<div class="col-sm-5 col-sm-offset-1">
					<h3>결제수단 선택</h3>
					<hr class="one">
					<div class="row form-group">
						<div class="row">
							<p>카드결제
							<p>
						</div>
					</div>
				</div>
			</div>
			<div class="row text-right">
				<button class="btn btn-info btn-sm" id="buy" data-toggle="modal"
					data-target="#myModal">결제</button>
				<a href="/order/list.do" class="btn btn-danger btn-sm">취소</a>
			</div>
		</form:form>
	</div>
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">ES전자 본인인증 서비스</h4>
				</div>
				<div class="modal-body">
					<p>본인 인증이 필요합니다. 아래의 QR코드를 본인의 스마트폰에 설치된 ES전자 본인인증 앱으로 읽어주시면
						결제가 완료됩니다.</p>
					<div class="row">
						<div class="col-sm-offset-3 col-sm-6">
							<img id="qrcode-img" src="" />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>