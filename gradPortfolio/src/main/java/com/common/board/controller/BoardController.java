package com.common.board.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.common.aws.service.AwsService;
import com.common.board.domain.BoardReplyVo;
import com.common.board.domain.BoardVO;
import com.common.board.domain.FileVO;
import com.common.board.paging.Criteria;
import com.common.board.paging.PageMaker;
import com.common.board.service.BoardService;
import com.common.util.CommonUtils;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
 
    private final BoardService boardService;
    
    private final AwsService awsService;
    
    @Value("${aws.bucket.img.upload.path}")
	private String bucketImgUploadPath;
    
    @Value("${aws.bucket.img.file.path}")
	private String bucketImgFilePath;
    
    
	
    @RequestMapping("/list") //게시판 리스트 화면 호출  
    private String boardList(HttpServletRequest request,Model model, @ModelAttribute Criteria criteria) throws Exception{
        
    	CommonUtils.setSession(request, 1);
    	
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(criteria);
        
        pageMaker.setTotalCount(boardService.boardCount());
            
        List<BoardVO> list = boardService.boardList(criteria);
        
        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
            
        return "board/board_list";
    }
    
    @RequestMapping("/detail/{boardId}") 
    private String boardDetail(@PathVariable int boardId, Model model) throws Exception{
        model.addAttribute("detail", boardService.boardDetail(boardId));
        model.addAttribute("replyList", boardService.getReplyList(boardId));
        
        return "board/board_detail";
    }
    
    @RequestMapping("/insert") //게시글 작성폼 호출  
    private String boardInsertForm(){
        
        return "board/board_insert";
    }
    
    @RequestMapping("/insertProc")
    private String boardInsertProc(@ModelAttribute BoardVO board, MultipartFile[] files) throws Exception{
    	FileVO file  = new FileVO();
    	
    	boardService.boardInsert(board);
    	
    	int boardId = board.getId();
    	
    	// Array To List
    	List<MultipartFile> fileList = new ArrayList<MultipartFile>(Arrays.asList(files));

    	for (MultipartFile multipartFile : fileList) {
            String originFileName = multipartFile.getOriginalFilename(); // 원본 파일 명
            
            String extension = FilenameUtils.getExtension(originFileName);
            
            String destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + extension;

            SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
            String filePath = bucketImgUploadPath + date.format(new Date());
			awsService.uploadObject(filePath, multipartFile, destinationFileName);
			
			file.setBoard_id(boardId);
			file.setFilePath(filePath + "/" + destinationFileName);
			file.setFullPath(bucketImgFilePath + "/" + filePath + "/" + destinationFileName);
			file.setFileName(destinationFileName);
			file.setFileOriName(originFileName);
			
			boardService.fileInsert(file);
        }
    	
        return "redirect:/board/list";
    }
    
    @RequestMapping("/update/{boardId}") //게시글 수정폼 호출  
    private String boardUpdateForm(@PathVariable int boardId, Model model) throws Exception{
        
        model.addAttribute("detail", boardService.boardDetail(boardId));
        
        return "board/board_update";
    }
    
    @RequestMapping("/updateProc")
    private String boardUpdateProc(@ModelAttribute BoardVO board) throws Exception{
        
         boardService.boardUpdate(board);
         
         return "redirect:/board/detail/"+board.getBoard_id(); 
    }
 
    @RequestMapping("/delete/{boardId}")
    private String boardDelete(@PathVariable int boardId) throws Exception{
        
        boardService.boardDelete(boardId);
        
        return "redirect:/board/list";
    }
    
  //AJAX 호출 (댓글 등록)
    @RequestMapping(value="/reply/save", method=RequestMethod.POST)
    @ResponseBody
    public Object boardReplySave(@ModelAttribute BoardReplyVo boardReply) {
 
        //리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();
 
        //정보입력
        int result = boardService.regReply(boardReply);
 
        if(result > 0){
            retVal.put("code", "OK");
            retVal.put("reply_id", boardReply.getReply_id());
            retVal.put("parent_id", boardReply.getParent_id());
            retVal.put("message", "등록에 성공 하였습니다.");
        }else{
            retVal.put("code", "FAIL");
            retVal.put("message", "등록에 실패 하였습니다.");
        }
 
        return retVal;
 
    }
    
  //AJAX 호출 (댓글 삭제)
    @RequestMapping(value="/reply/del", method=RequestMethod.POST)
    @ResponseBody
    public Object boardReplyDel(@ModelAttribute BoardReplyVo boardReply) {
 
        //리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();
 
        //정보입력
        int result = boardService.delReply(boardReply);
 
        if(result>0){
            retVal.put("code", "OK");
        }else{
            retVal.put("code", "FAIL");
            retVal.put("message", "삭제에 실패했습니다. 패스워드를 확인해주세요.");
        }
 
        return retVal;
 
    }
    
  //AJAX 호출 (댓글 수정)
    @RequestMapping(value="/reply/update", method=RequestMethod.POST)
    @ResponseBody
    public Object boardReplyUpdate(@ModelAttribute BoardReplyVo boardReply) {
 
        //리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();
 
        //정보입력
        boolean check = boardService.updateReply(boardReply);
 
        if(check){
            retVal.put("code", "OK");
            retVal.put("reply_id", boardReply.getReply_id());
            retVal.put("message", "수정에 성공 하였습니다.");
        }else{
            retVal.put("code", "FAIL");
            retVal.put("message", "수정에 실패 하였습니다.");
        }
 
        return retVal;
 
    }
}