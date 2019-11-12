package com.common.board.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
	private int board_id;
	private String subject;
	private String content;
	private String writer;
	private Date reg_date;

	
}
