$(function() {
	function getrows(result){
		var html="";
		if(result.parts.length!=0){
			$.each(result.parts, function(index, part){
				html += "<tr>"
				html += "<td>"+part.no+"</td>"
				html += "<td><a href='' data-toggle='modal' data-target='#part-form-modal' id='part-no-"+part.no+"'>"+part.name+"</a></td>"
				html += "<td>"+part.qty+"</td>"
				html += "<td>"+part.cost+"</td>"
				html += "<td>"+part.price+"</td>"
				html += "</tr>"
			})
		}else{
			html += "<tr>"
			html += "<td>등록된 부품이 없습니다</td>"
			html += "</tr>"
		}
		$("#part-table tbody tr").remove();
		$("#part-table tbody").append(html);
		
		var html2='';
		var navi = result.navi;
		if(result.parts.length!=0){
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
	$.getJSON("/rest/getparts", {pageNo:1}).done(function(result){
		getrows(result)
	})
	$('.pagination').on("click","a",function(event){
		event.preventDefault();	
		var pageNo = $(this).attr("href");
		var categoryId = $("#ul-cat li[class=active]").children("a").attr("id");
		if($(".pickedDiv").attr("id")){
			var divisionId = $(".pickedDiv").attr("id").replace("list-div-","");
		}else{
			var divisionId = 0;
		}
		$.getJSON("/rest/getparts", {pageNo:pageNo, divisionId:divisionId, categoryId:categoryId}).done(function(result){
			getrows(result)
		})
	});
})