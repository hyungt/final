package com.ese.vo.forms;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.ese.vo.hr.Employee;

public class BreakForm {
	
	private static final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	private String startdate;
	private String startHour;
	private String startMinute;
	private String enddate;
	private String endHour;
	private String endMinute;
	private String reason;
	private MultipartFile fetchFile;
	
	
	public Date getStart() {
		return stringToDate(startdate, startHour, startMinute);
	}
	public Date getEnd() {
			return stringToDate(enddate, endHour, endMinute);
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getStartHour() {
		return startHour;
	}
	public void setStartHour(String startHour) {
		this.startHour = startHour;
	}
	public String getStartMinute() {
		return startMinute;
	}
	public void setStartMinute(String startMinute) {
		this.startMinute = startMinute;
	}
	public String getEndHour() {
		return endHour;
	}
	public void setEndHour(String endHour) {
		this.endHour = endHour;
	}
	public String getEndMinute() {
		return endMinute;
	}
	public void setEndMinute(String endMinute) {
		this.endMinute = endMinute;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	public MultipartFile getFetchFile() {
		return fetchFile;
	}
	public void setFetchFile(MultipartFile fetchFile) {
		this.fetchFile = fetchFile;
	}
	private Date stringToDate(String day, String hour, String minute) {
		try {
			String str = day + " " + hour + ":" + minute;
			return df.parse(str);
		} catch (Exception e) {
			throw new RuntimeException("날짜 형식 오류");
		}
	}
	@Override
	public String toString() {
		return "BreakForm [startdate=" + startdate + ", startHour=" + startHour + ", startMinute=" + startMinute
				+ ", enddate=" + enddate + ", endHour=" + endHour + ", endMinute=" + endMinute + ", reason=" + reason
				+ ", fetchFile=" + fetchFile + "]";
	}
	
}
