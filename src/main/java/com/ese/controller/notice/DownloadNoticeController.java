package com.ese.controller.notice;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ese.common.view.FileDownloadView;
import com.ese.service.notice.DownloadNoticeService;
import com.ese.vo.notice.DownloadNotice;

@Controller
@RequestMapping("/servicecenter/notice/download")
public class DownloadNoticeController {
	
	@Autowired
	DownloadNoticeService downloadNoticeService;
	
	@Value("${file.upload.directory.attached}")
	public String uploadDirectory;
	
	@Autowired
	FileDownloadView fileDownloadView;
	
	@RequestMapping("/list.do")
	public String list(@RequestParam(value="category", required=false) String category, Model model) {
		model.addAttribute("boards", downloadNoticeService.getAllBoards());
		model.addAttribute("category", category);
		
		return "/servicecenter/notice/downloadnotice";
	}
	
	@RequestMapping("/download.do")
	public ModelAndView download(@RequestParam("boardNo") int boardNo) {
		ModelAndView mav = new ModelAndView();
		
		DownloadNotice notice = downloadNoticeService.getBoard(boardNo);
		
		mav.addObject("directory", uploadDirectory);
		mav.addObject("filename", notice.getAttachFile().getName());
		mav.setView(fileDownloadView);
		
		return mav;
	}
}
