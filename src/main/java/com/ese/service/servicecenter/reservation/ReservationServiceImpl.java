package com.ese.service.servicecenter.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.EmployeeMapper;
import com.ese.mappers.manage.part.DivisionMapper;
import com.ese.mappers.manage.part.PartMapper;
import com.ese.mappers.servicecenter.CenterMapper;
import com.ese.mappers.servicecenter.LocaleMapper;
import com.ese.mappers.servicecenter.ServiceReserveMapper;
import com.ese.vo.Division;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.afterservice.Center;
import com.ese.vo.afterservice.City;
import com.ese.vo.afterservice.Locale;
import com.ese.vo.common.ServiceCriteria;
import com.ese.vo.common.UseServiceCriteria;
import com.ese.vo.hr.Employee;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	CenterMapper centerMapper;
	@Autowired
	LocaleMapper localeMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	DivisionMapper divisionMapper;
	@Autowired
	ServiceReserveMapper reserveMapper;
	
	
	@Override
	public List<Center> getCenterList() {
		return centerMapper.getCenterList();
	}

	@Override
	public Center getCenter(String id) {
		return centerMapper.getCenter(id);
	}

	@Override
	public List<Center> getCenterListByLocale(String locale, String city) {
		
		Locale locales = localeMapper.getLocaleById(locale);
		City citys = localeMapper.getCityById(city);
		
		String localeCity = locales.getName() + " " + citys.getName();
		
		return centerMapper.getCenterByLocale(localeCity);
	}

	@Override
	public List<Employee> getCenterEmployee(String centerId) {
		return employeeMapper.getEmployeeByCenterId(centerId);
	}

	@Override
	public List<Division> getDivision(String categoryId) {
		return divisionMapper.getDivisions(categoryId);
	}

	@Override
	public List<AfterService> getAfterServiceByEmployeeId(ServiceCriteria criteria) {
		return reserveMapper.getServiceByEngineerId(criteria);
	}

	@Override
	public void addAfterService(AfterService as) {
		reserveMapper.addAfterService(as);
	}

	@Override
	public Integer getAfterServiceSeq() {
		return reserveMapper.getAfterServiceSeq();
	}
	
	@Override
	public AfterService getAfterServiceByNo(Integer no) {
		return reserveMapper.getServiceByNo(no);
	}
	
	@Override
	public List<AfterService> forServiceByUserNo(UseServiceCriteria criteria) {
		return reserveMapper.getServiceByUserNo(criteria);
	}
	
	@Override
	public int getTotalRowsServiceUser(UseServiceCriteria criteria) {
		return reserveMapper.getTotalRowsServiceUser(criteria);
	}
}
