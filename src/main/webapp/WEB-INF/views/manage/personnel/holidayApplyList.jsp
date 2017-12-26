<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="pragma" content="no-store"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>휴가자신청자 현황</title>
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
        	url:"/manage/personnel/applyList.do",
        	data:{deptId:department},
        	dataType:"json",
        	success:function(bSign){
        		$("#people").remove();
        		var html = "";
        		$.each(bSign,function(index, bsign){
        			html += "<tr>";
	        		html += "<td>"+bsign.employee.name+"</td>";
	        		html += "<td>"+toDate(bsign.breaks.apply)+"</td>";
	        		html += "<td>"+bsign.employee.department.name+"</td>";
	        		html += "<td>"+bsign.breaks.reason+"</td>";
	        		html += "<td><button id='apply-completed-"+bsign.breaks.no +"' type='submit' class='btn btn-info'>승인</button>";
                    html += "<button type='button' id='apply-notcompleted-"+bsign.breaks.no+"' class='btn btn-danger' data-toggle='modal' data-target='#myModal'>반려</button></td>";
	        		html += "</tr>";
        		});
        		$("tbody").html(html);
        	}
        })
   });
    $("tbody").on('click','button[id^=apply-completed]',function(event){
    	event.preventDefault();
    	var $button = $(this);
		var cNo = $button.attr("id").replace("apply-completed-","");
		
		$.ajax({
			type:"POST",
			url:"/manage/personnel/completed.do",
			data:{employeeNo: cNo},
			dataType:"text",
			success:function(text){
				$button.parents("tr").remove();
			}
		});
    });
    function toDate(date) {
		return moment(new Date(date)).format("YYYY-MM-DD");
	};   
    $("tbody").on('click','button[id^=apply-notcompleted]',function(event){
    	event.preventDefault();
    	var $button = $(this);
		var cNo = $button.attr("id").replace("apply-notcompleted-","");
		
		$.ajax({
			type:"POST",
			url:"/manage/personnel/applyDetail.do",
			data:{breakNo: cNo},
			dataType:"json",
			success:function(breakS){
				var star = breakS.breaks.startdate;
				var endd = breakS.breaks.enddate;
				$("#apply-name").text(breakS.employee.name);
				$("#date-start").text(toDate(star));
				$("#date-end").text(toDate(endd));
				$("#apply-reason").text(breakS.breaks.reason);
			}
		});
    });
    
    $("#sub").on('click', function(){
    	var $button = $("button[id^=apply-notcompleted]");
    	var reason = $("textarea").val();
    	var cNo = $button.attr("id").replace("apply-notcompleted-","");
        $.ajax({
            type:"POST",
            url:"/manage/personnel/cencle.do",
            data:{reason:reason, breakNo:cNo},
            dataType:"text",
            success:function(text){
                $("#myModal").modal("hide");
                $("button[id^=apply-notcompleted]").closest("tr").remove();
            }
           
            
        });
    });
    $("input").keyup(function(){
    	var empName = $("input").val();
    	$.ajax({
    		type:"GET",
    		url:"/manage/personnel/applyKeyword.do",
    		data:{keyword: empName},
    		dataType:"json",
    		success:function(keywordList){
    			$("#people").remove();
        		var html = "";
        		$.each(keywordList,function(index, emp){
        			html += "<tr>";
	        		html += "<td>"+emp.employee.name+"</td>";
	        		html += "<td>"+toDate(emp.breaks.apply)+"</td>";
	        		html += "<td>"+emp.employee.department.name+"</td>";
	        		html += "<td>"+emp.breaks.reason+"</td>";
	        		html += "<td><button id='apply-completed-"+emp.breaks.no +"' type='submit' class='btn btn-info'>승인</button>";
                    html += "<button type='button' id='apply-notcompleted-"+emp.breaks.no+"' class='btn btn-danger' data-toggle='modal' data-target='#myModal'>반려</button></td>";
	        		html += "</tr>";
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
    <h3>휴가 신청자 현황</h3>
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
                   <p class="text-left">검색할 이름을 입력하세요</p>
                       <input type="text" class="col-sm-6" />
                </div>
            </div>
            <div class="col-sm-1"></div>
            <div id="bab" class="col-sm-8 well">
                <table class="table">
                    <thead>
                        <tr>
                            <th>신청자</th>
                            <th>신청일자</th>
                            <th>소속부서</th>
                            <th>신청사유</th>
                            <th>승인/반려</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="apply" items="${applylist }">
	                        <tr id="people">
		                            <td>${apply.employee.name }</td>
		                            <td><fmt:formatDate value="${apply.breaks.apply }" pattern="yyyy-MM-dd"/></td>
		                            <td>${apply.employee.department.name }</td>
		                            <td>${apply.breaks.reason }</td>
		                            <td><button id="apply-completed-${apply.breaks.no }" type="submit" class="btn btn-info">승인</button>
		                                <button id="apply-notcompleted-${apply.breaks.no }" type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">반려</button>
		                            </td>
	                        </tr>
	                  	</c:forEach>
                    </tbody>
                    <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h5 class="modal-title text-center">반려</h5>
                                </div>
                               	<form class="form-horizonral">
                                <div class="modal-body">
                                	<div class="form-group text-right">
                                		<label>신청자</label>
                                		<p id="apply-name" class="form-control"></p>
                                	</div>
                                	<div class="form-group text-right">
                                		<label class="text-right">휴가 기간</label>
                                		<p id="date-start" class="form-control"></p>부터<p id="date-end" class="form-control"></p>
                                	</div>
                                	<div class="form-group text-right">
                                		<label>신청 사유</label>
                                		<p id="apply-reason" class="form-control"></p>
                                	</div>
                                	<div class="text-center">
	                                    <label>반려사유</label>
	                                    <textarea cols="70" rows="10" type="text"></textarea>
                                	</div>
                                </div>
                                </form>
                                <div class="modal-footer">
                                    <button name="cancle" id="cancle" type="text" class="btn btn-danger" data-dismiss="modal">취소</button>
                                    <button name="sub" id="sub" type="submit" class="btn btn-info" >확인</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </table> 
            </div>
    </div>
   </div>
</body>
</html>