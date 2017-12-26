package com.ese.controller.servicecenter.order;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ese.service.manage.part.PartService;
import com.ese.service.servicecenter.appraisal.AppraisalService;
import com.ese.service.servicecenter.order.OrderService;
import com.ese.vo.Category;
import com.ese.vo.Division;
import com.ese.vo.User;
import com.ese.vo.forms.PurchaseForm;
import com.ese.vo.order.Apparaisal;
import com.ese.vo.order.Order;
import com.ese.vo.part.Part;
import com.ese.vo.product.PartUsingModel;

@Controller
public class SCOrderController {
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	PartService partService;
	
	@Autowired
	AppraisalService appraisalService;
	
	@RequestMapping("/order/detail.do")
	public String main(@RequestParam("partNo") int partNo, Model model) {
		Part part = partService.getPartByNo(partNo);
		List<PartUsingModel> usingModels = partService.getPartUsingModels(partNo);
		List<Apparaisal> apparaisals = appraisalService.getAppraisals(partNo);
		model.addAttribute("part", part);
		model.addAttribute("usingModels", usingModels);
		model.addAttribute("apparaisals", apparaisals);
		return "servicecenter/order/detail";
	}
	
	@RequestMapping("/order/purchase.do")
	public String purchase(@RequestParam("partNo") int partNo,@RequestParam("count") int count, HttpSession session, Model model) {
		
		String returnpath = "/order/purchase.do?partNo="+partNo+"&count="+count;
		session.setAttribute("returnpath", returnpath);
		
		User user = (User)session.getAttribute("loginUser");
		if(user == null) {
			return "redirect:/user/login.do";
		}
		
		Part part = partService.getPartByNo(partNo);
		model.addAttribute("part", part);
		model.addAttribute("loginUser",user);
		model.addAttribute("count",count);
		model.addAttribute("purchaseForm",new PurchaseForm());
		return "servicecenter/order/purchase";
	}
	
	@RequestMapping("/order/list.do")
	public String list(@RequestParam(value="categoryId", required=false) String categoryId,@RequestParam(value="divisionId", required=false) String divisionId, Model model) {
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
		model.addAttribute("categoryId", categoryId);
		model.addAttribute("divisionId", divisionId);
		
		return "servicecenter/order/expendableList";
	}
	
	@RequestMapping("/order/addOrder.do")
	public String addOrder(@Valid PurchaseForm purchaseForm) {
		
		System.out.println(purchaseForm);
		
		int totalPrice = (purchaseForm.getCount() * purchaseForm.getPurchase());
		
		int seq = orderService.getOrderSeq();
		
		Order order = new Order();
		
		order.setNo(seq);
		
		BeanUtils.copyProperties(purchaseForm, order);
		
		order.setPurchase(totalPrice);
		
		Part part = new Part();
		User user = new User();
		
		part.setNo(purchaseForm.getPartNo());
		
		user.setNo(purchaseForm.getBuyerNo());
		
		String addr1 = purchaseForm.getAddress1();
		String addr2 = purchaseForm.getAddress2();
		String realAddr = addr1+", "+addr2;
		
		order.setAddress(realAddr);
		order.setPart(part);
		order.setUser(user);
		
		orderService.addOrder(order);
		
		return "redirect:/order/pay.do?orderNo="+seq;
	}
	
	@RequestMapping("/order/pay.do")
	public String pay(@RequestParam("orderNo") int orderNo, Model model) {
		Order order = orderService.getOrderByNo(orderNo);
		
		model.addAttribute("order", order);
		
		return "servicecenter/order/pay";
	}
}
