package com.ese.mappers.notice;

import java.util.List;

import com.ese.vo.forms.NoticeBoardForm;
import com.ese.vo.notice.CustomerNotice;
import com.ese.vo.pagination.notice.Pagination;

public interface CustomerNoticeMapper {
	
	void addBoard(CustomerNotice customerNotice);
	List<CustomerNotice> getAllBoards(Pagination pagination);
	CustomerNotice getBoardByNo(int boardNo);
	void updateBoard(CustomerNotice customerNotice);
	int getTotalRows(Pagination pagination);
}
