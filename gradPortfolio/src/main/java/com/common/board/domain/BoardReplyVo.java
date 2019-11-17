package com.common.board.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardReplyVo {
	private String reply_id;
	private int board_id;
	private String parent_id;
	private String depth;
	private String reply_content;
	private int reply_writer;
	private String register_datetime;
}
