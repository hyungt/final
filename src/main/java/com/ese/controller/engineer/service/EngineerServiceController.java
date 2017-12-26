package com.ese.controller.engineer.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.engineer.EngineerService;
import com.ese.service.engineer.inventory.InventoryService;
import com.ese.service.engineer.reserve.ReserveService;
import com.ese.service.engineer.serviceresult.ServiceResultService;
import com.ese.vo.Division;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.common.ServiceCriteria;
import com.ese.vo.common.ServiceEngineerResult;
import com.ese.vo.hr.Employee;
import com.ese.vo.part.Part;

@Controller
@RequestMapping("/engineer")
public class EngineerServiceController {
	
	@Autowired
	EngineerService engineerService;
	@Autowired
	ReserveService reserveService;
	@Autowired
	ServiceResultService resultService;
	@Autowired
	InventoryService inventoryService;
	
	@RequestMapping("/reserve.do")
	public String reserve (Model model) {
		
		model.addAttribute("repairInfoList", resultService.getAllRepairInfo());
		
		return "engineer/servicemanage/servicemanage";
	}
	
	@RequestMapping("/reserve/getReserve.do")
	@ResponseBody
	public ServiceEngineerResult getReserve(Integer pageNo, HttpSession session) {
		ServiceCriteria criteria = new ServiceCriteria();
		
		Employee engineer = (Employee)session.getAttribute("loginEngineer");
		criteria.setEngineerNo(engineer.getNo());
		if(pageNo != null) {
			criteria.setPageNo(pageNo);
		}
		ServiceEngineerResult result = new ServiceEngineerResult();
		result.setCriteria(criteria);
		result.setServiceList(reserveService.getMyService(criteria));
		return result;
	}
	
	@RequestMapping("/reserve/getAfterService.do")
	@ResponseBody
	public AfterService getAfterService(Integer reserveNo) {
		return reserveService.getDetailService(reserveNo);
	}
	
	@RequestMapping("/reserve/getASDivision.do")
	@ResponseBody
	public List<Part> getPartList(String divisionId) {
		Division division = new Division();
		division.setId(divisionId);
		return resultService.getPartsByDivision(division);
	}
	
	@RequestMapping("/reserve/addResult.do")
	@ResponseBody
	public String addResult(Integer serviceNo, String repairId, Long totalPrice, String usingParts) {
		
		System.out.println(serviceNo);
		System.out.println(repairId);
		System.out.println(totalPrice);
		
		List<Integer> partList = new ArrayList<Integer>();
		String[] partTemp = usingParts.split(",");
		System.out.println(partTemp.length);
		for(String partNo : partTemp) {
			if(partNo.equals("")) {
				continue;
			}
			partList.add(Integer.parseInt(partNo));
		}
		
		return resultService.serviceComplete(serviceNo, repairId, totalPrice, partList);
	}
	
	@RequestMapping("/stock.do")
	public String stock (Model model) {
		
		model.addAttribute("categoryList", inventoryService.getCategoryList());
		
		return "engineer/servicemanage/stock";
	}
	
	@RequestMapping("/stock/getDivision.do")
	@ResponseBody
	public List<Division> getDivision(String categoryId) {
		return inventoryService.getDivisionList(categoryId);
	}
	
	@RequestMapping("/reserve/getDivisionPart.do")
	@ResponseBody
	public Map<String, Object> getPartListbyDivision(String divisionId, Integer pageNo) {
		ServiceCriteria criteria = new ServiceCriteria();
		criteria.setDivisionId(divisionId);
		criteria.setPageNo(pageNo);
		
		List<Part> partList = resultService.getPartsByCriteria(criteria);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("partList", partList);
		result.put("criteria", criteria);
		
		return result;
	}
	
	@RequestMapping("/stock/getPartDetail.do")
	@ResponseBody
	public Part getPartDetail(Integer partNo) {
		return inventoryService.getPartDetail(partNo);
	}
	
}
