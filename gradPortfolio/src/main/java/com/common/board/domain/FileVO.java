package com.common.board.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileVO {
	private int fno;
    private int board_id;
    private String fileName;     //저장할 파일
    private String fileOriName;  //실제 파일
    private String filePath;
}
