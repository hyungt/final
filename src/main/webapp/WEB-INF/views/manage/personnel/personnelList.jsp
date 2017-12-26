<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>직원 정보 확인 페이지</title>
<style>
     
    div.container {
        max-height: 1024px;
    }
    img{
        max-width: 130px; 
        max-height: 150px;
    }
    
</style>
<script>
   $(function(){
   
    $("li a").click(function(){
        $("li").removeClass("active");
        $(this).closest("li").addClass("active");
        var department = $(".active").attr("id");
        $.ajax({
        	type:"GET",
        	url:"/manage/personnel/getByDetpId.do",
        	data:{deptId: department},
        	dataType:"json",
        	success:function(emps){
        		$("#people").remove();
        		var html = "";
        		$.each(emps,function(index, emp){
        		html += "<div>";
        		html += "<div id='empPic' class='col-sm-6 well'>";
        		html += "<div class='col-sm-5'>";
        		html += "<img src='/resources/images/emp/"+emp.pic+"' class='pic'>";
        		html += "</div>";
        		html += "<div class='textBox text-left col-sm-6'>";
        		html += "<label>이름</label>";
        		html += "<p>"+emp.name+"</p>";
        		html += "<label>직급</label>";
        		html += "<p>"+emp.position.name+"</p>";
        		html += "<label>부서</label>";
        		html += "<p>"+emp.department.name+"</p>";
        		html += "<label>전화번호</label>";
        		html += "<p>"+emp.phone +" </p>";
        		html += "</div>";
        		html += "</div>";
        		html += "</div>";
        		});
        		$("#bab").html(html);
        	}
        });
    });
    
    
    $("input").keyup(function(){
    	var empId = $("input").val();
    	$.ajax({
    		type:"GET",
    		url:"/manage/personnel/getByKeyword.do",
    		data:{keyword: empId},
    		dataType:"json",
    		success:function(empNs){
    			console.log(empNs);
    			
    			$("#people").remove();
        		var html = "";
        		$.each(empNs,function(index, empN){
        		html += "<div>";
        		html += "<div id='empPic' class='col-sm-6 well'>";
        		html += "<div class='col-sm-5'>";
        		html += "<img src='/resources/images/emp/"+empN.pic+"' class='pic'>";
        		html += "</div>";
        		html += "<div class='textBox text-left col-sm-6'>";
        		html += "<label>이름</label>";
        		html += "<p>"+empN.name+"</p>";
        		html += "<label>직급</label>";
        		html += "<p>"+empN.position.name+"</p>";
        		html += "<label>부서</label>";
        		html += "<p>"+empN.department.name+"</p>";
        		html += "<label>전화번호</label>";
        		html += "<p>"+empN.phone +" </p>";
        		html += "</div>";
        		html += "</div>";
        		html += "</div>";
        		});
        		$("#bab").html(html);
    		}
    	});
    });
   });
</script>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
   <div class="container">
    <h3>직원 명부</h3>
    <div class="row">
        <div class="col-sm-3 well well-lg">
                <ul class="nav nav-pills nav-stacked text-center" style="height: 1000%">
                    <li class="active" id="DEPT-INVEN"><a href="#">물류</a></li>
                    <li id="DEPT-HR"><a href="#">인사</a></li>
                    <li id="DEPT-ADMIN"><a href="#">운영</a></li>
                    <li id="DEPT-FIN"><a href="#">재무</a></li>
                    <li id="DEPT-SC"><a href="#">서비스</a></li>
                </ul>
        </div>
        <div class="col-sm-1"></div>
            <div>
                <div class="serchBar col-sm-8 well">
                   <p>검색할 이름을 입력하세요</p>
                       <input type="text" class="col-sm-6" value="${param.keyword}" />
                </div>
            </div>
            <div class="col-sm-1"></div>
                <div id="bab" class="col-sm-8 text-center well">
                	<c:forEach var="emp" items="${employees }">
                    <div id="people">
                        <div id="empPic" class="col-sm-6 well">
                           <div class="col-sm-5">
                                <img src="/resources/images/emp/${emp.pic }" class="pic">
                           </div>
                           <div class="textBox text-left col-sm-6">
                               <label>이름</label>
                               <p>${emp.name } </p>
                               <label>직급</label>
                               <p>${emp.position.name }</p>
                               <label>부서</label>
                               <p>${emp.department.name } </p>
                               <label>전화번호</label>
                               <p>${emp.phone } </p>
                           </div>
                       </div>
                  </div>               
                	</c:forEach>
              </div>
    </div>
   </div>
</body>
</html>