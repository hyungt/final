package com.ese.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.notice.DownloadNoticeMapper;
import com.ese.vo.common.DownNoticeCriteria;
import com.ese.vo.notice.DownloadNotice;

@Service
public class DownloadNoticeServiceImpl implements DownloadNoticeService {
	
	@Autowired
	DownloadNoticeMapper downloadNoticeMapper;
	
	public List<DownloadNotice> getAllBoards() {
		
		return downloadNoticeMapper.getAllBoards();
	}
	
	@Override
	public DownloadNotice getBoard(int boardNo) {
		return downloadNoticeMapper.getBoard(boardNo);
	}
	
	@Override
	public int getTotalRows() {
		return downloadNoticeMapper.getTotalRows();
	}
	
	@Override
	public List<DownloadNotice> getTotalBoards(DownNoticeCriteria criteria) {
		return downloadNoticeMapper.getTotalBoards(criteria);
	}
}
