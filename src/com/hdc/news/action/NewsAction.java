/**
 * Project Name:Banquet
 * File Name:NewsAction.java
 * Package Name:com.hdc.news.action
 * Date:2014-6-5上午11:03:20
 *
 */
package com.hdc.news.action;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hdc.entity.Hotel;
import com.hdc.entity.News;
import com.hdc.entity.Users;
import com.hdc.hotel.service.HotelService;
import com.hdc.news.service.NewsService;
import com.hdc.page.PageBean;
import com.hdc.user.service.UserService;
import com.hdc.util.BeanUtils;
import com.hdc.util.DateUtil;
import com.hdc.util.Dom4j;
import com.hdc.util.StringUtils;

/**
 * @ClassName: NewsAction
 * @Description:TODO(新闻控制类)
 * @author: zml
 * @date: 2014-6-5 上午11:03:20
 *
 */
@Controller
@RequestMapping("/newsAction")
public class NewsAction {
	protected final transient Log log = LogFactory.getLog(NewsAction.class);
	
	@Autowired
	private NewsService newsService;
	@Autowired
	private HotelService news_hotelService;
	@Autowired
	private UserService news_userService;
	
	
	/**
	 * 
	 * @Title: listNews
	 * @Description: TODO(后台管理员新闻列表)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listAdminNews/pageNum/{pageNum}/{hotel_id}")
	public String listAdminNews(@PathVariable("pageNum") String pageNum, @PathVariable("hotel_id") String hotel_id, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}	
		int pageNum_ = Integer.parseInt(pageNum);
		String user_id = null;
		List<Users> userList = null;
		if("admin".equals(hotel_id)){
			HttpSession session = request.getSession();
			user_id = (String) session.getAttribute("user_id");
		}else{
			userList = news_userService.getUsersByHotel(hotel_id);
			if(!BeanUtils.isBlank(userList)){
				user_id = String.valueOf(userList.get(0).getYhbh());
			}else{
				user_id = "0";
			}
		}
		newsService.initAdminNewsPageBean(pageNum_, 10, user_id);
		PageBean<News> pageBean = newsService.getNewsPageBean();
		List<News> newsList = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("newsList", newsList);
		List<Hotel> hotelList = news_hotelService.getHotelList();
	    modelMap.addAttribute("hotelList",hotelList);
	    modelMap.addAttribute("hotel_id", hotel_id);
	    modelMap.addAttribute("pageAction", "listAdminNews");
	    int newsCount = newsService.getPendingNewsCount();
	    modelMap.addAttribute("newsCount", newsCount);
	    //管理员页面有酒店下拉菜单，根据酒店id查看新闻
		return "admin/list_news";
	}
	
	/**
	 * 
	 * @Title: listPendingNews
	 * @Description: TODO(管理员查看待审核新闻)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listPendingNews/pageNum/{pageNum}/{hotel_id}")
	public ModelAndView listPendingNews(@PathVariable("pageNum") String pageNum, @PathVariable("hotel_id") String hotel_id, HttpServletRequest request){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}	
		int pageNum_ = Integer.parseInt(pageNum);
		newsService.initPendingNewsPageBean(pageNum_, 10);
		PageBean<News> pageBean = newsService.getNewsPageBean();
		List<News> newsList = pageBean.getList();
		ModelAndView model = new ModelAndView("admin/list_news");
		model.addObject("pageBean", pageBean);
		model.addObject("newsList", newsList);
		List<Hotel> hotelList = news_hotelService.getHotelList();
		model.addObject("hotelList", hotelList);
		model.addObject("hotel_id", hotel_id);
		model.addObject("pageAction", "listPendingNews");
		return model;
	}
	
	/**
	 * 
	 * @Title: listNews
	 * @Description: TODO(普通用户点击新闻分页)
	 * @param: @param pageNum
	 * @param: @param xzq_id
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listNews/pageNum/{pageNum}/{xzq_id}/{hotelPage}")
	public String listNews(@PathVariable("pageNum") String pageNum,@PathVariable("xzq_id") String xzq_id , @PathVariable("hotelPage") String hotelPage,HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum);
		List<News> listNews = null;
		List<Users> listUser = news_userService.getUsersByRole();
		PageBean<News> newsPageBean = null;
		if(!BeanUtils.isBlank(listUser)){
			String user_id = String.valueOf(listUser.get(0).getYhbh());
			newsService.getHotelNews(pageNum_, 5, user_id);
			newsPageBean = newsService.getNewsPageBean();
			listNews = newsPageBean.getList();
		}
		modelMap.addAttribute("listNews", listNews);
		modelMap.addAttribute("newsPageBean",newsPageBean);
		if(StringUtils.isBlank(hotelPage)){
			hotelPage = "1";
		}
		news_hotelService.initHotelPageBean(new Integer(hotelPage), xzq_id);
		PageBean<Hotel> hotelPageBean = news_hotelService.getHotelPageBean();
		List<Hotel> list = hotelPageBean.getList();
		modelMap.addAttribute("hotelPageBean",hotelPageBean);
		modelMap.addAttribute("listHotel",list);
		modelMap.addAttribute("xzq_id", xzq_id);
		modelMap.addAttribute("newsPage", pageNum);
		String pic_path = request.getSession().getServletContext().getRealPath("WEB-INF");
		pic_path+=File.separator+"carousel_pic.xml";
		List<Hotel> listURL = Dom4j.listXML(pic_path);
		modelMap.addAttribute("listURL", listURL);
		return "main";
		
	}
	
	
	/**
	 * 
	 * @Title: addNews
	 * @Description: TODO(管理员跳转到添加新闻页面)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminAddNews")
	public String addNews(){
		
		return "admin/add_news";
	}
	
	/**
	 * 
	 * @Title: saveNews
	 * @Description: TODO(管理员添加新闻，持久化到数据库)
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminSaveNews")
	public ModelAndView saveNews(@ModelAttribute("news") News news, HttpServletRequest request){
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		Users users = new Users();
		users.setYhbh(Integer.parseInt(user_id));
		news.setUsers(users);
		String fbsj = DateUtil.DateToString(new Date(), "yyyy-MM-dd HH:mm");
		news.setFbsj(fbsj);
		news.setSh(0);
		news.setXs(0);
		newsService.saveNews(news);
		return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/admin");
	}
	
	/**
	 * 
	 * @Title: updateNewsById
	 * @Description: TODO(管理员跳转到修改新闻页面)
	 * @param: @param news_id
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminUpdateNewsById/{news_id}")
	public String  updateNewsById(@PathVariable("news_id") String news_id, ModelMap modelMap){
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		
		modelMap.addAttribute("news", news);
		return "admin/update_news";
	}
	
	/**
	 * 
	 * @Title: updateNews
	 * @Description: TODO(管理员修改新闻，持久化到数据库)
	 * @param: @param news
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminUpdateNews")
	public ModelAndView updateNews(@ModelAttribute("news") News news, ModelMap modelMap){
		String fbsj = DateUtil.DateToString(new Date(), "yyyy-MM-dd HH:mm");
		news.setFbsj(fbsj);
		news.setSh(0);
		news.setXs(0);
		newsService.updateNews(news);
		Integer user_id = news.getUsers().getYhbh();
		Users users = news_userService.getManagerById(user_id);
		Integer role_id = users.getJx();
		if(role_id == 1){
			return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/admin");
		}else{
			return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/"+users.getHotel().getJdbh());
		}
	}
	/**
	 * 
	 * @Title: deleteNews
	 * @Description: TODO(管理员删除新闻)
	 * @param: @param news_id
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminDeleteNews/{news_id}")
	public ModelAndView deleteNews(@PathVariable("news_id") String news_id, ModelMap modelMap){
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		newsService.deleteNews(news);
		Integer user_id = news.getUsers().getYhbh();
		Users users = news_userService.getManagerById(user_id);
		Integer hotel_id = users.getHotel().getJdbh();
		return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/"+hotel_id);
	}
	
	/**
	 * 
	 * @Title: adminPassNews
	 * @Description: TODO(管理员跳到审核页面)
	 * @param: @param news_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminPassNewsById/{news_id}")
	public String adminPassNewsById(@PathVariable("news_id") String news_id, ModelMap modelMap){
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		String hotel_name = news.getUsers().getHotel().getJdmc();
		modelMap.addAttribute("news", news);
		modelMap.addAttribute("hotel_name", hotel_name);
		return "admin/show_news";
	}

	/**
	 * 
	 * @Title: adminPassNews
	 * @Description: TODO(管理员审核通过新闻)
	 * @param: @param news_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminPassNews/{news_id}/{isPass}")
	public ModelAndView adminPassNews(@PathVariable("news_id") String news_id,@PathVariable("isPass") String isPass, ModelMap modelMap){
		Integer sh = Integer.parseInt(isPass);
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		news.setSh(sh);
		if(sh == 0){
			news.setXs(0);
		}
		newsService.updateNews(news);
		Integer user_id = news.getUsers().getYhbh();
		Users users = news_userService.getManagerById(user_id);
		Integer role_id = users.getJx();
		if(role_id == 1){
			return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/admin");
		}else{
			return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/"+users.getHotel().getJdbh());
		}
	}
	
	/**
	 * 
	 * @Title: adminDisplayNews
	 * @Description: TODO(管理员控制显示新闻)
	 * @param: @param news_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminDisplayNews/{news_id}/{isDisp}")
	public ModelAndView adminDisplayNews(@PathVariable("news_id") String news_id, @PathVariable("isDisp") String isDisp, ModelMap modelMap){
		Integer xs = Integer.parseInt(isDisp);
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		news.setXs(xs);
		newsService.updateNews(news);
		Integer user_id = news.getUsers().getYhbh();
		Users users = news_userService.getManagerById(user_id);
		Integer role_id = users.getJx();
		if(role_id == 1){
			return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/admin");
		}else{
			return new ModelAndView("redirect:/newsAction/listAdminNews/pageNum/1/"+users.getHotel().getJdbh());
		}
	}
	/**
	 * 
	 * @Title: listManagerNews
	 * @Description: TODO(经理查看新闻列表)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listManagerNews/pageNum/{pageNum}")
	public String listManagerNews(@PathVariable("pageNum") String pageNum, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}	 
		int pageNum_ = Integer.parseInt(pageNum);
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		newsService.initAdminNewsPageBean(pageNum_, 10, user_id);
		PageBean<News> pageBean = newsService.getNewsPageBean();
		List<News> newsList = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("newsList", newsList);
		return "manager/list_news";
	}
	/**
	 * 
	 * @Title: managerShowNewsById
	 * @Description: TODO(经理查看新闻详情)
	 * @param: @param news_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/managerShowNewsById/{news_id}")
	public String managerShowNewsById(@PathVariable("news_id") String news_id, ModelMap modelMap){
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		modelMap.addAttribute("news", news);
		return "manager/show_news";
	}
	/**
	 * 
	 * @Title: managerUpdateNewsById
	 * @Description: TODO(经理跳转到修改新闻页面)
	 * @param: @param news_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/managerUpdateNewsById/{news_id}")
	public String  managerUpdateNewsById(@PathVariable("news_id") String news_id, ModelMap modelMap){
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		modelMap.addAttribute("news", news);
		return "manager/update_news";
	}
	/**
	 * 
	 * @Title: managerUpdateNews
	 * @Description: TODO(经理修改新闻，持久化到数据库)
	 * @param: @param news
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/managerUpdateNews")
	public ModelAndView managerUpdateNews(@ModelAttribute("news") News news, ModelMap modelMap){
		String fbsj = DateUtil.DateToString(new Date(), "yyyy-MM-dd HH:mm");
		news.setFbsj(fbsj);
		news.setSh(0);
		news.setXs(0);
		newsService.updateNews(news);
		Integer user_id = news.getUsers().getYhbh();
		Users users = news_userService.getManagerById(user_id);
		modelMap.addAttribute("hotel_id", users.getHotel().getJdbh());
		return new ModelAndView("redirect:/newsAction/listManagerNews/pageNum/1"+user_id);
	}
	/**
	 * 
	 * @Title: addNews
	 * @Description: TODO(经历跳转到添加新闻页面)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/managerAddNews")
	public String managerAddNews(){
		
		return "manager/add_news";
	}
	/**
	 * 
	 * @Title: ManagerSaveNews
	 * @Description: TODO(经理添加新闻，持久化到数据库)
	 * @param: @param news
	 * @param: @param request
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/managerSaveNews")
	public ModelAndView managerSaveNews(@ModelAttribute("news") News news, HttpServletRequest request){
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		Users users = new Users();
		users.setYhbh(Integer.parseInt(user_id));
		news.setUsers(users);
		String fbsj = DateUtil.DateToString(new Date(), "yyyy-MM-dd HH:mm");
		news.setFbsj(fbsj);
		news.setSh(0);
		news.setXs(0);
		newsService.saveNews(news);
		return new ModelAndView("redirect:/newsAction/listManagerNews/pageNum/1"+user_id);
	}
	/**
	 * 
	 * @Title: deleteNews
	 * @Description: TODO(经理删除新闻)
	 * @param: @param news_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/managerDeleteNews/{news_id}")
	public ModelAndView managerDeleteNews(@PathVariable("news_id") String news_id, ModelMap modelMap){
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		newsService.deleteNews(news);
		Integer user_id = news.getUsers().getYhbh();
		Users users = news_userService.getManagerById(user_id);
		modelMap.addAttribute("hotel_id", users.getHotel().getJdbh());
		return new ModelAndView("redirect:/newsAction/listManagerNews/pageNum/1"+user_id);
	}
	/**
	 * 
	 * @Title: managerDisplayNews
	 * @Description: TODO(经理控制新闻显示)
	 * @param: @param news_id
	 * @param: @param isDisp
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/managerDisplayNews/{news_id}/{isDisp}/{page}")
	public ModelAndView managerDisplayNews(@PathVariable("news_id") String news_id, @PathVariable("isDisp") String isDisp,@PathVariable("page") String page , ModelMap modelMap){
		Integer xs = Integer.parseInt(isDisp);
		News news = newsService.getNewsById(Integer.parseInt(news_id));
		news.setXs(xs);
		newsService.updateNews(news);
		return new ModelAndView("redirect:/newsAction/listManagerNews/pageNum/"+page);
	}
	
	
}
