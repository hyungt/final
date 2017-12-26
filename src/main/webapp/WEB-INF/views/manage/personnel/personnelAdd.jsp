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
    <title>직원 등록 페이지</title>
<style>
    
    div.container {max-height: 1024px;}
    
</style>
<script>
   $(function(){
    $("li a").click(function(){
        $("li").removeClass("active");
        $(this).closest("li").addClass("active");
        var department = $(".active").attr("id");
        $("#department").val(department);
    });
   });
</script>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
    <div class="container">
        <h3>신규 직원 등록</h3>
        <div class="row">
            <div class="col-sm-3 well">
                <ul class="nav nav-pills nav-stacked text-center">
                    <li class="active" id="DEPT-INVEN"><a href="#">물류</a></li>
                    <li id="DEPT-HR"><a href="#">인사</a></li>
                    <li id="DEPT-ADMIN"><a href="#">운영</a></li>
                    <li id="DEPT-FIN"><a href="#">재무</a></li>
                    <li id="DEPT-SC"><a href="#">서비스</a></li>
                </ul>
            </div>
            <div class="col-sm-1"></div>
            <div class="col-sm-8 well">
                <div class="row">
                    <div class="col-sm-9">
                        <form:form class="form-horizontal" id="register-form" action="addemp.do" method="post" commandName="employeeForm" enctype="multipart/form-data">
                            <div class="form-group">
                                <label class="control-label col-sm-2">이름</label>
                                <div class="col-sm-10">
                                    <form:input type="text" class="form-control" path="name" id="name" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">비밀번호</label>
                                <div class="col-sm-10">
                                    <form:input type="password" class="form-control" path="password" id="password" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">이메일</label>
                                <div class="col-sm-10">
                                    <form:input type="text" class="form-control" path="email" id="email" />
                                </div>  
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">사진</label>
                                <div class="addPic col-sm-10">
                                    <input type="file" class="form-control" name="pic" id="pic" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">센터번호</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="center" id="center" >
                                    <c:forEach var="center" items="${centerList }">
                                    	<option value="${center.id }">${center.name }</option>
                                   	</c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">전화번호</label>
                                <div class="col-sm-10">
                                    <form:input type="text" class="form-control" path="phone" id="phone" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">부서번호</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="department" id="department" readonly="readonly"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">직급</label>
                                <div class="col-sm-10">
                                    <select class="form-control" name="position" id="position" >
                                    	<option value="POS-STAF">사원</option>
                                    	<option value="POS-AS">대리</option>
                                    	<option value="POS-SV">과장</option>
                                    	<option value="POS-TM">팀장</option>
                                    	<option value="POS-CM">센터장</option>
                                    	<option value="POS-CEO">사장</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2">연봉</label>
                                <div class="col-sm-10">
                                    <form:input type="text" class="form-control" path="salary" id="salary"/>
                                </div>
                            </div>
                            <div class="form-group text-right">
                                <div class="col-sm-10">
                                    <button type="submit" class="btn btn-primary" >완료</button>
                                </div>
                            </div>
                        </form:form>
						<c:if test="${param.err eq 'otherEmail' }">
							<span class="help-block"> <label class="text-danger"
								id="email-help-block">동일한 email이 존재합니다.</label>
							</span>
						</c:if>
						<c:if test="${param.err eq 'shortPassword' }">
							<span class="help-block"> <label class="text-danger"
								id="pass-help-block">비밀번호가 너무 짧습니다.</label>
							</span>
						</c:if>
					</div>
                    <div class="pic col-sm-3">
                        <img src="#" class="img-thumbnail" alt="" width="200" height="236"> 
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