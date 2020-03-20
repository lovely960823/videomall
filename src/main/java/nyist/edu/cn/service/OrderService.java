package nyist.edu.cn.service;

import java.util.List;

import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.Order;
import nyist.edu.cn.service.base.BaseService;
import nyist.edu.cn.vo.ResultPage;

public interface OrderService extends BaseService<Order> {

	/**
	 * 查询这个课程是否购买过,购买过就不用添加到购物车
	 * @param cid
	 * @param uid
	 * @return
	 */
	List<Order> findByCidAndUid(Integer cid, Integer uid);

	/**
	 * 查询所有自己购买的课程
	 * @param uid
	 * @param resultPage 
	 * @return
	 */
	ResultPage<Course> findByUid(Integer uid, ResultPage<Course> resultPage);

	/**
	 * 查询我的订单
	 * @param uid
	 * @return
	 */
	ResultPage<Order> findByOrderUid(Integer uid);

}
