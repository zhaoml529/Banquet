package com.hdc.core;

import java.util.List;
/**
 * 对数据库操作的增删改查操做
 * @author song009
 *
 */
public interface BaseDao<T> {
	public List<T> createQuery(final String queryString);
	public T save(final T model);
	public T getBean(final Class<?> obj,final String id);
	public T getBean(final Class<?> obj,final int id);
	public void update(final T model);
	public void createHql(final String queryString);
	public void delete(final T model);
	public List<T> queryByPage(String hql, int startIndex, int PageSize);
	public List<T> queryByWhere(final String tableSimpleName,final String[] columns,final String[] query, int startIndex, int PageSize);
}
