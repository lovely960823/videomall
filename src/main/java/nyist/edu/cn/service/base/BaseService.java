package nyist.edu.cn.service.base;

import java.util.List;

import nyist.edu.cn.vo.ResultPage;
/**
 * <p>desc: 通用service接口（新建service接口继承该接口即可）</p>
 * <p>类名：BaseService </p>
 * <p>创建时间：2018-9-7 上午11:36:06 </p>
 * <p>@author：mmy</p>
 * @param <T>
 */
public interface BaseService<T> {
	/**
	 * <p>功能描述：保存</p>
	 * <p>方法名：save</p>
	 * <p>@param entity
	 * <p>@return</p>
	 * <p>创建日期：2018-9-7 上午11:00:39</p>  
	 * <p>@author：mmy</p>
	 */
	int save(T record);
	/**
	 * <p>功能描述：根据主键删除（实体类必须要有“@Id”注解）</p>
	 * <p>方法名：deleteByPrimaryKey</p>
	 * <p>@param key
	 * <p>@return</p>
	 * <p>创建日期：2018-9-7 上午11:02:23</p>  
	 * <p>@author：mmy</p>
	 */
    int deleteByPrimaryKey(Object key);
    /**
     * <p>功能描述：根据实体属性作为条件进行删除，查询条件使用等号</p>
     * <p>方法名：delete</p>
     * <p>@param record
     * <p>@return</p>
     * <p>创建日期：2018-9-7 上午11:05:07</p>  
     * <p>@author：mmy</p>
     */
    int delete(T record);
    /**
     * <p>功能描述：根据“主键”更新实体全部字段，null值会被更新</p>
     * <p>方法名：updateByPrimaryKey</p>
     * <p>@param record
     * <p>@return</p>
     * <p>创建日期：2018-9-7 上午11:06:15</p>  
     * <p>@author：mmy</p>
     */
    int updateByPrimaryKey(T record);
    /**
     * <p>功能描述：根据“主键”更新属性不为null的值</p>
     * <p>方法名：updateByPrimaryKeySelective</p>
     * <p>@param record
     * <p>@return</p>
     * <p>创建日期：2018-9-7 上午11:07:54</p>  
     * <p>@author：mmy</p>
     */
    int updateByPrimaryKeySelective(T record);
    /**
     * <p>功能描述：根据主键字段进行查询（实体类必须要有“@Id”注解）</p>
     * <p>方法名：findById</p>
     * <p>@param key
     * <p>@return</p>
     * <p>创建日期：2018-9-7 上午11:11:47</p>  
     * <p>@author：mmy</p>
     */
    T findById(Object key);
    /**
     * <p>功能描述：分页查询所有数据</p>
     * <p>方法名：findAll</p>
     * <p>@return</p>
     * <p>创建日期：2018-9-7 上午11:13:36</p>  
     * <p>@author：mmy</p>
     */
    ResultPage<T> findAll(ResultPage<T> resultPage);
    /**
     * <p>功能描述：分页查询所有数据(带条件查询，把条件封住在实体类中，使用“等号”查询，排序是按id正序排)</p>
     * <p>方法名：findByParam</p>
     * <p>@return</p>
     * <p>创建日期：2018-9-7 上午11:20:36</p>  
     * <p>@author：mmy</p>
     */
    ResultPage<T> findByParam(ResultPage<T> resultPage,T record);
    /**
     * <p>功能描述：根据 对象查询 使用“等号”进行查询</p>
     * <p>方法名：findByT</p>
     * <p>@param record
     * <p>@return</p>
     * <p>创建日期：2018-9-29 下午4:19:15</p>  
     * <p>@author：mmy</p>
     */
    List<T> findByT(T record);
}
