package com.hdc.user.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hdc.core.BaseService;
import com.hdc.entity.News;
import com.hdc.entity.Users;
import com.hdc.util.BeanUtils;



@Service
@Transactional
public class LoginService extends BaseService<Users>{
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public List<Users> getUserById(String userid){
		List<Users> list = findByWhere("com.hdc.entity.Users", new String[]{"yhm"}, new String[] {userid});
		if(BeanUtils.isBlank(list)){
			return null;
		}else{
			return list;
		}
	}
	
	public List<News> getNews() {
		// TODO Auto-generated method stub
		    
		return null;
	}

//	public List<ResearchInstitutionPeople> getAllList(){
//	List<ResearchInstitutionPeople> list = getAllList("nebula.common.entity.ry.ResearchInstitutionPeople");
//	return list;
//}
}
