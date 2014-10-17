/**
 * 
 */
package com.hdc.banquet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;
import com.hdc.entity.BanquetRoom;
import com.hdc.entity.Hotel;
import com.hdc.page.PageBean;
import com.hdc.page.PageDaoImpl;

/**
 * @ClassName: BanquetService
 * @Description:TODO(宴会厅业务类)
 * @author: zml
 * @date: 2014-4-13 上午10:29:34
 *
 */
@Service
@Transactional
public class BanquetService extends BaseService<BanquetRoom>{
	@Autowired
	private PageDaoImpl<BanquetRoom> pageDao;
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initBanquetPageBean(int pageNum, int pageSize, String hotel_id) {
        pageDao.initPageBean(pageNum, pageSize, "com.hdc.entity.BanquetRoom",new String[]{"hotel"}, new String[]{hotel_id});
    }
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initRangeHotelPageBean(int pageNum, String type, String num){
    	int begin = 0;
    	int end = 0;
		if("zs".equals(type)){
	    	begin = Integer.parseInt(num)-10;
	    	if(new Integer(num) >= 40){
	    		end = 100;
	    	}else{
	    		end = Integer.parseInt(num);
	    	}
			pageDao.initPageBean(pageNum, 10, "com.hdc.entity.BanquetRoom",new String[]{"zs"}, new String[]{String.valueOf(begin), String.valueOf(end)});
		}else{
			if(new Integer(num) == 10){
				begin = 0;
				end = Integer.parseInt(num);
			}else if(new Integer(num) == 25){
				begin = Integer.parseInt(num);
				end = 100;
			}else{
				begin = Integer.parseInt(num) - 5;
				end = Integer.parseInt(num);
			}
			pageDao.initPageBean(pageNum, 10, "com.hdc.entity.BanquetRoom",new String[]{"mzrs"}, new String[]{String.valueOf(begin), String.valueOf(end)});
		}
		
	}
	public PageBean<BanquetRoom> getBanquetRoomPageBean() {
        return pageDao.getPage();
    }
	
	public void saveBanquetRoom(BanquetRoom banquetRoom){
		save(banquetRoom);
	}
	
	public void updateBanquetRoom(BanquetRoom banquetRoom){
		update(banquetRoom);
	}
	public void updateBanquetPic(String yhtbh, String nuewURL){
		update("com.hdc.entity.BanquetRoom",new String[]{"yhtbh","yhttp"}, new String[]{yhtbh, nuewURL});
	}
	public List<BanquetRoom> getBanquetRoomByHotelId(String hotel_id){
		List<BanquetRoom> list = findByWhere("com.hdc.entity.BanquetRoom",new String[]{"hotel"}, new String[]{hotel_id});
		return list;
	}
	public BanquetRoom getBanquetRoomById(int banquet_id){
		BanquetRoom banquetRoom = (BanquetRoom) getBean(BanquetRoom.class, banquet_id);
		return banquetRoom;
	}
	public void deleteBanquetRoom(BanquetRoom banquetRoom){
		delete(banquetRoom);
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public PageBean<BanquetRoom> getRangeHotelPageBean() {
        return pageDao.getRangePage();
    }
}
