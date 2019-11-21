package com.common.board.paging;

public class Criteria {
    
    private int page;
    private int perPageNum;
    private String subject;
	private String kinds;
	private String gender;
	
    public Criteria() {
        this.page = 1;
        this.perPageNum = 12;
    }
    
    public int getPage() {
        return page;
    }
    
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    
    public int getPerPageNum() {
        return perPageNum;
    }
    
    public void setPerPageNum(int pageCount) {
        this.perPageNum = pageCount;
    }
    
    public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getKinds() {
		return kinds;
	}

	public void setKinds(String kinds) {
		this.kinds = kinds;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getPageStart() {
        return (this.page-1)*perPageNum;
    }

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", subject=" + subject + ", kinds=" + kinds
				+ ", gender=" + gender + "]";
	}
	
	
}

