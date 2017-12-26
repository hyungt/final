package com.ese.controller.notice;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ese.service.notice.CustomerNoticeService;
import com.ese.vo.forms.NoticeBoardForm;
import com.ese.vo.notice.CustomerNotice;
import com.ese.vo.pagination.notice.Pagination;

@Controller
@RequestMapping("/manage/notice/customer")
public class CustomNoticeController {
	
	@Autowired
	CustomerNoticeService customerNoticeService;
	
	@RequestMapping("/list.do")
	public String list(Pagination pagination, Model model) {
		
		int totalRows = customerNoticeService.getTotalRows(pagination);
		pagination.setTotalRows(totalRows);
		System.out.println(pagination);
		System.out.println(pagination.getOpt());
		System.out.println(pagination.getKeyword());

		
		model.addAttribute("navi", pagination);
		model.addAttribute("boards", customerNoticeService.getAllBoards(pagination));
		System.out.println(model);
		return "/manage/notice/customer/list";
	}
	@RequestMapping("/addform.do")
	public String form() {
		return "/manage/notice/customer/addform";
	}
	@RequestMapping("/add.do")
	public String addBoard(NoticeBoardForm noticeBoardForm) {
		CustomerNotice customerNotice = new CustomerNotice();
		BeanUtils.copyProperties(noticeBoardForm, customerNotice);
		customerNoticeService.addBoard(customerNotice);
		return "redirect:list.do";
	}	
	@RequestMapping("/detail.do")
	public String detail(@RequestParam("no") int boardNo, Model model) {
		model.addAttribute("board", customerNoticeService.getBoardByNo(boardNo));
		return "/manage/notice/customer/detail";
	}
}
