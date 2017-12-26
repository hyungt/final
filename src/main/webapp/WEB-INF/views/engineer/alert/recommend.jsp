<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
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
	 
    <c:set var="menu" value="engMain" />
    <c:set var="innermenu" value="recommend" />
	<%@include file="../engnavi/navi.jsp" %>
    <div class="cotainer-fluid">
    	<div class="row">
    		<div class="col-sm-3 col-sm-2 sidebar">
    			<ul class="nav nav-sidebar text-center">
		             <li class="${innermenu eq 'alert' ? 'active' :'' }"><a href="/engineer/alert.do">공지사항</a></li>
	  			     <li class="${innermenu eq 'recommend' ? 'active' :'' }"><a href="/engineer/recommend.do">건의사항</a></li>
		          </ul>
    		</div>
    	</div>
    	<div class="col-sm-9 col-sm-offset-1 col-md-10 col-md-offset-1 main">
    		<h1>직원 건의사항</h1>
    		<hr>
    		<div class="container">
    			<div class="row">
    				<div class="col-sm-12" id="blank"></div>
    			</div>
    			<div class="row">
<!-- 왼쪽 화면 -->    			
	    			<div class="col-sm-6">
		    			<div class="col-sm-11">
		    			<div id="select" class="col-sm-12">
		    				<div class="col-sm-12" id="list">
		    					<form id="search-form" action="recommend.do">
			    				<input type="hidden" name="pageNo" value="${param.pageNo }"/>
								<input type="hidden" name="rows" value="${param.rows }"/>
<!-- 왼쪽화면 안에 테이블 시작 -->		    </form>				
			    				<table class="table table-condensed" id="suggestion-table">
									<colgroup>
										<col width="70%">
										<col width="30%">
									</colgroup>
									<thead>
										<tr>
											<th>제목</th>
											<th>등록일</th>
										</tr>
									</thead>
<!-- 글 리스트 반복출력 -->									
									<tbody>
										<c:if test="${empty boards }">
											<tr>
												<td colspan="5" class="text-center">검색된 결과가 없습니다.</td>
											</tr>
										</c:if>
										<c:forEach var="board" items="${boards }">
											<tr>
												<td><a href="${board.no}"><c:out value="${board.title}"/></a></td>
												<td><fmt:formatDate value="${board.createdate }" pattern="yyyy-MM-dd"/></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
<!-- 페이지네이션 include -->		<%@ include file="/WEB-INF/views/manage/notice/include/pagination.jsp" %>
<!-- modal 글 입력 버튼 -->								
			    				<div class="text-right">
			    					<a href="" class="btn btn-primary btn-sm" id="btn-new-suggestion" data-toggle="modal" data-target="#add-form-modal">건의하기</a>
		    					</div>
		    					
		    					
<!-- 왼쪽화면 안에 테이블 / modal로 글 입력 버튼 끝 -->
<!-- modal 폼 -->		    						    					
		    					<div class="modal fade" id="add-form-modal" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title">건의하기</h4>
											</div>
											<form>
												<input type="hidden" name="no">
												<div class="modal-body">
													<div class="form-group">
														<label>건의제목</label>
														<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요">
													</div>
													<div class="form-group">
														<label>건의 내용</label>
														<textarea rows="3" class="form-control" name="contents" placeholder="내용을 입력하세요"></textarea>
													</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
													<button type="button" class="btn btn-primary btn-sm" id="btn-add-suggestion">완료</button>
												</div>
											</form>
										</div>
									</div>
								</div>
<!-- modal폼 여기까지 -->								
		    				</div>
		    			</div>
		    			</div>
	    			</div>
	    			
<!-- 오른쪽 화면 -->	    			
	    			<div class="col-sm-6">
		    				<div class="row">
		    				<div class="col-sm-12" id="result">
			    				<table id="suggestion-detail-table" class="table table-hover">
			    					<tbody>
						    			
			    					</tbody>
			    				</table>
			    				<div id="btn-place-in">
			    				
			    				</div>
		    				</div>
	    				</div>
	    	  		</div>
    	  		</div>
    	  	</div>
    	</div>
    </div>
    <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script type="text/javascript">

	$(function(){
		
		$('.pagination a').click(function(event) {
			event.preventDefault();
			$(":input[name=rows]").val(5);
			$(':input[name=pageNo]').val($(this).attr('href'));
			$("#search-form").submit();
		});
		
		$("#suggestion-table tbody").on("click", "a", function() {
			event.preventDefault();
			
			$.ajax({
				type:"GET",
				url:"detail.do",
				data: {no:$(this).attr("href")},
				dataType:"json",
				success:function(suggest){
					console.log(suggest);
					var html = "";						
					
					html += "<tr>";
					html += "<th>제목</th><td colspan='3'>"+suggest.title+"</td>";
					html += "</tr>";
					html += "<tr>";
					html += "<th>번호</th><td>"+suggest.no+"</td>";
					html += "<th>조회수</th><td>"+suggest.count+"</td>";
					html += "</tr>";
					html += "<tr>";
					html += "<th></th><td></td>";
					html += "<th>등록일</th><td>" + suggest.createdate + "</td>";
					html += "</tr>";
					html += "<tr>";
					html += "<th>내용</th>";
					html += "<td colspan='3'>" + suggest.contents + "</td>";
					html += "</tr>";
										
					$("#suggestion-detail-table tbody").html(html);
					
					
					
				}
			});
		})
		
		$("#btn-add-suggestion").click(function(event) {
			event.preventDefault();
			
			var suggestion = {
				title: $(":input[name=title]").val(),
				contents: $(":input[name=contents]").val(),
			};
			
			$.ajax({
				type:"POST",
				url:"add.do",
				data: suggestion,	
				dataType: "json",					// 서버로부터 받는 응답데이터의 타입
				success:function(suggestion) {
					console.log(suggestion)
					var html = "<tr>";
					html += "<td>"+suggestion.no+"</td>";
					html += "<td><a href='"+suggestion.no+"'>"+suggestion.title+"</a></td>";
					html += "<td>"+suggestion.createdate+"</td>";
					//html += "<td>"
					//html += "<button class='btn btn-warning btn-xs' id='btn-modify-todo-"+suggestion.no+"'>수정</button>";
					//html += "<button class='btn btn-danger btn-xs' id='btn-del-todo-"+suggestion.no+"'>삭제</button>";
					//html += "</td>";
					html += "</tr>";
					
					$("#suggestion-table tbody").append(html);
				},
				complete:function() {
					$(":input[name=title]").val("");
					$(":input[name=dates]").val("");
					$(":input[name=description]").val("");
					$("#add-form-modal").modal("hide");
				}
			});
		});
	})
</script>
</html>