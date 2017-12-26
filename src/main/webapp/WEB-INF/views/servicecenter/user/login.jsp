<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <title>login form</title>
  <style>
      body {background-color: white; background-color: #F4F4F4;}
      .container { height: 235px; background-color:white;  font-family: Malgun Gothic; height: 1000px;}
      img {width: 270px; height: 100px;}
      p {font-size: 20px; color: black;}
      #button {display: inline-block;}
      #login {padding-left: 42px; padding-bottom: 10px; margin-top: 4px;}
      #alert {text-align: left;}
      #alert, #login {font-weight: bold;}
      #blank {margin-top: 15%;}
      .navbar {background-color: white; height: 60px; position: relative; padding-left: 25%; font-weight: bold; font-size: 25px; color: black;
          margin-bottom: 0px; border-bottom: 1px groove;} 
      #help {margin-top: 2%; line-height: 14px;}
      #help p {font-size: 15px;}
  </style>
</head>
<body>
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="#">ESElectronic 계정</a>
	    </div>
	  </div>
	</nav>

	<div class="col-sm-3"></div>
    <div class="container col-sm-6">
          <div class="col-sm-12" id="blank">
          	<div class="col-sm-12">
                	<div class="row">
		              <div class="col-sm-12 text-center">
		                  <img src="/resources/images/main/image/main log.png">
		              </div>
		          </div>
                </div>
          </div>
          <div class="row">
              <div class="col-sm-6">
              <hr />
                  <div class="row">
                      <h3 id="login"><span class="glyphicon glyphicon-chevron-right"></span> 로그인</h3>
                  </div>
                   <form class="form-horizontal" method="post" action="login.do">
                  <div class="row">
                      <div class="col-sm-12">
                         
                        <div class="form-group">
                          <label for="exampleInputName2" class="control-label col-sm-1 sr-only">아이디</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" id="id" placeholder="아이디 입력" name="id">
                            </div>
                        </div>

                        <div class="form-group">
                          <label for="exampleInputName2" class="control-label col-sm-1 sr-only">비밀번호</label>
                          <div class="col-sm-10">
                            <input type="password" class="form-control" id="pwd" placeholder="비밀번호 입력" name="pwd">
                            </div>
                        </div>
                            
                          
                      </div>
                      <div class="text-right" style="margin-right: 10%;">
                          <button type="submit" class="btn btn-primary btn-md">로그인</button>
                      </div>
                  </div>
                  </form>
              </div>
              
                  <div class="row">
             		 <div class="col-sm-6" id="help" style="border-left: 1px solid; border-color: #d0d0e1;">
	              		<div class="col-sm-12">
	                	<h2 style="font-weight: bold;">ES 계정 하나면 충분합니다.</h2>
	                	<p>한번 가입으로 모든 서비스 사용가능!</p>
	                		<p>여러분에게 필요한 바로 그 기능!</p>
	                	</div>
	                	<div class="col-sm-12" style="margin-top: 13%;">
	                		<p>ES 계정이 아직 없으세요?</p>
	                		<p><a href="/user/registe.do">회원 가입 바로가기</a></p>
	                	</div>
		          </div>
              </div>  
          </div> 
           <hr/> 
          	<c:if test="${param.error eq 'fail' }">
					<div class="panel-footer">
						<p class="text-danger">아이디 혹은 비밀번호가 일치하지 않습니다.</p>
					</div>
				</c:if>
				<c:if test="${param.error eq 'deny' }">
					<div class="panel-footer">
						<p class="text-danger">로그인이 필요한 서비스 입니다.</p>
					</div>
				</c:if>   
    </div>
    <div class="col-sm-3"></div>
</body>
</html>