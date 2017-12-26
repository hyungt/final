<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" import="java.util.*"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ page import="java.text.SimpleDateFormat" %>
<%
	Map<String, Object> map = (Map<String, Object>) request.getAttribute("engineer");
	response.setHeader("Content-Disposition", "attachment; filename='"+URLEncoder.encode( ((String)map.get("name")) + "님의 급여명세서.xls", "utf-8")+"'");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
	th{
            font-weight:bold;
            background-color:#ddd;
            width: 12%;
        }
</style>
</head>
<body bgcolor="#ffffff" text="#000000" topmargin="0" leftmargin="0">
   <table width=784px; border=1; bordercolor=#A2AFCC; bordercolorlight=#ffffff; bordercolordark=#6C717D; cellspacing=0; cellpadding=0;>
   		<tr align="center" style="font-size: 20px;">
   			<th colspan="6">${engineer.name }님의 ${engineer.month } 급여 명세서</th>
   		</tr>
   		<tr align="center">
   			<th>부서명</th><td>${engineer.deptName }</td><th>센터명</th><td>${engineer.centerName }</td><th>이름</th><td>${engineer.name }</td>
   		</tr>
   		<tr align="center">
   			<th>직위</th><td>${engineer.position }</td><th>전화번호</th><td>${engineer.phone }</td><th>입사일</th><td><fmt:formatDate value="${engineer.hiredate }"/></td>
   		</tr>
   		<tr align="center">
   			<th>급여</th><td colspan="2"><fmt:formatNumber value="${engineer.salary }" /></td><th>세금, 공제금액</th><td colspan="2"><fmt:formatNumber value="${engineer.tax }" /></td>
   		</tr>
   		<tr align="center">
   			<th>최종 급여</th><td colspan="5"><fmt:formatNumber value="${engineer.total }" /></td>
   		</tr>
   		<tr align="center">
   			<td colspan="6">귀하의 노고에 진심으로 감사드립니다.</td>
   		</tr>
   </table>
</body>
</html>