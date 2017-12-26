package com.ese.controller.servicecenter.notice;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.notice.DownloadNoticeService;
import com.ese.vo.common.DownNoticeCriteria;
import com.ese.vo.notice.DownloadNotice;

@Controller
@RequestMapping("/servicecenter/notice/download")
public class DownAjaxController {

	@Autowired
	DownloadNoticeService downloadNoticeService;
	
	@RequestMapping("/loaddownloadlist.do")
	@ResponseBody
	public Map<String, Object> loaddownloadlist(DownNoticeCriteria criteria){
		int totalRows = downloadNoticeService.getTotalRows();
		criteria.setTotalRows(totalRows);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("navi", criteria);
		map.put("boards", downloadNoticeService.getTotalBoards(criteria));
		
		return map;
	}
	
	@RequestMapping("/detailUpload.do")
	@ResponseBody
	public DownloadNotice detailUpload(int boardNo) {
		return downloadNoticeService.getBoard(boardNo);
	}
	
}
