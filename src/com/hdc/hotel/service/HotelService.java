/**
 * 
 */
package com.hdc.hotel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;
import com.hdc.entity.BanquetRoom;
import com.hdc.entity.Hotel;
import com.hdc.page.PageDaoImpl;
import com.hdc.page.PageBean;


/**
 * @ClassName: HotelService
 * @Description:TODO(酒店业务类)
 * @author: zml
 * @date: 2014-4-12 下午6:39:53
 *
 */
@Service
@Transactional
public class HotelService extends BaseService<Hotel>{
	@Autowired
	private PageDaoImpl<Hotel> pageDao;
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initHotelPageBean(int pageNum, String xzq) {
		pageDao.initPageBean(pageNum, 8, "com.hdc.entity.Hotel",new String[]{"xzq"}, new String[]{xzq});
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initAdminHotelPageBean(int pageNum) {
		pageDao.initPageBean(pageNum, 10, "com.hdc.entity.Hotel",new String[]{}, new String[]{});
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initSearchHotelPageBean(int pageNum, String jdmc){
		pageDao.initPageBean(pageNum, 10, "com.hdc.entity.Hotel",new String[]{"jdmc"}, new String[]{jdmc});
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public PageBean<Hotel> getHotelPageBean() {
        return pageDao.getPage();
    }
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public List<Hotel> getHotelAllList(){
		List<Hotel> list = getAllList("com.hdc.entity.Hotel");
		return list;
	}
	public void saveHotel(Hotel hotel){
		save(hotel);
	}
	public Hotel getHotelById(int jdbh){
		Hotel hotel = (Hotel)getBean(Hotel.class, jdbh);
		return hotel;
    }
	public Hotel getHotelById(String jdbh){
		Hotel hotel = (Hotel)getBean(Hotel.class, jdbh);
		return hotel;
    }
	public void deleteHotel(Hotel hotel){
		delete(hotel);
	}
	public void updateHotel(Hotel hotel){
		update(hotel);
	}
	public void updateHotel(String jdbh, String nuewURL){
		update("com.hdc.entity.Hotel",new String[]{"jdbh","jdzp"}, new String[]{jdbh, nuewURL});
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public List<Hotel> getHotelList(){
		List<Hotel> list = getAllList("com.hdc.entity.Hotel");
		return list;
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public PageBean<Hotel> getSearchHotelPageBean() {
        return pageDao.getDimPage();
    }
	
}
