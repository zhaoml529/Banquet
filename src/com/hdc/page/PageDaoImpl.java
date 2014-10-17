/**
 * 
 */
package com.hdc.page;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;

/**
 * @ClassName: PageDaoImpl
 * @Description:TODO(·ÖÒ³)
 * @author: zml
 * @param <T>
 * @date: 2014-4-12 ÏÂÎç12:56:06
 *
 */
@Service
@Transactional
public class PageDaoImpl<T> extends BaseService<PageBean<T>>{
	private String tableName;
	public PageBean<T> page;
	private String[] columns;
	private String[] values;
	public int start;
	public int pageSize;
	public void initPageBean(int start,int pageSize, String tableName,String[] columns, String[] values) {
		page = new PageBean<T>();
		this.tableName = tableName;
		this.columns = columns;
		this.values = values;
		this.start = start;
		this.pageSize = pageSize;
		setRowCount();
		setPageSize();
		setTotalPage();
		setCurrentPage();
		setPrePage();
		setNextPage();
		setPreOrNextBoolean();
	}

	public int getRowCount() {
		List<PageBean<T>> list = new ArrayList<PageBean<T>>();
		if(columns.length <= 0 && values.length <= 0){
			list = getAllList(tableName);
		}else{
			list = findByWhere(tableName, columns, values);
		}
		if (list == null) {
			return 0;
		}
		return list.size();
	}

	@SuppressWarnings("unchecked")
	public PageBean<T> getPage() {
		List<T> list = (List<T>) queryByPage(tableName, columns, values, getStartIndex(), page.getPageSize());
		page.setList(list);
		return page;
	}
	@SuppressWarnings("unchecked")
	public PageBean<T> getDimPage() {
		List<T> list =  (List<T>) findByDim(tableName, columns, values, getStartIndex(), page.getPageSize());
		page.setList(list);
		return page;
	}
	@SuppressWarnings("unchecked")
	public PageBean<T> getRangePage() {
		List<T> list =  (List<T>) getBanquetRange(tableName, columns, values, getStartIndex(), page.getPageSize());
		page.setList(list);
		return page;
	}
	public void setPreOrNextBoolean() {
		if (page.getCurrentPage() <= 1) {
			page.setHasPreviousPage(false);
		} else {
			page.setHasPreviousPage(true);
		}
		if (page.getCurrentPage() >= page.getTotalPage()) {
			page.setHasNextPage(false);
		} else {
			page.setHasNextPage(true);
		}
	}

	public void setCurrentPage() {
		if (start < 1) {
			page.setCurrentPage(1);
		}
		if (start > page.getTotalPage()) {
			page.setCurrentPage(page.getTotalPage());
		}
		page.setCurrentPage(start);
	}

	public void setPrePage() {
		page.setPrePage(page.getCurrentPage() - 1);
	}

	public void setNextPage() {
		page.setNextPage(page.getCurrentPage() + 1);
	}

	public void setTotalPage() {
		int rowCount = getRowCount();
		int pageSize = page.getPageSize();
		if (rowCount > pageSize) {
			if (rowCount % pageSize == 0) {
				page.setTotalPage(rowCount / pageSize);
			} else {
				page.setTotalPage(1 + (rowCount / pageSize));
			}
		} else {
			page.setTotalPage(1);
		}
	}

	public void setRowCount() {
		page.setRowCount(getRowCount());
	}

	public void setPageSize(){
		page.setPageSize(pageSize);
	}
	public int getStartIndex() {
		int startIndex = 0;
		if (start <= 0) {
			startIndex = 0;
		} else {
			if (start > page.getTotalPage()) {
				startIndex = page.getPageSize() * (page.getTotalPage() - 1);
			} else {
				startIndex = page.getPageSize() * (start - 1);
			}
		}
		return startIndex;
	}

	
}
