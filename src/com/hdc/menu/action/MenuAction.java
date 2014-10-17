package com.hdc.menu.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hdc.entity.Hotel;
import com.hdc.entity.Menu;
import com.hdc.hotel.service.HotelService;
import com.hdc.menu.service.MenuService;
import com.hdc.page.PageBean;
import com.hdc.util.StringUtils;
import com.hdc.util.UploadPicture;

@Controller
@RequestMapping("/menuAction")
public class MenuAction {
	protected final transient Log log = LogFactory.getLog(MenuAction.class);
	private static final String MENU = "menu";
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private HotelService menu_hotelService;
	/**
	 * 
	 * @Title: listMenu
	 * @Description: TODO(管理员菜单列表)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listAdminMenu/pageNum/{pageNum}")
	public String listAdminMenu(@PathVariable("pageNum")String pageNum, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}	
		int pageNum_ = Integer.parseInt(pageNum);
		String hotel_id = request.getParameter("hotel_id");
		if(StringUtils.isBlank(hotel_id)) hotel_id = "0";
		menuService.initAdminMenuPageBean(pageNum_, 10, hotel_id);
		PageBean<Menu> pageBean = menuService.getMenuPageBean();
		List<Menu> menuList = pageBean.getList();
		List<Hotel> hotelList = menu_hotelService.getHotelList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("menuList", menuList);
	    modelMap.addAttribute("hotelList",hotelList);
	    modelMap.addAttribute("hotel_id", hotel_id);
		return "admin/list_menu";
	}

	/**
	 * 
	 * @Title: listMenu
	 * @Description: TODO(经理菜单列表)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listMenu/pageNum/{pageNum}")
	public String listMenu(@PathVariable("pageNum")int pageNum, HttpServletRequest request, ModelMap modelMap){
		String hotel_id = (String) request.getSession().getAttribute("hotel_id");
		menuService.initMenuPageBean(pageNum, 8, hotel_id);
		PageBean<Menu> pageBean = menuService.getMenuPageBean();
		List<Menu> menuList = pageBean.getList();
		modelMap.addAttribute("pageBean", pageBean);
		modelMap.addAttribute("menuList", menuList);
		return "manager/list_menu";
	}
	
	
	/**
	 * 
	 * @Title: listMenu
	 * @Description: TODO(用户主页查看酒店列表)
	 * @param: @param pageNum
	 * @param: @param hotel_id
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listMenu/pageNum/{pageNum}/{hotel_id}")
	public String listMenu(@PathVariable("pageNum") String pageNum, @PathVariable("hotel_id") String hotel_id, HttpServletRequest request,  ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}	
		int pageNum_ = Integer.parseInt(pageNum);
		menuService.initMenuPageBean(pageNum_, 2, hotel_id);
		PageBean<Menu> pageBean = menuService.getMenuPageBean();
		List<Menu> menulist = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("menuList", menulist);
		modelMap.addAttribute("hotel_id", hotel_id);
		return "list_menu";
	}
	
	/**
	 * 
	 * @Title: addMenu
	 * @Description: TODO(管理员跳转菜谱页面)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminAddMenu")
	public String adminAddMenu(ModelMap modelMap){
		
		List<Hotel> hotelList = menu_hotelService.getHotelList();
		modelMap.addAttribute("hotelList", hotelList);
		return "admin/add_menu";
	}
	/**
	 * 
	 * @Title: addMenu
	 * @Description: TODO(经理跳转菜谱页面)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/addMenu")
	public String addMenu(HttpServletRequest request,ModelMap modelMap){
		String hotel_id = (String) request.getSession().getAttribute("hotel_id");
		modelMap.addAttribute("hotel_id",hotel_id);
		return "manager/add_menu";
	}
	/**
	 * @throws IOException 
	 * @throws IllegalStateException 
	 * 
	 * @Title: saveMenu
	 * @Description: TODO(管理员添加菜谱)
	 * @param: @param menu
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminSaveMenu")
	public ModelAndView adminSaveMenu(@ModelAttribute("menu") Menu menu, @RequestParam("file") MultipartFile file,HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IllegalStateException, IOException{
		UploadPicture uploadPicture =new UploadPicture();
		String newURL = uploadPicture.uploadPic(file, MENU, request, response);
		menu.setZttp(newURL);
		menuService.seveMenu(menu);
		modelMap.addAttribute("hotel_id", menu.getHotel().getJdbh());
		return new ModelAndView("redirect:/menuAction/listAdminMenu/pageNum/1", modelMap);
	}	
	/**
	 * 
	 * @Title: saveMenu
	 * @Description: TODO(经理添加菜谱)
	 * @param: @param menu
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/saveMenu")
	public ModelAndView saveMenu(@ModelAttribute("menu") Menu menu,@RequestParam("file") MultipartFile file,HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IllegalStateException, IOException{
	UploadPicture uploadPicture =new UploadPicture();
	String newURL = uploadPicture.uploadPic(file, MENU, request, response);
	menu.setZttp(newURL);
	menuService.seveMenu(menu);
	return new ModelAndView("redirect:/menuAction/listMenu/pageNum/1");
	}	
	/**
	 * 
	 * @Title: deleteHotel
	 * @Description: TODO(管理员删除菜谱)
	 * @param: @param tcbh
	 * @param: @param request
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminDeleteMenu/{tcbh}/{jdbh}")
		public ModelAndView deleteHotel(@PathVariable("tcbh") int tcbh, @PathVariable("jdbh") String jdbh, HttpServletRequest request, ModelMap modelMap){
			Menu menu =menuService.getMenuById(tcbh);
			menuService.deleteMenu(menu);
			modelMap.addAttribute("hotel_id", jdbh);
			return new ModelAndView("redirect:/menuAction/listAdminMenu/pageNum/1", modelMap);
		}
	/**
	 * 
	 * @Title: deleteHotel
	 * @Description: TODO(经理删除菜谱)
	 * @param: @param tcbh
	 * @param: @param request
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/deleteMenu/{tcbh}")
	  public ModelAndView deleteMenu(@PathVariable("tcbh") int tcbh,HttpServletRequest request, ModelMap modelMap){
		Menu menu =menuService.getMenuById(tcbh);
		menuService.deleteMenu(menu);
		return new ModelAndView("redirect:/menuAction/listMenu/pageNum/1");
	}
	
	/**
	 * 
	 * @Title: updateMenuById
	 * @Description: TODO(管理员跳转到更新菜谱页面)
	 * @param: @param tcbh
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminUpdateMenuById/{tcbh}/{hotel_id}")
	public String adminUpdateMenuById(@PathVariable("tcbh") int tcbh,@PathVariable("hotel_id") int hotel_id, ModelMap modelMap){
		Menu menu = menuService.getMenuById(tcbh);
		modelMap.addAttribute("menu", menu);
		modelMap.addAttribute("hotel_id", hotel_id);
		return "admin/update_menu";
	}
	/**
	 * 
	 * @Title: updateMenu
	 * @Description: TODO(管理员更新菜谱)
	 * @param: @param menu
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminUpdateMenu")
	public ModelAndView adminUpdateMenu(@ModelAttribute("menu")Menu menu, ModelMap modelMap){ 
		menuService.updateMenu(menu);
		modelMap.addAttribute("hotel_id", menu.getHotel().getJdbh());
		return new ModelAndView("redirect:/menuAction/listAdminMenu/pageNum/1",modelMap);
	}
	/**
	 * 
	 * @Title: updateMenuById
	 * @Description: TODO(经理跳转到更新菜谱页面)
	 * @param: @param tcbh
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("updateMenuById/{tcbh}/{hotel_id}")
	public String updateMenuById(@PathVariable("tcbh") int tcbh,@PathVariable("hotel_id") int hotel_id, ModelMap modelMap){
		Menu menu = menuService.getMenuById(tcbh);
		modelMap.addAttribute("menu", menu);
		modelMap.addAttribute("hotel_id", hotel_id);
		return "manager/update_menu";
	}
	/**
	 * 
	 * @Title: updateMenu
	 * @Description: TODO(经理更新菜谱)
	 * @param: @param menu
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("updateMenu")
	public ModelAndView updateMenu(@ModelAttribute("menu")Menu menu, ModelMap modelMap){ 
		menuService.updateMenu(menu);
		modelMap.addAttribute("hotel_id", menu.getHotel().getJdbh());
		return new ModelAndView("redirect:/menuAction/listMenu/pageNum/1",modelMap);
	}
	/**
	 * 
	 * @Title: updateMenu
	 * @Description: TODO(管理员和经理跳转菜谱详情)
	 * @param: @param menu
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/showMenu/{menu_id}")
	public String showMenu(@PathVariable("menu_id") int menu_id,ModelMap modelMap){
		Menu menu = menuService.getMenuById(menu_id);
		modelMap.addAttribute("menu", menu);
		return "manager/show_menu";
	}
	
	/**
	 * 
	 * @Description: TODO(管理员和经理修改菜谱图片)
	 * @param yhtbh
	 * @param file
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/uploadMenuPic/{tcbh}/{hotel_id}")
	public ModelAndView uploadBanquetPic(
			@PathVariable("tcbh") String tcbh, 
			@PathVariable("hotel_id") String hotel_id,
			@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IllegalStateException, IOException{
		UploadPicture uploadPicture =new UploadPicture();
		String newURL = uploadPicture.uploadPic(file,MENU, request, response);
		String role = (String) request.getSession().getAttribute("role");
		menuService.updateMenuPic(tcbh, newURL);
		if(Integer.parseInt(role) == 1){
			return new ModelAndView("redirect:/menuAction/adminUpdateMenuById/"+tcbh+"/"+hotel_id);
		}else{
			return new ModelAndView("redirect:/menuAction/updateMenuById/"+tcbh+"/"+hotel_id);
		}
		
	}		
}

