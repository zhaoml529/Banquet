package com.hdc.core;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service 
@Transactional
public class BaseDaoImpl<T>  implements BaseDao<T>{
	@Autowired
	private SessionFactory sessionFactory;
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	/**
	 * query
	 */
	public List<T> createQuery(final String queryString) {
		Session session=sessionFactory.getCurrentSession();
		List<T> list=session.createQuery(queryString).list();
		return list;
	}
	
	/**
	 *分页信息 
	 */
	public List<T> queryByPage(String hql, int startIndex, int PageSize){
		Session session=sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setFirstResult(startIndex);
		query.setMaxResults(PageSize);
		return query.list();
		
	}
	 /**
     * 模糊查询  
     */
    public List<T> queryByWhere(String tableSimpleName,String[] columns, String[] query, int startIndex, int PageSize){
    	Session session=sessionFactory.getCurrentSession();
    	Criteria criteria = session.createCriteria(tableSimpleName);
    	if(columns.length==query.length){  
            for(int i = 0; i < columns.length; i++){  
            	criteria.add(Restrictions.like(columns[i], "%"+query[i]+"%"));
            }
        }else{
        	return null;
        }
        List<T> list=criteria.setFirstResult(startIndex).setMaxResults(PageSize).list();
        return list;
    }
	
	/**
	 * add
	 */
	public T save(final T model) {
		Session session=sessionFactory.getCurrentSession();
		T o=(T) session.save(model);
		return o;
	}
	/**
	 * update
	 */
	public void update(final T model) {
		Session session=sessionFactory.getCurrentSession();
		session.update(model);
	}
	/**
	 * delete
	 */
	public void delete(final T model) {
		Session session=sessionFactory.getCurrentSession();
		session.delete(model);
	}
	public T getBean(Class<?> obj, String id) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession();
		return (T) session.get(obj, id);
	}
	public T getBean(Class<?> obj, int id) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession();
		return (T) session.get(obj, id);
	}
	/* (non-Javadoc)
	 * @see com.hdc.core.BaseDao#update(java.lang.String)
	 */
	public void createHql(String queryString) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.getCurrentSession();
		Query q = session.createQuery(queryString);
		q.executeUpdate();
	}
}
