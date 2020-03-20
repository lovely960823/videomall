package nyist.edu.cn.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.Order;
import nyist.edu.cn.mapper.CourseMapper;
import nyist.edu.cn.mapper.OrderMapper;
import nyist.edu.cn.service.OrderService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;
import nyist.edu.cn.vo.ResultPage;

@Service
@Transactional
public class OrderServiceImpl extends BaseServiceImpl<Order> implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private CourseMapper courseMapper;

	@Override
	public List<Order> findByCidAndUid(Integer cid, Integer uid) {
		List<Order> list = orderMapper.findByCidAndUid(cid,uid);
		return list;
	}

	@Override
	public ResultPage<Course> findByUid(Integer uid, ResultPage<Course> resultPage) {
		List<Order> listOrder = orderMapper.findByUid(uid);
		List<Course> list = new ArrayList<Course>();
		if(!listOrder.isEmpty()){
			for(int i =0;i<listOrder.size();i++){
				Course c =courseMapper.findById(listOrder.get(i).getCid());
				list.add(c);
			}
		}
		PageHelper.startPage(resultPage.getPage(),resultPage.getLimit());
		PageHelper.orderBy("id desc");
		PageInfo<Course> pageInfo = new PageInfo<Course>(list);
		resultPage.setData(list);
		resultPage.setCount(pageInfo.getTotal());
		resultPage.setTotalPage(pageInfo.getPages());
		return resultPage;
	}

	@Override
	public ResultPage<Order> findByOrderUid(Integer uid) {
		ResultPage<Order> resultPage = new ResultPage<Order>();
		PageHelper.startPage(resultPage.getPage(),resultPage.getLimit());
		PageHelper.orderBy("ordernum desc");
		List<Order> list = orderMapper.findByUid(uid);
		PageInfo<Order> pageInfo = new PageInfo<Order>(list);
		resultPage.setData(list);
		resultPage.setCount(pageInfo.getTotal());
		resultPage.setTotalPage(pageInfo.getPages());
		return resultPage;
	}

	
}
