package com.hdc.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;


import com.hdc.entity.Order;
import com.hdc.page.PageBean;
import com.hdc.page.PageDaoImpl;
/**
 * 
 * @ClassName: OrderService
 * @Description:TODO(宴会厅预定业务类)
 * @author: mzj
 * @date: 2014-4-13 下午05:58:13
 *
 */

@Service
@Transactional
public class OrderService extends BaseService<Order>{
	@Autowired
	private PageDaoImpl<Order> pageDao;
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initOrderPageBean(int pageNum, int pageSize) {
		pageDao.initPageBean(pageNum, pageSize, "com.hdc.entity.Order",new String[]{}, new String[]{});		
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public PageBean<Order> getOrderPageBean() {
        return pageDao.getPage();
    }
	public void seveOrder(Order order){
		save(order);
	}
	public Order getOrderById(int bh){
		Order order = (Order)getBean(Order.class, bh);
		return order;
    }
	public Order getOrderById(String bh){
		Order order = (Order)getBean(Order.class, bh);
		return order;
    }
	public void deleteOrder(Order order){
		delete(order);
	}
	public void updateOrder(Order order){
		update(order);
	}
	public List<Order> getOrderDateRange(String hotel_id, String start, String end){
		List<Order> list = getDateRange("com.hdc.entity.Order",new String[]{"jdbh", "kssj"},new String[]{hotel_id, start, end});
		return list;
	}
}
