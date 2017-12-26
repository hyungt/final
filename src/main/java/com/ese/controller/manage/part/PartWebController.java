package com.ese.controller.manage.part;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ese.service.engineer.EngineerService;
import com.ese.service.manage.part.PartService;
import com.ese.service.notice.EmployeeNoticeService;
import com.ese.service.servicecenter.order.OrderService;
import com.ese.vo.Category;
import com.ese.vo.Division;
import com.ese.vo.common.PartCriteria;
import com.ese.vo.forms.PartForm;
import com.ese.vo.hr.Employee;
import com.ese.vo.order.Order;
import com.ese.vo.order.OrderStatus;
import com.ese.vo.pagination.notice.Pagination;
import com.ese.vo.part.Part;
import com.ese.vo.part.PartStatus;
import com.ese.vo.product.PartUsingModel;
import com.ese.vo.product.Product;


@Controller
public class PartWebController {

	@Autowired
	PartService partService;
	
	@Autowired
	EngineerService engineerService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	EmployeeNoticeService employeeNoticeService;
	
	@RequestMapping("/manage/part/main.do")
	public String main(Pagination pagination, Model model) {
		
		pagination.setRows(10);
		int totalRows  = employeeNoticeService.getTotalRows(pagination);
		pagination.setTotalRows(totalRows);
		
		model.addAttribute("navi", pagination);
		model.addAttribute("notis", employeeNoticeService.getAllBoards(pagination));
		
		return "manage/part/main";
	}
	
	@RequestMapping("/manage/part/partList.do")
	public String partlist(PartCriteria criteria, Model model) {
		List<Category> categories = partService.getCategory();
		
		List<Division> phoneDivisions = partService.getDivisions("CAT-PH");
		List<Division> computerDivisions = partService.getDivisions("CAT-COM");
		List<Division> appliancesDivisions = partService.getDivisions("CAT-AP");
		List<Division> wearableDivisions = partService.getDivisions("CAT-WE");
		List<Division> soundDiviceDivisions = partService.getDivisions("CAT-SD");

		model.addAttribute("categories", categories);
		model.addAttribute("phoneDivisions", phoneDivisions);
		model.addAttribute("computerDivisions", computerDivisions);
		model.addAttribute("appliancesDivisions", appliancesDivisions);
		model.addAttribute("wearableDivisions", wearableDivisions);
		model.addAttribute("soundDiviceDivisions", soundDiviceDivisions);

		return "manage/part/partList";
	}
	
	@RequestMapping("/manage/part/partStock.do")
	public String partStock(Model model) {
		List<Category> categories = partService.getCategory();
		
		List<Division> phoneDivisions = partService.getDivisions("CAT-PH");
		List<Division> computerDivisions = partService.getDivisions("CAT-COM");
		List<Division> appliancesDivisions = partService.getDivisions("CAT-AP");
		List<Division> wearableDivisions = partService.getDivisions("CAT-WE");
		List<Division> soundDiviceDivisions = partService.getDivisions("CAT-SD");
		
		model.addAttribute("categories", categories);
		model.addAttribute("phoneDivisions", phoneDivisions);
		model.addAttribute("computerDivisions", computerDivisions);
		model.addAttribute("appliancesDivisions", appliancesDivisions);
		model.addAttribute("wearableDivisions", wearableDivisions);
		model.addAttribute("soundDiviceDivisions", soundDiviceDivisions);
		return "manage/part/partStock";
	}
	
	@RequestMapping("/manage/part/partAdd.do")
	public String partAdd(Model model){
		List<Category> categories = partService.getCategory();
		List<PartStatus> status = partService.getAllStatus();
		List<Division> divisions = partService.getDivisions("0");
		
		model.addAttribute("status", status);
		model.addAttribute("categories", categories);
		model.addAttribute("divisions", divisions);
		
		return "manage/part/partAdd";
	}
	
	@RequestMapping("/manage/part/add.do")
	public String add(@Valid PartForm partForm)throws IOException {
		String divId = partForm.getDivId();
		String statusId = partForm.getStatusId();
		int seq = partService.getPartSeq();
		String info = "<p>제품의 외관 및 사양, 가격 등은 제품 개량을 위해 사전예고없이 변경될 수 있습니다.</p>" + 
				"<p>제품의 색상은 실제와 약간 다를수 있습니다.신제품 출시 일정은 사정에 따라 변경될 수 있습니다.</p>";
		
		Division division = new Division();		
		division.setId(divId);
		
		PartStatus status = new PartStatus();
		status.setId(statusId);

		Product product = new Product();
		
		Part part = new Part();	
		
		BeanUtils.copyProperties(partForm, part);
		
		part.setNo(seq);

		MultipartFile img = partForm.getImage();
		MultipartFile infoimg = null;
		if(partForm.getInfoimg().getOriginalFilename()!= "") {
			infoimg= partForm.getInfoimg();
		}
		if(!img.isEmpty()) {
			String imagepath = img.getOriginalFilename();
			if(infoimg == null) {
				part.setInfo(info);
			}else {
				String infoimage= infoimg.getOriginalFilename();
				String realInfo = "/resources/images/part/info/" + infoimage;
				info += "<img src='"+realInfo+"'>";
				part.setInfo(info);
				String infopath = servletContext.getRealPath("/resources/images/part/info");
				File infofile = new File(infopath + "/" + infoimage);
				infoimg.transferTo(infofile);
			}
			String realpath = servletContext.getRealPath("/resources/images/part");
			
			part.setImagepath(imagepath);
			
			File file = new File(realpath +"/"+ imagepath);
			
			img.transferTo(file);
		}
		
		part.setDivision(division);
		part.setPartStatus(status);
		
		partService.addPart(part);
		
		PartUsingModel partUsingModel = new PartUsingModel();
		for(String p : partForm.getProducts()) {
			product.setId(p);
			partUsingModel.setPart(part);
			partUsingModel.setProduct(product);
			partService.addPartUsingModel(partUsingModel);
		}
		
		return "redirect:/manage/part/partAdd.do";
	}
	
	@RequestMapping("/manage/part/modify.do")
	public String modify(PartForm partForm) {
		
		String divId = partForm.getDivId();
		String statusId = partForm.getStatusId();
		
		Division division = new Division();		
		division.setId(divId);
		
		PartStatus status = new PartStatus();
		status.setId(statusId);
				
		Part part = new Part();
		
		BeanUtils.copyProperties(partForm, part);
		
		part.setNo(partForm.getPartnum());
		part.setDivision(division);
		part.setPartStatus(status);
		
		Product product = new Product();
		
		partService.delPartUsingModel(partForm.getPartnum());
		
		PartUsingModel partUsingModel = new PartUsingModel();
		for(String p : partForm.getProducts()) {
			product.setId(p);
			partUsingModel.setPart(part);
			partUsingModel.setProduct(product);
			partService.addPartUsingModel(partUsingModel);
		}
		
		partService.updatePart(part);
	
		return "redirect:/manage/part/partAdd.do";
	}
	
	@RequestMapping("/manage/part/deliveryManage.do")
	public String diliveryManage(Model model) {
		List<Order> orders = orderService.getAllOrders();
		
		model.addAttribute("orders", orders);
		
		return "manage/part/deliveryManage";
	}
	
	@RequestMapping("/manage/part/cancel.do")
	public String diliveryManage(int orderNo) {
		
		Order order = orderService.getOrderByNo(orderNo);
		
		OrderStatus orderStatus = new OrderStatus();
		
		orderStatus.setId("ORDER-CANCEL");
		
		order.setStatusId(orderStatus);
		
		orderService.updateOrder(order);
		
		return "redirect:/manage/part/deliveryManage.do";
	}
}
