<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="pragma" content="no-store"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
    <title>직원 정보 변경</title>
<style>
    
    div.container {max-height: 1024px;}
    
</style>
<script type="text/javascript">
$(function(){
	$("button").addClass("disabled");
	$(":input[id='password']").keyup(function(){
		var pass = $("#password").val();
		var phoneNo = $("#phone").val();
		if(pass != null && phoneNo != null){
			$("button").removeClass("disabled");
		}
		
	})
	
})
</script>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
    <div class="container">
        <h3>신규 직원 변경</h3>
        <div class="row">
            <div class="col-sm-12 well">
                <div class="row">
                    <div class="col-sm-9">
                        <form:form class="form-horizontal" id="change-form" action="changeEmp.do" commandName="employeeForm" method="post" enctype="multipart/form-data">
                        	<input type="hidden" name="no" value="${changeInfo.no }">
                        	<input type="hidden" name="email" value="${changeInfo.email }">
                            <div class="form-group">
                                <label class="control-label col-sm-2">이름</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="name" name="name" readonly="readonly" value="${changeInfo.name }" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">비밀번호</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="password" name="password" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">사진</label>
                                <div class="addPic col-sm-10">
                                    <input type="file" class="form-control" name="pic" id="pic" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">전화번호</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="phone" name="phone" value="${changeInfo.phone }" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">직급</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="position" id="position" readonly="readonly" value="${changeInfo.position.name }" />
                                </div>
                            </div>
                            <div class="form-group text-right">
                                <div class="col-sm-10">
                                    <button type="submit" class="btn btn-danger" >변경</button>
                                </div>
                            </div>
                        </form:form>
                        <c:if test="${param.err eq 'shortPassword' }">
							<span class="help-block"> <label class="text-danger"
								id="email-help-block">비밀번호가 입력되지 않았거나 너무 짧습니다.</label>
							</span>
						</c:if>
                        <c:if test="${param.err eq 'longPassword' }">
							<span class="help-block"> <label class="text-danger"
								id="email-help-block">비밀번호가 너무 깁니다.</label>
							</span>
						</c:if>
                        <c:if test="${param.success eq 'good' }">
							<span class="help-block"> <label class="text-primary"
								id="email-help-block">개인정보가 성공적으로 변경되었습니다.</label>
							</span>
						</c:if>
					</div>
                    <div class="pic col-sm-3">
                        <img src="/resources/images/emp/${changeInfo.pic }" class="img-thumbnail" alt="" width="200" height="236"> 
                    </div>                    
                </div>
            </div>
        </div>
   </div>
       <script type="text/javascript">
    
    $('#pic').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#pic').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('.img-thumbnail').attr('src', blobURL);
            $('.img-thumbnail').slideDown(); //업로드한 이미지 미리보기 
        }
    });
  
    </script>
</body>
</html>