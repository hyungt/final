<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/commons/jstl.jsp" %>
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
    <c:set var="menu" value="mypage" />
    <c:set var="innermenu" value="myinfo" />
	<%@ include file="/WEB-INF/views/engineer/engnavi/navi.jsp" %>
   	 <div class="cotainer-fluid">
    	<div class="row">
    		<div class="col-sm-3 col-sm-2 sidebar">
    			<ul class="nav nav-sidebar text-center">
		            <li class="${innermenu eq 'vacation' ? 'active' :'' }"><a href="/engineer/mypage.do">휴가신청</a></li>
	      			<li class="${innermenu eq 'myinfo' ? 'active' :'' }"><a href="/engineer/myinfo.do">정보수정</a></li>
	      			<li class="${innermenu eq 'myinfocheck' ? 'active' :'' }"><a href="/engineer/myinfocheck.do">내 정보</a></li>
	      			<li class="${innermenu eq 'paystub' ? 'active' :'' }"><a href="/engineer/paystub.do">급여명세서 출력</a></li>
		          </ul>
    		</div>
    	</div>
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<div class="container">
    			<div class="row">
	    			<div class="col-sm-12">
		    			<h1><span class="glyphicon glyphicon-file"></span> 직원 정보 수정</h1>
			           <hr>
			           <div class="alert alert-danger" id="error-message-box">
						   <strong>Error!</strong> <span id="error-message"></span> 
					   </div>
        
			            <form:form id="register-form" method="POST" class="form-horizontal" action="update.do" commandName="employeeForm"> 
			               <div class="row" id="base">
				                <div class="form-group col-sm-12">
				                    <label class="control-label col-sm-3" for="email">이메일</label>
				                    <div class="col-sm-4">
					                    <form:input type="text" class="form-control" id="email" path="email" />
					                    <form:errors path="email" cssClass="text-danger"></form:errors>
				                    </div>
				                </div>
				               <div class="form-group col-sm-12">
				                    <label class="control-label col-sm-3" for="password">비밀번호</label>
				                    <div class="col-sm-4">
					                    <form:input type="password" class="form-control" id="password" path="password" />
					                    <form:errors path="password" cssClass="text-danger"></form:errors>
				                    </div>
				                </div>
				                <div class="form-group col-sm-12">
				                    <label class="control-label col-sm-3" for="id">이름</label>
				                    <div class="col-sm-4">
					                    <form:input type="text" class="form-control" id="name" path="name"  readonly="true" />
					                    <form:errors path="name" cssClass="text-danger"></form:errors>
				                    </div>
				                </div>
				                <div class="form-group col-sm-12">
				                    <label class="control-label col-sm-3" for="id">전화번호</label>
				                    <div class="col-sm-4">
					                    <form:input type="text" class="form-control" id="phone" path="phone" />
					                    <form:errors path="phone" cssClass="text-danger"></form:errors>
				                    </div>
				                </div>
				                 <div class="form-group col-sm-12">
				                    <label class="control-label col-sm-3" for="id">부서</label>
				                    <div class="col-sm-4">
					                    <form:input type="text" class="form-control" id="department" path="department" readonly="true" />
					                    <form:errors path="department" cssClass="text-danger"></form:errors>
				                    </div>
				                </div>
				                 <div class="form-group col-sm-12">
				                    <label class="control-label col-sm-3" for="id">센터</label>
				                    <div class="col-sm-4">
					                    <form:input type="text" class="form-control" id="center" path="center" readonly="true" />
					                    <form:errors path="center" cssClass="text-danger"></form:errors>
				                    </div>
				                </div>
				                 <div class="form-group col-sm-12">
				                    <label class="control-label col-sm-3" for="id">직급</label>
				                    <div class="col-sm-4">
					                    <form:input type="text" class="form-control" id="position" path="position" readonly="true" />
					                    <form:errors path="position" cssClass="text-danger"></form:errors>
				                    </div>
				                </div>			       
			                </div>
			                <div class="form-group text-center">
			                   <a href="/engineer/home.do" class="btn btn-default btn-md">돌아가기</a>
			                    <button type="submit" class="btn btn-primary btn-md">등록</button>
			                </div>
			            </form:form>
	    	  		</div>
    	  		</div>
    	  	</div>
    	</div>
    </div>
    <%@include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script type="text/javascript">
$(function () {
	$("#error-message-box").hide();
	
	var emailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var phoneExp = /^01[016789]-\d{3,4}-\d{4}$/;
	var idPwdExp = /^[a-zA-Z0-9]{6,20}$/;
	
	$("#register-form").submit(function() {
   		if (!$.trim($("#password").val())) {
   			$("#error-message").text("비밀번호는 필수입력값입니다.");
   			$("#error-message-box").show();
   			return false;
   		}
   		if (!idPwdExp.test($("#password").val())) {
   			$("#error-message").text("비밀번호는 6~20글자로 영문자, 숫자만 가능합니다.");
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
   		return true;
	})
})
</script>
</html>