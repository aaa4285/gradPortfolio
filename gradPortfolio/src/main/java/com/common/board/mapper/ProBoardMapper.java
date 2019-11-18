package com.common.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.common.board.domain.BoardReplyVo;
import com.common.board.domain.ProBoardVO;
import com.common.board.domain.FileVO;
import com.common.board.paging.Criteria;

@Mapper
public interface ProBoardMapper {
	 //게시글 개수  
    public int boardCount() throws Exception;
    
    //게시글 목록  
    public List<ProBoardVO> boardList(Criteria criteria) throws Exception;
    
    //게시글 상세
    public ProBoardVO boardDetail(int bno) throws Exception;
    
    //게시글 작성  
    public int boardInsert(ProBoardVO board) throws Exception;
    
    //게시글 수정  
    public int boardUpdate(ProBoardVO board) throws Exception;
    
    //게시글 삭제  
    public int boardDelete(int bno) throws Exception;
    
    int regReply(BoardReplyVo boardReply);
    
    List<BoardReplyVo> getReplyList(int boardId);
    
    int delReply(BoardReplyVo boardReply);
    
    boolean updateReply(BoardReplyVo boardReply);
    
    public int fileInsert(FileVO file) throws Exception;
}
