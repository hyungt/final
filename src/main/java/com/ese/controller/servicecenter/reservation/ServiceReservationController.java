package com.ese.controller.servicecenter.reservation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.engineer.EngineerService;
import com.ese.service.servicecenter.LocaleService;
import com.ese.service.servicecenter.reservation.ReservationService;
import com.ese.vo.Division;
import com.ese.vo.User;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.afterservice.Center;
import com.ese.vo.afterservice.City;
import com.ese.vo.afterservice.Locale;
import com.ese.vo.afterservice.ServiceStatus;
import com.ese.vo.afterservice.ServiceType;
import com.ese.vo.common.ReservationEmpASBreakResult;
import com.ese.vo.common.ServiceCriteria;
import com.ese.vo.common.UseServiceCriteria;
import com.ese.vo.hr.Employee;

@Controller
@RequestMapping("/reserve")
public class ServiceReservationController {

	@Autowired
	ReservationService reservationService;
	@Autowired
	LocaleService localeService;
	@Autowired
	EngineerService engineerService;
	
	@RequestMapping("/visitReserve/reserveView.do")
	public String visitReservation(Model model) {
		
		List<Locale> localeList = localeService.getAllLocale();
		
		model.addAttribute("localeList", localeList);
		
		return "/servicecenter/reservation/visit";
	}
	
	@RequestMapping("/visitReserve/result.do")
	public String reservationSuccess(Model model, Integer serviceNo) {
		model.addAttribute("as", reservationService.getAfterServiceByNo(serviceNo));
		
		return "/servicecenter/reservation/reservesuccess";
	}
	
	@RequestMapping("/getCity.do")
	@ResponseBody
	public List<City> getCity(String localeId) {
		return localeService.getCitysByLocaleId(localeId);
	}
	
	@RequestMapping("/findCenter.do")
	@ResponseBody
	public List<Center> getCenter(String locale, String city) {
		return reservationService.getCenterListByLocale(locale, city);
	}
	
	@RequestMapping("/getCenterEmp.do")
	@ResponseBody
	public List<Employee> getCenterEmployee(String centerId) {
		return reservationService.getCenterEmployee(centerId);
	}
	
	@RequestMapping("/getDivision.do")
	@ResponseBody
	public List<Division> getDivision(String categoryId) {
		
		return reservationService.getDivision(categoryId);
	}
	
	@RequestMapping("/getReservation.do")
	@ResponseBody
	public ReservationEmpASBreakResult getServiceByEmployeeId(Integer no, String reservation) throws ParseException {
		ServiceCriteria criteria = new ServiceCriteria();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(reservation);
		Date now = new Date();
		if(date.getTime() <= now.getTime()) {
			date = now;
		}
		
		criteria.setEngineerNo(no);
		criteria.setReservation(date);
		ReservationEmpASBreakResult reasbr = new ReservationEmpASBreakResult();
		reasbr.setAsList(reservationService.getAfterServiceByEmployeeId(criteria));
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("empNo", no);
		map.put("reserveDate", reservation);
		reasbr.setBreakList(engineerService.getBreakByDate(map));
		return reasbr;
	}
	
	@RequestMapping("/addReserve.do")
	public String addReserve(String divisionId, String centerId, Long reserve, 
							Integer empId, String symptom, String serviceType, String address, HttpSession session) {
		
		AfterService as = new AfterService();
		
		Division division = new Division();
		division.setId(divisionId);

		Center center = new Center();
		center.setId(centerId);
		
		Employee emp = new Employee();
		emp.setNo(empId);
		
		ServiceStatus status = new ServiceStatus();
		status.setId("STA_STANDBY");
		
		ServiceType type = new ServiceType();
		type.setId(serviceType);
		
		User user = (User)session.getAttribute("loginUser");
		
		Date date = new Date(reserve);
		
		as.setDivision(division);
		as.setCenter(center);
		as.setEmployee(emp);
		as.setUser(user);
		as.setReservation(date);
		as.setSymptom(symptom);
		as.setServiceStatus(status);
		as.setServiceType(type);
		
		if(address != null) {
			as.setAddress(address);
		} else {
			System.out.println("address is null");
		}
		int no = reservationService.getAfterServiceSeq();
		as.setNo(no);
		reservationService.addAfterService(as);
		
		return "redirect:/reserve/visitReserve/result.do?serviceNo="+no;
	}
	
	@RequestMapping("/visitReserve/reserveCheck.do")
	public String reserveCheck (UseServiceCriteria criteria, HttpSession session, Model model) {
		User user = (User)session.getAttribute("loginUser");
		
		criteria.setUserNo(user.getNo());
		criteria.setTotalRows(reservationService.getTotalRowsServiceUser(criteria));
		
		model.addAttribute("navi", criteria);
		model.addAttribute("reserveCheck", reservationService.forServiceByUserNo(criteria));
		
		return "/servicecenter/reservation/reserveCheck";
	}
}
