package com.common.board.paging;

public class Criteria {
    
    private int page;
    private int perPageNum;
    
    public int getPageStart() {
        return (this.page-1)*perPageNum;
    }
    
    public Criteria() {
        this.page = 1;
        this.perPageNum = 6;
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
}

