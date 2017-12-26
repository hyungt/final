package com.ese.service.notice;

import java.util.List;

import com.ese.vo.notice.CustomerNotice;
import com.ese.vo.pagination.notice.Pagination;

public interface CustomerNoticeService {

	void addBoard(CustomerNotice customerNotice);
	List<CustomerNotice> getAllBoards(Pagination pagination);
	CustomerNotice getBoardByNo(int boardNo);
	int getTotalRows(Pagination pagination);
}
