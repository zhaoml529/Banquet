/**
 * Project Name:Banquet
 * File Name:NewsService.java
 * Package Name:com.hdc.news.service
 * Date:2014-6-5上午11:05:38
 *
 */
package com.hdc.news.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;
import com.hdc.entity.News;
import com.hdc.page.PageBean;
import com.hdc.page.PageDaoImpl;
import com.hdc.util.BeanUtils;

/**
 * @ClassName: NewsService
 * @Description:TODO(这里用一句话描述这个类的作用)
 * @author: zml
 * @date: 2014-6-5 上午11:05:38
 *
 */
@Service
@Transactional
public class NewsService extends BaseService <News>{
	@Autowired
	private PageDaoImpl<News> pageDao;
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initAdminNewsPageBean(int pageNum, int pageSize, String user_id) {
        pageDao.initPageBean(pageNum, pageSize, "com.hdc.entity.News",new String[]{"users"}, new String[]{user_id});
    }
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initPendingNewsPageBean(int pageNum, int pageSize) {
        pageDao.initPageBean(pageNum, pageSize, "com.hdc.entity.News",new String[]{"sh"}, new String[]{"0"});
    }
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void getHotelNews(int pageNum, int pageSize, String user_id){
		pageDao.initPageBean(pageNum, pageSize, "com.hdc.entity.News", new String[]{"users", "sh", "xs"}, new String[]{user_id, "1", "1"});
	}
	
	public News getNewsById(Integer news_id){
		News news = (News)getBean(News.class, news_id);
		return news;
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public PageBean<News> getNewsPageBean() {
        return pageDao.getPage();
    }
	public void updateNews(News news){
		update(news);
	}
	public void saveNews(News news){
		save(news);
	}
	public void deleteNews(News news){
		delete(news);
	}
	public int getPendingNewsCount(){
		List<News> newsList = findByWhere("com.hdc.entity.News", new String[]{"sh"}, new String[]{"0"});
		if(BeanUtils.isBlank(newsList)){
			return 0;
		}else{
			return newsList.size();
		}
	}
	
	public List<News> findByUserId(String user_id ){
		List<News> newsList = findByWhere("com.hdc.entity.News", new String[]{"users"}, new String[]{user_id});
		return newsList;
	}
}
