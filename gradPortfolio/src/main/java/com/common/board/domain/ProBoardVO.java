package com.common.board.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProBoardVO {
	private int id;
	private int board_id;
	private String subject;
	private String content;
	private int writer;
	private Date reg_date;
	private String fullPath;
	private String telNo;
	private String location;
	private String kinds;
	private String gender;
	private String displayName;
	private int replyCnt;
	private String lost_date;
}
