package com.ese.controller.notice;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ese.service.notice.EmployeeNoticeService;
import com.ese.vo.forms.NoticeBoardForm;
import com.ese.vo.notice.EmployeeNotice;
import com.ese.vo.pagination.notice.Pagination;

@Controller
@RequestMapping("/manage/notice/employee")
public class EmployeeNoticeController {
	@Autowired
	EmployeeNoticeService employeeNoticeService;
		
	@RequestMapping("/list.do")
	public String list(Pagination pagination, Model model) {
		
		int totalRows = employeeNoticeService.getTotalRows(pagination);
		pagination.setTotalRows(totalRows);
		System.out.println(pagination);
		System.out.println(pagination.getOpt());
		System.out.println(pagination.getKeyword());
		
		model.addAttribute("navi", pagination);
		model.addAttribute("boards", employeeNoticeService.getAllBoards(pagination));
		System.out.println(model);
		return "/manage/notice/employee/list";
	}
	
	@RequestMapping("/addform.do")
	public String addform() {
		return "/manage/notice/employee/addform";
	}
	
	@RequestMapping("/add.do")
	public String addBoard(NoticeBoardForm noticeBoardForm) {
		EmployeeNotice employeeNotice = new EmployeeNotice();
		BeanUtils.copyProperties(noticeBoardForm, employeeNotice);
		employeeNoticeService.addBoard(employeeNotice);
		return "redirect:list.do";
	}
	
	@RequestMapping("detail.do")
	public String detail(@RequestParam("no") int boardNo, Model model) {
		model.addAttribute("board", employeeNoticeService.getBoardByNo(boardNo));
		return "/manage/notice/employee/detail";
	}
	
	
}
