<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/resources/css/userpage.css">
	<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
    <title>Document</title>
    <style type="text/css">
    	#phone .col-sm-1 {padding-left: 10px; padding-right: 5px;}
     	 #phone .col-sm-2 {padding-left: 5px; padding-right: 5px; }
     	 #phone {display: inline-block;}
     	 #error-message-box { height: 50px;}
    </style>
</head>
<body>
	<%@ include file="/WEB-INF/views/servicecenter/include/navi.jsp" %>
    <div class="container">
        <div class="row rowMan">
            <div id="div1" class="col-md-offset-2 col-md-4 well">
               <h3><span class="glyphicon glyphicon-menu-right"></span>메뉴 안내</h3>
               <p style="padding-left: 20px;"></p>
           </div>
          
           <div id="div2" class="col-md-4 well">
               <h3><span class="glyphicon glyphicon-menu-right"></span>정보 수정</h3>
           </div>
           <div class="container" style="background-color: white;" id="div22">
           	  <div class="row">
	           	  <div id="modify" class="col-sm-12">
		              <h2 style="">회원정보 수정</h2>
	              </div>
	              <div class="col-sm-12">
	              <div class="alert alert-danger" id="error-message-box">
					   <strong>Error!</strong> <span id="error-message"></span> 
				   </div>
				   </div>
	              
              <div class="col-sm-11 col-sm-offset-1" id="modifyForm">
            	  <h3 id="singleInfo">아이디정보</h3>
                  <form class="form-horizontal" action="/user/userMyPage.do" method="post" id="modifyUser">
                    <div class="form-group">
                      <label class="control-label col-sm-2" for="userid">아이디</label>
                      <div class="col-sm-4">
                        <input type="text" class="form-control" id="userId" name="id" value="${loginUser.id }" readonly >
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-sm-2" for="pwd">비밀번호</label>
                      <div class="col-sm-8">          
                        <input type="password" class="form-control" id="pw" placeholder="변경할 비밀번호를 입력해주세요." name="pw" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-sm-2" for="pwd">비밀번호 확인</label>
                      <div class="col-sm-8">          
                        <input type="password" class="form-control" id="pwdCheck" placeholder="변경할 비밀번호를 다시 입력해주세요." name="pwdCheck">
                      </div>
                    </div>
                    <hr>
                    <div class="form-group">
                   	  <h3 style="margin-left: 5px;">개인정보</h3>
                      <label class="control-label col-sm-2">이름</label>
                      <div class="col-sm-4">
                        <input type="text" class="form-control" id="userName" name="userNmae" value="${user.getName() }" readonly >
                      </div>
                    </div>
                    <div class="form-group">
		                       <label class="control-label col-sm-2" for="phone">전화번호</label>
		                    <div class="col-sm-9">
		                    	<div id="phone">
		                    	<div class="col-sm-2">
			                    <input type="text" class="form-control" id="phone" value="${fn:substring(loginUser.phone,0,3) }" name="phone" />
			                    </div>
			                    <div class="col-sm-1">
			                    <p>-</p>
			                    </div>
			                    <div class="col-sm-2">
			                    <input type="text" class="form-control" id="phone" name="phone" value="${fn:substring(loginUser.phone,4,8) }" />
			                    </div>
			                    <div class="col-sm-1">
			                    <p>-</p>
			                    </div>
			                     <div class="col-sm-2">
			                    <input type="text" class="form-control" id="phone" name="phone" value="${fn:substring(loginUser.phone,9,14) }" />
			                    </div>
		                    </div>
		                </div>
	                </div>
                    <div class="form-group">
                      <label class="control-label col-sm-2" for="email">이메일</label>
                      <div class="col-sm-8">          
                        <input type="email" class="form-control" id="email" placeholder="이메일을 작성해주세요" value="${loginUser.email }" name="email">
                      </div>
                    </div>
                    
                    <div class="form-group" id="cancelAndread">        
                      <div>
                        <button type="submit" class="btn btn-primary btn-md" style="width: 20%">확인</button>
                        <button type="button" class="btn btn-md" style="width:20%" id="cancel">취소</button>
                      </div>
                    </div>
                  </form>
              </div> 
           	</div>
                   
            </div>
           <div id="div3" class="col-md-offset-2 col-md-4 well">
               <h3 class="well"><span class="glyphicon glyphicon-menu-right"></span>주문 확인</h3>
           </div>
            <div class="container well" id="div33">
                 <div class="row" id="dateSearch">
                  <form action="" class="form-inline" id="dateForm">
                    <div class="form-group">
					    <label for="startdate">날짜 </label>
					    <input type="date" class="form-control" id="startdate">
					  </div>
					  <div class="form-group">
					    <label for="enddate"> ~ </label>
					    <input type="date" class="form-control" id="enddate">
					  </div>
					  <div class="form-group">
					  	<button id="ordercheck" class="btn btn-primary">조회</button>
					  </div>
                  </form>
              </div>
              <div class="row" id="table-area">
                <table class="table table-hover" id="joomoonTable">
                    <colgroup>
                        <col width="20%">
                        <col width="20%">
                        <col width="11%">
                        <col width="19%">
                        <col width="15%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>사진</th>
                            <th>상품명</th>
                            <th>주문 수량</th>
                            <th>가 격</th>
                            <th>주문 날짜</th>
                            <th>주문 상태</th>
                        </tr>
                    </thead>
                    <tbody id="product" style="font-size: 14.5px;">
                        
                    </tbody>
                </table>
           </div>
               <button class="btn btn-default btn-md">닫기</button>
        </div>
            
           <div id="div4" class="col-md-4" style="border: 1px solid; border-radius: 5px;">
               <h3><span class="glyphicon glyphicon-menu-right"></span>서비스 이력</h3>  
           </div>
           <div class="well" id="div44">
                  <div class="row">
                      <div class="col-md-offset-1 col-md-4 "><h2>서비스 이력</h2></div>
                      <div class="col-md-offset-4 col-md-3" style="font-style: italic; margin-top: 5%"><h5>마이페이지>서비스이력</h5></div>
                  </div>
                  <div class="row">
                      <div id="serviceUse" class="col-md-12 well">
                          <div class="col-md-2">
                              <img src="/resources/images/main/usermypage/service.PNG" id="bookLogo">
                          </div>
                          <div class="col-md-10">
                              <h3>서비스 이용현황</h3>
                              <ul>
	                              <li>홈페이지에서 예약하신 건에 대해 고객냄의 전화번호 기준으로 이력이 조회됨.</li>
	                              <li>전화번호 기준으로 조회되기 때문에 사실과 다른 경우 삭제해 주시기 바랍니다.</li>
	                              <li>휴대폰의 S/W, 펌웨어, 업그레이드 등의 간단한 이력은 최근 3개월, 나머지는 최근 2년간 이력만 조회됩니다 헤헷</li>
                              </ul>
                          </div>                
                      </div>
                  </div>
                  <div class="row" id="tablea">
                     <hr>
                      <table class="table table-hover text-center" id="part">
                      	<colgroup>
                      		<col width="30%">
                      		<col width="25%">
                      		<col width="25%">
                      		<col width="20%">
                      	</colgroup>
                      	<thead>
                      		<tr>
                      			<th>제품</th>
                      			<th>수리비용</th>
                      			<th>완료일</th>
                      			<th>수리형태</th>
                      		</tr>
                      	</thead>
                      	<tbody>
                      
                      		<c:choose>
        						<c:when test="${serviceCheck != null }">
		        					<c:forEach var="x" items="${serviceCheck }">
			                      		<tr>
			                      			<td>
			                      			  <ul>
			                      			  	  <c:forEach var="usingPart" items="${usingParts }">
					                      				<c:forEach var="e" items="${usingPart }">
			                      							<c:if test="${e.serviceResult.no == x.no }">
						                      					<li id="partName">${e.part.name }</li>
				                      						</c:if>
						                      			</c:forEach>
				                      			   </c:forEach>
			                      			  </ul>
			                      			</td>
				                      			<c:forEach var="m" items="${income }">
				                      				<c:if test="${m.key == x.no }">
				                      						<td><fmt:formatNumber value="${m.value }" /></td>
				                      				</c:if>
				                      			</c:forEach>
			                      			<td><fmt:formatDate value="${x.complete }"/></td>
			                      			<td>${x.repairInfo.type }</td>
			                      		</tr>
	                      			</c:forEach>
		        				</c:when>
		        				<c:otherwise>
		        						<tr>
		        							<td colspan="4" style="font-weight: bold; font-size: 20px;">서비스 이력이 없습니다.</td>
		        						</tr>
		        				</c:otherwise>
	        				</c:choose> 
                      	</tbody>
                      </table>         
                  </div>
                  
                  <div class="footer">
                  	<div class="text-center">
                        <ul class="pagination">
                        	<c:if test="${navi.totalRows gt 0 }">
								<c:choose>
									<c:when test="${navi.pageNo gt 1 }">
										<li><a href="${navi.pageNo - 1 }">&lt;</a></li>
									</c:when>
									<c:otherwise>
										<li class="disabled"><span>&lt;</span></li>
									</c:otherwise>
								</c:choose>
								<c:forEach var="p" begin="${navi.beginPage }" end="${navi.endPage }">
									<li class="${navi.pageNo eq p ? 'active' : '' }"><a href="${p }">${p }</a></li>
								</c:forEach>
								<c:choose>
									<c:when test="${navi.pageNo lt navi.totalPages }">
									<li><a href="${navi.pageNo + 1 }">&gt;</a></li>
									</c:when>
									<c:otherwise>
										<li class="disabled"><span>&gt;</span></li>
									</c:otherwise>
								</c:choose>
							</c:if>
                        </ul>
                    </div>
                  </div> 
    
                   <button class="btn btn-primary btn-md">닫기</button>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script>
$(function(){
	var userNo = "${loginUser.no}";
	
	$("#error-message-box").hide();
	
	function timeToString(time) {
		return moment(new Date(time)).format("YYYY-MM-DD");
	}	
	
	var nameExp = /^[가-힣]{2,}$/;
		var idPwdExp = /^[a-zA-Z0-9]{6,20}$/;
		var emailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	$("#modifyUser").submit(function() {
  		if (!$.trim($("#pw").val())) {
  			$('pw').text("${loginUser.pw}")
  		}
  		if(!$.trim($('#pwdCheck').val())) {
  			$('pw').text("${loginUser.pw}")
  		}
  		if(!$('#pwd').val().equals($('#pwdCheck').val())) {
  			$("#error-message").text("비밀번호와 동일하게 입력해주십시오.");
  			$("#error-message-box").show();
  			return false;
  		}
  		if(!$.trim($("#address").val())) {
  			$("#error-message").text("주소는 필수 입력값입니다.");
  			$("#error-message-box").show();
  			return false;
  		}
  		if (!$.trim($("#email").val())) {
  			$("#error-message").text("이메일은 필수입력값입니다.");
  			$("#error-message-box").show();
  			return false;
  		}
  		if (!emailExp.test($("#email").val())) {
  			$("#error-message").text("유효한 이메일 주소형식이 아닙니다.");
  			$("#error-message-box").show();
  			return false;
  		}
  		alert("정보가 수정되었습니다.");
  		return true;
  	});
	
	function ordercheck (userNo) {
		$.ajax ({
			url:"/user/ordercheck.do",
			data:{userNo:userNo},
			dataType:"json",
			success:function(data) {
				var html = "";
				var checked=0;
				var count = 0;
				var apprOrderNums = [];
				$.each(data.apparaisals, function(index, apparaisal){
					apprOrderNums[count] = apparaisal.order.no;
					count++;
				})
				$.each(data.orders, function (index, item){
					html += "<tr id='tr-appraisal-"+item.no+"'>";
					html += "<td><img src='/resources/images/part/"+item.part.imagepath+"' style='width: 120px; height: 100px;'/></td>";
					html += "<td>"+item.part.name+"</td>";
					html += "<td>"+item.count+"</td>";
					html += "<td>"+item.purchase+"</td>";
					html += "<td>"+timeToString(item.dates)+"</td>";
					html += "<td>"+item.statusId.type;
					for(var i = 0; i< count ; i++){
						if(apprOrderNums[i] == item.no){
							checked = 1;
						}
					}
					if(item.statusId.id == "ORDER-COMPLETE" && checked == 0){
						html += "<label class='btn btn-primary btn-sm' id='appraisal-"+item.part.no+"'>상품평등록</label>"
					}
					html += "</td>"
					html += "</tr>";
				})
				$('#product').prepend(html);
			}, error:function (err) {
				alert(err);
			}
		})
	}
	$("#product").on("click","label[id^=appraisal]",function(e){
		var partNo = $(this).attr("id").replace("appraisal-","")
		var orderNo = $("tr[id^=tr-appraisal]").attr("id").replace("tr-appraisal-","")
		e.preventDefault();
		var html = "";
		html += "<tr id='tr-addappraisal-"+orderNo+"'>";
		html += "<td colspan='12'>";
		html += "상품 평 : "
		html += "<input type='text' id='contents'/>"
		html += "<a href='' class='btn btn-primary btn-sm' id='addappraisal-"+partNo+"'>상품평 등록";
		html += "</td>";
		html += "</tr>";
		$(this).parents("tr").after(html);
	})
	$("#product").on("click","a[id^=addappraisal]",function(e){
		var contents = $("#contents").val()
		var orderNo = $("tr[id^=tr-addappraisal]").attr("id").replace("tr-addappraisal-","")
		var partNo = $(this).attr("id").replace("addappraisal-","")
		e.preventDefault();
		$.ajax ({
			url:"/user/addappraisal.do",
			data:{partNo:partNo, orderNo:orderNo, contents:contents},
			dataType:"json",
			success:function(data) {
			}
		})
		$(this).parents("tr").remove();
		$("label[id^=appraisal]").remove();
	})
	$('#ordercheck').click (function (e) {
		var startdate = $('input[id=startdate]').val();
		var enddate = $('input[id=enddate]').val();
		
		$.ajax ({
			url:"/user/checkclick.do",
			data:{userNo:userNo, startdate:startdate, enddate:enddate},
			dataType:"json",
			success:function(data) {
				console.log(data)	
			}, error:function (err) {
				alert(err);
			}
		})
		
		e.stopImmediatePropagation();
		e.preventDefault();
	})
	
    $("#div2").hover(function(){
        $("#div1 p").text("고객님의 정보를 수정할 수 있습니다.");
        }, function(){
        $("#div1 p").text("");
    })
     $("#div3").hover(function(){
    	 $("#div1 p").text("주문 내역을 확인할 수 있습니다.");
	     }, function(){
	     $("#div1 p").text("");
    })
     $("#div4").hover(function(){
    	 $("#div1 p").text("서비스 이력을 확인할 수 있습니다.");
	     }, function(){
	     $("#div1 p").text("");
    })
      
    $("#div2").click(function(){
        $("#div22").show().animate({
        });
        $("#div1").animate({
            opacity: '0.4'
        })
        $("#div2").animate({
            opacity: '0.4'
        })
        $("#div3").animate({
            opacity: '0.4'
        })
        $("#div4").animate({
            opacity: '0.4'
        })
    })
    
    $("#cancel").click(function(){
        $("#div22").animate({

            height:'toggle',
            width:'toggle'
        }).hide();
        $("#div1").animate({
            opacity: '1'
        })
        $("#div2").animate({
            opacity: '1'
        })
        $("#div3").animate({
            opacity: '1'
        })
        $("#div4").animate({
            opacity: '1'
        })
    })
    $("#div3").click(function(){
    	
    	$("#product").html("");
    	
        $("#div33").show().animate({
        });
        $("#div1").animate({
            opacity: '0.4'
        })
        $("#div2").animate({
            opacity: '0.4'
        })
        $("#div3").animate({
            opacity: '0.4'
        })
        $("#div4").animate({
            opacity: '0.4'
        })
        
        ordercheck(userNo);
    })
    
    $("#div33 button").click(function(){
        $("#div33").animate({
            height:'toggle',
            width:'toggle'
        }).hide();
        $("#div1").animate({
            opacity: '1'
        })
        $("#div2").animate({
            opacity: '1'
        })
        $("#div3").animate({
            opacity: '1'
        })
        $("#div4").animate({
            opacity: '1'
        })
    })
    
     $("#div4").click(function(){
        $("#div44").show().animate({
        });
        $("#div1").animate({
            opacity: '0.4'
        })
        $("#div2").animate({
            opacity: '0.4'
        })
        $("#div3").animate({
            opacity: '0.4'
        })
        $("#div4").animate({
            opacity: '0.4'
        })
    })
    
    $("#div44 button").click(function(){
        $("#div44").animate({
            height:'toggle',
            width:'toggle'
        }).hide();
        $("#div1").animate({
            opacity: '1'
        })
        $("#div2").animate({
            opacity: '1'
        })
        $("#div3").animate({
            opacity: '1'
        })
        $("#div4").animate({
            opacity: '1'
        })
    })
})
</script>
</html>