<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/commons/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8">
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="pragma" content="no-store"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Expires" content="-1"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script type="text/javascript" src="/resources/SmartEditor2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" ></script>
</head>
<style>
	div.container {max-width: 1024px;}
</style>
<body>
<%@ include file="/WEB-INF/views/manage/common/navi.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-sm-4">
			<h1>직원 공지사항</h1>
		</div>
	</div>
	<div class="row">	
		<div id="div-search" class="form-group text-right">
			<form id="form-search" class="form-inline pull-right" action="list.do">
				<input type="hidden" name="pageNo" value="${param.pageNo }"/>
				<input type="hidden" name="rows" value="${param.rows }"/>
				<div class="form-group">
					<label class="sr-only">select-opt</label>
					<select id="select-opt" class="form-control" name="opt">
						<option value="title" "${param.opt eq 'title' ? 'selected' : '' }">제목</option>
						<!-- 
						<option value="contents">내용</option>
						 -->
					</select>
				</div>
				<div class="form-group">
					<label class="sr-only">keyword</label>
					<input type="text" class="form-control" name="keyword" value="${param.keyword }" />
				
				<button type="submit" id="btn-search" class="btn btn-primary">조회</button>
				<a href="list.do" class="btn btn-default">초기화</a>
				</div>
			</form>
		</div>
		<table class="table table-condenced">
			<colgroup>
				<col width="15%">
				<col width="*">
				<col width="20%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>글 번호</th>
					<th>글 제목</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${empty boards }">
				<tr>
					<td colspan="5" class="text-center">검색된 결과가 없습니다.</td>
				</tr>
			</c:if>
			<tr>
				<td>0</td>
				<td><a href="" id="notice-detail" data-toggle="modal" data-target="#notice-form-modal"><c:out value="공지입니다"></c:out></a></td>
				<td>2017-11-06</td>
				<td>0</td>
			</tr>
			<c:forEach var="board" items="${boards }">
				<c:url var="detailURL" value="detail.do">
					<c:param name="no" value="${board.no }" />
				</c:url>
				<tr>
					<td>${board.no }</td>
					<td><a href="${detailURL }"/><c:out value="${board.title }"/></td>
					<td><fmt:formatDate value="${board.createdate }" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatNumber value="${board.count }" pattern="#,###"/></td>
				</tr>
			</c:forEach>
				
			</tbody>
		</table>
		
		<div class="row col-sm-2">
			<form>
				<select class="form-control" id="select-rows">
					<option value="5" ${param.rows eq '5' ? 'selected':'' }>5개씩 보기</option>
					<option value="10" ${param.rows eq '10' ? 'selected':'' }>10개씩 보기</option>
					<option value="20" ${param.rows eq '20' ? 'selected':'' }>20개씩 보기</option>
				</select>
			</form>
		</div>
		
		<div class="row text-right">
			<a href="addform.do" class="btn btn-primary btn-sm" id="btn-new-notice">새 공지 등록</a>
		</div>
		<%@ include file="/WEB-INF/views/manage/notice/include/pagination.jsp" %>
	</div>
	
</div>
<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
</body>
<script type="text/javascript">
	$(function() {
		
		$("#select-rows").change(function() {
			$(':input[name=rows]').val($(this).val());
			$(':input[name=pageNo]').val(1);
			$("#form-search").submit();
		});
		$('.pagination a').click(function(event) {
			event.preventDefault();
			$(':input[name=pageNo]').val($(this).attr('href'));
			$("#form-search").submit();
		});
		$("#btn-search").click(function() {
			$(':input[name=pageNo]').val(1);
		});
	});
</script>
</html>