package com.hdc.page;

import java.util.List;

public class PageBean<T> {

	private int pageSize;

	private int totalPage;

	private int rowCount;

	private int currentPage;

	private int prePage;

	private int nextPage;

	private boolean hasNextPage;

	private boolean hasPreviousPage;

	private List<T> list;

	public PageBean() {
		//每页显示多少数据
		//this.pageSize = 10;

	}

	public int getPageSize() {

		return pageSize;

	}

	public void setPageSize(int pageSize) {

		this.pageSize = pageSize;

	}

	public int getTotalPage() {

		return totalPage;

	}

	public void setTotalPage(int totalPage) {

		this.totalPage = totalPage;

	}

	public int getRowCount() {

		return rowCount;

	}

	public void setRowCount(int rowCount) {

		this.rowCount = rowCount;

	}

	public int getCurrentPage() {

		return currentPage;

	}

	public void setCurrentPage(int currentPage) {

		this.currentPage = currentPage;

	}

	public int getPrePage() {

		return prePage;

	}

	public void setPrePage(int prePage) {

		this.prePage = prePage;

	}

	public int getNextPage() {

		return nextPage;

	}

	public void setNextPage(int nextPage) {

		this.nextPage = nextPage;

	}

	public boolean isHasNextPage() {

		return hasNextPage;

	}

	public void setHasNextPage(boolean hasNextPage) {

		this.hasNextPage = hasNextPage;

	}

	public boolean isHasPreviousPage() {

		return hasPreviousPage;

	}

	public void setHasPreviousPage(boolean hasPreviousPage) {

		this.hasPreviousPage = hasPreviousPage;

	}

	public List<T> getList() {
		return (List<T>) list;
	}

	public void setList(List<T> list) {
		this.list =  list;
	}



}