package com.ese.controller.notice;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.notice.SuggestBoardService;
import com.ese.vo.forms.SuggestBoardForm;
import com.ese.vo.hr.Employee;
import com.ese.vo.notice.Suggest;
import com.ese.vo.pagination.notice.Pagination;

@Controller
@RequestMapping("/manage/suggestion")
public class SuggestBoardController {
	
	@Autowired
	SuggestBoardService suggestBoardService;
	
	@RequestMapping(value= {"/list.do", "/keyword.do"})
	public String list(Pagination pagination, Model model, HttpSession session) {
		
		int totalRows = suggestBoardService.getTotalRows(pagination);
		pagination.setTotalRows(totalRows);
		
		model.addAttribute("loginedHR", session.getAttribute("loginedHR"));
		model.addAttribute("boards", suggestBoardService.getByResult(pagination));
		model.addAttribute("navi", pagination);
		return "/manage/suggestion/list";
	}
	@RequestMapping("/addform.do")
	public String addform() {
		return "/manage/suggestion/addform";
	}
	
	@RequestMapping("/detail.do")
	@ResponseBody
	public Suggest detail(int suuNo, Model model) {
		 Suggest suggest  = suggestBoardService.getBoardByNo(suuNo);
		return suggest;
	}
	
	@RequestMapping("/detailComment.do")
	@ResponseBody
	public Suggest  detailComment(int parentNo) {
		Suggest sug = suggestBoardService.detailComment(parentNo);
		return sug;
	}
	
	@RequestMapping("/reply.do")
	@ResponseBody
	public String reply(int pNo, String itTitle, String contents, HttpSession session) {
		Employee empLogined = (Employee) session.getAttribute("loginedHR");
		Suggest suggest = new Suggest();
		Employee employee = new Employee();
		employee.setNo(empLogined.getNo());
		suggest.setParentNo(pNo);
		suggest.setTitle("└─▶"+itTitle);
		suggest.setContents(contents);
		suggest.setEmployee(employee);
		
		suggestBoardService.reply(suggest);
		return "text";
		
	}
}
