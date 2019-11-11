package com.common.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.board.domain.BoardVO;
import com.common.board.paging.Criteria;
import com.common.board.paging.PageMaker;
import com.common.board.service.BoardService;
import com.common.util.CommonUtils;

@Controller
@RequestMapping("/board")
public class BoardController {
 
    @Autowired
    private BoardService boardService;
    
    @RequestMapping("/list") //게시판 리스트 화면 호출  
    private String boardList(HttpServletRequest request,Model model, @ModelAttribute Criteria criteria) throws Exception{
        
    	CommonUtils.setSession(request, 5);
        
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(criteria);
        pageMaker.setTotalCount(boardService.boardCount());
            
        List<BoardVO> list = boardService.boardList(criteria);
        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
            
        return "board/board_list";
    }
    
    @RequestMapping("/detail/{bno}") 
    private String boardDetail(@PathVariable int bno, Model model) throws Exception{
        
        model.addAttribute("detail", boardService.boardDetail(bno));
        
        return "board/board_detail";
    }
    
    @RequestMapping("/insert") //게시글 작성폼 호출  
    private String boardInsertForm(){
        
        return "board/board_insert";
    }
    
    @RequestMapping("/insertProc")
    private String boardInsertProc(@ModelAttribute BoardVO board) throws Exception{
        
		boardService.boardInsert(board);
        
        return "redirect:/board/list";
    }
    
    @RequestMapping("/update/{bno}") //게시글 수정폼 호출  
    private String boardUpdateForm(@PathVariable int bno, Model model) throws Exception{
        
        model.addAttribute("detail", boardService.boardDetail(bno));
        
        return "board/board_update";
    }
    
    @RequestMapping("/updateProc")
    private String boardUpdateProc(@ModelAttribute BoardVO board) throws Exception{
        
         boardService.boardUpdate(board);
         
         return "redirect:/board/detail/"+board.getBno(); 
    }
 
    @RequestMapping("/delete/{bno}")
    private String boardDelete(@PathVariable int bno) throws Exception{
        
        boardService.boardDelete(bno);
        
        return "redirect:/board/list";
    }
}