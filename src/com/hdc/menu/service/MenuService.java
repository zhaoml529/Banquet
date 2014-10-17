package com.hdc.menu.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;
import com.hdc.entity.Menu;
import com.hdc.page.PageDaoImpl;
import com.hdc.page.PageBean;


@Service
@Transactional
public class MenuService extends BaseService <Menu>{
	@Autowired
	private PageDaoImpl<Menu> pageDao;
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initAdminMenuPageBean(int pageNum, int pageSize, String hotel_id) {
        pageDao.initPageBean(pageNum, pageSize, "com.hdc.entity.Menu",new String[]{"hotel"}, new String[]{hotel_id});
    }
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initMenuPageBean(int pageNum, int pageSize, String hotel_id) {
        pageDao.initPageBean(pageNum, pageSize, "com.hdc.entity.Menu",new String[]{"hotel"}, new String[]{hotel_id});
    }
	public PageBean<Menu> getMenuPageBean() {
        return pageDao.getPage();
    }
	public void seveMenu(Menu menu){
		save(menu);
	}
	public Menu getMenuById(int tcbh){
		Menu menu = (Menu)getBean(Menu.class, tcbh);
		return menu;
    }
	public List<Menu> getMenuByHotelId(String id){
		List<Menu> list = findByWhere("com.hdc.entity.Menu", new String[]{"hotel"}, new String[]{id});
		return list;
	}
	public void updateMenu(Menu menu){
		update(menu);
	}
	public void updateMenuPic(String tcbh, String newURL){
		update("com.hdc.entity.Menu",new String[]{"tcbh","zttp"}, new String[]{tcbh, newURL});
	}
	public void deleteMenu(Menu menu){
		delete(menu);
	}


}
