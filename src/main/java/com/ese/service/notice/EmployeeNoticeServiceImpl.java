package com.ese.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.notice.EmployeeNoticeMapper;
import com.ese.vo.notice.EmployeeNotice;
import com.ese.vo.pagination.notice.Pagination;

@Service
public class EmployeeNoticeServiceImpl implements EmployeeNoticeService {
	
	@Autowired
	EmployeeNoticeMapper employeeNoticeMapper;
	
	public void addBoard(EmployeeNotice employeeNotice) {
		employeeNoticeMapper.addBoard(employeeNotice);
	}
	public List<EmployeeNotice> getAllBoards(Pagination pagination) {
		return employeeNoticeMapper.getAllBoards(pagination);
	}
	public int getTotalRows(Pagination pagination) {
		return employeeNoticeMapper.getTotalRows(pagination);
	}
	public EmployeeNotice getBoardByNo(int boardNo) {
		EmployeeNotice employeeNotice = employeeNoticeMapper.getBoardByNo(boardNo);
		employeeNotice.setCount(employeeNotice.getCount()+1);
		employeeNoticeMapper.updateBoard(employeeNotice);
		
		return employeeNoticeMapper.getBoardByNo(boardNo);
	}
	
	@Override
	public List<EmployeeNotice> getTwoRows() {
		return employeeNoticeMapper.getTwoRows();
	}
}
