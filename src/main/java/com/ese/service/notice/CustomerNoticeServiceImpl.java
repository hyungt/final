package com.ese.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.notice.CustomerNoticeMapper;
import com.ese.vo.notice.CustomerNotice;
import com.ese.vo.pagination.notice.Pagination;

@Service
public class CustomerNoticeServiceImpl implements CustomerNoticeService {
	
	@Autowired
	CustomerNoticeMapper customerNoticeMapper;
	
	public void addBoard(CustomerNotice customerNotice) {
		customerNoticeMapper.addBoard(customerNotice);
	}
	public List<CustomerNotice> getAllBoards(Pagination pagination) {
		return customerNoticeMapper.getAllBoards(pagination);
	}
	public CustomerNotice getBoardByNo(int boardNo) {
				
		CustomerNotice customerNotice = customerNoticeMapper.getBoardByNo(boardNo);
		customerNotice.setCount(customerNotice.getCount()+1);
		customerNoticeMapper.updateBoard(customerNotice);
		
		return customerNoticeMapper.getBoardByNo(boardNo);
	}
	public void updateBoard(CustomerNotice customerNotice) {
		customerNoticeMapper.updateBoard(customerNotice);
	}
	@Override
	public int getTotalRows(Pagination pagination) {
		return customerNoticeMapper.getTotalRows(pagination);
	}
}
