/**
 * 
 */
package com.hdc.hotel.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hdc.banquet.service.BanquetService;
import com.hdc.entity.BanquetRoom;
import com.hdc.entity.Hotel;
import com.hdc.entity.Menu;
import com.hdc.entity.News;
import com.hdc.entity.Users;
import com.hdc.hotel.service.HotelService;
import com.hdc.menu.service.MenuService;
import com.hdc.news.service.NewsService;
import com.hdc.page.PageBean;
import com.hdc.user.service.UserService;
import com.hdc.util.BeanUtils;
import com.hdc.util.Dom4j;
import com.hdc.util.StringUtils;
import com.hdc.util.UploadPicture;


/**
 * @ClassName: HotelAction
 * @Description:TODO(酒店控制类)
 * @author: zml
 * @date: 2014-4-12 下午6:37:55
 *
 */
@Controller
@RequestMapping("/hotelAction")
public class HotelAction {
	private Logger log = Logger.getLogger(getClass());
	private static final String HOTEL = "hotel";
	
	@Autowired
	private HotelService hotelService;
	@Autowired
	private BanquetService hotel_banquetService;
	@Autowired
	private MenuService hotel_menuService;
	@Autowired
	private NewsService hotel_newsService;
	@Autowired
	private UserService hotel_usersService;
	
	/**
	 * 
	 * @Title: listHotel
	 * @Description: TODO(管理员酒店列表)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listAdminHotel/pageNum/{pageNum}")
	public String listAdminHotel(@PathVariable("pageNum") String pageNum, HttpServletRequest request,ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		hotelService.initAdminHotelPageBean(pageNum_);
		PageBean<Hotel> pageBean = hotelService.getHotelPageBean();
		List<Hotel> list = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("listHotel",list);
		return "/admin/list_hotel";
	}
	@RequestMapping("/showHotel/{hotel_id}")
	public String showHotel(@PathVariable("hotel_id") int hotel_id,ModelMap modelMap){
		Hotel hotel = hotelService.getHotelById(hotel_id);
		modelMap.addAttribute("hotel", hotel);
		return "admin/show_hotel";
	}
	
	/**
	 * 
	 * @Title: listHotel
	 * @Description: TODO(普通用户点击主页上的酒店列表)
	 * @param: @param pageNum
	 * @param: @param xzq_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listHotel/pageNum/{pageNum}/{xzq_id}/{newsPage}")
	public String listHotel(@PathVariable("pageNum") String pageNum, @PathVariable("xzq_id") String xzq_id, @PathVariable("newsPage")  String newsPage, HttpServletRequest request , ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum);
		List<News> listNews = null;
		List<Users> listUser = hotel_usersService.getUsersByRole();
		PageBean<News> newsPageBean = null;
		if(StringUtils.isBlank(newsPage)){
			newsPage = "1";
		}
		if(!BeanUtils.isBlank(listUser)){
			String user_id = String.valueOf(listUser.get(0).getYhbh());
			hotel_newsService.getHotelNews(new Integer(newsPage), 5, user_id);
			newsPageBean = hotel_newsService.getNewsPageBean();
			listNews = newsPageBean.getList();
		}
		modelMap.addAttribute("listNews", listNews);
		modelMap.addAttribute("newsPageBean",newsPageBean);
		hotelService.initHotelPageBean(pageNum_, xzq_id);
		PageBean<Hotel> hotelPageBean = hotelService.getHotelPageBean();
		List<Hotel> list = hotelPageBean.getList();
		modelMap.addAttribute("hotelPageBean",hotelPageBean);
		modelMap.addAttribute("listHotel",list);
		modelMap.addAttribute("xzq_id", xzq_id);
		modelMap.addAttribute("hotelPage", pageNum);
		String pic_path = request.getSession().getServletContext().getRealPath("/WEB-INF");
		pic_path+=File.separator+"carousel_pic.xml";
		List<Hotel> listURL = Dom4j.listXML(pic_path);
		modelMap.addAttribute("listURL", listURL);
		return "main";
		//从这跳转到main页面
	}
	
	
	/**
	 * 
	 * @Title: listHotel
	 * @Description: TODO(普通用户点击主页上的具体的一个酒店)
	 * @param: @param hotel_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listHotel/{hotel_id}")
	public String listHotel(@PathVariable("hotel_id") String hotel_id, ModelMap modelMap){
		
		Hotel hotel = hotelService.getHotelById(Integer.parseInt(hotel_id));
		List<BanquetRoom> banquetList = hotel_banquetService.getBanquetRoomByHotelId(hotel_id);
		List<Menu> menuList = hotel_menuService.getMenuByHotelId(hotel_id);
		
		String user_id = null;
		List<Users> userList = hotel_usersService.getUsersByHotel(hotel_id);
		if(!BeanUtils.isBlank(userList)){
			user_id = String.valueOf(userList.get(0).getYhbh());
		}else{
			user_id = "0";
		}
		hotel_newsService.getHotelNews(1, 10, user_id);
		PageBean<News> pageBean = hotel_newsService.getNewsPageBean();
		List<News> newsList = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("newsList", newsList);
		modelMap.addAttribute("banquetList", banquetList);
		modelMap.addAttribute("hotel_id", hotel_id);
		modelMap.addAttribute("menuList", menuList);
		modelMap.addAttribute("hotel", hotel);
		return "hotel";
	}
	
	
	
	/**
	 * 
	 * @Title: addHotel
	 * @Description: TODO(管理员跳转添加酒店页面)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminAddHotel")
	public String addHotel(HttpServletRequest request, ModelMap modelMap){
		return "admin/add_hotel";
	}
	/**
	 * @throws IOException 
	 * @throws IllegalStateException 
	 * 
	 * @Title: saveHotel
	 * @Description: TODO(管理员添加酒店)
	 * @param: @param hotel
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminSaveHotel")
	public ModelAndView saveHotel(@ModelAttribute("Hotel") Hotel hotel, @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IllegalStateException, IOException{
		UploadPicture uploadPicture =new UploadPicture();
		String newURL = uploadPicture.uploadPic(file, HOTEL, request, response);
		hotel.setJdzp(newURL);
		hotelService.saveHotel(hotel);
		return new ModelAndView("redirect:/hotelAction/listAdminHotel/pageNum/1");
				
	}
	/**
	 * 
	 * @Title: deleteHotel
	 * @Description: TODO(管理员删除酒店操作)
	 * @param: @param jdbh
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminDeleteHotel/{jdbh}")
		public ModelAndView deleteHotel(@PathVariable("jdbh") int jdbh){
			Hotel hotel =hotelService.getHotelById(jdbh);
			hotelService.deleteHotel(hotel);
			return new ModelAndView("redirect:/hotelAction/listAdminHotel/pageNum/1");
		}

	/**
	 * 
	 * @Title: updateHotelById
	 * @Description: TODO(跳转到管理员更新酒店页面)
	 * @param: @param jdbh
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminUpdateHotelById/{jdbh}")
	public String adminUpdateHotelById(@PathVariable("jdbh") int jdbh, HttpServletRequest request,ModelMap modelMap){
		Hotel hotel = hotelService.getHotelById(jdbh);
		String newURL = request.getParameter("newURL");
		modelMap.addAttribute("hotel", hotel);
		modelMap.addAttribute("newURL", newURL);
		return "admin/update_hotel";
	}
	/**
	 * 
	 * @Title: updateHotel
	 * @Description: TODO(管理员更新酒店操作)
	 * @param: @param hotel
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminUpdateHotel")
	public ModelAndView updateHotel(@ModelAttribute("hotel")Hotel hotel){
		hotelService.updateHotel(hotel);
		return new ModelAndView("redirect:/hotelAction/listAdminHotel/pageNum/1");
	}
	/**
	 * 
	 * @Title: adminUploadHotelPic
	 * @Description: TODO(管理员修改酒店信息上传图片)
	 * @param: @param file
	 * @param: @param request
	 * @param: @param response
	 * @param: @param modelMap
	 * @param: @return
	 * @param: @throws IllegalStateException
	 * @param: @throws IOException   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminUploadHotelPic/{jdbh}")
	public ModelAndView adminUploadHotelPic(@PathVariable("jdbh") String jdbh, @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IllegalStateException, IOException{
		UploadPicture uploadPicture =new UploadPicture();
		String newURL = uploadPicture.uploadPic(file,HOTEL, request, response);
		hotelService.updateHotel(jdbh,newURL);
		modelMap.addAttribute("newURL", newURL);
		return new ModelAndView("redirect:/hotelAction/adminUpdateHotelById/"+jdbh,modelMap);
	}

	
	/**
	 * 
	 * @Title: showHotelById
	 * @Description: TODO(用户在主页点击要查看的酒店)
	 * @param: @param hotel_id
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/showHotelById/{hotel_id}")
	public String showHotelById(@PathVariable("hotel_id") String hotel_id, HttpServletRequest request, ModelMap modelMap){
		Hotel hotel = hotelService.getHotelById(Integer.parseInt(hotel_id));
		modelMap.addAttribute("hotel", hotel);
		return "hotel";
	}
	/**
	 * 
	 * @Title: location
	 * @Description: TODO(获取酒店的位置信息,在地图上显示)
	 * @param: @param hotel_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/location/{hotel_id}")
	public String location(@PathVariable("hotel_id") Integer hotel_id, ModelMap modelMap){
		Hotel hotel = hotelService.getHotelById(hotel_id);
		modelMap.addAttribute("location", hotel.getZb());
		return "map";
	}
	/**
	 * 
	 * @Title: getHotelAllList
	 * @Description: TODO(获得所有hotel轮播图片管理)
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/getHotelAllList/pageNum/{pageNum}")
	public String getHotelAllList(@PathVariable("pageNum") String pageNum, HttpServletRequest request, ModelMap modelMap){
		String pic_path = request.getSession().getServletContext().getRealPath("/WEB-INF");
		pic_path+=File.separator+"carousel_pic.xml";
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		hotelService.initAdminHotelPageBean(pageNum_);
		PageBean<Hotel> pageBean = hotelService.getHotelPageBean();
		List<Hotel> list = pageBean.getList();
		
		List<Hotel> listURL = Dom4j.listXML(pic_path);
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("listHotel",list);
		modelMap.addAttribute("listURL", listURL);
		return "admin/list_carousel";
	}
	
	/**
	 * @throws DocumentException 
	 * @throws IOException 
	 * 
	 * @Title: addCarousel
	 * @Description: TODO(添加轮播图片)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/addCarousel/{hotel_id}")
	public void addCarousel(@PathVariable("hotel_id") String hotel_id, HttpServletRequest request, HttpServletResponse response) throws IOException, DocumentException{
		PrintWriter out = response.getWriter();
		String pic_path = request.getSession().getServletContext().getRealPath("/WEB-INF");
		pic_path+=File.separator+"carousel_pic.xml";
		Hotel hotel = hotelService.getBean(Hotel.class, Integer.parseInt(hotel_id));
		String picURL = hotel.getJdzp();
		String hotel_name = hotel.getJdmc();
		//不存在hotel_id的picture则先创建一个
		if(!Dom4j.searchXML(hotel_id, pic_path)){
			Dom4j.createXML(hotel_id, pic_path);
		}
		try {
			Dom4j.addXML(hotel_id, picURL, hotel_name, pic_path);
			out.print("success");
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
			out.print("fail");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
			out.print("fail");
		}
		
		out.flush();
		out.close();
	}
	
	/**
	 * 
	 * @Title: deleteCarousel
	 * @Description: TODO(删除轮播图片)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/deleteCarousel/{hotel_id}")
	public void deleteCarousel(@PathVariable("hotel_id") String hotel_id, HttpServletRequest request, HttpServletResponse response) throws IOException, DocumentException{
		PrintWriter out = response.getWriter();
		String pic_path = request.getSession().getServletContext().getRealPath("/WEB-INF");
		pic_path+=File.separator+"carousel_pic.xml";
		try {
			Dom4j.deleteXML(hotel_id, pic_path);
			out.print("success");
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
			out.print("fail");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
			out.print("fail");
		}
		out.flush();
		out.close();
	}
	
	/**
	 * 
	 * @Title: queryByWhere
	 * @Description: TODO(主页搜索酒店-模糊查询)
	 * @param: @param hotel_name
	 * @param: @return   
	 * @return: List<Hotel>   
	 * @throws
	 */
	@RequestMapping("/searchHotel/{pageNum}")
	public String searchHotel(@PathVariable("pageNum") String pageNum, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		String hotel_name = request.getParameter("hotel_name");
		hotelService.initSearchHotelPageBean(pageNum_,hotel_name);
		PageBean<Hotel> pageBean = hotelService.getSearchHotelPageBean();
		List<Hotel> hotelList = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("hotelList",hotelList);
		return "search_hotel";
	}
	
}
