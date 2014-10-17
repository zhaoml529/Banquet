package com.hdc.user.action;

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

import com.hdc.entity.Hotel;
import com.hdc.entity.Users;
import com.hdc.hotel.service.HotelService;
import com.hdc.page.PageBean;
import com.hdc.user.service.UserService;
import com.hdc.util.StringUtils;
/**
 * 
 * @ClassName: UserAction
 * @Description:TODO(用户控制类)
 * @author: mzj
 * @date: 2014-4-19 下午10:51:08
 *
 */

@Controller
@RequestMapping("/userAction")
public class UserAction {
	protected final transient Log log = LogFactory.getLog(UserAction.class);
    
	@Autowired
	private UserService userService;
	@Autowired
	private HotelService user_hotelService;
	/**
	 * 
	 * @Title: listManager
	 * @Description: TODO(管理员查看经理列表)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	
	@RequestMapping("/listManager/pageNum/{pageNum}")
	public String listManager(@PathVariable("pageNum") String pageNum, HttpServletRequest request,ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		userService.initManagerPageBean(pageNum_);
		PageBean<Users> pageBean = userService.getManagerPageBean();
		List<Users> managerList = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("managerList",managerList);
		return"admin/list_manager";
	}
	/**
	 * 
	 * @Title: addHotel
	 * @Description: TODO(管理员添加经理)
	 * @param: @param request
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/addManager")
	public String addManager(ModelMap modelMap){
		List<Hotel> hotelList = user_hotelService.getHotelList();
		modelMap.addAttribute("hotelList",hotelList);
		return "admin/add_manager";
	}
	@RequestMapping("/saveManager")
	public ModelAndView saveManager(@ModelAttribute("Users") Users users){
		userService.saveManager(users);
		return new ModelAndView("redirect:/userAction/listManager/pageNum/1");
	}
/**
 * 
 * @Title: deleteHotel
 * @Description: TODO(管理员删除经理)
 * @param: @param yhbh
 * @param: @return   
 * @return: ModelAndView   
 * @throws
 */
	@RequestMapping("/deleteManager/{manager_id}")
	public ModelAndView deleteManager(@PathVariable("manager_id") int manager_id){
		Users users =userService.getManagerById(manager_id);
		//System.out.println(hotel+"---"+hotel.getJdmc());
		userService.deleteManager(users);
		return new ModelAndView("redirect:/userAction/listManager/pageNum/1");
	}
	/**
	 * 
	 * @Title: showManager
	 * @Description: TODO(管理员查看经理详细信息)
	 * @param: @param manager_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/showManagerById/{manager_id}")
	public String showManager(@PathVariable("manager_id") int manager_id,ModelMap modelMap){
		Users users = userService.getManagerById(manager_id);
		modelMap.addAttribute("users", users);
		return "admin/show_manager";
	}
	/**
	 * 
	 * @Title: showAdmin
	 * @Description: TODO(管理员跳转到更新信息)
	 * @param: @param manager_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/showAdmin")
	public String showAdmin(HttpServletRequest request,ModelMap modelMap){
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");		
		Users users = userService.getAdminById(Integer.valueOf(user_id));
		modelMap.addAttribute("users", users);
		return "admin/show_admin";
	}
	
	/**
	 * 
	 * @Title: showAdmin
	 * @Description: TODO(管理员跳转到更新信息)
	 * @param: @param manager_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/updateAdminById/{manager_id}")
	public String updateAdminById(@PathVariable("manager_id") int manager_id, ModelMap modelMap){
		Users users = userService.getManagerById(manager_id);
		modelMap.addAttribute("users", users);
		return "/admin/update_admin";
	}
	/**
	 * 
	 * @Title: upadteAdmin
	 * @Description: TODO(经理保存已修改信息，持久化数据库)
	 * @param: @param users
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/upadteAdmin")
	public ModelAndView upadteAdmin(@ModelAttribute("users" ) Users users){
		userService.updateManager(users);
		return new ModelAndView("redirect:/userAction/showAdmin");		
	}
	
	/**
	 * 
	 * @Title: UpdateManagerById
	 * @Description: TODO(管理员跳转到修改经理信息页面)
	 * @param: @param manager_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/updateManagerById/{manager_id}")
	public String UpdateManagerById(@PathVariable("manager_id") int manager_id, ModelMap modelMap){
		Users users = userService.getManagerById(manager_id);
		List<Hotel> hotelList = user_hotelService.getHotelList();
		modelMap.addAttribute("hotelList",hotelList);
		modelMap.addAttribute("users", users);
		return "/admin/update_manager";
	}
	/**
	 * 
	 * @Title: updateManager
	 * @Description: TODO(修改经理信息)
	 * @param: @param users
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/updateManager")
	public ModelAndView updateManager(@ModelAttribute("users" ) Users users){
		userService.updateManager(users);
		return new ModelAndView("redirect:/userAction/listManager/pageNum/1");		
	}
	

}
