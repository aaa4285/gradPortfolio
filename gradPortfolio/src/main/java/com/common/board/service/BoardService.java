package com.common.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.board.domain.BoardVO;
import com.common.board.mapper.BoardMapper;
import com.common.board.paging.Criteria;

@Service
public class BoardService {
 
    @Autowired
    BoardMapper boardMapper;
    
    //게시글 개수  
    public int boardCount() throws Exception {
    	return boardMapper.boardCount();
    }
    
    public List<BoardVO> boardList(Criteria criteria) throws Exception{
        
        return boardMapper.boardList(criteria);
    }
    
    public BoardVO boardDetail(int bno) throws Exception{
        
        return boardMapper.boardDetail(bno);
    }
    
    public int boardInsert(BoardVO board) throws Exception{
        
        return boardMapper.boardInsert(board);
    }
    
    public int boardUpdate(BoardVO board) throws Exception{
        
        return boardMapper.boardUpdate(board);
    }
    
    public int boardDelete(int bno) throws Exception{
        
        return boardMapper.boardDelete(bno);
    }

}