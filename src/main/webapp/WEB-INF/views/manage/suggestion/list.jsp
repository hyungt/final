<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>건의사항 답변 게시판</title>
<meta charset="UTF-8">
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="pragma" content="no-store"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Expires" content="-1"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
	div.container {max-height: 1024px;}
</style>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
<div class="container">
	<div class="row">
	<h1>건의사항 답변</h1>
		<table class="table table-condenced">
			<thead>
				<tr>
					<th>글번호</th>
					<th>건의제목</th>
					<th>부서명</th>
					<th>작성일</th>
					<th>답변 여부</th>
				</tr>
			</thead>
			<tbody>
				<form>
					<div class="row col-sm-2">
						<select class="form-control" id="rows-box">
							<option value="5" ${param.rows eq '5' ? 'selected': '' }> 5개씩 보기</option>
							<option value="10" ${param.rows eq '10' ? 'selected': '' }> 10개씩 보기</option>
							<option value="20" ${param.rows eq '20' ? 'selected': '' }> 20개씩 보기</option>
						</select>
					</div>
					<div class="form-group pull-right">
						<select class="form-control" id="com-box" name="oppt">
							<option value="all" ${param.oppt eq 'all' ? 'selected' : ''}>전체선택</option>
							<option value="comp" ${param.oppt eq 'comp' ? 'selected' : ''}>답변완료</option>
							<option value="incomp" ${param.oppt eq 'incomp' ? 'selected' : ''}>답변미완료</option>
						</select>
					</div>
				</form>
				<c:forEach var="ie" items="${boards }">
					<tr>
						<td>${ie.no }</td>
						<td><a href="#" id="result-detail-${ie.no }" data-toggle="modal" data-target="#result-form-modal">${ie.title }</a></td>
						<td>${ie.employee.department.name }</td>
						<td><fmt:formatDate value="${ie.createdate }" pattern="yyyy-MM-dd"/></td>
						<c:choose>
							<c:when test="${ie.conf eq 1 }">
								<td><span class="label label-primary">답변</span></td>
							</c:when>
							<c:otherwise>
								<td><span class="label label-danger">미답변</span></td>
							</c:otherwise>
						</c:choose>						
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%@include file="/WEB-INF/views/manage/notice/include/pagination.jsp" %>
	<div class="col-sm-8">
			<form id="search-form" class="form-inline pull-right" action="/manage/suggestion/keyword.do">
				<input type="hidden" name="pageNo" value="${(param.pageNo eq null)? 1 : param.pageNo }"/>
				<input type="hidden" name="rows" value="${param.rows }"/>
				<input type="hidden" name="oppt" value="${param.oppt }"/>
				<div class="form-group">
					<label class="sr-only">검색조건</label>
					<select class="form-control" id="opt" name="opt">
						<option value="title" ${param.opt eq 'title' ? 'selected' : ''}>제목</option>
					<!-- 	<option value="contents" ${param.opt eq 'contents' ? 'selected' : ''}>내용</option> -->
					</select>
				</div>
				<div class="form-group">
					<label class="sr-only">키워드</label>
					<input type="text" class="form-control" name="keyword" value="${param.keyword }"/>
				</div>
				<button type="submit" class="btn btn-primary" id="btn-search">조회</button>
			</form>
			</div>
	</div>
	<div class="modal fade" id="result-form-modal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">건의사항 답변</h4>
				</div>
				<form>
					<input type="hidden" name="no">
					<div class="modal-body">
						<div class="form-group">
							<label>건의제목</label>
							<input type="text" class="form-control" disabled="disabled" name="title" >
						</div>
						<div class="form-group">
							<label>건의 부서</label>
							<input type="text" class="form-control" disabled="disabled" name="dept">
						</div>
						<div class="form-group">
							<label>건의 내용</label>
							<textarea rows="3" class="form-control" disabled="disabled" name="contents"></textarea>
						</div>
						<div class="form-group">
							<label>답변</label>
							<textarea rows="3" class="form-control" name="reple" ></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"
							data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary btn-sm" id="btn-reply">답변</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script type="text/javascript">
	$(function(){
		$("#rows-box").change(function(){
			$(':input[name=rows]').val($(this).val());
			$(':input[name=pageNo]').val(1);
			$(':input[name=oppt]').val($("#com-box").val())
			$('#search-form').submit();
		});
		
		$("#com-box").change(function(){
			$(':input[name=rows]').val($("#rows-box").val());
			$(':input[name=pageNo]').val(1);
			$(':input[name=oppt]').val($("#com-box").val())
			$('#search-form').submit();
		});
		
		$('.pagination a').click(function(event){
			event.preventDefault();
			$(':input[name=rows]').val($("#rows-box").val());
			$(':input[name=pageNo]').val($(this).attr('href'));
			$("#search-form").submit();
		});
		
		$("#btn-search").click(function(){
			$(':input[name=oppt]').val($("#com-box").val())
			$(':input[name=pageNo]').val(1);
			$(':input[name=rows]').val($("#rows-box").val());
			
		});
		
		$("a[id^=result-detail-]").click(function(){
			var cNo = $(this).attr("id").replace("result-detail-","");
			
			$.ajax({
				type:"POST",
				url:"/manage/suggestion/detail.do",
				data:{suuNo:cNo},
				dataType:"json",
				success:function(suggest){
						var itTitle = suggest.title;
						$("input[name=title]").val(itTitle);
						$("input[name=dept]").val(suggest.employee.department.name);
						$("textarea[name=contents]").val(suggest.contents);
					if(suggest.conf == 1){
							$("textarea[name=reple]").attr("disabled",true);
		
							$.ajax({
								type:"GET",
								url:"/manage/suggestion/detailComment.do",
								data:{parentNo:suggest.no},
								dataType:"json",
								success:function(sug){
									$("textarea[name=reple]").val(sug.contents);
									$("#btn-reply").attr("disabled", true);
									}
							})
						};
						if(suggest.conf == 0){
							 $("textarea[name=reple]").removeAttr("disabled");
							 $("textarea[name=reple]").val("");
							 $("#btn-reply").removeAttr("disabled");
							 $("#btn-reply").on('click', function(){
								var itContents = $("textarea[name=reple]").val();
								 
							 $.ajax({
								 type:"POST",
								 url:"/manage/suggestion/reply.do",
								 data:{pNo:cNo , itTitle:itTitle, contents:itContents},
								 dataType:"text",
								 success:function(){
									 $("#result-form-modal").modal("hide");
									 $('#search-form').submit();
								 }
							 })
						 })
					 }
				}
			});
		});
	})
</script>
</html>