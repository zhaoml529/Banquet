/**
 * 
 */
package com.hdc.banquet.action;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hdc.banquet.service.BanquetService;
import com.hdc.entity.BanquetRoom;
import com.hdc.hotel.service.HotelService;
import com.hdc.page.PageBean;
import com.hdc.util.StringUtils;
import com.hdc.util.UploadPicture;
import com.hdc.entity.Hotel;


/**
 * @ClassName: BanquetAction
 * @Description:TODO(宴会厅控制类)
 * @author: zml
 * @date: 2014-4-13 上午10:28:13
 *
 */
@Controller
@RequestMapping("/banquetAction")
public class BanquetAction {
	protected final transient Log log = LogFactory.getLog(BanquetAction.class);
	private static final String BANQUET = "banquet";
	@Autowired
	private BanquetService banquetService;
	@Autowired
	private HotelService banquet_hotelService;
	
	/**
	 * 
	 * @Title: listBanquet
	 * @Description: TODO(管理员查看宴会厅列表)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listAdminBanquet/pageNum/{pageNum}")
	public String listAdminBanquet(@PathVariable("pageNum") String pageNum, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		String hotel_id = request.getParameter("hotel_id");
		if(StringUtils.isBlank(hotel_id)) hotel_id = "0";
		banquetService.initBanquetPageBean(pageNum_,8,hotel_id);
		PageBean<BanquetRoom> pageBean = banquetService.getBanquetRoomPageBean();
		List<BanquetRoom> banquetList = pageBean.getList();
		List<Hotel> hotelList = banquet_hotelService.getHotelList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("banquetList",banquetList);
		modelMap.addAttribute("hotelList",hotelList);
		return "admin/list_banquet";
		
	}
	/**
	 * 
	 * @Title: listBanquet
	 * @Description: TODO(普通用户查看宴会厅列表)
	 * @param: @param pageNum
	 * @param: @param hotel_id
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listBanquet/pageNum/{pageNum}/{hotel_id}")
	public String listBanquet(@PathVariable("pageNum") String pageNum, @PathVariable("hotel_id") String hotel_id, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		banquetService.initBanquetPageBean(pageNum_,4,hotel_id);
		PageBean<BanquetRoom> pageBean = banquetService.getBanquetRoomPageBean();
		List<BanquetRoom> banquetList = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("banquetList",banquetList);
		modelMap.addAttribute("hotel_id", hotel_id);
		return "list_banquet";
		
	}
	
	/**
	 * 
	 * @Title: listAdminBanquet
	 * @Description: TODO(经理查看宴会厅列表)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listBanquet/pageNum/{pageNum}")
	public String listBanquet(@PathVariable("pageNum") String pageNum, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		HttpSession session = request.getSession();
		String hotel_id = (String) session.getAttribute("hotel_id");
		banquetService.initBanquetPageBean(pageNum_,8,hotel_id);
		PageBean<BanquetRoom> pageBean = banquetService.getBanquetRoomPageBean();
		List<BanquetRoom> banquetList = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("banquetList",banquetList);
		return "manager/list_banquet";
		
	}
	/**
	 * 
	 * @Title: addBanquetRoom
	 * @Description: TODO(管理员跳转到添加宴会厅页面)
	 * @param: @param request
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminaddBanquetRoom")
	public String adminaddBanquetRoom(ModelMap modelMap){
		List<Hotel> hotelList = banquet_hotelService.getHotelList();
		modelMap.addAttribute("hotelList",hotelList);
		return "admin/add_banquet";
	}
	/**
	 * @throws IOException 
	 * @throws IllegalStateException 
	 * 
	 * @Title: saveBanquetRoom
	 * @Description: TODO(管理员添加宴会厅信息)
	 * @param: @param banquetRoom
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminsaveBanquetRoom")
	public ModelAndView adminsaveBanquetRoom(@ModelAttribute("banquetRoom") BanquetRoom banquetRoom, @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IllegalStateException, IOException{
		UploadPicture uploadPicture =new UploadPicture();
		String newURL = uploadPicture.uploadPic(file, BANQUET, request, response);
		banquetRoom.setYhttp(newURL);
		banquetService.saveBanquetRoom(banquetRoom);
		int hotel_id = banquetRoom.getHotel().getJdbh();
		modelMap.addAttribute("hotel_id", hotel_id);
		return new ModelAndView("redirect:/banquetAction/listAdminBanquet/pageNum/1",modelMap);
	}
	/**
	 * 
	 * @Title: addBanquetRoom
	 * @Description: TODO(经理跳转到添加宴会厅页面)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/addBanquetRoom")
	public String addBanquetRoom(){
		return "manager/add_banquet";
	}
	/**
	 * @throws IOException 
	 * @throws IllegalStateException 
	 * 
	 * @Title: saveBanquetRoom
	 * @Description: TODO(经理添加宴会厅信息)
	 * @param: @param banquetRoom
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("saveBanquetRoom")
	public ModelAndView saveBanquetRoom(@ModelAttribute("banquetRoom") BanquetRoom banquetRoom , @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		UploadPicture uploadPicture =new UploadPicture();
		String newURL = uploadPicture.uploadPic(file, BANQUET, request, response);
		banquetRoom.setYhttp(newURL);
		banquetService.saveBanquetRoom(banquetRoom);
		int hotel_id = banquetRoom.getHotel().getJdbh();
        return new ModelAndView("redirect:/banquetAction/listBanquet/pageNum/1","hotel_id",hotel_id);	
	}
	/**
	 * 
	 * @Title: updateBanquetRoomById
	 * @Description: TODO(管理员跳转到更新宴会厅页面)
	 * @param: @param banquet_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/adminUpdateBanquetById/{banquet_id}")
	public String adminUpdateBanquetById(@PathVariable("banquet_id") int banquet_id, ModelMap modelMap){
		BanquetRoom banquetRoom = banquetService.getBanquetRoomById(banquet_id);
		modelMap.addAttribute("banquetRoom",banquetRoom);
		return "admin/update_banquet";
	}
	
	/**
	 * 
	 * @Title: updateBanquetRoom
	 * @Description: TODO(管理员更新宴会厅信息)
	 * @param: @param banquetRoom
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminUpdateBanquetRoom")
	public ModelAndView adminUpdateBanquetRoom(@ModelAttribute("banquetRoom") BanquetRoom banquetRoom){
		banquetService.updateBanquetRoom(banquetRoom);
		int hotel_id = banquetRoom.getHotel().getJdbh();
        return new ModelAndView("redirect:/banquetAction/listAdminBanquet/pageNum/1","hotel_id",hotel_id);	
	}	
    
	/**
	 * 
	 * @Title: updateBanquetRoomById
	 * @Description: TODO(经理跳转到更新宴会厅页面)
	 * @param: @param banquet_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/updateBanquetById/{banquet_id}")
	
		public String updateBanquetById(@PathVariable("banquet_id") int banquet_id, ModelMap modelMap){
		BanquetRoom banquetRoom = banquetService.getBanquetRoomById(banquet_id);
		modelMap.addAttribute("banquetRoom",banquetRoom);
			return "manager/update_banquet";
		}
	
	/**
	 * 
	 * @Title: updateBanquetRoom
	 * @Description: TODO(经理更新宴会厅信息)
	 * @param: @param banquetRoom
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/updateBanquetRoom")
	public ModelAndView updateBanquetRoom(@ModelAttribute("banquetRoom") BanquetRoom banquetRoom){
		banquetService.updateBanquetRoom(banquetRoom);
		int hotel_id = banquetRoom.getHotel().getJdbh();
        return new ModelAndView("redirect:/banquetAction/listAdminBanquet/pageNum/1","hotel_id",hotel_id);	
	}	
	/**
	 * 
	 * @Title: deleteBanquetRoomById
	 * @Description: TODO(管理员删除宴会厅)
	 * @param: @param banquet_id
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/adminDeleteBanquetRoom/{banquet_id}")
	public ModelAndView adminDeleteBanquetRoomById(@PathVariable("banquet_id") int banquet_id){
		BanquetRoom banquetRoom = banquetService.getBanquetRoomById(banquet_id);
		banquetService.deleteBanquetRoom(banquetRoom);
		int hotel_id = banquetRoom.getHotel().getJdbh();
        return new ModelAndView("redirect:/banquetAction/listAdminBanquet/pageNum/1","hotel_id",hotel_id);	
	}
	/**
	 * 
	 * @Title: deleteBanquetRoomById
	 * @Description: TODO(经理删除宴会厅)
	 * @param: @param banquet_id
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/deleteBanquetRoom/{banquet_id}")
	public ModelAndView deleteBanquetRoomById(@PathVariable("banquet_id") int banquet_id){
		BanquetRoom banquetRoom = banquetService.getBanquetRoomById(banquet_id);
		banquetService.deleteBanquetRoom(banquetRoom);
		int hotel_id = banquetRoom.getHotel().getJdbh();
        return new ModelAndView("redirect:/banquetAction/listBanquet/pageNum/1","hotel_id",hotel_id);	
	}

	/**
	 * 
	 * @Title: showBanquet
	 * @Description: TODO(经理和管理员查看宴会厅信息)
	 * @param: @param banquet_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/showBanquetRoom/{banquet_id}")
	public String showBanquet(@PathVariable("banquet_id") int banquet_id,ModelMap modelMap){
		BanquetRoom banquetRoom = banquetService.getBanquetRoomById(banquet_id);
		modelMap.addAttribute("banquetRoom", banquetRoom);
		return "manager/show_banquet";
		
	}
	/**
	 * 
	 * @Description: TODO(管理员和经理修改宴会厅图片)
	 * @param yhtbh
	 * @param file
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/uploadBanquetPic/{yhtbh}")
	public ModelAndView uploadBanquetPic(@PathVariable("yhtbh") String yhtbh, @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IllegalStateException, IOException{
		UploadPicture uploadPicture =new UploadPicture();
		String newURL = uploadPicture.uploadPic(file,BANQUET, request, response);
		String role = (String) request.getSession().getAttribute("role");
		banquetService.updateBanquetPic(yhtbh, newURL);
		if(Integer.parseInt(role) == 1){
			return new ModelAndView("redirect:/banquetAction/adminUpdateBanquetById/"+yhtbh);
		}else{
			return new ModelAndView("redirect:/banquetAction/updateBanquetById/"+yhtbh);
		}
	}	
	
	/**
	 * 
	 * @Title: toListOrder
	 * @Description: TODO(用户跳转到fullcalendar页面查看预定信息)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/toListOrder/{hotel_id}")
	public String toListOrder(@PathVariable("hotel_id") String hotel_id, HttpServletRequest request, ModelMap modelMap){
		List<BanquetRoom> banquetList = banquetService.getBanquetRoomByHotelId(hotel_id);
		modelMap.addAttribute("banquetList", banquetList);
		modelMap.addAttribute("hotel_id", hotel_id);
		return "fullcalendar-dragging";
	}
	
	@RequestMapping("/searchBanquet/{pageNum}/{type}/{zs}")
	public String searchBanquet(@PathVariable("pageNum") String pageNum,
								@PathVariable("type") String type, 
								@PathVariable("zs") String zs, HttpServletRequest request, ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		if("1".equals(type)){
			//桌数
			banquetService.initRangeHotelPageBean(pageNum_,"zs" , zs);
			PageBean<BanquetRoom> pageBean = banquetService.getRangeHotelPageBean();
			List<BanquetRoom> banquetList = pageBean.getList();
			modelMap.addAttribute("pageBean",pageBean);
			modelMap.addAttribute("banquetList",banquetList);
			modelMap.addAttribute("type", type);
			modelMap.addAttribute("zs", zs);
		}else{
			//每桌人数
			banquetService.initRangeHotelPageBean(pageNum_,"mzrs" , zs);
			PageBean<BanquetRoom> pageBean = banquetService.getRangeHotelPageBean();
			List<BanquetRoom> banquetList = pageBean.getList();
			modelMap.addAttribute("pageBean",pageBean);
			modelMap.addAttribute("banquetList",banquetList);
			modelMap.addAttribute("type", type);
			modelMap.addAttribute("zs", zs);
		}
		return "search_banquet";
	}
}
