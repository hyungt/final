/**
 * 
 */
$(function() {
	
	$(".inline-block").hover(function(e) {
		$(this).toggleClass("select");
	}, function() {
		$(this).toggleClass("select");
	});
	$(".inline-block").click(function(e) {
		$(this).addClass("select-box").siblings().removeClass("select-box");
		
		var id = $(this).attr("id");
		
		$.ajax({
			type:"get",
			url: "/reserve/getDivision.do",
			data: {
				categoryId: id
			},
			dataType: "json",
			success: function(result) {
				var html = "";
				
				$.each(result, function(index, division) {
					html += "<li><h4><a id='"+division.id+"' class='btn'>"+division.name+"</a></h4></li>"
				});
				console.log(html);
				$("#division").html(html);
				$("#division-box").show(300);
			}
		});
	});
	
	$("#division").on("click", "a[id^=DIV-]", function(e){
		e.preventDefault();
		$(this).closest("ul").find("li h4 a").removeClass("active").removeClass("btn-primary");
		$(this).addClass("active").addClass("btn-primary");
		$("#division-input").val($(this).attr("id"));
		var contents = "";
		
		contents = "<label class='control-label'>"+$(".select-box").find("h4 strong").text()+"</label> > <label class='control-label'>"+$(this).text()+"</label>";
		
		$("#category-division").html(contents);
	});
	
	var calendar = new controller(); 
	calendar.init();

	function controller(target) {

		var that = this;   
		var m_oMonth = new Date();
		m_oMonth.setDate(1);

		this.init = function() {
			that.renderCalendar();
			that.initEvent();
		}

	    /* 달력 UI 생성 */
		this.renderCalendar = function() {
			var arrTable = [];

			arrTable.push('<table><colgroup>');
			for(var i=0; i<7; i++) {
				arrTable.push('<col width="100">');
			}		
			arrTable.push('</colgroup><thead><tr>');

			var arrWeek = "일월화수목금토".split("");

			for(var i=0, len=arrWeek.length; i<len; i++) {
				var sClass = '';
				sClass += i % 7 == 0 ? 'sun' : '';
				sClass += i % 7 == 6 ? 'sat' : '';
				arrTable.push('<td class="'+sClass+'">' + arrWeek[i] + '</td>');
			}
			arrTable.push('</tr></thead>');
			arrTable.push('<tbody>');

			var oStartDt = new Date(m_oMonth.getTime());
	        // 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
			oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());
	        
	        var now = new Date();
	        now.setHours(0);
	        now.setMinutes(0);
	        now.setSeconds(0);
	        var endDate = new Date();
	        endDate.setDate(endDate.getDate()+7)
	        endDate.setHours(0);
	        endDate.setMinutes(0);
	        endDate.setSeconds(0);
	        
			for(var i=0; i<100; i++) {
				if(i % 7 == 0) {
					arrTable.push('<tr>');
				}

				var sClass = 'date-cell '
	            sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : '';
				sClass += i % 7 == 0 ? 'sun' : '';
				sClass += i % 7 == 6 ? 'sat' : '';

				
				if(oStartDt >= now  && oStartDt < endDate && (sClass.search('sun') == -1 && sClass.search('sat') == -1)){
					sClass += 'click';
					console.log(sClass.search('sun'));
				}
				
				arrTable.push('<td id="'+now.getFullYear()+'-'+(oStartDt.getMonth()+1)+'-'+oStartDt.getDate()+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
				oStartDt.setDate(oStartDt.getDate() + 1);

				if(i % 7 == 6) {
					arrTable.push('</tr>');
					if(m_oMonth.getMonth() != oStartDt.getMonth()) {
						break;
					}
				}
			}
			arrTable.push('</tbody></table>');

			$('#calendar').html(arrTable.join(""));

			that.changeMonth();
		}

	    /* Next, Prev 버튼 이벤트 */
		this.initEvent = function() {
			$('#btnPrev').click(that.onPrevCalendar);
			$('#btnNext').click(that.onNextCalendar);
		}

	    /* 이전 달력 */
		this.onPrevCalendar = function(e) {
			m_oMonth.setMonth(m_oMonth.getMonth() - 1);
			that.renderCalendar();
		}

	    /* 다음 달력 */
		this.onNextCalendar = function(e) {
			m_oMonth.setMonth(m_oMonth.getMonth() + 1);
			that.renderCalendar();
		}

	    /* 달력 이동되면 상단에 현재 년 월 다시 표시 */
		this.changeMonth = function() {
			$('#currentDate').text(that.getYearMonth(m_oMonth).substr(0,9));
		}

	    /* 날짜 객체를 년 월 문자 형식으로 변환 */
		this.getYearMonth = function(oDate) {
			return oDate.getFullYear() + '년 ' + (oDate.getMonth() + 1) + '월';
		}
	}
		
	$("#calendar").on("click", ".select", function() {
		if(!$("#center-input").val()) {
			alert("센터를 먼저 선택 해 주세요!");
			return;
		}
		getReservationAjax(false, null);
		$("#emp-input").val("");
		$("#emp-img").attr("src", "/resources/images/main/image/reserve_noimg.gif");
		$(".clickselect").removeClass("clickselect");
		$("#reserve-input").val($(this).attr("id"));
		$(this).addClass("clickselect");
		
		$.ajax({
			type:"get",
			url: "/reserve/getCenterEmp.do",
			data: {
				centerId: $("#center-input").val()
			},
			dataType: "json",
			success: function(result) {
				var htmlContents = "";
				$.each(result, function(index, emp){
					console.log(emp)
					
					htmlContents += '<div class="col-sm-5 text-center">';
					htmlContents += '<a id="emp-no-'+emp.no+'" class="btn btn-default" data-imgpath="/resources/images/main/image/'+emp.pic+'">'+emp.name+'</a>';
					htmlContents += '</div>';
				});
				$("#emplist-div").html(htmlContents);
			}
		});
	});
	
	function getReservationAjax(isContinue, empNo) {
		
		$("#reservation").val("");
		
		var reserveHtmlContents = "";
		
		reserveHtmlContents += '<tr><th colspan="2">오전</th></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-1">09:00</td><td id="reserve-time-2">09:30</td></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-3">10:00</td><td id="reserve-time-4">10:30</td></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-5">11:00</td><td id="reserve-time-6">11:30</td></tr>';
		reserveHtmlContents += '<tr><th colspan="2">오후</th></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-7">12:00</td><td id="reserve-time-8">12:30</td></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-9">13:00</td><td id="reserve-time-10">13:30</td></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-11">14:00</td><td id="reserve-time-12">14:30</td></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-13">15:00</td><td id="reserve-time-14">15:30</td></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-15">16:00</td><td id="reserve-time-16">16:30</td></tr>';
		reserveHtmlContents += '<tr><td id="reserve-time-17">17:00</td><td id="reserve-time-18">17:30</td></tr>';
		
		$("#reserve-time-body").html(reserveHtmlContents);
		if(isContinue == false) {
			return;
		}
		$.ajax({
			type:"get",
			url: "/reserve/getReservation.do",
			data: {
				no:empNo,
				reservation: $("#reserve-input").val()
			},
			dataType: "json",
			success: function(result) {
				console.log(result);
				for(var i = 0; i < 18; ++i) {
					var hour = parseInt(9 + (i/2));
					var minute = 30 * (i%2);
					var date = new Date($("#reserve-input").val() + " " + hour +":"+minute+":00");
					if(date <= new Date()) {
						continue;
					}
					var isReserve = false;
					$.each(result.asList, function(index, service) {
						if(date.getTime() == service.reservation) {
							isReserve = true;
						}
					});
					
					$.each(result.breakList, function(index, vacation) {
						if(date.getTime() >= vacation.startdate && date.getTime() <= vacation.enddate) {
							console.log(vacation.startdate, vacation.enddate, date.getTime());
							isReserve = true;
						}
					});
					
					if(isReserve) {
						continue;
					}
					var htmlContents = "<a class='btn btn-primary btn-xs' href='"+date.getTime()+"'>"+ ((hour== 9? '0'+hour : hour) +":"+(minute == 30? minute : '0'+minute)+":00")+"</a>";
					
					$("#reserve-time-"+(i+1)).html(htmlContents);
				}
			}
		});
	}
	$("#emplist-div").on("click", "a[id^=emp-no-]", function(e) {
		$("a[id^=emp-no-]").removeClass("active");
		$(this).addClass("active");
		
		var empNo = $(this).attr("id").replace("emp-no-","")
		$("#emp-input").val(empNo);
		$("#emp-img").attr("src", $(this).attr("data-imgpath"));
		
		getReservationAjax(true, empNo);
	});
	
	$("#reserve-time-body").on("click", "a", function(e){
		e.preventDefault();
		var date = $(this).attr("href");
		$("#reserve-final-date").val(date);
	})
	
	$("#calendar").on("mouseenter", ".click", function(e) {
		$(this).toggleClass("select");
		$(this).toggleClass("click");
	})
	$("#calendar").on("mouseleave", ".select", function() {
		$(this).toggleClass("select");
		$(this).toggleClass("click");
	});
	
	$("#center-city").click(function(e){
		if($("#center-locale").val() == "") {
			alert("지역을 먼저 선택하세요!");
			return false;
		}
	});
	$("#center-locale").change(function(e){
		$.ajax({
			type:"GET",
			url:"/reserve/getCity.do",
			data:{localeId:$("#center-locale").val()},
			dataType:"json",
			success: function(cityList) {
				var html = "";
				html += '<option value="">--시/구/군--</option>';
				$.each(cityList, function(index, city){
					html += "<option value='" + city.id + "'>"+city.name+"</option>"
				});
				$("#center-city").html(html);
			}
		});
	});
	
	$("#locale-btn").click(function(e){
		if(!$("#center-city").val()) {
			alert("지역을 선택해 주세요!");
			return;
		}
		$.ajax({
			type:"GET",
			url:"/reserve/findCenter.do",
			data:{
				locale:$("#center-locale").val(),
				city:$("#center-city").val()
			},
			dataType:"json",
			success: function(centerList) {
				var html = "";
				$.each(centerList, function(index, center) {
					html += "<tr>";
					html += "<td>"+center.name+"</td>";
					html += "<td>"+center.address+"</td>";
					html += "<td><button id='select-"+center.id+"' class='btn btn-primary'>센터선택</button></td>";
					html += "</tr>";
				});
				
				$("#center-table tbody").html(html);
				$("#center-name-div").show();
			}
		});
		$("#center-table").show();
	});
});