
package com.ese.controller.servicecenter.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ese.common.encrypt.Sha256;
import com.ese.service.notice.CustomerNoticeService;
import com.ese.service.servicecenter.ServicecenterService;
import com.ese.vo.User;
import com.ese.vo.afterservice.ServiceResult;
import com.ese.vo.afterservice.UsingPart;
import com.ese.vo.common.UseServiceCriteria;
import com.ese.vo.forms.NoticeBoardForm;
import com.ese.vo.forms.Userform;
import com.ese.vo.notice.CustomerNotice;
import com.ese.vo.pagination.notice.Pagination;
import com.ese.vo.part.Part;

@Controller
public class SCUserController {
	
	@Autowired
	ServicecenterService centerService;
	
	@Autowired
	CustomerNoticeService customerNoticeService;
	
	@RequestMapping("/user/registe.do")
	public String registe(Model model) {
		model.addAttribute("userform", new Userform());
		return "servicecenter/user/registe";
	}
	
	@RequestMapping(value="/user/login.do", method=RequestMethod.GET)
	public String login() {
		
		return "servicecenter/user/login";
	}
	
	@RequestMapping(value="/user/login.do", method=RequestMethod.POST)
	public String loginProcess(@RequestParam("id") String id,
							@RequestParam("pwd") String pwd,
							HttpSession session) {
		
		User user = centerService.getUserDetail(id);
		String returnpath = (String) session.getAttribute("returnpath"); 
		if(user == null) {
			return "redirect:/user/login.do?error=fail";
		}
		String encryptPwd = Sha256.encrypt(pwd);
		if(!user.getPw().equals(encryptPwd)) {
			return "redirect:/user/login.do?error=fail";
		}
		session.setAttribute("loginUser", user);
		if(returnpath!=null) {
			return "redirect:"+returnpath;
		}
		return "redirect:/home.do";
	}
	
	@RequestMapping("/user/add.do")
	public String addUser(@Valid Userform userform, BindingResult errors)  {
		
		String phoneNo = userform.getPhone().replace(",", "-");
		
		phoneNo.substring(0, 12);
		
		userform.setPhone(phoneNo);
		
		if(centerService.getUserDetail(userform.getId()) != null) {
			errors.rejectValue("id", null, "이미 사용중인 아이디 입니다.");
			return "servicecenter/user/registe";
		}
		if(errors.hasErrors()) {
			return "servicecenter/user/registe";
		}
		
		User user = new User();
	
		BeanUtils.copyProperties(userform, user);
		
		String encryptPassword = Sha256.encrypt(user.getPw());
		user.setPw(encryptPassword);
		
		centerService.addNewUser(user);
		
		return "redirect:/home.do";
	}
	
	@RequestMapping(value="/user/userMyPage.do",method=RequestMethod.GET)
	public String userInfoUpdate(Model model, HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		
		UseServiceCriteria criteria = new UseServiceCriteria();
		
		criteria.setUserNo(user.getNo());
		int totalRows = centerService.getTotalRowsVitae(criteria);
		criteria.setTotalRows(totalRows);
		
		List<ServiceResult> services = centerService.getServiceVitaeForUserNo(criteria);
		List<List<UsingPart>> usingParts = new ArrayList<List<UsingPart>>();
		Map<Integer, Integer> income = new HashMap<Integer, Integer>(); 
		
		for(ServiceResult result : services) {
			List<UsingPart> temp = centerService.usingPartForServiceNo(result.getNo());
			
			usingParts.add(temp);
			int partPrice = 0;
			
			for(UsingPart usingPart : temp) {
				int length = usingPart.getPart().getName().length();
				if(length > 7) {
					String little = usingPart.getPart().getName().substring(0, 7);
					Part part = new Part();
					part.setName(little+ "...");
					part.setPrice(usingPart.getPart().getPrice());
					usingPart.setPart(part);
				}
				partPrice += usingPart.getPart().getPrice();
			}
			int totalPrice = partPrice + result.getRepairInfo().getPrice();
			
			income.put(result.getNo(), totalPrice);
		}
		model.addAttribute("page", criteria);
		model.addAttribute("income", income);
		model.addAttribute("usingParts", usingParts);
		model.addAttribute("user",user);
		model.addAttribute("serviceCheck", services);
		
		return "/servicecenter/user/myPage";
	}
	
	@RequestMapping(value="/user/userMyPage.do",method=RequestMethod.POST)
	public String userInfoUpdate(Userform userForm) {
		System.out.println(userForm);
		if(userForm.getPw().equals(userForm.getPwdCheck())) {
			
			String phoneNo = userForm.getPhone().replace(",", "-");
			
			phoneNo.substring(0, 12);
			
			userForm.setPhone(phoneNo);
			
			String id = userForm.getId();
			String newPw = Sha256.encrypt(userForm.getPw());
			String phone = userForm.getPhone();
			String email = userForm.getEmail();
			User user = new User();
			user = centerService.getUserById(id);
			user.setPw(newPw);
			user.setPhone(phone);
			user.setEmail(email);

			centerService.updateInfo(user);
			return "/servicecenter/user/myPage";
		}
		return "redirect:servicecenter/home";
	}
	
	@RequestMapping("/user/logout.do")
	public String logout (HttpSession httpSession) {
		
		httpSession.removeAttribute("loginUser");
		
		return "redirect:/home.do";
	}
		
		
	@RequestMapping("/user/list.do")
	public String list(Pagination pagination, Model model) {
		
		int totalRows = customerNoticeService.getTotalRows(pagination);
		pagination.setTotalRows(totalRows);
		System.out.println(pagination);
		System.out.println(pagination.getOpt());
		System.out.println(pagination.getKeyword());

		
		model.addAttribute("navi", pagination);
		model.addAttribute("boards", customerNoticeService.getAllBoards(pagination));
		System.out.println(model);
		return "/servicecenter/user/client/alert";
	}
	
	@RequestMapping("/user/detail.do")
	public String detail(@RequestParam("no") int boardNo, Model model) {
		model.addAttribute("board", customerNoticeService.getBoardByNo(boardNo));
		return "/servicecenter/user/client/alertdetail";
	}
}
