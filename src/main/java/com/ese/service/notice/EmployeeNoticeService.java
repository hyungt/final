package com.ese.service.notice;

import java.util.List;

import com.ese.vo.notice.EmployeeNotice;
import com.ese.vo.pagination.notice.Pagination;

public interface EmployeeNoticeService {
	
	void addBoard(EmployeeNotice employeeNotice);
	List<EmployeeNotice> getAllBoards(Pagination pagination);
	int getTotalRows(Pagination pagination);
	EmployeeNotice getBoardByNo(int boardNo);
	List<EmployeeNotice> getTwoRows();
}
