<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
     <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
  <title>ES 회원 등록</title>
  <style>
      .container {margin-top: 3%; background-color:white; color: black;}
      body {background-color: #F4F4F4; margin-top: 2.5%; color: white; background-image: url('/resources/images/main/image/registe.PNG'); background-repeat: no-repeat; width: 100%; 
      		background-size: cover;}
      h1 {color: white; padding-left: 9%; padding-top: 6px;}
      #base {padding-right: 20%;}
      body {margin-left: 20%; margin-right: 400px;}
      #phone {display: inline-block;}
      #head {margin-top: -20px; margin-bottom: -5px; height: 100px; background-color: black; }
      #phone .col-sm-1 {padding-left: 10px; padding-right: 5px;}
      #phone .col-sm-2 {padding-left: 5px; padding-right: 5px; }
  </style>
 
</head>
<body>
	
	
   <div class="col-sm-1"></div>
    <div class="container col-sm-5">
        	<div class="row" id="head">
           		<h1><span class="glyphicon glyphicon-file"></span> 회원가입</h1>
           </div>
           <hr>
           <div class="alert alert-danger" id="error-message-box">
			   <strong>Error!</strong> <span id="error-message"></span> 
		   </div>
        
            <form:form id="register-form" method="post" class="form-horizontal" action="add.do" commandName="userform"> 
               <div class="row" id="base">
                <div class="form-group col-sm-12">
                    <label class="control-label col-sm-3" for="id">아이디</label>
                    <div class="col-sm-4">
	                    <form:input type="text" class="form-control" id="id" path="id" />
	                    <form:errors path="id" cssClass="text-danger"></form:errors>
                    </div>
                </div>
                <div class="form-group col-sm-12">
                    <label class="control-label col-sm-3" for="pwd">비밀번호</label>
                    <div class="col-sm-5">
	                    <form:input type="password" class="form-control" id="pw" path="pw" />
	                    <form:errors path="pw" cssClass="text-danger"></form:errors>
                    </div>
                </div>
                <div class="form-group col-sm-12">
                    <label class="control-label col-sm-3" for="name">이름</label>
                    <div class="col-sm-5">
	                    <form:input type="text" class="form-control" id="name" path="name" />
	                    <form:errors path="name" cssClass="text-danger"></form:errors>
                    </div>
                </div>
                <div class="form-group col-sm-12">
                    <label class="control-label col-sm-3" for="pwd">우편 번호</label>
                    <div class="col-sm-4">
	                    <form:input type="text" id="zipcode" class="postcodify_postcode5 form-control" path="zipcode" readonly="true" />
	             		<form:errors path="zipcode" cssClass="text-danger"></form:errors>
                    </div>
                    <button id="postcodify_search_button" class="btn btn-primary">검색</button>
                </div>
                <div class="form-group col-sm-12">
                    <label class="control-label col-sm-3">도로명</label>
                    <div class="col-sm-7">
	                    <form:input type="text" id="address" class="postcodify_address form-control" path="address" readonly="true" />
	                    <form:errors path="address" cssClass="text-danger"></form:errors>
                    </div>
                </div>
                 <div class="form-group col-sm-12">
	                 <label class="control-label col-sm-3">상세 주소</label>
	                 <div class="col-sm-7">
		                 <form:input type="text" id="address" class="postcodify_details form-control" path="address" />
		                 <form:errors path="address" cssClass="text-danger"></form:errors>
	                 </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-3" for="email">이메일</label>
                    <div class="col-sm-7">
	                    <form:input type="text" class="form-control" id="email" path="email" />
						<form:errors path="email" cssClass="text-danger"></form:errors>
                    </div>
                </div>
                <div class="form-group">
                     <label class="control-label col-sm-3" for="phone">전화번호</label>
                    <div class="col-sm-9">
                    	<div id="phone">
                    	<div class="col-sm-2">
	                    <input type="text" class="form-control" id="phone" name="phone" />
	                    </div>
	                    <div class="col-sm-1">
	                    <p>-</p>
	                    </div>
	                    <div class="col-sm-2">
	                    <input type="text" class="form-control" id="phone" name="phone" />
	                    </div>
	                    <div class="col-sm-1">
	                    <p>-</p>
	                    </div>
	                     <div class="col-sm-2">
	                    <input type="text" class="form-control" id="phone" name="phone" />
	                    </div>
                    </div>
                </div>
                </div>
                <div class="form-group text-center">
                   <a href="/home.do" class="btn btn-default btn-md">돌아가기</a>
                    <button type="submit" class="btn btn-primary btn-md">등록</button>
                </div>
                </div>
            </form:form>
    </div>
</body>
 <script type="text/javascript"> 
      $(function() { 
          
          $("#postcodify_search_button").click(event, function () {
              event.preventDefault();
              $(this).postcodifyPopUp();  
          }) 
          
          var idcheckpassed = true;
      	
      	$("#error-message-box").hide();
      		var nameExp = /^[가-힣]{2,}$/;
      		var idPwdExp = /^[a-zA-Z0-9]{6,20}$/;
      		var emailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
      	
      	$('#id').keyup(function() {
      		var userid = $(this).val()
      		console.log(userid)
      		if(!idPwdExp.test(id)) {
      			return;
      		}
      		$.ajax({
      			type:"GET",	
      			url:"/servicecenter/user/idcheck.do",
      			data:{id:userid},
      			dataType:"json",
      			success:function(result) {
      				console.log(result)
      				var used = result.used;
      				if(used) {
      					$('#id-help-block').text("사용중인 아이디입니다.")
      					idcheckpassed = false;
      				} else {
      					$('#id-help-block').text("사용가능한 아이디입니다.")
      					idcheckpassed = true;
      				}
      			}
      		})
      	})
      	
      	$("#register-form").submit(function() {
      		if(!idcheckpassed) {
      			console.log(idcheckpassed)
      			$('#error-message').text("아이디 중복검사를 통과하지 못했습니다.")
      			$('#error-message-box').show()
      			return false;
      		}
      		if (!$.trim($("#name").val())) {
      			$("#error-message").text("이름은 필수입력값입니다.");
      			$("#error-message-box").show();
      			return false;
      		}
      		if (!nameExp.test($("#name").val())) {
      			$("#error-message").text("이름은 2글자이상 한글만 가능합니다.");
      			$("#error-message-box").show();
      			return false;
      		}
      		if (!$.trim($("#id").val())) {
      			$("#error-message").text("아이디는 필수입력값입니다.");
      			$("#error-message-box").show();
      			return false;
      		}
      		if (!idPwdExp.test($("#id").val())) {
      			$("#error-message").text("아이디는 6~20글자로 영문자, 숫자만 가능합니다.");
      			$("#error-message-box").show();
      			return false;
      		}
      		if (!$.trim($("#pw").val())) {
      			$("#error-message").text("비밀번호는 필수입력값입니다.");
      			$("#error-message-box").show();
      			return false;
      		}
      		if (!idPwdExp.test($("#pw").val())) {
      			$("#error-message").text("비밀번호는 6~20글자로 영문자, 숫자만 가능합니다.");
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
      		alert("회원 가입이 완료 되었습니다.");
      		return true;
      	});
      }); 
  </script>
</html>