package com.hdc.order.action;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hdc.banquet.service.BanquetService;
import com.hdc.entity.BanquetRoom;
import com.hdc.entity.Hotel;
import com.hdc.entity.Order;
import com.hdc.hotel.service.HotelService;
import com.hdc.order.service.OrderService;
import com.hdc.page.PageBean;
import com.hdc.util.DateUtil;
import com.hdc.util.StringUtils;
/**
 * 
 * @ClassName: OrderAction
 * @Description:TODO(宴会厅预定控制类)
 * @author: mzj
 * @date: 2014-4-13 下午05:59:02
 *
 */
@Controller
@RequestMapping("/orderAction")
public class OrderAction {
	protected final transient Log log = LogFactory.getLog(OrderAction.class);
	@Autowired
	private OrderService orderService;
	@Autowired
	private HotelService order_hotelService;
	@Autowired
	private BanquetService order_banquetService;
	
	/**
	 * 
	 * @Title: listOrder
	 * @Description: TODO(用户查看宴会厅的预订信息及时间)
	 * @param: @param pageNum
	 * @param: @param request
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/listOrder/pageNum/{pageNum}")
	public String listOrder(@PathVariable("pageNum") String pageNum, HttpServletRequest request,ModelMap modelMap){
		if(StringUtils.isBlank(pageNum)){
			pageNum = "1";
		}
		int pageNum_ = Integer.parseInt(pageNum); 
		orderService.initOrderPageBean(pageNum_,8);
		PageBean<Order> pageBean = orderService.getOrderPageBean();
		List<Order> list = pageBean.getList();
		modelMap.addAttribute("pageBean",pageBean);
		modelMap.addAttribute("Orders",list);
		return "/order/list_order";
	}
	/**
	 * 
	 * @Title: addOrder
	 * @Description: TODO(经理添加宴会厅的预订信息和时间)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/addOrder")
	public String addOrder(){
		return "/order/add_order";
	}
	@RequestMapping("/saveOrder")
	public ModelAndView saveOrder(@ModelAttribute("Order") Order order){
		orderService.seveOrder((com.hdc.entity.Order) order);
		return new ModelAndView("redirect:/orderAction/listOrder/pageNum/1");
	}
	/**
	 * 
	 * @Title: deleteHotel
	 * @Description: TODO(经理删除宴会厅的预订信息)
	 * @param: @param time_id
	 * @param: @return   
	 * @return: ModelAndView   
	 * @throws
	 */
	@RequestMapping("/deleteOrder/{time_id}")
	public ModelAndView deleteHotel(@PathVariable("time_id") int time_id){
		Order order =orderService.getOrderById(time_id);
		orderService.deleteOrder(order);
		return new ModelAndView("redirect:/orderAction/listOrder/pageNum/1");
	}
	/**
	 * 
	 * @Title: updateOrderById
	 * @Description: TODO(经理跳转到更新预定页面)
	 * @param: @param time_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/updateOrderById/{time_id}")
	public String updateOrderById(@PathVariable("time_id") int time_id,ModelMap modelMap){
		Order order = orderService.getOrderById(time_id);
		modelMap.addAttribute("order", order);
		return "/order/update_order";
	}
	/**
	 * 
	 * @Title: updateOrderById
	 * @Description: TODO(经理更改宴会厅的预订信息)
	 * @param: @param time_id
	 * @param: @param modelMap
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/updateOrder")
	public ModelAndView updateHotel(@ModelAttribute("order")Order order){
		orderService.updateOrder(order);
		return new ModelAndView("redirect:/orderAction/listOrder/pageNum/1");
	}

	/**
	 * 
	 * @Title: toListOrder
	 * @Description: TODO(跳转到fullcalendar页面)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/toListOrder")
	public String toListOrder(HttpServletRequest request, ModelMap modelMap){
		String hotel_id = (String)request.getSession().getAttribute("hotel_id");
		List<BanquetRoom> banquetList = order_banquetService.getBanquetRoomByHotelId(hotel_id);
		modelMap.addAttribute("banquetList", banquetList);
		modelMap.addAttribute("hotel_id", hotel_id);
		return "manager/fullcalendar-dragging";
	}
	/**
	 * 
	 * @Title: listOrder
	 * @Description: TODO(获取酒店订单日程)
	 * @param: @param request   
	 * @return: void   
	 * @throws
	 */
	@RequestMapping("/listOrder")
	public @ResponseBody List<Order> listOrder(HttpServletRequest request){
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String viewName = request.getParameter("viewName");
		String hotel_id = request.getParameter("hotel_id");
		List<Order> orderList = orderService.getOrderDateRange(hotel_id, start, end);
		return orderList;
	}
	/**
	 * @throws IOException 
	 * 
	 * @Title: saveOrder
	 * @Description: TODO(保存fullcalendar的order信息)
	 * @param: @param request   
	 * @return: void   
	 * @throws
	 */
	@RequestMapping("/saveOrders")
	public @ResponseBody Order saveOrders(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String title = request.getParameter("title"); 
		String banquet_name = request.getParameter("banquet_name");
		//String banquet = request.getParameter("banquet");
		short allDay = 0; //1.全天
		String tel = request.getParameter("lxfs");
		String remark = request.getParameter("bz");
		String hotel_id = (String)request.getSession().getAttribute("hotel_id");
		Date startDate = DateUtil.StringToDate(start, "yyyy-MM-dd HH:mm");
		Date endDate = DateUtil.StringToDate(end, "yyyy-MM-dd HH:mm");
		if(DateUtil.diffDate(endDate, startDate) >= 24){ //大于1天
			allDay = 1;
		}
		Hotel hotel = order_hotelService.getHotelById(Integer.parseInt(hotel_id));
		String hotel_name = hotel.getJdmc();
		Order order = new Order();
		order.setJdbh(Integer.parseInt(hotel_id));
		order.setZt(title);
		order.setJdmc(hotel_name);
		order.setYhtmz(banquet_name);
		order.setKssj(start);
		order.setJssj(end);
		order.setQt(allDay);
		order.setLxfs(tel);
		order.setBz(remark);
		orderService.seveOrder(order);
		return order;
	}
	
	@RequestMapping("/toUpdateOrders")
	public @ResponseBody Order toUpdateOrders(HttpServletRequest request){
		String order_id = request.getParameter("order_id");
		Order order = orderService.getOrderById(Integer.parseInt(order_id));
		return order;
	}
	
	/**
	 * @throws IOException 
	 * 
	 * @Title: ShowOrder
	 * @Description: TODO(更新fullcalendar的order信息)
	 * @param: @return   
	 * @return: String   
	 * @throws
	 */
	@RequestMapping("/updateOrders")
	public void updateOrders(HttpServletRequest request, HttpServletResponse response) throws IOException{
		PrintWriter out = response.getWriter();
		//String banquet_name = request.getParameter("banquet_name");
		String order_id = request.getParameter("order_id");
		String banquet_name = request.getParameter("banquet_name");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		short allDay = 0;	//1.全天
		String title = request.getParameter("title");
		String tel = request.getParameter("lxfs");
		String remark = request.getParameter("bz");
		Date startDate = DateUtil.StringToDate(start, "yyyy-MM-dd HH:mm");
		Date endDate = DateUtil.StringToDate(end, "yyyy-MM-dd HH:mm");
		if(DateUtil.diffDate(endDate, startDate) >= 24){ //大于1天
			allDay = 1;
		}
		String hotel_id = (String)request.getSession().getAttribute("hotel_id");
		Hotel hotel = order_hotelService.getHotelById(Integer.parseInt(hotel_id));
		String hotel_name = hotel.getJdmc();
		Order order = new Order();
		order.setJdbh(Integer.parseInt(hotel_id));
		order.setBh(Integer.parseInt(order_id));
		order.setJdmc(hotel_name);
		order.setYhtmz(banquet_name);
		order.setKssj(start);
		order.setJssj(end);
		order.setLxfs(tel);
		order.setZt(title);
		order.setQt(allDay);//具体全天否要判断
		order.setBz(remark);
		orderService.updateOrder(order);
		//return new ModelAndView("redirect:loginAction/fullCalendar1");
		out.print("true");
		out.flush();
		out.close();
	}
	/**
	 * 
	 * @Title: dropUpdateOrders
	 * @Description: TODO(eventDrop和eventResize更新拖动后的日程信息)
	 * @param: @param request
	 * @param: @param response
	 * @param: @throws IOException   
	 * @return: void   
	 * @throws
	 */
	@RequestMapping("/dropUpdateOrders")
	public void dropUpdateOrders(HttpServletRequest request, HttpServletResponse response) throws IOException{
		PrintWriter out = response.getWriter();
		String order_id = request.getParameter("order_id");
		String allDay = request.getParameter("qt");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		Order order = orderService.getOrderById(Integer.parseInt(order_id));
		System.out.println(allDay+" !!!!!!!!!!!!");
		short qt = 0; //1 全天
		if("true".equals(allDay)){
			//此判断为：直接拖拽到全天栏目上面
			qt = 1;
		}
		Date startDate = DateUtil.StringToDate(start, "yyyy-MM-dd HH:mm");
		Date endDate = DateUtil.StringToDate(end, "yyyy-MM-dd HH:mm");
		if(DateUtil.diffDate(endDate, startDate) >= 24){ //大于1天
			//此判断为：拖拽时间大于或等于1天的时候
			qt = 1;
		}
		order.setKssj(start);
		order.setJssj(end);
		order.setQt(qt);
		orderService.updateOrder(order);
		out.print("true");
		out.flush();
		out.close();
	}
	
	
	
	
	/**
	 * @throws IOException 
	 * 
	 * @Title: deleteOrders
	 * @Description: TODO(删除fullcalendar的order信息)
	 * @param: @param request   
	 * @return: void   
	 * @throws
	 */
	@RequestMapping("/deletOrders")
	public void deleteOrders(HttpServletRequest request, HttpServletResponse response) throws IOException{
		PrintWriter out = response.getWriter();
		String order_id = request.getParameter("order_id");
		Order order = orderService.getOrderById(Integer.parseInt(order_id));
		orderService.deleteOrder(order);
		out.print("true");
		out.flush();
		out.close();
	}
}
