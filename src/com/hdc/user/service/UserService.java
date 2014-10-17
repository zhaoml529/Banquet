package com.hdc.user.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;
import com.hdc.entity.Users;
import com.hdc.page.PageBean;
import com.hdc.page.PageDaoImpl;
/**
 * 
 * @ClassName: UserService
 * @Description:TODO(用户业务类)
 * @author: mzj
 * @date: 2014-4-19 下午10:53:22
 *
 */
@Service
@Transactional
public class UserService extends BaseService<Users>{
	@Autowired
	private PageDaoImpl<Users> pageDao;
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public void initManagerPageBean(int pageNum) {
		pageDao.initPageBean(pageNum, 10, "com.hdc.entity.Users",new String[]{}, new String[]{});
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public PageBean<Users> getManagerPageBean() {
        return pageDao.getPage();
    }
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public List<Users> getUsersByHotel(String hotel_id){
		List<Users> list = findByWhere("com.hdc.entity.Users",new String[]{"hotel","jx"}, new String[]{hotel_id,"2"});
		return list;
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public List<Users> getUsersByRole(){
		List<Users> list = findByWhere("com.hdc.entity.Users",new String[]{"jx"}, new String[]{"1"});
		return list;
	}
	
	public void saveManager(Users users){
		save(users);
	}
	public Users getManagerById(int manager_id){
		Users users = (Users)getBean(Users.class,manager_id);
		return users;
	}
	public Users getAdminById(int user_id){
		Users users = (Users)getBean(Users.class,user_id);
		return users;
	}
	public void deleteManager(Users users){
		delete(users);
	}
	public void updateManager(Users users){
		update(users);
	}
	
}
