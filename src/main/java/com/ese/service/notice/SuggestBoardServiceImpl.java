package com.ese.service.notice;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.notice.SuggestBoardMapper;
import com.ese.vo.notice.Suggest;
import com.ese.vo.pagination.notice.Pagination;

@Service
public class SuggestBoardServiceImpl implements SuggestBoardService {
	@Autowired
	SuggestBoardMapper suggestBoardMapper;
	
	public void addBoard(Suggest suggest) {
		int seq = suggestBoardMapper.getSeq();
		suggest.setNo(seq);
		suggest.setParentNo(seq);
		suggest.setCreatedate(new Date());
		
		suggestBoardMapper.addBoard(suggest);
	}
	public List<Suggest> getAllBoards(Pagination pagination) {
		return suggestBoardMapper.getAllBoards(pagination);
	}
	@Override
	public int getTotalRows(Pagination pagination) {
		return suggestBoardMapper.getTotalRows(pagination);
	}
	public Suggest getBoardByNo(int boardNo) {
		return suggestBoardMapper.getBoardByNo(boardNo);
	}
	public void updateBoard(Suggest suggest) {
		suggestBoardMapper.updateBoard(suggest);
	}
	
	@Override
	public List<Suggest> getByResult(Pagination pagination) {
		return suggestBoardMapper.getByResult(pagination);
	}
	@Override
	public Suggest detailComment(int parentNo) {
		return suggestBoardMapper.detailComment(parentNo);
	}
	
	@Override
	public void reply(Suggest suggest) {
		int seq = suggestBoardMapper.getSeq();
		suggest.setNo(seq);
		
		suggestBoardMapper.reply(suggest);
	}
}
