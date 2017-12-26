package com.ese.controller.manage.download;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.mappers.manage.download.UploadMapper;
import com.ese.vo.notice.DownloadNotice;

@Controller
public class UploadAjaxController {

	@Autowired
	UploadMapper uploadMapper;
	
	@RequestMapping("/manage/detailUpload.do")
	@ResponseBody
	public DownloadNotice getUploadByNo(int fileNo) {
		DownloadNotice downloadNotice = uploadMapper.getUploadByNo(fileNo);
		return downloadNotice;
	}
}
