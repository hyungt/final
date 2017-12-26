package com.ese.mappers.notice;

import java.util.List;

import com.ese.vo.common.DownNoticeCriteria;
import com.ese.vo.notice.DownloadNotice;

public interface DownloadNoticeMapper {
	List<DownloadNotice> getAllBoards();
	DownloadNotice getBoard(int boardNo);
	int getTotalRows();
	List<DownloadNotice> getTotalBoards(DownNoticeCriteria criteria);
}
