package com.common.board.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.board.domain.BoardReplyVo;
import com.common.board.domain.BoardVO;
import com.common.board.domain.FileVO;
import com.common.board.mapper.ProBoardMapper;
import com.common.board.paging.Criteria;

@Transactional
@Service
public class ProBoardService {

	@Autowired
	ProBoardMapper proBoardMapper;

	// 게시글 개수
	public int boardCount() throws Exception {
		return proBoardMapper.boardCount();
	}

	public List<BoardVO> boardList(Criteria criteria) throws Exception {

		return proBoardMapper.boardList(criteria);
	}

	public BoardVO boardDetail(int bno) throws Exception {

		return proBoardMapper.boardDetail(bno);
	}

	public int boardInsert(BoardVO board) throws Exception {

		return proBoardMapper.boardInsert(board);
	}

	public int boardUpdate(BoardVO board) throws Exception {

		return proBoardMapper.boardUpdate(board);
	}

	public int boardDelete(int bno) throws Exception {

		return proBoardMapper.boardDelete(bno);
	}

	public int regReply(BoardReplyVo boardReply) {
		return proBoardMapper.regReply(boardReply);
	}
	
	public int selectBoardId(BoardReplyVo boardReply) {
		return proBoardMapper.regReply(boardReply);
	}

	public List<BoardReplyVo> getReplyList(int boardId) {

		List<BoardReplyVo> boardReplyList = proBoardMapper.getReplyList(boardId);

		// msyql 에서 계층적 쿼리가 어려우니 여기서 그냥 해결하자

		// 부모
		List<BoardReplyVo> boardReplyListParent = new ArrayList<BoardReplyVo>();
		// 자식
		List<BoardReplyVo> boardReplyListChild = new ArrayList<BoardReplyVo>();
		// 통합
		List<BoardReplyVo> newBoardReplyList = new ArrayList<BoardReplyVo>();

		// 1.부모와 자식 분리
		for (BoardReplyVo boardReplyVo : boardReplyList) {
			if (boardReplyVo.getDepth().equals("0")) {
				boardReplyListParent.add(boardReplyVo);
			} else {
				boardReplyListChild.add(boardReplyVo);
			}
		}

		// 2.부모를 돌린다.
		for (BoardReplyVo boardReplyParent : boardReplyListParent) {
			// 2-1. 부모는 무조건 넣는다.
			newBoardReplyList.add(boardReplyParent);
			// 3.자식을 돌린다.
			for (BoardReplyVo boardReplyChild : boardReplyListChild) {
				// 3-1. 부모의 자식인 것들만 넣는다.
				if (boardReplyParent.getReply_id().equals(boardReplyChild.getParent_id())) {
					newBoardReplyList.add(boardReplyChild);
				}

			}

		}

		// 정리한 list return
		return newBoardReplyList;
	}

	public int delReply(BoardReplyVo boardReply) {
		return proBoardMapper.delReply(boardReply);
	}

	public boolean updateReply(BoardReplyVo boardReply) {
		return proBoardMapper.updateReply(boardReply);
	}
	
	public int fileInsert(FileVO file) throws Exception{
	    return proBoardMapper.fileInsert(file);
	}


}