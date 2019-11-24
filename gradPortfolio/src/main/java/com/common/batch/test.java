package com.common.batch;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.common.aws.service.AwsService;
import com.common.board.domain.BoardVO;
import com.common.board.domain.FileVO;
import com.common.board.service.BoardService;
import com.common.board.service.ProBoardService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class test {
	
	private final BoardService boardService;

	private final ProBoardService proBoardService;
	
	private final AwsService awsService;
	
	//@Scheduled(initialDelay = 1000, fixedDelay = 600000)
	private void start() {
		try {
			createJson("proBoard");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws Exception{
		
		test test = new test(new BoardService(), new ProBoardService(), new AwsService());
		test.createJson("proBoard");
	}
	
	public void createJson(String boardFlag) throws Exception{
		if (boardFlag.equals("board")) {
			
			// 강아지
			//String url = "http://www.zooseyo.or.kr/Yu_board/petfind.html?area=&animal=&page=2";
			// 고양이
			String url = "http://www.zooseyo.or.kr/Yu_board/petfind.html?area=&animal=고양이&page=3";
			board(url);
		}
		
		
		if (boardFlag.equals("proBoard")) {
			// 강아지			
			//String url = "http://www.zooseyo.or.kr/Yu_board/petcare.html?area=&animal=강아지&page=3";	
			//고양이
			String url = "http://www.zooseyo.or.kr/Yu_board/petcare.html?area=&animal=고양이&page=3";
			
			proBoard(url);
		}

	}
	
	private void proBoard(String url) throws Exception{
		ArrayList srcList = new ArrayList();
		ArrayList distincList = new ArrayList();
		String homeUrl = "http://www.zooseyo.or.kr/Yu_board/";
		Document doc = null;
		
		doc = Jsoup.connect(url).get();
		Elements elem = doc.select("a");
		for (Element element : elem) {
			String href = element.attr("href");
			
			// 중복제거
			if (href.contains("petcare_view.html?no=")) {
				if (!distincList.contains(href)) {
					distincList.add(href);
				}
			}
		}
		
		for (int i = 0; i < distincList.size(); i++) {
			String detailUrl = homeUrl + distincList.get(i);
			Document detailDoc = Jsoup.connect(detailUrl).get();
			
			Element table = detailDoc.select("table").get(20);
			
			Elements tdElems = table.select("td");
			
			BoardVO boardVO = new BoardVO();
			boardVO.setLost_date(tdElems.get(4).text());
			boardVO.setTelNo(tdElems.get(8).text());
			
			if (tdElems.get(10).text().equals("암컷")) {
				boardVO.setGender("0");
			} 
			
			if (tdElems.get(10).text().equals("수컷")) {
				boardVO.setGender("1");
			}
			
			// 강아지: 1 고양이: 2
			boardVO.setKinds("2");
			
			boardVO.setLocation(tdElems.get(14).text());
			boardVO.setSubject(tdElems.get(18).text());
			boardVO.setContent(tdElems.get(22).text());
			
			
			String imgUrl = "http://www.zooseyo.or.kr/" + tdElems.get(24).select("img").attr("src");
			
			ObjectMapper mapper = new ObjectMapper();
			
			System.out.println(mapper.writeValueAsString(boardVO));
			System.out.println(imgUrl);
			
			fileDownload(imgUrl, boardVO, "proBoard");
		}
	}
	
	private void board(String url) throws Exception{

		ArrayList srcList = new ArrayList();
		String homeUrl = "http://www.zooseyo.or.kr/Yu_board/";
		Document doc = null;
		
		doc = Jsoup.connect(url).get();
		Elements elem = doc.select("a");
		for (Element element : elem) {
			String href = element.attr("href");
			
			if (href.startsWith("petfind") && href.contains("no=")) {
				String detailUrl = homeUrl + href;
				
				Document detailDoc = Jsoup.connect(detailUrl).get();
				
				Elements detailElem = detailDoc.select("img");
				Element table = detailDoc.select("table").get(5);
				Elements blElem = table.select("b");
				
				String imgUrl = "";
				for (Element detailEl : detailElem) {
					String src = detailEl.attr("src");
					if (src.contains("pet_care")) {
						imgUrl = "http://www.zooseyo.or.kr" + src;
					}
				}
				
				Elements telEm = detailDoc.select("b");
				
				String telNo = "";
				
				if (telEm.size() > 0) {
					if (telEm.get(0).text().contains("연락처")) {
						telNo = telEm.get(0).text();
						String[] telNoarray = telNo.split(": ");
						telNo = telNoarray[1];
					}
				}
				
				ArrayList boardVoList = new ArrayList();
				
				for (int i = 0; i < blElem.size(); i++) {
					if (i == 3) {
						continue;
					}
					Element boardEl = blElem.get(i);
					String boardStr = boardEl.text();
					
					//암컷 0, 수컷 1
					if (boardStr.equals("암컷")) {
						boardStr = "0";
					} 
					
					if (boardStr.equals("수컷")) {
						boardStr = "1";
					}
					
					boardVoList.add(boardStr);
				}
				
				// 강아지 1, 고양이 2
				boardVoList.add("2");
				boardVoList.add(imgUrl);
				boardVoList.add(telNo);
				
				BoardVO boardVO = new BoardVO();
				// 0: 장소, 1: 날짜, 2: 제목, 3: 성별, 4: 설명, 5: 종류, 6: imgUrl, 7: 연락처

				boardVO.setLocation((String) boardVoList.get(0));
				boardVO.setLost_date((String) boardVoList.get(1));
				boardVO.setSubject((String) boardVoList.get(2));
				boardVO.setGender((String) boardVoList.get(3));
				boardVO.setContent((String) boardVoList.get(4));
				boardVO.setKinds((String) boardVoList.get(5));
				boardVO.setTelNo((String) boardVoList.get(7));
				
				ObjectMapper mapper = new ObjectMapper();
				System.out.println(mapper.writeValueAsString(boardVO));
				
				fileDownload((String)boardVoList.get(6), boardVO, "board");
			}
		}
	}
	
	private void fileDownload(String imgUrl, BoardVO board, String boardFlag) throws Exception{

		URL url = new URL(imgUrl);

		String fileName = imgUrl.substring( imgUrl.lastIndexOf('/')+1, imgUrl.length() ); // 이미지 파일명 추출

		String ext = imgUrl.substring( imgUrl.lastIndexOf('.')+1, imgUrl.length() );  // 이미지 확장자 추출

		BufferedImage img = ImageIO.read(url);
		
		
		File imgFile = new File("C:\\Users\\user\\Desktop\\강아지 이미지\\"+fileName);
		
		ImageIO.write(img, ext, imgFile);
		
		MultipartFile multipartFile = new MockMultipartFile(fileName, new FileInputStream(imgFile));
		
		if (boardFlag.equals("board")) {
			insertBoard(multipartFile, board);
		}
		
		if (boardFlag.equals("proBoard")) {
			insertProBoard(multipartFile, board);
		}
		
	}
	
	private void insertBoard(MultipartFile multipartFile, BoardVO board) throws Exception{
		FileVO file  = new FileVO();
		
    	Map<String, Object> sessionMap = new HashMap<String, Object>();
        
        board.setWriter((int) (long) 1);
    	
    	boardService.boardInsert(board);
    	
    	int boardId = board.getId();
    
		if (!StringUtils.isEmpty(multipartFile.getName())) {
			String originFileName = multipartFile.getName(); // 원본 파일 명
            
            String extension = FilenameUtils.getExtension(originFileName);
            
            String destinationFileName = RandomStringUtils.randomAlphanumeric(20) + "." + extension;

            SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
            String filePath = "aaa4285gradportfolio/board/" + date.format(new Date());
			awsService.uploadObject(filePath, multipartFile, destinationFileName);
			
			file.setBoard_id(boardId);
			file.setFilePath(filePath + "/" + destinationFileName);
			file.setFullPath("s3.ap-northeast-2.amazonaws.com" + "/" + filePath + "/" + destinationFileName);
			file.setFileName(destinationFileName);
			file.setFileOriName(originFileName);
			
			boardService.fileInsert(file);
		}
	}
	
	private void insertProBoard(MultipartFile multipartFile, BoardVO board) throws Exception{
		FileVO file  = new FileVO();
		
    	Map<String, Object> sessionMap = new HashMap<String, Object>();
        
        board.setWriter((int) (long) 1);
    	
    	proBoardService.boardInsert(board);
    	
    	int boardId = board.getId();
    
		if (!StringUtils.isEmpty(multipartFile.getName())) {
			String originFileName = multipartFile.getName(); // 원본 파일 명
            
            String extension = FilenameUtils.getExtension(originFileName);
            
            String destinationFileName = RandomStringUtils.randomAlphanumeric(20) + "." + extension;

            SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
            String filePath = "aaa4285gradportfolio/board/" + date.format(new Date());
			awsService.uploadObject(filePath, multipartFile, destinationFileName);
			
			file.setBoard_id(boardId);
			file.setFilePath(filePath + "/" + destinationFileName);
			file.setFullPath("s3.ap-northeast-2.amazonaws.com" + "/" + filePath + "/" + destinationFileName);
			file.setFileName(destinationFileName);
			file.setFileOriName(originFileName);
			
			proBoardService.fileInsert(file);
		}
	}
}
