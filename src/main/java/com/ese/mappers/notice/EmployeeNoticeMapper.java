package com.ese.mappers.notice;

import java.util.List;

import com.ese.vo.notice.EmployeeNotice;
import com.ese.vo.pagination.notice.Pagination;

public interface EmployeeNoticeMapper {

	void addBoard(EmployeeNotice employeeNotice);
	List<EmployeeNotice> getAllBoards(Pagination pagination);
	int getTotalRows(Pagination pagination);
	EmployeeNotice getBoardByNo(int boardNo);
	void updateBoard(EmployeeNotice employeeNotice);
	List<EmployeeNotice> getTwoRows();
}
