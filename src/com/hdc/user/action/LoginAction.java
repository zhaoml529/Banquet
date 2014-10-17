package com.hdc.user.action;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hdc.entity.Hotel;
import com.hdc.entity.News;
import com.hdc.entity.Users;
import com.hdc.hotel.service.HotelService;
import com.hdc.news.service.NewsService;
import com.hdc.page.PageBean;
import com.hdc.user.service.LoginService;
import com.hdc.user.service.UserService;
import com.hdc.util.BeanUtils;
import com.hdc.util.Dom4j;

@Controller
@RequestMapping("/loginAction")
public class LoginAction {
	protected final transient Log log = LogFactory.getLog(LoginAction.class);
	@Autowired
	private LoginService loginService;
	@Autowired
	private HotelService mainService;
	@Autowired
	private UserService login_userService;
	@Autowired
	private NewsService login_newsService;

	
	@RequestMapping("/login_view")
	public  String loginView(HttpServletRequest request,ModelMap modelMap){
		String pic_path = request.getSession().getServletContext().getRealPath("WEB-INF");
		pic_path+=File.separator+"carousel_pic.xml";
		mainService.initHotelPageBean(1, "1");
		PageBean<Hotel> pageBean = mainService.getHotelPageBean();
		List<Hotel> list = pageBean.getList();
		List<Hotel> listURL = Dom4j.listXML(pic_path);
		List<News> listNews = null;
		List<Users> listUser = login_userService.getUsersByRole();
		PageBean<News> newsPageBean = null;
		if(!BeanUtils.isBlank(listUser)){
			String user_id = String.valueOf(listUser.get(0).getYhbh());
			login_newsService.getHotelNews(1, 5, user_id);
			newsPageBean = login_newsService.getNewsPageBean();
			listNews = newsPageBean.getList();
		}
		modelMap.addAttribute("listNews", listNews);
		modelMap.addAttribute("newsPageBean",newsPageBean);
		modelMap.addAttribute("hotelPageBean",pageBean);
		modelMap.addAttribute("listHotel",list);
		modelMap.addAttribute("listURL", listURL);
		modelMap.addAttribute("hotelPage", "1");
		modelMap.addAttribute("newsPage", "1");
		modelMap.addAttribute("xzq_id", 1);
		return "main";
	}
	
	
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception{
		HttpSession session = request.getSession();
		session.removeAttribute("user_id");
		session.removeAttribute("user_name");
		session.removeAttribute("hotel_id");
		session.removeAttribute("role");
		session.invalidate();
		return new ModelAndView("redirect:/loginAction/login_view");
	}
	@RequestMapping("/login")
	public String login(HttpServletRequest request,ModelMap modelMap){
		String username=request.getParameter("username");
		String password=request.getParameter("userpwd");
		HttpSession session = request.getSession();
		List<Users> user = loginService.getUserById(username);
		if(!BeanUtils.isBlank(user)){
			if(!password.equals(user.get(0).getMm())){
				modelMap.addAttribute("errorMessage", "密码错误");
				System.out.println("用户名密码错误！");
				return "Login";
			}else{
				String user_id = String.valueOf(user.get(0).getYhbh());
				session.setAttribute("user_id", user_id);
				session.setAttribute("user_name", user.get(0).getXm());
				String hotel_id = String.valueOf(user.get(0).getHotel().getJdbh());
				session.setAttribute("hotel_id", hotel_id);
				//1.管理员 2.经理
				String role = String.valueOf(user.get(0).getJx());
				session.setAttribute("role", role);
				System.out.println("用户名密码正确！");
				return "admin";
			}
		}else{
			modelMap.addAttribute("errorMessage", "用户不存在!");
			return "Login";
		}
	}
	@RequestMapping("/register")
	public String register(){
		return "register";
	}
	
	@RequestMapping("/saveUser")
	public String saveUser(@ModelAttribute("user") Users user, HttpServletRequest request, HttpServletResponse response) throws IOException{
//		System.out.println(user.getBirthday()+"  !!!!!!!!!!");
//		Date nowTime = new Date();
//		user.setLastlogin(nowTime);
//		user.setRegdate(nowTime);
//		user.setIp("127.0.0.1");
//		String birthday = request.getParameter("birthDay");
//		user.setBirthday(DateUtil.StringToDate(birthday, "yyyy-MM-dd"));
//		loginService.saveUser(user);
//		response.getWriter().print("<script>alert('注册成功！');</script>");
		return "Login";
		
	}
	@RequestMapping("/toLogin")
	public String toLogin(){
		return "Login";
	}
}
