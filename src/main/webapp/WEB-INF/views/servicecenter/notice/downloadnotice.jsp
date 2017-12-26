<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
</head>
<style>
	div.container {max-height: 1024px;}
</style>
<body>
<%@ include file="/WEB-INF/views/servicecenter/include/navi.jsp" %>
<div class="container">
	<h1>다운로드 페이지</h1>
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
		<table class="table table-condenced" id="board-table">
			<thead>
				<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>카테고리</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="row text-center">
			<ul class="pagination" id="navi-pagination">
			</ul>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
		<div class="modal fade" id="upload-form-modal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">다운로드</h4>
				</div>
				<form>
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
							<label>다운로드 파일</label>
							<p name="filename"></p>
							<a href="" class="btn btn-info btn-xs" id="download">다운로드</a>
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="3" class="form-control" id="contents" name="contents"></textarea>
						</div>
					</div>
				</form>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"data-dismiss="modal">닫기</button>
					</div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	$(function(){
		var cat1 = "${param.category }"
		function getrows(result){
			var m = moment();
			var html="";
			if(result.boards.length != 0){
				$.each(result.boards, function(index, board){
					var cdate = board.createdate
					cdate = m.format("YYYY-MM-DD")
					html += "<tr>";
					html += "<td>"+board.no+"</td>";
					html += "<td><a href='' id='viewTitle-"+board.no+"' data-toggle='modal' data-target='#upload-form-modal'>"+board.title+"</a></td>";
					html += "<td>"+board.category+"</td>";
					html += "<td>"+cdate+"</td>";
					html += "<tr>";
				})
			}else{
				html += "<tr>";
				html += "<td>드라이버가 존재하지 않습니다</td>";
				html += "<tr>";
			}
			$("#board-table tbody").html(html);
			var html2='';
			var navi = result.navi;
			if(result.boards.length!=0){
				html2 += '<li><a href="1">&laquo;</a>';
				if (navi.pageNo >= 2) {
					html2 += '<li><a href="'+(navi.pageNo-1)+'">&lt;</a>';
				} else {
					html2 += '<li class="disabled"><span>&lt;</span></li>';
				}
				for(var i=navi.beginPage; i <=navi.endPage;i++){
					html2 += '<li class="'+((navi.pageNo == i) ? "active" : "")+'"><a href='+i+'>'+i+'</a></li>';
				}
				if (navi.pageNo <navi.totalPages) {
					html2 += '<li><a href="'+(navi.pageNo+1)+'">&gt;</a>';
				} else {
					html2 += '<li class="disabled"><span>&gt;</span></li>';
				}
				html2 += '<li><a href="'+navi.totalPages+'">&raquo;</a>';			
			}
			$("#navi-pagination").html(html2);
		}
		$.ajax({
			type:"GET",
			url:"/servicecenter/notice/download/loaddownloadlist.do",
			data:{pageNo:1, category:cat1},
			dataType:"json",
			success:function(result){
				getrows(result);
			}
		})
		$('.pagination').on("click","a",function(event){
			event.preventDefault();	
			var pageNo = $(this).attr("href");
			var categoryId = $("select[name=categoryId]").val();
			$.ajax({
				type:"GET",
				url:"/servicecenter/notice/download/loaddownloadlist.do",
				data:{pageNo:pageNo, category:categoryId},
				dataType:"json",
				success:function(result){
					getrows(result);
				}
			})
		});
		$("select[name=categoryId]").change(function(event){
			event.preventDefault();
			var categoryId = $(this).val();
			$.ajax({
				type:"GET",
				url:"/servicecenter/notice/download/loaddownloadlist.do",
				data:{pageNo:1, category:categoryId},
				dataType:"json",
				success:function(result){
					getrows(result);
				}
			})
		})
		$('#upload-form-modal').on('hidden.bs.modal',function(e){
			$(":input[name=title]").removeAttr('disabled');
			$(":input[name=category]").removeAttr('disabled');
			$(":input[name=contents]").removeAttr('disabled');
			$("button[name=uploadButton]").removeClass('hidden');
			$(":input[name=title]").val("");
			$(":input[name=category]").val("");
			$(":input[name=contents]").val("");
		})
		$("#board-table tbody").on("click","a[id^=viewTitle-]",function(){
			$(":input[name=title]").attr('disabled', 'true');
			$(":input[name=category]").attr('disabled', 'true');
			$(":input[name=contents]").attr('disabled', 'true');
			
			var boardNo = $(this).attr("id").replace("viewTitle-","");
			$.ajax({
				type:"GET",
				url:"/servicecenter/notice/download/detailUpload.do",
				data:{boardNo:boardNo},
				dataType:"json",
				success:function(downloadNotice){
					var fileName = downloadNotice.attachFile.name;
					var str = fileName.substring(13);
					var cdate = 
					$(":input[name=upfile]").attr('type','text');
					$(":input[name=title]").val(downloadNotice.title);
					$(":input[name=category]").val(downloadNotice.category);
					$("p[name=filename]").text(str);
					$("a[id=download]").attr("href","/servicecenter/notice/download/download.do?boardNo="+downloadNotice.no)
					$(":input[name=contents]").val(downloadNotice.contents);
				}
			})
		})
	})
</script>
</html>