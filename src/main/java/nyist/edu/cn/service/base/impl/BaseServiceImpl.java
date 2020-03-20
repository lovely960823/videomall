package nyist.edu.cn.service.base.impl;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.service.base.BaseService;
import nyist.edu.cn.vo.ResultPage;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.entity.Example;

/**
 * <p>desc: 通用service实现类</p>
 * <p>类名：BaseServiceImpl </p>
 * <p>创建时间：2018-9-7 上午11:36:15 </p>
 * <p>@author：mmy</p>
 * @param <T>
 */
@Transactional   //加入事务注解，解决baseservice方法没有被spring事务控制问题
public class BaseServiceImpl<T> implements BaseService<T> {
	private Class<T> entityClass;
	
	/**
	 * 在构造方法中动态获得操作的实体类型
	 */
	public BaseServiceImpl() {
		// 获得父类（BaseServiceImpl<T>）类型
		ParameterizedType genericSuperclass = (ParameterizedType) this
				.getClass().getGenericSuperclass();
		// 获得父类上的泛型数组
		Type[] actualTypeArguments = genericSuperclass.getActualTypeArguments();
		entityClass = (Class<T>) actualTypeArguments[0];
	}
	
	@Autowired
    private Mapper<T> mapper;
	/**
	 * 保存
	 */
	public int save(T record) {
		return mapper.insertSelective(record);
	}
	/**
	 * 根据主键删除（实体类必须要有“@Id”注解）
	 */
	public int deleteByPrimaryKey(Object key) {
		return mapper.deleteByPrimaryKey(key);
	}
	/**
	 * 根据实体属性作为条件进行删除，查询条件使用等号
	 */
	public int delete(T record) {
		return mapper.delete(record);
	}
	/**
	 * 根据 “主键” 更新实体全部字段，null值会被更新
	 */
	public int updateByPrimaryKey(T record) {
		return mapper.updateByPrimaryKey(record);
	}
	/**
	 * 根据 “主键” 更新属性不为null的值
	 */
	public int updateByPrimaryKeySelective(T record) {
		return mapper.updateByPrimaryKeySelective(record);
	}
	/**
	 * 根据主键字段进行查询（实体类必须要有“@Id”注解）
	 */
	public T findById(Object key) {
		return mapper.selectByPrimaryKey(key);
	}
	/**
	 * 分页查询所有数据
	 */
	public ResultPage<T> findAll(ResultPage<T> resultPage) {
		ResultPage<T> result = new ResultPage<T>();
		PageHelper.startPage(resultPage.getPage(), resultPage.getLimit());
		Example example = new Example(entityClass);
		example.setOrderByClause("id desc"); //默认根据id倒序排序
		List<T> list = mapper.selectByExample(example);
		PageInfo<T> pageInfo = new PageInfo<T>(list);
		result.setData(list);
		result.setCount(pageInfo.getTotal());   //总记录数
		result.setTotalPage(pageInfo.getPages());  //总页数
		result.setPage(resultPage.getPage());
		return result;
	}
	/**
	 * 分页查询所有数据(带条件查询，把条件封住在实体类中，使用等号查询)
	 */
	public ResultPage<T> findByParam(ResultPage<T> resultPage, T record) {
		ResultPage<T> result = new ResultPage<T>();
		PageHelper.startPage(resultPage.getPage(), resultPage.getLimit());
		List<T> list = mapper.select(record);
		PageInfo<T> pageInfo = new PageInfo<T>(list);
		result.setData(list);
		result.setCount(pageInfo.getTotal());   //总记录数
		result.setTotalPage(pageInfo.getPages());  //总页数
		result.setPage(resultPage.getPage());  //总页数
		return result;
	}
	/**
	 * 根据 对象查询 使用“等号”进行查询
	 */
	public List<T> findByT(T record) {
		return mapper.select(record);
	}

}
