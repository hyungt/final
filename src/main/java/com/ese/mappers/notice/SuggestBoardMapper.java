package com.ese.mappers.notice;

import java.util.List;

import com.ese.vo.notice.Suggest;
import com.ese.vo.pagination.notice.Pagination;

public interface SuggestBoardMapper {
	void addBoard(Suggest suggest);
	List<Suggest> getAllBoards(Pagination pagination);
	int getTotalRows(Pagination pagination);
	Suggest getBoardByNo(int boardNo);
	void updateBoard(Suggest suggest);
	int getSeq();
	List<Suggest> getByResult(Pagination pagination);
	Suggest detailComment(int parentNo);
	void reply(Suggest suggest);
}
