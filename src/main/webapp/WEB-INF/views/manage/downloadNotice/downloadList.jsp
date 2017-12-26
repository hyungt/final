<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
	div.container {max-height: 1024px;}
</style>
<body>
<%@include file="/WEB-INF/views/manage/common/navi.jsp"%>
<div class="container">
	<h1>업로드 페이지</h1>
		<div class="row">
			<form>
				<div class="form-group col-sm-3">
					<select class="form-control" name="categoryId">
						<option value="all" ${param.category eq 'all' ? 'selected': '' }>선택하세요</option>
						<option value="smartPhone" ${param.category eq 'smartPhone' ? 'selected': '' }>스마트폰</option>
						<option value="notebook" ${param.category eq 'notebook' ? 'selected': '' }>노트북</option>
						<option value="deTop" ${param.category eq 'deTop' ? 'selected': '' }>데스크탑</option>
					</select>
				</div>
			</form>
		</div>
		<table class="table table-condenced">
			<thead>
				<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>카테고리</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="downList" items="${uploadFile }">
				<tr>
					<td>${downList.no }</td>
					<td><a href="" id="viewTitle-${downList.no }" data-toggle="modal" data-target="#upload-form-modal">${downList.title }</a></td>
					<td>${downList.category }</td>
					<td><fmt:formatDate value="${downList.createdate }"/></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="text-right">
			<a href="" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#upload-form-modal">파일 업로드</a>
		</div>
		<div class="modal fade" id="upload-form-modal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">파일 업로드 등록폼</h4>
				</div>
				<form id="uploadFile" method="post" action="/manage/addUpload.do" enctype="multipart/form-data">
					<div class="modal-body">
						<div class="form-group">
							<label>파일명</label>
							<input type="text" class="form-control" id="title" name="title">
						</div>
						<div class="form-group">
							<select class="form-control" id="category" name="category" >
								<option value="smartPhone" ${param.category eq 'smartPhone' ? 'selected': '' }>스마트폰</option>
								<option value="notebook" ${param.category eq 'notebook' ? 'selected': '' }>노트북</option>
								<option value="deTop" ${param.category eq 'deTop' ? 'selected': '' }>데스크탑</option>
							</select>
						</div>
						<div class="form-group">
							<label>업로드 파일</label>
							<input type="file" class="form-control" id="upfile" name="upfile">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="3" class="form-control" id="contents" name="contents"></textarea>
						</div>
					</div>
				</form>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"data-dismiss="modal">닫기</button>
						<button type="button" name="uploadButton" class="btn btn-primary btn-sm" id="btn-addupload">등록</button>
					</div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	$(function(){
		$('#upload-form-modal').on('hidden.bs.modal',function(e){
			$(":input[name=title]").removeAttr('disabled');
			$(":input[name=category]").removeAttr('disabled');
			$(":input[name=upfile]").removeAttr('disabled');
			$(":input[name=contents]").removeAttr('disabled');
			$("button[name=uploadButton]").removeClass('hidden');
			$(":input[name=upfile]").attr('type','file');
			$(":input[name=title]").val("");
			$(":input[name=category]").val("");
			$(":input[name=upfile]").val("");
			$(":input[name=contents]").val("");
		})
		
		$('button[name=uploadButton]').on('click',function(){
			$('#uploadFile').submit();
		})
		$("a[id^=viewTitle-]").click(function(){
			$("button[name=uploadButton]").addClass('hidden');
			$(":input[name=title]").attr('disabled', 'true');
			$(":input[name=category]").attr('disabled', 'true');
			$(":input[name=upfile]").attr('disabled', 'true');
			$(":input[name=contents]").attr('disabled', 'true');
			$("h4").text("세부 내용 확인창");
			
			var cNo = $(this).attr("id").replace("viewTitle-","");
			$.ajax({
				type:"GET",
				url:"/manage/detailUpload.do",
				data:{fileNo:cNo},
				dataType:"json",
				success:function(downloadNotice){
					var fileName = downloadNotice.attachFile.name;
					var str = fileName.substring(13);
					
					$(":input[name=upfile]").attr('type','text');
					$(":input[name=title]").val(downloadNotice.title);
					$(":input[name=category]").val(downloadNotice.category);
					$(":input[name=upfile]").val(str);
					$(":input[name=contents]").val(downloadNotice.contents);
				}
				
			})
		})
	})
</script>
</html>