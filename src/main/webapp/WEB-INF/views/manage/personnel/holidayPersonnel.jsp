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
    <title>휴가자 현황</title>
<style>
    div.container {
        max-height: 1024px;
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
        	url:"/manage/personnel/HolidayPerList.do",
        	data:{deptId: department},
        	dataType:"json",
        	success:function(emps){
        		$("#people").remove();
        		var html = "";
        		$.each(emps,function(index, emp){
	        		html += "<tr>";
	        		html += "<td>"+emp.department.name+"</td>";
	        		html += "<td>"+emp.name+"</td>";
	        		html += "<td>"+emp.phone+"</td>";
	        		html += "<td>"+emp.email+"</td>";
	        		html += "</tr>"
        		});
        			$("tbody").html(html);
        	}
        });
        
    });
    $("input").keyup(function(){
    	var empName = $("input").val();
    	$.ajax({
    		type:"GET",
    		url:"/manage/personnel/findKeyword.do",
    		data:{keyword: empName},
    		dataType:"json",
    		success:function(empName){
    			console.log(empName);
    			$("#people").remove();
        		var html = "";
        		$.each(empName,function(index, emp){
        			html += "<tr>";
	        		html += "<td>"+emp.department.name+"</td>";
	        		html += "<td>"+emp.name+"</td>";
	        		html += "<td>"+emp.phone+"</td>";
	        		html += "<td>"+emp.email+"</td>";
	        		html += "</tr>"
        		});
        		$("tbody").html(html);
    		}
    	});
    });
   });
</script>
</head>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
   <div class="container">
    <h3>휴가자 현황</h3>
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
        <div>
            <div class="serchBar col-sm-8 well">
               <p>검색할 이름을 입력하세요</p>
                   <input type="text" class="col-sm-6" />
            </div>
        </div>
        <div class="col-sm-1"></div>
        <div id="bab" class="col-sm-8 well">
        
            <table class="table">
                <thead>
                    <tr>
                        <th>부서이름</th>
                        <th>이름</th>
                        <th>전화번호</th>
                        <th>이메일</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="empList" items="${employees }">
                    <tr id="people">
                        <td>${empList.department.name }</td>
                        <td>${empList.name }</td>
                        <td>${empList.phone }</td>
                        <td>${empList.email}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table> 
        </div>
    </div>
   </div>
</body>
</html>