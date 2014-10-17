package com.hdc.core;

import java.util.List;  

import com.hdc.core.BaseDao;
import com.hdc.util.StringUtils;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;  
  
  
@Service  
@Transactional
public class BaseService<T> {  
    @Autowired  
    private BaseDao<T> entityDao;  
    
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true) 
    public List<T> getAllList(String tableSimpleName){  
        StringBuffer sff = new StringBuffer();  
        sff.append("select a from ").append(tableSimpleName).append(" a ");  
        List<T> list = entityDao.createQuery(sff.toString());  
        return list;  
    }  
    /** 
     * find the list of entity by where conditions  
     * @param tableSimpleName 
     * @param columns 
     * @param values 
     * @return  list 
     */  
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public List<T> findByWhere(String tableSimpleName,String[] columns,String[] values){  
        StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where ");  
        if(columns.length==values.length){  
            for(int i = 0; i < columns.length; i++){
            	if(columns[i] != null && columns[i] != ""){
            		sb.append("a.").append(columns[i]).append("='").append(values[i]).append("'");  
            		if(i < columns.length-1){  
                        sb.append(" and ");  
                    }
            	}
            }
            String sub = sb.toString();
            if(sub.lastIndexOf("and ")!=-1 && sub.lastIndexOf("and ") == sub.length()-4){
            	sub = sub.substring(0, sub.length()-5);
            }
           List<T> list = entityDao.createQuery(sub);  
            return list.size()>0?list:null;  
        }else{  
            return null;  
        }  
    }
    /**
     * 分页信息
     */
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public List<T> queryByPage(String tableSimpleName, String[] columns, String[] values, int startIndex, int PageSize){
    	 StringBuffer sb = new StringBuffer();  
    	 boolean flag = false;
    	 if(columns.length <= 0 && values.length <= 0){
    		 sb.append("select a from ").append(tableSimpleName).append(" a");
    	 }else{
    		 sb.append("select a from ").append(tableSimpleName).append( " a where 1=1 and ");
    	 }
         if(columns.length==values.length){  
             for(int i = 0; i < columns.length; i++){  
            	 if(!StringUtils.isBlank(values[i])){
            		 if(columns[i].equals("question_body")){
            			flag = true;
                 		sb.append("a.").append(columns[i]).append(" like '%").append(values[i]).append("%'");  
                 		if(i < columns.length-1){  
                             sb.append(" and ");  
                 		}
                 	}
             		else{
	                 sb.append("a.").append(columns[i]).append("='").append(values[i]).append("'");  
	                 if(i < columns.length-1){  
	                     sb.append(" and ");  
	                 } 
             		}
            	 }
             }
             String sub = sb.toString();
             if(flag){
            	 sub = sub.substring(0, sub.length()-5);
             }
             if(sub.lastIndexOf("and ")!=-1 && sub.lastIndexOf("and ") == sub.length()-4){
             	sub = sub.substring(0, sub.length()-5);
             }
             List<T> list = entityDao.queryByPage(sub, startIndex, PageSize);  
             return list.size()>0?list:null;  
         }else{  
             return null;  
         }
    }
    /**
     * 统计数量
     */
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public List<T> getCount(String tableSimpleName){
    	String hql = "select count(*) from " + tableSimpleName;
    	List<T> list = entityDao.createQuery(hql);
    	return list;
    }
    
    /**
     * 模糊查询
     */
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public List<T> queryByWhere(String tableSimpleName,String[] columns, String[] query, int startIndex, int PageSize){
        List<T> list=entityDao.queryByWhere(tableSimpleName, columns, query, startIndex, PageSize);
        return list;
    }
    
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public List<T> findByDim(String tableSimpleName,String[] columns,String[] values, int startIndex, int PageSize){  
        StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where 1=1 and ");  
        if(columns.length==values.length){  
            for(int i = 0; i < columns.length; i++){
            	if(!StringUtils.isBlank(values[i])){
                		sb.append("a.").append(columns[i]).append(" like '%").append(values[i]).append("%'");  
                		if(i < columns.length-1){  
                            sb.append(" and ");  
                		}
                	}
            	}
            String sub = sb.toString();
            if(sub.lastIndexOf("and ")!=-1 && sub.lastIndexOf("and ") == sub.length()-4){
            	sub = sub.substring(0, sub.length()-5);
            }
            List<T> list = entityDao.queryByPage(sub, startIndex, PageSize);  
            return list.size()>0?list:null;  
        }
        else{  
            return null;  
        }  
    }

    
    /** 
     * save 
     * @param obj 
     */  
    @Transactional
    public void save(T obj){  
        entityDao.save(obj);  
    }  
    /** 
     * delete 
     * @param obj 
     */ 
    @Transactional
    public void delete(T obj){  
       entityDao.delete(obj);  
    }  
    /** 
     * update 
     * @param obj 
     */  
    @Transactional
    public void update(T obj){  
        entityDao.update(obj);  
    }
    
    @Transactional
    public void update(String tableSimpleName,String[] columns,String[] values){
    	StringBuffer sb = new StringBuffer();  
        sb.append("update ").append(tableSimpleName).append( " a set ");  
        if(columns.length==values.length){
        	//i=0为where条件
            for(int i = 1; i < columns.length; i++){
            	if(columns[i] != null && columns[i] != ""){
            		sb.append("a.").append(columns[i]).append("='").append(values[i]).append("' ");  
            	}
            }
        }
        sb.append("where a."+columns[0]+"='"+values[0]+"'");
        String sub = sb.toString();
        entityDao.createHql(sub); 
    }
    /**
     * @return 
     * 
     * @Title: getDateRange
     * @Description: TODO(得到酒店预定日期范围数据 between and)
     * @param:    
     * @return: void   
     * @throws
     */
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public List<T> getDateRange(String tableSimpleName, String[] column, String[] values){
    	StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where a.").append(column[0]); 
        sb.append("='").append(values[0]).append("'").append(" and a.").append(column[1]); 
        sb.append(" BETWEEN '").append(values[1]).append("' and '").append(values[2]).append("'");
        String sub = sb.toString();
        List<T> list = entityDao.createQuery(sub);
        return list.size()>0?list:null;   
    }
    
    /**
     * @return 
     * 
     * @Title: getDateRange
     * @Description: TODO(得到酒店桌数、人数数据 between and)
     * @param:    
     * @return: void   
     * @throws
     */
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public List<T> getBanquetRange(String tableSimpleName, String[] column, String[] values, int startIndex, int PageSize){
    	StringBuffer sb = new StringBuffer();  
        sb.append("select a from ").append(tableSimpleName).append( " a where a.").append(column[0]); 
        sb.append(" BETWEEN '").append(values[0]).append("' and '").append(values[1]).append("'");
        String sub = sb.toString();
        List<T> list = entityDao.queryByPage(sub, startIndex, PageSize);
        return list.size()>0?list:null;   
    }
    /** 
     * getBean
     * @param obj 
     */  
    //通过id 反射获取相应的类
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public T getBean(Class<T> obj, String id){  
       return entityDao.getBean(obj,id);
    }  
    @Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
    public T getBean(Class<T> obj, int id){  
        return entityDao.getBean(obj,id);
     } 
    
}  