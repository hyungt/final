package com.ese.controller.manage.download;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ese.service.manage.download.UploadService;
import com.ese.vo.forms.UploadForm;
import com.ese.vo.hr.Employee;
import com.ese.vo.notice.DownloadNotice;
import com.ese.vo.notice.FileAttach;

@Controller
public class UploadController {

	@Autowired
	private ServletContext servletContext;
	
	//@Value("${file.upload.download}")
	//String uploadDirectory;
	
	@Autowired
	UploadService uploadService;
	
	@RequestMapping("/manage/upload.do")
	public String getAllUpload(Model model,HttpSession session){
		Employee empLogined = (Employee) session.getAttribute("loginedHR");
		if(empLogined == null) {
			return "redirect:/manage/login.do";
		}
		model.addAttribute("loginEmployee", session.getAttribute("loginedHR"));
		model.addAttribute("uploadFile",uploadService.getAllUpload());
		return "/manage/downloadNotice/downloadList";
	}
	
	@RequestMapping("/manage/addUpload.do")
	public String updateUpload(UploadForm uploadForm) throws IOException {
		FileAttach fileAttach = new FileAttach();
		DownloadNotice downloadNotice = new DownloadNotice();
		
		fileAttach.setSize(uploadForm.getUpfile().getSize());
		BeanUtils.copyProperties(uploadForm, downloadNotice);
		
		MultipartFile upFile = uploadForm.getUpfile();
		System.out.println(upFile);
		String files = System.currentTimeMillis() + upFile.getOriginalFilename();
		Long siz = upFile.getSize();
		
		fileAttach.setSize(siz);
		fileAttach.setName(files);
		uploadService.addFile(fileAttach);
		
		FileAttach fileOne = uploadService.getFileNoByName(files);
		String uploadDirectory = servletContext.getRealPath("/resources/util");
		FileCopyUtils.copy(upFile.getBytes(), new File(uploadDirectory, files));
		
		downloadNotice.setAttachFile(fileOne);
		uploadService.addUpload(downloadNotice);
		
		return "redirect:/manage/upload.do";
	}
	
}
